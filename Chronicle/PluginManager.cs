using System;
using System.Collections;
using System.Collections.Generic;
using System.Linq;
using System.Reflection;
using System.Runtime.Loader;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Input;
using Chronicle.Plugins.Core;

namespace Chronicle
{
    public class PluginManager
    {
        public Dictionary<string, IPlugable> plugins { get => _plugins; }
        Dictionary<string, IPlugable> _plugins = new Dictionary<string, IPlugable>();
        public PluginManager()
        {
            string[] pluginPaths = new string[] {
               Path.Join(Environment.GetFolderPath(Environment.SpecialFolder.ApplicationData), "Chronicle", "plugins")
            };

            foreach(string pluginPath in pluginPaths)
            {
                string[] fileEntries = Directory.GetFiles(pluginPath);
                foreach(string file in fileEntries)
                {
                    if (!file.EndsWith(".dll")) continue;
                    Assembly? pluginAssembly = LoadPlugin(file);
                    if (pluginAssembly is null) continue;
                    IEnumerable<IPlugable> plugins = CreateCommands(pluginAssembly);
                    foreach(IPlugable plugin in plugins)
                    {
                        this._plugins[plugin.PluginName] = plugin;
                    }
                }
            }
        }

        static Assembly? LoadPlugin(string absolutePath)
        {
            string pluginLocation = Path.GetFullPath(absolutePath.Replace('\\', Path.DirectorySeparatorChar));
            if (!pluginLocation.Contains("Chronicle.")) return null;
            Console.WriteLine($"Loading commands from: {pluginLocation}");
            PluginLoadContext loadContext = new PluginLoadContext(pluginLocation);
            return loadContext.LoadFromAssemblyName(new AssemblyName(Path.GetFileNameWithoutExtension(pluginLocation)));
        }

        static IEnumerable<IPlugable> CreateCommands(Assembly assembly)
        {
            int count = 0;

            foreach (Type type in assembly.GetTypes())
            {
                if (typeof(IPlugable).IsAssignableFrom(type))
                {
                    object? objResult = Activator.CreateInstance(type);
                    IPlugable? result = objResult as IPlugable;
                    if (result != null)
                    {
                        count++;
                        yield return result;
                    }
                }
            }

            if (count == 0)
            {
                string availableTypes = string.Join(",", assembly.GetTypes().Select(t => t.FullName));
                throw new ApplicationException(
                    $"Can't find any type which implements ICommand in {assembly} from {assembly.Location}.\n" +
                    $"Available types: {availableTypes}");
            }

        }

        public int ExecutePlugin(string pluginName)
        {
            IPlugable? plugin;
            if(_plugins.TryGetValue(pluginName, out plugin))
            {
                return plugin.Execute();
            }
            throw new Exception($"Could not find plugin with name {pluginName}");
        }
    }


    class PluginLoadContext : AssemblyLoadContext
    {
        private AssemblyDependencyResolver _resolver;

        public PluginLoadContext(string pluginPath)
        {
            _resolver = new AssemblyDependencyResolver(pluginPath);
        }

        protected override Assembly? Load(AssemblyName assemblyName)
        {
            string? assemblyPath = _resolver.ResolveAssemblyToPath(assemblyName);
            if (assemblyPath != null)
            {
                return LoadFromAssemblyPath(assemblyPath);
            }

            return null;
        }

        protected override IntPtr LoadUnmanagedDll(string unmanagedDllName)
        {
            string? libraryPath = _resolver.ResolveUnmanagedDllToPath(unmanagedDllName);
            if (libraryPath != null)
            {
                return LoadUnmanagedDllFromPath(libraryPath);
            }

            return IntPtr.Zero;
        }
    }
    
}
