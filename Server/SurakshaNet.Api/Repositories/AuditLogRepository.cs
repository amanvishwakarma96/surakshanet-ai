using Microsoft.EntityFrameworkCore;
using SurakshaNet.Api.Data;
using SurakshaNet.Api.Models;

namespace SurakshaNet.Api.Repositories;

public sealed class AuditLogRepository(SurakshaNetDbContext dbContext) : IAuditLogRepository
{
    public async Task<IReadOnlyList<AuditLog>> GetRecentAsync(CancellationToken cancellationToken)
    {
        return await dbContext.AuditLogs
            .AsNoTracking()
            .OrderByDescending(log => log.CreatedAt)
            .Take(100)
            .ToListAsync(cancellationToken);
    }

    public async Task<AuditLog> AddAsync(AuditLog auditLog, CancellationToken cancellationToken)
    {
        dbContext.AuditLogs.Add(auditLog);
        await dbContext.SaveChangesAsync(cancellationToken);
        return auditLog;
    }
}
