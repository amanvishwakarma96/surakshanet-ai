using Microsoft.AspNetCore.Mvc;
using SurakshaNet.Api.DTOs;

namespace SurakshaNet.Api.Controllers;

[ApiController]
[Route("api/[controller]")]
public sealed class GeoFencesController : ControllerBase
{
    [HttpGet("status")]
    [ProducesResponseType(typeof(ModuleStatusResponse), StatusCodes.Status200OK)]
    public ActionResult<ModuleStatusResponse> GetStatus()
    {
        return Ok(new ModuleStatusResponse(
            "GeoFences",
            "Foundation",
            "Geo-fence model is prepared for future safety alert workflows."));
    }
}
