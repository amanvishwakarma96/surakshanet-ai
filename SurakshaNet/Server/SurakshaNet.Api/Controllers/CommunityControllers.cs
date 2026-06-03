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
[Route("api/solutions")]
[Authorize]
public class SolutionsController(SurakshaNetDbContext db, IAuditService audit) : ControllerBase
{
    [HttpPost]
    public async Task<ActionResult<Solution>> Create(SolutionCreateDto r) { var s = new Solution { IncidentId = r.IncidentId, SuggestedByUserId = User.GetUserId(), Title = r.Title, Description = r.Description, SolutionType = r.SolutionType }; db.Solutions.Add(s); await db.SaveChangesAsync(); await audit.LogAsync("Solution", s.Id, "Submitted", User.GetUserId(), null, r.SolutionType, "Solution requires verification before public recommendation."); return Ok(s); }
    [HttpGet("by-incident/{incidentId:int}")]
    public async Task<IEnumerable<Solution>> ByIncident(int incidentId) => await db.Solutions.Where(s => s.IncidentId == incidentId).ToListAsync();
    [HttpPost("{id:int}/support")]
    public async Task<IActionResult> Support(int id) { var s = await db.Solutions.FindAsync(id); if (s is null) return NotFound(); s.SupportCount++; await db.SaveChangesAsync(); return NoContent(); }
    [HttpPost("{id:int}/expert-review")]
    public async Task<IActionResult> ExpertReview(int id, VerificationDecisionDto r) { var s = await db.Solutions.FindAsync(id); if (s is null) return NotFound(); s.ExpertReviewStatus = "Requested"; await db.SaveChangesAsync(); await audit.LogAsync("Solution", id, "ExpertReviewRequested", User.GetUserId(), null, "Requested", r.Remarks); return NoContent(); }
    [HttpPut("{id:int}/status")]
    public async Task<IActionResult> Status(int id, StatusUpdateDto r) { var s = await db.Solutions.FindAsync(id); if (s is null) return NotFound(); var old = s.VerificationStatus; s.VerificationStatus = r.Status; await db.SaveChangesAsync(); await audit.LogAsync("Solution", id, "StatusChanged", User.GetUserId(), old, r.Status, r.Remarks); return NoContent(); }
}

[ApiController]
[Route("api/petitions")]
[Authorize]
public class PetitionsController(SurakshaNetDbContext db, IAuditService audit) : ControllerBase
{
    [HttpPost]
    public async Task<ActionResult<Petition>> Create(PetitionCreateDto r) { var p = new Petition { IncidentId = r.IncidentId, Title = r.Title, Summary = r.Summary }; db.Petitions.Add(p); await db.SaveChangesAsync(); await audit.LogAsync("Petition", p.Id, "Created", User.GetUserId(), null, "Pending", "Petitions need human verification."); return Ok(p); }
    [HttpGet]
    public async Task<IEnumerable<Petition>> List() => await db.Petitions.OrderByDescending(p => p.CreatedAt).ToListAsync();
    [HttpPost("{id:int}/support")]
    public async Task<IActionResult> Support(int id, bool anonymous = true) { var p = await db.Petitions.FindAsync(id); if (p is null) return NotFound(); p.SupportCount++; db.PetitionSupporters.Add(new PetitionSupporter { PetitionId = id, UserId = User.GetUserId(), IsAnonymous = anonymous }); await db.SaveChangesAsync(); return NoContent(); }
    [HttpPost("{id:int}/verify")]
    public async Task<IActionResult> Verify(int id, VerificationDecisionDto r) { var p = await db.Petitions.FindAsync(id); if (p is null) return NotFound(); p.VerificationStatus = "Verified"; await db.SaveChangesAsync(); await audit.LogAsync("Petition", id, "Verified", User.GetUserId(), null, "Verified", r.Remarks); return NoContent(); }
}

[ApiController]
[Route("api/helper")]
[Authorize]
public class HelperController(SurakshaNetDbContext db, IAuditService audit) : ControllerBase
{
    [HttpPost("request")]
    public async Task<ActionResult<HelperRequest>> Request(HelperRequestCreateDto r)
    {
        // User protection: helpers receive approximate location first; exact location is shared only after explicit consent.
        var h = new HelperRequest { RequestedByUserId = User.GetUserId(), HelpType = r.HelpType, Message = r.Message, ApproxLatitude = r.ApproxLatitude, ApproxLongitude = r.ApproxLongitude, ExactLocationShared = r.ExactLocationShared };
        db.HelperRequests.Add(h); await db.SaveChangesAsync(); await audit.LogAsync("HelperRequest", h.Id, "Created", User.GetUserId(), null, "ApproxLocationOnly", "Exact location consent: " + r.ExactLocationShared); return Ok(h);
    }
    [HttpGet("requests/nearby")]
    public async Task<IEnumerable<HelperRequest>> Nearby([FromQuery] decimal lat = 0, [FromQuery] decimal lng = 0) => await db.HelperRequests.Where(h => h.Status == "Open" && Math.Abs((double)(h.ApproxLatitude - lat)) < 0.2 && Math.Abs((double)(h.ApproxLongitude - lng)) < 0.2).ToListAsync();
    [HttpPost("requests/{id:int}/accept")]
    public async Task<IActionResult> Accept(int id) { var h = await db.HelperRequests.FindAsync(id); if (h is null) return NotFound(); h.AcceptedByHelperUserId = User.GetUserId(); h.Status = "Accepted"; await db.SaveChangesAsync(); await audit.LogAsync("HelperRequest", id, "Accepted", User.GetUserId(), "Open", "Accepted", "Helper accepted request."); return NoContent(); }
    [HttpPost("requests/{id:int}/close")]
    public async Task<IActionResult> Close(int id) { var h = await db.HelperRequests.FindAsync(id); if (h is null) return NotFound(); h.Status = "Closed"; h.ClosedAt = DateTime.UtcNow; await db.SaveChangesAsync(); await audit.LogAsync("HelperRequest", id, "Closed", User.GetUserId(), null, "Closed", "Requester/helper closed request."); return NoContent(); }
    [HttpPost("requests/{id:int}/report-misuse")]
    public async Task<IActionResult> Misuse(int id, VerificationDecisionDto r) { await audit.LogAsync("HelperRequest", id, "MisuseReported", User.GetUserId(), null, "Reported", r.Remarks); return Accepted(new { status = "MisuseReported" }); }
}

[ApiController]
[Route("api/audit")]
[Authorize]
public class AuditController(SurakshaNetDbContext db) : ControllerBase
{
    [HttpGet("by-incident/{incidentId:int}")]
    public async Task<IEnumerable<AuditLog>> ByIncident(int incidentId) => await db.AuditLogs.Where(a => a.EntityName == "Incident" && a.EntityId == incidentId).OrderByDescending(a => a.CreatedAt).ToListAsync();
    [HttpGet("by-user/{userId:int}")]
    public async Task<IEnumerable<AuditLog>> ByUser(int userId) => await db.AuditLogs.Where(a => a.PerformedByUserId == userId).OrderByDescending(a => a.CreatedAt).ToListAsync();
}
