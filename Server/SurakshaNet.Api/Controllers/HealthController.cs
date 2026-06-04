using Microsoft.AspNetCore.Mvc;
using SurakshaNet.Api.DTOs;

namespace SurakshaNet.Api.Controllers;

[ApiController]
[Route("api/[controller]")]
public sealed class HealthController : ControllerBase
{
    [HttpGet]
    [ProducesResponseType(typeof(HealthResponse), StatusCodes.Status200OK)]
    public ActionResult<HealthResponse> Get()
    {
        return Ok(new HealthResponse(
            Status: "Healthy",
            Service: "SurakshaNet.Api",
            Version: "v1",
            CheckedAt: DateTimeOffset.UtcNow));
    }
}
