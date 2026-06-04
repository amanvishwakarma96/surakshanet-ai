namespace SurakshaNet.Api.DTOs;

public sealed record AuditLogResponse(
    Guid Id,
    string Actor,
    string Action,
    string EntityName,
    Guid? EntityId,
    string Summary,
    DateTimeOffset CreatedAt);
