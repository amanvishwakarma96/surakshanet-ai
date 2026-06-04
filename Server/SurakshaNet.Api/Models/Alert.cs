namespace SurakshaNet.Api.Models;

public sealed class Alert : BaseEntity
{
    public Guid? IncidentId { get; set; }

    public Incident? Incident { get; set; }

    public Guid GeoFenceId { get; set; }

    public GeoFence GeoFence { get; set; } = null!;

    public string Title { get; set; } = string.Empty;

    public string Message { get; set; } = string.Empty;

    public string Severity { get; set; } = "Medium";

    public string Status { get; set; } = "Draft";

    public Guid? PublishedByUserId { get; set; }

    public User? PublishedByUser { get; set; }

    public DateTimeOffset? PublishedAt { get; set; }

    public DateTimeOffset? ExpiresAt { get; set; }
}
