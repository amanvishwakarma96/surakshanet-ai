using System.IdentityModel.Tokens.Jwt;
using System.Security.Claims;
using System.Text;
using Microsoft.EntityFrameworkCore;
using Microsoft.IdentityModel.Tokens;
using SurakshaNet.Api.Data;
using SurakshaNet.Api.DTOs;
using SurakshaNet.Api.Entities;
using SurakshaNet.Api.Helpers;

namespace SurakshaNet.Api.Services;

public interface IJwtTokenService { string CreateToken(User user, IEnumerable<string> roles); }
public class JwtTokenService(IConfiguration config) : IJwtTokenService
{
    public string CreateToken(User user, IEnumerable<string> roles)
    {
        var claims = new List<Claim> { new(ClaimTypes.NameIdentifier, user.Id.ToString()), new(ClaimTypes.Email, user.Email), new(ClaimTypes.Name, user.FullName) };
        claims.AddRange(roles.Select(role => new Claim(ClaimTypes.Role, role)));
        var key = new SymmetricSecurityKey(Encoding.UTF8.GetBytes(config["Jwt:Key"]!));
        var token = new JwtSecurityToken(config["Jwt:Issuer"], config["Jwt:Audience"], claims, expires: DateTime.UtcNow.AddHours(8), signingCredentials: new SigningCredentials(key, SecurityAlgorithms.HmacSha256));
        return new JwtSecurityTokenHandler().WriteToken(token);
    }
}

public interface IAuthService { Task<AuthResponseDto> RegisterAsync(RegisterRequestDto request); Task<AuthResponseDto?> LoginAsync(LoginRequestDto request); }
public class AuthService(SurakshaNetDbContext db, IJwtTokenService jwt) : IAuthService
{
    public async Task<AuthResponseDto> RegisterAsync(RegisterRequestDto request)
    {
        var user = new User { FullName = request.FullName, Mobile = request.Mobile, Email = request.Email, PreferredLanguage = request.PreferredLanguage, PasswordHash = PasswordHasher.Hash(request.Password) };
        db.Users.Add(user);
        await db.SaveChangesAsync();
        db.UserRoles.Add(new UserRole { UserId = user.Id, RoleId = 2 });
        await db.SaveChangesAsync();
        var token = jwt.CreateToken(user, ["Citizen"]);
        return new AuthResponseDto(token, new UserProfileDto(user.Id, user.FullName, user.Mobile, user.Email, user.PreferredLanguage, user.VerificationLevel));
    }

    public async Task<AuthResponseDto?> LoginAsync(LoginRequestDto request)
    {
        var user = await db.Users.Include(u => u.UserRoles).ThenInclude(ur => ur.Role).FirstOrDefaultAsync(u => u.Email == request.Email && u.IsActive);
        if (user is null || !PasswordHasher.Verify(request.Password, user.PasswordHash)) return null;
        var roles = user.UserRoles.Select(ur => ur.Role.Name).DefaultIfEmpty("Citizen");
        return new AuthResponseDto(jwt.CreateToken(user, roles), new UserProfileDto(user.Id, user.FullName, user.Mobile, user.Email, user.PreferredLanguage, user.VerificationLevel));
    }
}

public interface IAuditService { Task LogAsync(string entityName, int entityId, string action, int? userId, string? oldValue, string? newValue, string remarks); }
public class AuditService(SurakshaNetDbContext db) : IAuditService
{
    public async Task LogAsync(string entityName, int entityId, string action, int? userId, string? oldValue, string? newValue, string remarks)
    {
        db.AuditLogs.Add(new AuditLog { EntityName = entityName, EntityId = entityId, Action = action, PerformedByUserId = userId, OldValue = oldValue, NewValue = newValue, Remarks = remarks });
        await db.SaveChangesAsync();
    }
}

public interface IAiVerificationService
{
    Task<AiVerificationResultDto> VerifyIncidentAsync(IncidentDto incident);
    Task<string> CalculateSeverityAsync(IncidentDto incident);
    Task<bool> DetectDuplicateAsync(IncidentDto incident);
    Task<IEnumerable<string>> SuggestSolutionsAsync(IncidentDto incident);
    Task<string> GenerateNativeLanguageAlertAsync(AlertRequestDto request);
}

public class MockAiVerificationService : IAiVerificationService
{
    private static readonly string[] CriticalPhrases = ["live wire in flooded water", "electric pole collapse", "transformer spark", "transformer fire", "open manhole in flooded", "major accident", "fire", "smoke", "building collapse", "person trapped", "flooded underpass", "unsafe bridge", "road collapse", "immediate threat", "child distress", "senior citizen distress", "gas leakage", "chemical spill"];

