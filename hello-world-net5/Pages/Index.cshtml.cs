using System;
using System.Collections;
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

        public IDictionary EnvVars { get; private set; }
        public string ComputerName { get; private set; } = Environment.GetEnvironmentVariable("COMPUTERNAME");
        public string DockerImage { get; private set; } = Environment.GetEnvironmentVariable("CONTAINER_CONFIGURED");

        public IndexModel(ILogger<IndexModel> logger)
        {
            _logger = logger;
        }

        public void OnGet()
        {
            EnvVars = Environment.GetEnvironmentVariables();
        }
    }
}
