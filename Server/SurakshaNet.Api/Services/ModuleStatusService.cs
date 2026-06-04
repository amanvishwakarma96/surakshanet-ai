using SurakshaNet.Api.DTOs;

namespace SurakshaNet.Api.Services;

public sealed class ModuleStatusService : IModuleStatusService
{
    private static readonly ModuleStatusResponse[] InitialModules =
    [
        new("Auth", "Foundation", "JWT bearer authentication is wired for future protected endpoints."),
        new("Users", "Foundation", "User model and data set are available."),
        new("Incidents", "Foundation", "Basic incident create/read endpoints exist for MVP integration."),
        new("GeoFences", "FlowReady", "Published active geo-fenced alerts can be matched with approximate location."),
        new("PublicBoard", "Foundation", "Public board model is available; records should be archived, not silently deleted."),
        new("Solutions", "Foundation", "Solution suggestion model and module placeholder are registered."),
        new("HelperRequests", "Foundation", "Helper request model defaults to approximate location workflows."),
        new("AuditLogs", "Foundation", "Audit log persistence and read endpoint exist for sensitive action trails.")
    ];

    public IReadOnlyList<ModuleStatusResponse> GetInitialModuleStatuses()
    {
        return InitialModules;
    }
}
