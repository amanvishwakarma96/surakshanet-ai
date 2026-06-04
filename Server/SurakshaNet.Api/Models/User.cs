namespace SurakshaNet.Api.Models;

public sealed class User : BaseEntity
{
    public string DisplayName { get; set; } = string.Empty;

    public string Email { get; set; } = string.Empty;

    public string Role { get; set; } = "Resident";

    public bool IsActive { get; set; } = true;
}
