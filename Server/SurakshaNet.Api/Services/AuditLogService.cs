using SurakshaNet.Api.DTOs;
using SurakshaNet.Api.Models;
using SurakshaNet.Api.Repositories;

namespace SurakshaNet.Api.Services;

public sealed class AuditLogService(IAuditLogRepository auditLogRepository) : IAuditLogService
{
    public async Task<IReadOnlyList<AuditLogResponse>> GetRecentAsync(CancellationToken cancellationToken)
    {
        var logs = await auditLogRepository.GetRecentAsync(cancellationToken);
        return logs.Select(ToResponse).ToList();
    }

    public async Task RecordAsync(
        string actor,
        string action,
        string entityName,
        Guid? entityId,
        string summary,
        CancellationToken cancellationToken)
    {
        var auditLog = new AuditLog
        {
            Actor = actor,
            Action = action,
            EntityName = entityName,
            EntityId = entityId,
            Summary = summary
        };

        await auditLogRepository.AddAsync(auditLog, cancellationToken);
    }

    private static AuditLogResponse ToResponse(AuditLog auditLog)
    {
        return new AuditLogResponse(
            auditLog.Id,
            auditLog.Actor,
            auditLog.Action,
            auditLog.EntityName,
            auditLog.EntityId,
            auditLog.Summary,
            auditLog.CreatedAt);
    }
}