    public async Task<AiVerificationResultDto> VerifyIncidentAsync(IncidentDto incident)
    {
        // AI assists verification only; it does not make final legal/corruption/publication decisions.
        var severity = await CalculateSeverityAsync(incident);
        var duplicate = await DetectDuplicateAsync(incident);
        var actions = await SuggestSolutionsAsync(incident);
        var alert = await GenerateNativeLanguageAlertAsync(new AlertRequestDto(null, incident.Title, incident.Description, "en", severity));
        return new AiVerificationResultDto(severity == "Critical" ? 0.92m : 0.74m, severity, severity == "Critical", duplicate, alert, actions);
    }

    public Task<string> CalculateSeverityAsync(IncidentDto incident)
    {
        var text = $"{incident.Category} {incident.Title} {incident.Description}".ToLowerInvariant();
        if (CriticalPhrases.Any(text.Contains) || text.Contains("live wire") || text.Contains("person trapped")) return Task.FromResult("Critical");
        if (incident.Category.Contains("Electric", StringComparison.OrdinalIgnoreCase)) return Task.FromResult("Critical");
        if (incident.Category.Contains("Flood", StringComparison.OrdinalIgnoreCase) || incident.Category.Contains("Accident", StringComparison.OrdinalIgnoreCase)) return Task.FromResult("High");
        if (incident.Category.Contains("Women Safety", StringComparison.OrdinalIgnoreCase)) return Task.FromResult(text.Contains("immediate") ? "High" : "Medium");
        return Task.FromResult(incident.Category.Contains("Pothole", StringComparison.OrdinalIgnoreCase) ? "Medium" : "High");
    }

    public Task<bool> DetectDuplicateAsync(IncidentDto incident) => Task.FromResult(false);
    public Task<IEnumerable<string>> SuggestSolutionsAsync(IncidentDto incident) => Task.FromResult<IEnumerable<string>>(["Create temporary barricade", "Notify responsible department", "Send geo-fenced warning when severity is high"]);
    public Task<string> GenerateNativeLanguageAlertAsync(AlertRequestDto request) => Task.FromResult($"{request.Severity} alert: {request.Title}. Avoid the area and follow official safety instructions.");
}

public interface IIncidentService
{
    Task<IncidentDto> CreateAsync(IncidentCreateDto request, int reporterUserId);
    Task<IncidentDto?> GetAsync(int id);
    IQueryable<Incident> Query();
}

public class IncidentService(SurakshaNetDbContext db, IAiVerificationService ai, IAuditService audit) : IIncidentService
{
    public IQueryable<Incident> Query() => db.Incidents.AsNoTracking();

    public async Task<IncidentDto> CreateAsync(IncidentCreateDto request, int reporterUserId)
    {
        var incident = new Incident { IncidentCode = $"SN-{DateTime.UtcNow:yyyyMMddHHmmss}", Category = request.Category, Title = request.Title, Description = request.Description, Latitude = request.Latitude, Longitude = request.Longitude, LocationText = request.LocationText, IsAnonymous = request.IsAnonymous, ReporterUserId = reporterUserId };
        db.Incidents.Add(incident);
        await db.SaveChangesAsync();
        var dto = ToDto(incident);
        var aiResult = await ai.VerifyIncidentAsync(dto);
        incident.Severity = aiResult.SuggestedSeverity;
        incident.Status = "AI Checked";
        incident.VerificationStatus = aiResult.PossibleDuplicate ? "PossibleDuplicate" : "NeedsHumanReview";
        incident.UpdatedAt = DateTime.UtcNow;
        await db.SaveChangesAsync();
        await audit.LogAsync("Incident", incident.Id, "CreatedAndAiChecked", reporterUserId, null, incident.Status, "Mock AI confidence: " + aiResult.ConfidenceScore);

        if (aiResult.IsCritical)
        {
            db.GeoFences.Add(new GeoFence { IncidentId = incident.Id, Latitude = incident.Latitude, Longitude = incident.Longitude, RadiusMeters = 500, Severity = "Critical", RiskType = incident.Category, ExpiresAt = DateTime.UtcNow.AddHours(12) });
            db.Alerts.Add(new Alert { Title = incident.Title, Message = aiResult.NativeLanguageAlert, Language = "en", Severity = "Critical" });
            await db.SaveChangesAsync();
            await audit.LogAsync("Incident", incident.Id, "CriticalGeoFenceCreated", reporterUserId, null, "GeoFence", "Critical issue requires verified closure proof and control-room notification.");
        }

        return ToDto(incident);
    }

    public async Task<IncidentDto?> GetAsync(int id) => await db.Incidents.AsNoTracking().Where(i => i.Id == id).Select(i => ToDto(i)).FirstOrDefaultAsync();
    public static IncidentDto ToDto(Incident i) => new(i.Id, i.IncidentCode, i.Category, i.Title, i.Description, i.Latitude, i.Longitude, i.LocationText, i.Severity, i.Status, i.VerificationStatus, i.IsAnonymous, i.ReporterUserId, i.AssignedDepartmentId, i.CreatedAt);
}
