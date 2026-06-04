using Microsoft.AspNetCore.Mvc;
using SurakshaNet.Api.DTOs;

namespace SurakshaNet.Api.Controllers;

[ApiController]
[Route("api/[controller]")]
public sealed class UsersController : ControllerBase
{
    [HttpGet("status")]
    [ProducesResponseType(typeof(ModuleStatusResponse), StatusCodes.Status200OK)]
    public ActionResult<ModuleStatusResponse> GetStatus()
    {
        return Ok(new ModuleStatusResponse(
            "Users",
            "Foundation",
            "User data model is prepared; identity exposure is intentionally limited."));
    }
}
