using Microsoft.AspNetCore.Mvc;

namespace G2PracticaProgramada1.Controllers
{
    public class HomeController : Controller
    {

        public IActionResult Home()
        {
            return View();
        }
    }
}
