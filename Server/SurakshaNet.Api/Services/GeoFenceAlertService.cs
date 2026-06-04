using SurakshaNet.Api.DTOs;
using SurakshaNet.Api.Models;
using SurakshaNet.Api.Repositories;

namespace SurakshaNet.Api.Services;

public sealed class GeoFenceAlertService(IAlertRepository alertRepository) : IGeoFenceAlertService
{
    private const string PrivacyNote = "Uses approximate location only; reporter identity and exact coordinates are not exposed.";

    public async Task<IReadOnlyList<GeoFenceAlertResponse>> GetNearbyAlertsAsync(
        decimal? approximateLatitude,
        decimal? approximateLongitude,
        CancellationToken cancellationToken)
    {
        var alerts = await alertRepository.GetPublishedActiveAsync(cancellationToken);
        var hasApproximateLocation = approximateLatitude.HasValue && approximateLongitude.HasValue;

        return alerts
            .Select(alert => ToResponse(alert, hasApproximateLocation
                ? CalculateDistanceMeters(
                    (double)approximateLatitude!.Value,
                    (double)approximateLongitude!.Value,
                    (double)alert.GeoFence.CenterLatitude,
                    (double)alert.GeoFence.CenterLongitude)
                : null))
            .Where(alert => alert.DistanceMeters is null || alert.DistanceMeters <= alert.RadiusMeters)
            .OrderBy(alert => alert.DistanceMeters ?? double.MaxValue)
            .ThenByDescending(alert => alert.PublishedAt)
            .ToList();
    }

    private static GeoFenceAlertResponse ToResponse(Alert alert, double? distanceMeters)
    {
        return new GeoFenceAlertResponse(
            alert.Id,
            alert.Title,
            alert.Message,
            alert.Severity,
            alert.GeoFence.HazardType,
            alert.GeoFence.Name,
            alert.GeoFence.RadiusMeters,
            distanceMeters is null ? null : Math.Round(distanceMeters.Value),
            alert.PublishedAt,
            alert.ExpiresAt,
            PrivacyNote);
    }

    private static double CalculateDistanceMeters(
        double fromLatitude,
        double fromLongitude,
        double toLatitude,
        double toLongitude)
    {
        const double earthRadiusMeters = 6371000;
        var latitudeDelta = DegreesToRadians(toLatitude - fromLatitude);
        var longitudeDelta = DegreesToRadians(toLongitude - fromLongitude);
        var fromLatitudeRadians = DegreesToRadians(fromLatitude);
        var toLatitudeRadians = DegreesToRadians(toLatitude);

        var haversine = Math.Sin(latitudeDelta / 2) * Math.Sin(latitudeDelta / 2)
            + Math.Cos(fromLatitudeRadians) * Math.Cos(toLatitudeRadians)
            * Math.Sin(longitudeDelta / 2) * Math.Sin(longitudeDelta / 2);

        return earthRadiusMeters * 2 * Math.Atan2(Math.Sqrt(haversine), Math.Sqrt(1 - haversine));
    }

    private static double DegreesToRadians(double degrees)
    {
        return degrees * Math.PI / 180;
    }
}
