using SurakshaNet.Api.Models;

namespace SurakshaNet.Api.Repositories;

public interface IIncidentRepository
{
    Task<IReadOnlyList<Incident>> GetRecentAsync(CancellationToken cancellationToken);

    Task<Incident?> GetByIdAsync(Guid id, CancellationToken cancellationToken);

    Task<Incident> AddAsync(Incident incident, CancellationToken cancellationToken);
}
