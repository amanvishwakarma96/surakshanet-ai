using Microsoft.EntityFrameworkCore;
using SurakshaNet.Api.Data;
using SurakshaNet.Api.Models;

namespace SurakshaNet.Api.Repositories;

public sealed class IncidentRepository(SurakshaNetDbContext dbContext) : IIncidentRepository
{
    public async Task<IReadOnlyList<Incident>> GetRecentAsync(CancellationToken cancellationToken)
    {
        return await dbContext.Incidents
            .AsNoTracking()
            .OrderByDescending(incident => incident.CreatedAt)
            .Take(50)
            .ToListAsync(cancellationToken);
    }

    public async Task<Incident?> GetByIdAsync(Guid id, CancellationToken cancellationToken)
    {
        return await dbContext.Incidents
            .AsNoTracking()
            .FirstOrDefaultAsync(incident => incident.Id == id, cancellationToken);
    }

    public async Task<Incident> AddAsync(Incident incident, CancellationToken cancellationToken)
    {
        dbContext.Incidents.Add(incident);
        await dbContext.SaveChangesAsync(cancellationToken);
        return incident;
    }
}
