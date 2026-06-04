using SurakshaNet.Api.DTOs;

namespace SurakshaNet.Api.Services;

public interface IModuleStatusService
{
    IReadOnlyList<ModuleStatusResponse> GetInitialModuleStatuses();
}
