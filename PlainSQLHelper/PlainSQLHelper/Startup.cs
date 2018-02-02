using Microsoft.Owin;
using Owin;

[assembly: OwinStartupAttribute(typeof(PlainSQLHelper.Startup))]
namespace PlainSQLHelper
{
    public partial class Startup {
        public void Configuration(IAppBuilder app) {
            ConfigureAuth(app);
        }
    }
}
