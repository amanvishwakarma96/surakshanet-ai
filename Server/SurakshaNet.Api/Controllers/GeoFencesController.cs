using Microsoft.AspNetCore.Mvc;
using SurakshaNet.Api.DTOs;
using SurakshaNet.Api.Services;

namespace SurakshaNet.Api.Controllers;

[ApiController]
[Route("api/[controller]")]
public sealed class GeoFencesController(IGeoFenceAlertService geoFenceAlertService) : ControllerBase
{
    [HttpGet("status")]
    [ProducesResponseType(typeof(ModuleStatusResponse), StatusCodes.Status200OK)]
    public ActionResult<ModuleStatusResponse> GetStatus()
    {
        return Ok(new ModuleStatusResponse(
            "GeoFences",
            "FlowReady",
            "Geo-fenced alert lookup is available using approximate location only."));
    }

    [HttpGet("alerts/nearby")]
    [ProducesResponseType(typeof(IReadOnlyList<GeoFenceAlertResponse>), StatusCodes.Status200OK)]
    public async Task<ActionResult<IReadOnlyList<GeoFenceAlertResponse>>> GetNearbyAlerts(
        [FromQuery] decimal? approximateLatitude,
        [FromQuery] decimal? approximateLongitude,
        CancellationToken cancellationToken)
    {
        var alerts = await geoFenceAlertService.GetNearbyAlertsAsync(
            approximateLatitude,
            approximateLongitude,
            cancellationToken);

        return Ok(alerts);
    }
}
