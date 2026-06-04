using SurakshaNet.Api.DTOs;

namespace SurakshaNet.Api.Services;

public interface IAuditLogService
{
    Task<IReadOnlyList<AuditLogResponse>> GetRecentAsync(CancellationToken cancellationToken);

    Task RecordAsync(
        string actor,
        string action,
        string entityName,
        Guid? entityId,
        string summary,
        CancellationToken cancellationToken);
}
