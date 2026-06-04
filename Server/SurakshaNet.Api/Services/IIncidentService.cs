using SurakshaNet.Api.DTOs;

namespace SurakshaNet.Api.Services;

public interface IIncidentService
{
    Task<IReadOnlyList<IncidentResponse>> GetRecentAsync(CancellationToken cancellationToken);

    Task<IncidentResponse?> GetByIdAsync(Guid id, CancellationToken cancellationToken);

    Task<IncidentResponse> CreateAsync(CreateIncidentRequest request, CancellationToken cancellationToken);
}
