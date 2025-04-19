using Microsoft.AspNetCore.Mvc;
using System.Text.Json;
using PracticaProgramada2_Web.Models;
using System.Net.Http.Headers;

namespace PracticaProgramada2_Web.Controllers
{
    public class RegistroController : Controller
    {
        private readonly IHttpClientFactory _httpClient;
        private readonly IConfiguration _configuration;

        public RegistroController(IHttpClientFactory httpClient, IConfiguration configuration)
        {
            _httpClient = httpClient;
            _configuration = configuration;
        }

        [HttpGet]
        public IActionResult Registro()
        {
            using (var api = _httpClient.CreateClient())
            {
                var url = "https://localhost:7256/api/Registro/Registro";
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

                        TempData["Compras"] = JsonSerializer.Serialize(compras); 
                        return View(compras);
                    }
                }
            }

            TempData["Compras"] = JsonSerializer.Serialize(new List<ComprasModel>());
            return View(new List<ComprasModel>());
        }

        [HttpPost]
        public IActionResult Registro(AbonoModel model)
        {
            using (var api = _httpClient.CreateClient())
            {
                var url = "https://localhost:7256/api/Registro/Registro";
                var response = api.PostAsJsonAsync(url, model).Result;

                if (response.IsSuccessStatusCode)
                {
                    var content = response.Content.ReadAsStringAsync().Result;

                    var result = JsonSerializer.Deserialize<RespuestaModel>(content,
                        new JsonSerializerOptions { PropertyNameCaseInsensitive = true });

                    if (result != null && result.Indicador)
                    {
                        return RedirectToAction("Consulta", "Consulta");
                    }
                }
            }

            var comprasJson = TempData["Compras"]?.ToString();
            var compras = comprasJson != null
                ? JsonSerializer.Deserialize<List<ComprasModel>>(comprasJson,
                    new JsonSerializerOptions { PropertyNameCaseInsensitive = true })
                : new List<ComprasModel>();

            TempData["Compras"] = comprasJson;
            return View(compras);
        }
    }
}