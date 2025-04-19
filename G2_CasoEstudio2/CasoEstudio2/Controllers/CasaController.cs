using Microsoft.AspNetCore.Mvc;

namespace CasoEstudio2.Controllers
{
    public class CasaController : Controller
    {
        public IActionResult Index()
        {
            return View();
        }
    }
}
