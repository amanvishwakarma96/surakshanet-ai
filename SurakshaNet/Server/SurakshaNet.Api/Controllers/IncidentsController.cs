using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using SurakshaNet.Api.Data;
using SurakshaNet.Api.DTOs;
using SurakshaNet.Api.Entities;
using SurakshaNet.Api.Helpers;
using SurakshaNet.Api.Services;

namespace SurakshaNet.Api.Controllers;

[ApiController]
[Route("api/incidents")]
[Authorize]
public class IncidentsController(SurakshaNetDbContext db, IIncidentService incidents, IAiVerificationService ai, IAuditService audit) : ControllerBase
{
    [HttpPost]
    public async Task<ActionResult<IncidentDto>> Create(IncidentCreateDto request) => Created("", await incidents.CreateAsync(request, User.GetUserId()));

    [HttpGet]
    public async Task<ActionResult<IEnumerable<IncidentDto>>> List() => Ok(await incidents.Query().OrderByDescending(i => i.CreatedAt).Select(i => IncidentService.ToDto(i)).ToListAsync());

    [HttpGet("{id:int}")]
    public async Task<ActionResult<IncidentDto>> Get(int id)
    {
        var incident = await incidents.GetAsync(id);
        return incident is null ? NotFound() : Ok(incident);
    }

    [HttpPut("{id:int}/status")]
    public async Task<IActionResult> UpdateStatus(int id, StatusUpdateDto request)
    {
        var incident = await db.Incidents.FindAsync(id);
        if (incident is null) return NotFound();
        var old = incident.Status;
        incident.Status = request.Status;
        incident.UpdatedAt = DateTime.UtcNow;
        await db.SaveChangesAsync();
        await audit.LogAsync("Incident", id, "StatusChanged", User.GetUserId(), old, request.Status, request.Remarks);
        return NoContent();
    }

    [HttpPost("{id:int}/verify")]
    public async Task<IActionResult> Verify(int id, VerificationDecisionDto request)
    {
        var incident = await db.Incidents.FindAsync(id);
        if (incident is null) return NotFound();
        var aiResult = await ai.VerifyIncidentAsync(IncidentService.ToDto(incident));
        incident.VerificationStatus = "Verified";
        incident.Status = "Verified";
        db.IncidentVerificationLogs.Add(new IncidentVerificationLog { IncidentId = id, VerifiedByUserId = User.GetUserId(), VerificationType = "HumanReviewWithAiSupport", Result = "Verified", Remarks = request.Remarks });
        await db.SaveChangesAsync();
        await audit.LogAsync("Incident", id, "Verified", User.GetUserId(), null, "Verified", $"{request.Remarks}; AI confidence {aiResult.ConfidenceScore}");
        return Ok(aiResult);
    }

    [HttpPost("{id:int}/reject")]
    public async Task<IActionResult> Reject(int id, VerificationDecisionDto request) => await SetVerification(id, "Rejected", request.Remarks);

    [HttpPost("{id:int}/mark-duplicate")]
    public async Task<IActionResult> Duplicate(int id, VerificationDecisionDto request) => await SetVerification(id, "Duplicate", request.Remarks);

    [HttpPut("{id:int}/assign-department")]
    public async Task<IActionResult> AssignDepartment(int id, AssignDepartmentDto request)
    {
        var incident = await db.Incidents.FindAsync(id);
        if (incident is null) return NotFound();
        incident.AssignedDepartmentId = request.DepartmentId;
        incident.Status = "Assigned";
        await db.SaveChangesAsync();
        await audit.LogAsync("Incident", id, "AssignedDepartment", User.GetUserId(), null, request.DepartmentId.ToString(), request.Remarks);
        return NoContent();
    }

    private async Task<IActionResult> SetVerification(int id, string status, string remarks)
    {
        var incident = await db.Incidents.FindAsync(id);
        if (incident is null) return NotFound();
        incident.VerificationStatus = status;
        incident.Status = status;
        await db.SaveChangesAsync();
        await audit.LogAsync("Incident", id, status, User.GetUserId(), null, status, remarks);
        return NoContent();
    }
}
