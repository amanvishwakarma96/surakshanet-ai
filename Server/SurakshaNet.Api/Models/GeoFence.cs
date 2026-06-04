namespace SurakshaNet.Api.Models;

public sealed class GeoFence : BaseEntity
{
    public string Name { get; set; } = string.Empty;

    public string HazardType { get; set; } = string.Empty;

    public decimal CenterLatitude { get; set; }

    public decimal CenterLongitude { get; set; }

    public int RadiusMeters { get; set; }

    public bool IsActive { get; set; } = true;
}
