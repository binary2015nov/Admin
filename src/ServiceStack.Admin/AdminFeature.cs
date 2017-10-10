using System.Web;
using ServiceStack.Host.Handlers;

namespace ServiceStack.Admin
{
    public class AdminFeature : IPlugin, IPreInitPlugin
    {
        public void Configure(IAppHost appHost)
        {
            appHost.Config.EmbeddedResourceSources.Add(GetType().GetAssembly());
        }

        public void Register(IAppHost appHost)
        {
            var indexHtml = appHost.VirtualFileSources.GetFile("ss_admin/index.html").ReadAllText();

            appHost.CatchAllHandlers.Add((httpMethod, pathInfo, filePath) => 
                pathInfo.StartsWith("/ss_admin") 
                    ? (pathInfo == "/ss_admin/index.html" || !appHost.VirtualFileSources.FileExists(pathInfo)
                        ? new CustomActionHandlerAsync(async (req, res) => {
                            res.ContentType = MimeTypes.Html;
                            await res.WriteAsync(indexHtml.Replace("/dist", req.ResolveAbsoluteUrl("~/ss_admin/dist")));
                        }) as IHttpHandler
                        : new StaticFileHandler(appHost.VirtualFileSources.GetFile(pathInfo)))
                    : null);

            appHost.GetPlugin<MetadataFeature>()
                ?.AddLink(MetadataFeature.PluginLinks, "ss_admin/autoquery/", "AutoQuery Viewer");
        }
    }
}
