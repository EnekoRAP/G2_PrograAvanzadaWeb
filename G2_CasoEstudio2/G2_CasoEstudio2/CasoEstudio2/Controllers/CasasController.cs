using CasoEstudio2.Models;
using Dapper;
using Microsoft.AspNetCore.Mvc;
using Microsoft.Data.SqlClient;

namespace CasoEstudio2.Controllers
{
    public class CasasController : Controller
    {
        private readonly IConfiguration _configuration;
        public CasasController(IConfiguration configuration)
        {

            _configuration = configuration;
        }

        [HttpGet]
        public IActionResult Consulta()
        {
            var casas = new List<CasasModel>();

                using (var context = new SqlConnection(_configuration.GetSection("ConnectionStrings:BDConnection").Value))
                {
                    casas = context.Query<CasasModel>("ConsultarCasas",
                        commandType: System.Data.CommandType.StoredProcedure).ToList();
                }

            return View(casas);
        }

        [HttpGet]
        public IActionResult Alquiler()
        {
            PoblarCasasViewbag();
            return View();
        }

        [HttpPost]
        public IActionResult Alquiler(CasasModel model)
        {

            using (var context = new SqlConnection(_configuration.GetSection("ConnectionStrings:BDConnection").Value))
            {
                var result = context.Execute("AlquilarCasa", new { model.IdCasa, model.UsuarioAlquiler});
            }

            return RedirectToAction("Consulta", "Casas");
        }

        private void PoblarCasasViewbag()
        {
            using (var context = new SqlConnection(_configuration.GetSection("ConnectionStrings:BDConnection").Value))
            {
                var casas = context.Query<CasasModel>("ConsultarCasas", commandType: System.Data.CommandType.StoredProcedure).ToList();
                var casasDisponibles = casas.Where(c => c.FechaAlquiler == null).ToList();

                ViewBag.Casas = casasDisponibles;
            }
        }
    }
}
