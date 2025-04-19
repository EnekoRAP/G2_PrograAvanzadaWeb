using Microsoft.AspNetCore.Mvc;

namespace PracticaProgramada2_Web.Controllers
{
    public class HomeController : Controller
    {
        public IActionResult Index()
        {
            return View();
        }
    }
}
