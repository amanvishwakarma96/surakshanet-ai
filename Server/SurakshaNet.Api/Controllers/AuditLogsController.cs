using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using SurakshaNet.Api.DTOs;
using SurakshaNet.Api.Services;

namespace SurakshaNet.Api.Controllers;

[ApiController]
[Route("api/[controller]")]
public sealed class AuditLogsController(IAuditLogService auditLogService) : ControllerBase
{
    [Authorize(Roles = "Admin,Reviewer")]
    [HttpGet]
    [ProducesResponseType(typeof(IReadOnlyList<AuditLogResponse>), StatusCodes.Status200OK)]
    public async Task<ActionResult<IReadOnlyList<AuditLogResponse>>> GetRecent(CancellationToken cancellationToken)
    {
        var auditLogs = await auditLogService.GetRecentAsync(cancellationToken);
        return Ok(auditLogs);
    }
}
