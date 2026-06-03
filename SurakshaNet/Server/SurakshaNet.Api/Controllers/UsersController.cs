using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using SurakshaNet.Api.Data;
using SurakshaNet.Api.DTOs;
using SurakshaNet.Api.Helpers;
using SurakshaNet.Api.Services;

namespace SurakshaNet.Api.Controllers;

[ApiController]
[Route("api/users")]
[Authorize]
public class UsersController(SurakshaNetDbContext db, IAuditService audit) : ControllerBase
{
    [HttpGet("profile")]
    public async Task<ActionResult<UserProfileDto>> Profile()
    {
        var user = await db.Users.FindAsync(User.GetUserId());
        return user is null ? NotFound() : Ok(new UserProfileDto(user.Id, user.FullName, user.Mobile, user.Email, user.PreferredLanguage, user.VerificationLevel));
    }

    [HttpPut("profile")]
    public async Task<IActionResult> Update(UpdateUserProfileDto request)
    {
        var user = await db.Users.FindAsync(User.GetUserId());
        if (user is null) return NotFound();
        var old = $"{user.FullName}|{user.PreferredLanguage}";
        user.FullName = request.FullName;
        user.PreferredLanguage = request.PreferredLanguage;
        await db.SaveChangesAsync();
        await audit.LogAsync("User", user.Id, "ProfileUpdated", user.Id, old, $"{user.FullName}|{user.PreferredLanguage}", "User profile changed.");
        return NoContent();
    }

    [HttpPost("request-verification")]
    public async Task<IActionResult> RequestVerification()
    {
        await audit.LogAsync("User", User.GetUserId(), "VerificationRequested", User.GetUserId(), null, "Requested", "Human verification workflow placeholder.");
        return Accepted(new { status = "VerificationRequested" });
    }
}
