namespace SurakshaNet.Api.DTOs;

public record RegisterRequestDto(string FullName, string Mobile, string Email, string Password, string PreferredLanguage = "en");
public record LoginRequestDto(string Email, string Password);
public record AuthResponseDto(string Token, UserProfileDto User);
public record UserProfileDto(int Id, string FullName, string Mobile, string Email, string PreferredLanguage, string VerificationLevel);
public record UpdateUserProfileDto(string FullName, string PreferredLanguage);

public record IncidentCreateDto(string Category, string Title, string Description, decimal Latitude, decimal Longitude, string LocationText, bool IsAnonymous);
public record IncidentDto(int Id, string IncidentCode, string Category, string Title, string Description, decimal Latitude, decimal Longitude, string LocationText, string Severity, string Status, string VerificationStatus, bool IsAnonymous, int ReporterUserId, int? AssignedDepartmentId, DateTime CreatedAt);
public record StatusUpdateDto(string Status, string Remarks);
public record VerificationDecisionDto(string Remarks);
public record AiVerificationResultDto(decimal ConfidenceScore, string SuggestedSeverity, bool IsCritical, bool PossibleDuplicate, string NativeLanguageAlert, IEnumerable<string> SuggestedActions);
public record GeoFenceDto(int Id, int? IncidentId, decimal Latitude, decimal Longitude, int RadiusMeters, string Severity, string RiskType, string Status, DateTime? ExpiresAt);
public record GeoFenceCreateDto(int? IncidentId, decimal Latitude, decimal Longitude, int RadiusMeters, string Severity, string RiskType, DateTime? ExpiresAt);
public record AlertRequestDto(int? GeoFenceId, string Title, string Message, string Language, string Severity);
public record DepartmentDto(int Id, string Name, string DepartmentType, string ContactEmail, string ContactMobile, bool IsActive);
public record CreateDepartmentDto(string Name, string DepartmentType, string ContactEmail, string ContactMobile);
public record AssignDepartmentDto(int DepartmentId, string Remarks);
public record PublishPublicIssueDto(string PublicTitle, string PublicSummary);
public record HidePublicIssueDto(string Reason);
public record SolutionCreateDto(int IncidentId, string Title, string Description, string SolutionType);
public record PetitionCreateDto(int IncidentId, string Title, string Summary);
public record HelperRequestCreateDto(string HelpType, string Message, decimal ApproxLatitude, decimal ApproxLongitude, bool ExactLocationShared);
