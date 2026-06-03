using System.Security.Claims;

namespace SurakshaNet.Api.Helpers;

public static class ClaimsPrincipalExtensions
{
    public static int GetUserId(this ClaimsPrincipal user)
    {
        var id = user.FindFirstValue(ClaimTypes.NameIdentifier);
        return int.TryParse(id, out var value) ? value : 1; // Swagger/dev fallback for MVP only.
    }
}
