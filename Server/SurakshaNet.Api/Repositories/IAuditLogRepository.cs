using SurakshaNet.Api.Models;

namespace SurakshaNet.Api.Repositories;

public interface IAuditLogRepository
{
    Task<IReadOnlyList<AuditLog>> GetRecentAsync(CancellationToken cancellationToken);

    Task<AuditLog> AddAsync(AuditLog auditLog, CancellationToken cancellationToken);
}
