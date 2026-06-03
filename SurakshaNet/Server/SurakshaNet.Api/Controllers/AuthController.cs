using Microsoft.AspNetCore.Mvc;
using SurakshaNet.Api.DTOs;
using SurakshaNet.Api.Services;

namespace SurakshaNet.Api.Controllers;

[ApiController]
[Route("api/auth")]
public class AuthController(IAuthService auth) : ControllerBase
{
    [HttpPost("register")]
    public async Task<ActionResult<AuthResponseDto>> Register(RegisterRequestDto request) => Ok(await auth.RegisterAsync(request));

    [HttpPost("login")]
    public async Task<ActionResult<AuthResponseDto>> Login(LoginRequestDto request)
    {
        var result = await auth.LoginAsync(request);
        return result is null ? Unauthorized(new { message = "Invalid credentials" }) : Ok(result);
    }
}
