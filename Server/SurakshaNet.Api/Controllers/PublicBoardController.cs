using Microsoft.AspNetCore.Mvc;
using SurakshaNet.Api.DTOs;

namespace SurakshaNet.Api.Controllers;

[ApiController]
[Route("api/[controller]")]
public sealed class PublicBoardController : ControllerBase
{
    [HttpGet("status")]
    [ProducesResponseType(typeof(ModuleStatusResponse), StatusCodes.Status200OK)]
    public ActionResult<ModuleStatusResponse> GetStatus()
    {
        return Ok(new ModuleStatusResponse(
            "PublicBoard",
            "Foundation",
            "Public accountability records are modeled for visibility controls and archival rather than silent deletion."));
    }
}
