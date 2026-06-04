namespace SurakshaNet.Api.Models;

public sealed class Incident : BaseEntity
{
    public string Title { get; set; } = string.Empty;

    public string Description { get; set; } = string.Empty;

    public string Category { get; set; } = string.Empty;

    public string Status { get; set; } = "Submitted";

    public decimal ApproximateLatitude { get; set; }

    public decimal ApproximateLongitude { get; set; }

    public bool ExactLocationConsent { get; set; }

    public Guid? ReporterUserId { get; set; }

    public User? ReporterUser { get; set; }
}
