using Microsoft.AspNetCore.Mvc;

namespace G2PracticaProgramada1.Controllers
{
    public class LoginController : Controller
    {
        public IActionResult Login()
        {
            return View();
        }
    }
}
