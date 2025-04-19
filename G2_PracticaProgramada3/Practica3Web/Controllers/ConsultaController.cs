using Microsoft.AspNetCore.Mvc;
using PracticaProgramada2_Web.Models;
using System.Text.Json;

namespace PracticaProgramada2_Web.Controllers
{
    public class ConsultaController : Controller
    {
        private readonly IHttpClientFactory _httpClient;
        private readonly IConfiguration _configuration;
        public ConsultaController(IHttpClientFactory httpClient, IConfiguration configuration)
        {
            _httpClient = httpClient;
            _configuration = configuration;
        }

        [HttpGet]
        public IActionResult Consulta()
        {
            using (var api = _httpClient.CreateClient())
            {
                var url = "https://localhost:7256/api/Consulta/Consulta";
                var result = api.GetAsync(url).Result;

                if (result.IsSuccessStatusCode)
                {
                    var content = result.Content.ReadAsStringAsync().Result;

                    var respuesta = JsonSerializer.Deserialize<RespuestaModel>(content,
                        new JsonSerializerOptions { PropertyNameCaseInsensitive = true });

                    if (respuesta != null && respuesta.Indicador && respuesta.Datos != null)
                    {
                        var comprasJson = JsonSerializer.Serialize(respuesta.Datos);
                        var compras = JsonSerializer.Deserialize<List<ComprasModel>>(comprasJson,
                            new JsonSerializerOptions { PropertyNameCaseInsensitive = true });

                        return View(compras);
                    }
                }
            }
            return View(new List<ComprasModel>());
        }
    }

}