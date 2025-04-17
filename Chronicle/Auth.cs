using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Diagnostics;
using System.Drawing;
using System.Linq;
using System.Net.Http;
using System.Runtime.CompilerServices;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;
using System.Text.Json;
using System.Net.Http.Json;
using System.Text.Json.Serialization.Metadata;
using System.Security.Policy;


namespace Chronicle
{
    public partial class Auth : Form
    {

        public string userid { get => txtuserID.Text; }
        public string password { get => txtUserPass.Text; }

        public string environment { get => environmentBox.Text; }

        HttpClient client;

        ToolTip tooltip = new ToolTip();

        public Auth()
        {
            InitializeComponent();
            client = new HttpClient();
            client.BaseAddress = new Uri(Globals.AuthServer);

            var task = Task.Run(() => client.GetAsync("environments"));
            task.Wait();
            var task2 = Task.Run(() => task.Result.Content.ReadAsStringAsync());
            var response = task2.Result;
            environmentBox.Items.AddRange(JsonSerializer.Deserialize<List<string>>(response).ToArray());
            if (environmentBox.Items.Count == 0)
            {
                throw new Exception("Failed to get any environments from Auth Endpoint.");
            }

            environmentBox.SelectedIndex = 0;
            if (environmentBox.Items.Count == 1)
            {
                environmentBox.Enabled = false;
            }


        }

        private void button1_Click(object sender, EventArgs e)
        {
            var requestData = new { 
                operatorID = txtuserID.Text,
                password = txtUserPass.Text
            };

            var webRequest = new HttpRequestMessage(HttpMethod.Post, $"/login/{environmentBox.Text}/")
            {
                Content = new StringContent(JsonSerializer.Serialize(requestData), Encoding.UTF8, "application/json")
            };

            var response = client.Send(webRequest);
            if (response.StatusCode != System.Net.HttpStatusCode.OK)
            {
                switch (response.StatusCode)
                {
                    case System.Net.HttpStatusCode.InternalServerError:
                        MessageBox.Show("An unknown error occured while trying to authenticate with the server.", "Internal Server Error", MessageBoxButtons.OK, MessageBoxIcon.Error);
                        return;
                    case System.Net.HttpStatusCode.Unauthorized:
                    case System.Net.HttpStatusCode.Forbidden:
                        MessageBox.Show("Invalid username or password.", "Unauthorized", MessageBoxButtons.OK, MessageBoxIcon.Error);
                        return;
                    default:
                        MessageBox.Show("An unknown error occured. Please contact support.", response.StatusCode.ToString(), MessageBoxButtons.OK, MessageBoxIcon.Error);
                        return;
                }
            }

            StreamReader reader = new StreamReader(response.Content.ReadAsStream());

            Dictionary<string, string> data = JsonSerializer.Deserialize<Dictionary<string, string>>(reader.ReadToEnd());

            reader.Close();

            Globals.Username = data["apUser"];
            Globals.OperatorID = data["operatorID"];
            Globals.Password = data["apPass"];
            Globals.Host = data["apHost"];
            Globals.Port = UInt32.Parse(data["apPort"]);
            Globals.Database = data["apName"];
            DialogResult = DialogResult.OK;

        }
    }

}
