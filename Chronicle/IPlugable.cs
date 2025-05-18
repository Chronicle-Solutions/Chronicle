using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Chronicle.Plugins.Core
{
    public abstract class IPlugable
    {
        public abstract string PluginName { get; }
        public abstract string PluginDescription { get; }
        public abstract Version Version { get; }

        public abstract int Execute();

        public int CleanUp()
        {

            return 0;
        }
    }
}
