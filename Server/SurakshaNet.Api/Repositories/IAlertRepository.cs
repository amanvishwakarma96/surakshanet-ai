using SurakshaNet.Api.Models;

namespace SurakshaNet.Api.Repositories;

public interface IAlertRepository
{
    Task<IReadOnlyList<Alert>> GetPublishedActiveAsync(CancellationToken cancellationToken);
}
