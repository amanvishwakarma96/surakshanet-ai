namespace SurakshaNet.Api.Models;

public sealed class HelperRequest : BaseEntity
{
    public Guid IncidentId { get; set; }

    public Incident? Incident { get; set; }

    public string NeedType { get; set; } = string.Empty;

    public string Status { get; set; } = "Open";

    public string ApproximateLocationLabel { get; set; } = string.Empty;

    public bool ExactLocationSharedWithConsent { get; set; }
}
