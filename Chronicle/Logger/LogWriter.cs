using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Chronicle.Plugins.Core;
using Serilog;

namespace Chronicle.Logger
{
    public class LogWriter
    {
        public static void DoInit()
        {
            Log.Logger = new LoggerConfiguration()
                .WriteTo.File(Globals.LogPath,
                rollingInterval: RollingInterval.Day,
                rollOnFileSizeLimit: true)
                .CreateLogger();
            Log.Logger.Information("Program Started");
            Log.Logger.Information($"Chronicle Software Solutions {Globals.BaseAppVersion.ToString()}");
            Log.Logger.Information("-------------------------------------------------------");

            Log.Logger.Information($"{Globals.PluginManager.plugins.Count} Plugins Loaded.");
            foreach (var item in Globals.PluginManager.plugins.Keys)
            {
                IPlugable currentPlugin = Globals.PluginManager.plugins[item];
                Log.Logger.Information($"{item}\r\n\tDescription: {currentPlugin.PluginDescription}\r\n\tVersion: {currentPlugin.Version.ToString()}\r\n\tNamespace: {currentPlugin.GetType().Namespace}");                

            }
        }

        public static void Close()
        {
            Log.CloseAndFlush();
        }
    }
}
