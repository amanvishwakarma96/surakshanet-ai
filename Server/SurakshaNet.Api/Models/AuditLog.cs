namespace SurakshaNet.Api.Models;

public sealed class AuditLog : BaseEntity
{
    public string Actor { get; set; } = "System";

    public string Action { get; set; } = string.Empty;

    public string EntityName { get; set; } = string.Empty;

    public Guid? EntityId { get; set; }

    public string Summary { get; set; } = string.Empty;
}
