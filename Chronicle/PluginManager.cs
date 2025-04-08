using System;
using System.Collections;
using System.Collections.Generic;
using System.Linq;
using System.Reflection;
using System.Text;
using System.Threading.Tasks;

namespace Chronicle
{
    internal class PluginManager
    {
        Dictionary<string, Assembly> plugins = new Dictionary<string, Assembly>();
        public PluginManager() { 
        }
    }
}
