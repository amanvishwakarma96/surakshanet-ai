using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using SurakshaNet.Api.Data;
using SurakshaNet.Api.DTOs;
using SurakshaNet.Api.Entities;
using SurakshaNet.Api.Helpers;
using SurakshaNet.Api.Services;

namespace SurakshaNet.Api.Controllers;

[ApiController]
[Route("api/geofences")]
[Authorize]
public class GeoFencesController(SurakshaNetDbContext db, IAuditService audit) : ControllerBase
{
    [HttpPost]
    public async Task<ActionResult<GeoFence>> Create(GeoFenceCreateDto r) { var g = new GeoFence { IncidentId = r.IncidentId, Latitude = r.Latitude, Longitude = r.Longitude, RadiusMeters = r.RadiusMeters, Severity = r.Severity, RiskType = r.RiskType, ExpiresAt = r.ExpiresAt }; db.GeoFences.Add(g); await db.SaveChangesAsync(); await audit.LogAsync("GeoFence", g.Id, "Created", User.GetUserId(), null, r.RiskType, "Manual geo-fence created."); return CreatedAtAction(nameof(Active), new { id = g.Id }, g); }
    [HttpGet("active")]
    public async Task<IEnumerable<GeoFence>> Active() => await db.GeoFences.Where(g => g.Status == "Active" && (g.ExpiresAt == null || g.ExpiresAt > DateTime.UtcNow)).ToListAsync();
    [HttpGet("nearby")]
    public async Task<IEnumerable<GeoFence>> Nearby([FromQuery] decimal lat, [FromQuery] decimal lng) => await db.GeoFences.Where(g => g.Status == "Active" && Math.Abs((double)(g.Latitude - lat)) < 0.1 && Math.Abs((double)(g.Longitude - lng)) < 0.1).ToListAsync();
    [HttpPut("{id:int}/resolve")]
    public async Task<IActionResult> Resolve(int id) { var g = await db.GeoFences.FindAsync(id); if (g is null) return NotFound(); g.Status = "Resolved"; g.ResolvedAt = DateTime.UtcNow; await db.SaveChangesAsync(); await audit.LogAsync("GeoFence", id, "Resolved", User.GetUserId(), "Active", "Resolved", "Closure requires proof for critical incident."); return NoContent(); }
}

[ApiController]
[Route("api/alerts")]
[Authorize]
public class AlertsController(SurakshaNetDbContext db, IAiVerificationService ai) : ControllerBase
{
    [HttpPost("send")]
    public async Task<ActionResult<Alert>> Send(AlertRequestDto r) { var message = await ai.GenerateNativeLanguageAlertAsync(r); var alert = new Alert { GeoFenceId = r.GeoFenceId, Title = r.Title, Message = string.IsNullOrWhiteSpace(r.Message) ? message : r.Message, Language = r.Language, Severity = r.Severity }; db.Alerts.Add(alert); await db.SaveChangesAsync(); return Ok(alert); }
    [HttpGet("my-alerts")]
    public async Task<IEnumerable<Alert>> MyAlerts() => await db.Alerts.OrderByDescending(a => a.CreatedAt).Take(50).ToListAsync();
}

[ApiController]
[Route("api/departments")]
[Authorize]
public class DepartmentsController(SurakshaNetDbContext db) : ControllerBase
{
    [HttpGet]
    public async Task<IEnumerable<Department>> List() => await db.Departments.Where(d => d.IsActive).ToListAsync();
    [HttpPost]
    public async Task<ActionResult<Department>> Create(CreateDepartmentDto r) { var d = new Department { Name = r.Name, DepartmentType = r.DepartmentType, ContactEmail = r.ContactEmail, ContactMobile = r.ContactMobile }; db.Departments.Add(d); await db.SaveChangesAsync(); return Ok(d); }
}

[ApiController]
[Route("api/public-board")]
[Authorize]
public class PublicBoardController(SurakshaNetDbContext db, IAuditService audit) : ControllerBase
{
    [HttpPost("publish/{incidentId:int}")]
    public async Task<ActionResult<PublicIssue>> Publish(int incidentId, PublishPublicIssueDto r)
    {
        var incident = await db.Incidents.FindAsync(incidentId);
        if (incident is null) return NotFound();
        if (incident.VerificationStatus != "Verified") return BadRequest(new { message = "Only verified incidents can be published to the public board." });
        // Public identity protection: anonymous/sensitive reports never expose reporter identity or exact sensitive location.
        var sensitive = incident.Category.Contains("Women", StringComparison.OrdinalIgnoreCase) || incident.Category.Contains("Corruption", StringComparison.OrdinalIgnoreCase);
        var summary = sensitive ? r.PublicSummary.Replace(incident.LocationText, "approximate area", StringComparison.OrdinalIgnoreCase) : r.PublicSummary;
        var issue = new PublicIssue { IncidentId = incidentId, PublicTitle = r.PublicTitle, PublicSummary = summary, ReporterIdentityLabel = incident.IsAnonymous || sensitive ? "Identity Protected" : "Verified Citizen" };
        db.PublicIssues.Add(issue);
        await db.SaveChangesAsync();
        await audit.LogAsync("PublicIssue", issue.Id, "Published", User.GetUserId(), null, issue.PublicStatus, "Public record is append-only; hiding requires reason and audit.");
        return Ok(issue);
    }
    [HttpGet]
    public async Task<IEnumerable<PublicIssue>> List() => await db.PublicIssues.Where(p => !p.IsHidden).OrderByDescending(p => p.CreatedAt).ToListAsync();
    [HttpGet("{id:int}")]
    public async Task<ActionResult<PublicIssue>> Get(int id) { var p = await db.PublicIssues.FindAsync(id); return p is null || p.IsHidden ? NotFound() : Ok(p); }
    [HttpPost("{id:int}/support")]
    public async Task<IActionResult> Support(int id) { var p = await db.PublicIssues.FindAsync(id); if (p is null) return NotFound(); p.SupportCount++; await db.SaveChangesAsync(); return NoContent(); }
    [HttpPost("{id:int}/request-hide")]
    public async Task<IActionResult> Hide(int id, HidePublicIssueDto r) { var p = await db.PublicIssues.FindAsync(id); if (p is null) return NotFound(); p.IsHidden = true; p.HideReason = r.Reason; await db.SaveChangesAsync(); await audit.LogAsync("PublicIssue", id, "HiddenWithReason", User.GetUserId(), "Visible", "Hidden", r.Reason); return NoContent(); }
}
