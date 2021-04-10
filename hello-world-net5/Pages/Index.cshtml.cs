using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Mvc.RazorPages;
using Microsoft.Extensions.Logging;

namespace hello_world_net5.Pages
{
    public class IndexModel : PageModel
    {
        private readonly ILogger<IndexModel> _logger;

        public string ComputerName { get; private set; } =  Environment.GetEnvironmentVariable("COMPUTERNAME");
        public string DockerImage { get; private set; } = Environment.GetEnvironmentVariable("DOCKER_CUSTOM_IMAGE_NAME");

        public IndexModel(ILogger<IndexModel> logger)
        {
            _logger = logger;
        }

        public void OnGet()
        {
            
        }
    }
}
