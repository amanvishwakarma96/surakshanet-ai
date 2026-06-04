using SurakshaNet.Api.DTOs;

namespace SurakshaNet.Api.Services;

public interface IGeoFenceAlertService
{
    Task<IReadOnlyList<GeoFenceAlertResponse>> GetNearbyAlertsAsync(
        decimal? approximateLatitude,
        decimal? approximateLongitude,
        CancellationToken cancellationToken);
}
