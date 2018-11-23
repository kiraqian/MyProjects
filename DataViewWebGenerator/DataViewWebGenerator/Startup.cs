using Microsoft.Owin;
using Owin;

[assembly: OwinStartupAttribute(typeof(DataViewWebGenerator.Startup))]
namespace DataViewWebGenerator
{
    public partial class Startup {
        public void Configuration(IAppBuilder app) {
            ConfigureAuth(app);
        }
    }
}
