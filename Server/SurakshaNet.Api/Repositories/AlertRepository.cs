using Microsoft.EntityFrameworkCore;
using SurakshaNet.Api.Data;
using SurakshaNet.Api.Models;

namespace SurakshaNet.Api.Repositories;

public sealed class AlertRepository(SurakshaNetDbContext dbContext) : IAlertRepository
{
    public async Task<IReadOnlyList<Alert>> GetPublishedActiveAsync(CancellationToken cancellationToken)
    {
        var now = DateTimeOffset.UtcNow;

        return await dbContext.Alerts
            .AsNoTracking()
            .Include(alert => alert.GeoFence)
            .Where(alert => alert.Status == "Published")
            .Where(alert => alert.PublishedAt != null)
            .Where(alert => alert.ExpiresAt == null || alert.ExpiresAt > now)
            .Where(alert => alert.GeoFence.IsActive)
            .OrderByDescending(alert => alert.PublishedAt)
            .Take(100)
            .ToListAsync(cancellationToken);
    }
}
