using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Chronicle.Plugins.Core
{
    public interface IPlugable
    {
        public string PluginName { get; }
        public string PluginDescription { get; }
        public Version Version { get; }

        public int Execute();
    }
}
