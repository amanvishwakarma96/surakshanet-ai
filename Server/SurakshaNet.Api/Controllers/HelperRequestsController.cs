using Microsoft.AspNetCore.Mvc;
using SurakshaNet.Api.DTOs;

namespace SurakshaNet.Api.Controllers;

[ApiController]
[Route("api/[controller]")]
public sealed class HelperRequestsController : ControllerBase
{
    [HttpGet("status")]
    [ProducesResponseType(typeof(ModuleStatusResponse), StatusCodes.Status200OK)]
    public ActionResult<ModuleStatusResponse> GetStatus()
    {
        return Ok(new ModuleStatusResponse(
            "HelperRequests",
            "Foundation",
            "Helper request model starts with approximate location and requires consent before exact location sharing."));
    }
}
