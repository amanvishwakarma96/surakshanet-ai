namespace SurakshaNet.Api.Models;

public sealed class SolutionSuggestion : BaseEntity
{
    public Guid IncidentId { get; set; }

    public Incident? Incident { get; set; }

    public string SuggestedAction { get; set; } = string.Empty;

    public string SuggestedBy { get; set; } = "System";

    public string Status { get; set; } = "Proposed";
}
