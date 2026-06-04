using Microsoft.AspNetCore.Mvc;
using SurakshaNet.Api.DTOs;
using SurakshaNet.Api.Services;

namespace SurakshaNet.Api.Controllers;

[ApiController]
[Route("api/[controller]")]
public sealed class ModulesController(IModuleStatusService moduleStatusService) : ControllerBase
{
    [HttpGet]
    [ProducesResponseType(typeof(IReadOnlyList<ModuleStatusResponse>), StatusCodes.Status200OK)]
    public ActionResult<IReadOnlyList<ModuleStatusResponse>> GetInitialModules()
    {
        return Ok(moduleStatusService.GetInitialModuleStatuses());
    }
}
