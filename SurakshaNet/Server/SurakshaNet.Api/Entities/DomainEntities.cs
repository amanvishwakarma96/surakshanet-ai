namespace SurakshaNet.Api.Entities;

public class User
{
    public int Id { get; set; }
    public string FullName { get; set; } = string.Empty;
    public string Mobile { get; set; } = string.Empty;
    public string Email { get; set; } = string.Empty;
    public string PasswordHash { get; set; } = string.Empty;
    public string PreferredLanguage { get; set; } = "en";
    public string VerificationLevel { get; set; } = "Basic";
    public bool IsActive { get; set; } = true;
    public DateTime CreatedAt { get; set; } = DateTime.UtcNow;
    public ICollection<UserRole> UserRoles { get; set; } = new List<UserRole>();
}

public class Role { public int Id { get; set; } public string Name { get; set; } = string.Empty; public ICollection<UserRole> UserRoles { get; set; } = new List<UserRole>(); }
public class UserRole { public int UserId { get; set; } public User User { get; set; } = null!; public int RoleId { get; set; } public Role Role { get; set; } = null!; }

public class Incident
{
    public int Id { get; set; }
    public string IncidentCode { get; set; } = string.Empty;
    public string Category { get; set; } = string.Empty;
    public string Title { get; set; } = string.Empty;
    public string Description { get; set; } = string.Empty;
    public decimal Latitude { get; set; }
    public decimal Longitude { get; set; }
    public string LocationText { get; set; } = string.Empty;
    public string Severity { get; set; } = "Medium";
    public string Status { get; set; } = "Submitted";
    public string VerificationStatus { get; set; } = "Pending";
    public bool IsAnonymous { get; set; } = true;
    public int ReporterUserId { get; set; }
    public int? AssignedDepartmentId { get; set; }
    public DateTime CreatedAt { get; set; } = DateTime.UtcNow;
    public DateTime? UpdatedAt { get; set; }
}

public class IncidentMedia { public int Id { get; set; } public int IncidentId { get; set; } public string MediaType { get; set; } = string.Empty; public string FileUrl { get; set; } = string.Empty; public bool IsRedacted { get; set; } = true; public string EvidenceHash { get; set; } = string.Empty; public DateTime CreatedAt { get; set; } = DateTime.UtcNow; }
public class IncidentVerificationLog { public int Id { get; set; } public int IncidentId { get; set; } public int? VerifiedByUserId { get; set; } public string VerificationType { get; set; } = string.Empty; public string Result { get; set; } = string.Empty; public string Remarks { get; set; } = string.Empty; public DateTime CreatedAt { get; set; } = DateTime.UtcNow; }
public class Department { public int Id { get; set; } public string Name { get; set; } = string.Empty; public string DepartmentType { get; set; } = string.Empty; public string ContactEmail { get; set; } = string.Empty; public string ContactMobile { get; set; } = string.Empty; public bool IsActive { get; set; } = true; }
public class GeoFence { public int Id { get; set; } public int? IncidentId { get; set; } public decimal Latitude { get; set; } public decimal Longitude { get; set; } public int RadiusMeters { get; set; } public string Severity { get; set; } = string.Empty; public string RiskType { get; set; } = string.Empty; public string Status { get; set; } = "Active"; public DateTime? ExpiresAt { get; set; } public DateTime CreatedAt { get; set; } = DateTime.UtcNow; public DateTime? ResolvedAt { get; set; } }
public class Alert { public int Id { get; set; } public int? GeoFenceId { get; set; } public string Title { get; set; } = string.Empty; public string Message { get; set; } = string.Empty; public string Language { get; set; } = "en"; public string Severity { get; set; } = string.Empty; public DateTime CreatedAt { get; set; } = DateTime.UtcNow; }
public class PublicIssue { public int Id { get; set; } public int IncidentId { get; set; } public string PublicTitle { get; set; } = string.Empty; public string PublicSummary { get; set; } = string.Empty; public string ReporterIdentityLabel { get; set; } = "Identity Protected"; public string PublicStatus { get; set; } = "Published"; public int SupportCount { get; set; } public bool IsHidden { get; set; } public string? HideReason { get; set; } public DateTime CreatedAt { get; set; } = DateTime.UtcNow; }
public class Solution { public int Id { get; set; } public int IncidentId { get; set; } public int SuggestedByUserId { get; set; } public string Title { get; set; } = string.Empty; public string Description { get; set; } = string.Empty; public string SolutionType { get; set; } = string.Empty; public string VerificationStatus { get; set; } = "Pending"; public int SupportCount { get; set; } public string ExpertReviewStatus { get; set; } = "NotRequested"; public DateTime CreatedAt { get; set; } = DateTime.UtcNow; }
public class Petition { public int Id { get; set; } public int IncidentId { get; set; } public string Title { get; set; } = string.Empty; public string Summary { get; set; } = string.Empty; public string VerificationStatus { get; set; } = "Pending"; public int SupportCount { get; set; } public string Status { get; set; } = "Open"; public DateTime CreatedAt { get; set; } = DateTime.UtcNow; }
public class PetitionSupporter { public int Id { get; set; } public int PetitionId { get; set; } public int UserId { get; set; } public bool IsAnonymous { get; set; } = true; public DateTime CreatedAt { get; set; } = DateTime.UtcNow; }
public class HelperRequest { public int Id { get; set; } public int RequestedByUserId { get; set; } public string HelpType { get; set; } = string.Empty; public string Message { get; set; } = string.Empty; public decimal ApproxLatitude { get; set; } public decimal ApproxLongitude { get; set; } public bool ExactLocationShared { get; set; } public int? AcceptedByHelperUserId { get; set; } public string Status { get; set; } = "Open"; public DateTime CreatedAt { get; set; } = DateTime.UtcNow; public DateTime? ClosedAt { get; set; } }
public class AuditLog { public int Id { get; set; } public string EntityName { get; set; } = string.Empty; public int EntityId { get; set; } public string Action { get; set; } = string.Empty; public int? PerformedByUserId { get; set; } public string? OldValue { get; set; } public string? NewValue { get; set; } public string Remarks { get; set; } = string.Empty; public DateTime CreatedAt { get; set; } = DateTime.UtcNow; }
