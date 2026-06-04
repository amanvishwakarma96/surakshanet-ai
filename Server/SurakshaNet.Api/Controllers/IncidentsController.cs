using Microsoft.AspNetCore.Mvc;
using SurakshaNet.Api.DTOs;
using SurakshaNet.Api.Services;

namespace SurakshaNet.Api.Controllers;

[ApiController]
[Route("api/[controller]")]
public sealed class IncidentsController(IIncidentService incidentService) : ControllerBase
{
    [HttpGet]
    [ProducesResponseType(typeof(IReadOnlyList<IncidentResponse>), StatusCodes.Status200OK)]
    public async Task<ActionResult<IReadOnlyList<IncidentResponse>>> GetRecent(CancellationToken cancellationToken)
    {
        var incidents = await incidentService.GetRecentAsync(cancellationToken);
        return Ok(incidents);
    }

    [HttpGet("{id:guid}")]
    [ProducesResponseType(typeof(IncidentResponse), StatusCodes.Status200OK)]
    [ProducesResponseType(StatusCodes.Status404NotFound)]
    public async Task<ActionResult<IncidentResponse>> GetById(Guid id, CancellationToken cancellationToken)
    {
        var incident = await incidentService.GetByIdAsync(id, cancellationToken);
        return incident is null ? NotFound() : Ok(incident);
    }

    [HttpPost]
    [ProducesResponseType(typeof(IncidentResponse), StatusCodes.Status201Created)]
    [ProducesResponseType(StatusCodes.Status400BadRequest)]
    public async Task<ActionResult<IncidentResponse>> Create(
        [FromBody] CreateIncidentRequest request,
        CancellationToken cancellationToken)
    {
        var incident = await incidentService.CreateAsync(request, cancellationToken);
        return CreatedAtAction(nameof(GetById), new { id = incident.Id }, incident);
    }
}
