using Dapper;
using Microsoft.AspNetCore.Mvc;
using Microsoft.Data.SqlClient;
using PracticaProgramada2_Api.Models;

namespace PracticaProgramada2_Api.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class ConsultaController : ControllerBase
    {
        private readonly IConfiguration _configuration;

        public ConsultaController(IConfiguration configuration)
        {
            _configuration = configuration;
        }

        [HttpGet]
        [Route("Consulta")]
        public IActionResult Consulta()
        {
            using var context = new SqlConnection(_configuration.GetSection("ConnectionStrings:BDConnection").Value);
            var result = context.Query<ComprasModel>("ObtenerCompras").ToList();

            var respuesta = new RespuestaModel();

            if (result != null)
            {
                respuesta.Indicador = true;
                respuesta.Mensaje = "Información consultada";
                respuesta.Datos = result;
            }
            else
            {
                respuesta.Indicador = false;
                respuesta.Mensaje = "No hay información registrada en este momento";
            }

            return Ok(respuesta);
        }
    }
}
