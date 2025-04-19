using System.Data;
using Dapper;
using Microsoft.AspNetCore.Mvc;
using Microsoft.Data.SqlClient;
using PracticaProgramada2_Api.Models;

namespace PracticaProgramada2_Api.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class RegistroController : ControllerBase
    {
        private readonly IConfiguration _configuration;

        public RegistroController(IConfiguration configuration)
        {
            _configuration = configuration;
        }

        [HttpGet]
        [Route("Registro")]
        public IActionResult ObtenerComprasPendientes()
        {
            using var context = new SqlConnection(_configuration.GetConnectionString("BDConnection"));
            var result = context.Query<ComprasModel>("ObtenerComprasPendientes").ToList();

            var respuesta = new RespuestaModel();

            if (result.Any())
            {
                respuesta.Indicador = true;
                respuesta.Mensaje = "Compras pendientes obtenidas correctamente.";
                respuesta.Datos = result;
            }
            else
            {
                respuesta.Indicador = false;
                respuesta.Mensaje = "No hay compras pendientes.";
            }

            return Ok(respuesta);
        }

        [HttpPost]
        [Route("Registro")]
        public IActionResult Registro(AbonoModel model)
        {
            using (var context = new SqlConnection(_configuration.GetSection("ConnectionStrings:BDConnection").Value))
            {
                var result = context.QueryFirstOrDefault<int>("InsertarAbono", new { model.Id_Compra, model.Monto });
                var respuesta = new RespuestaModel();

                if (result == 1)
                {
                    respuesta.Indicador = true;
                    respuesta.Mensaje = "Su información se ha registrado correctamente";
                }
                else
                {
                    respuesta.Indicador = false;
                    respuesta.Mensaje = "Su información no se ha registrado correctamente";
                }

                return Ok(respuesta);
            }
        }
    }
}