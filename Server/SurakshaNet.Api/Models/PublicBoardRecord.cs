namespace SurakshaNet.Api.Models;

public sealed class PublicBoardRecord : BaseEntity
{
    public Guid IncidentId { get; set; }

    public Incident? Incident { get; set; }

    public string PublicSummary { get; set; } = string.Empty;

    public string VisibilityStatus { get; set; } = "Draft";

    public bool IsArchived { get; set; }
}
