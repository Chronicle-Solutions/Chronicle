using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;
using System.Xml;

namespace Chronicle
{
    public partial class NewEnv : Form
    {
        public NewEnv()
        {
            InitializeComponent();
        }

        public string getEnvironment()
        {
            ShowDialog();
            XmlDocument doc = new XmlDocument();
            doc.Load("");
            return textBox1.Text;
        }
    }
}
