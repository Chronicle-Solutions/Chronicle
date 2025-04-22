namespace Chronicle
{
    partial class Auth
    {
        /// <summary>
        /// Required designer variable.
        /// </summary>
        private System.ComponentModel.IContainer components = null;

        /// <summary>
        /// Clean up any resources being used.
        /// </summary>
        /// <param name="disposing">true if managed resources should be disposed; otherwise, false.</param>
        protected override void Dispose(bool disposing)
        {
            if (disposing && (components != null))
            {
                components.Dispose();
            }
            base.Dispose(disposing);
        }

        #region Windows Form Designer generated code

        /// <summary>
        /// Required method for Designer support - do not modify
        /// the contents of this method with the code editor.
        /// </summary>
        private void InitializeComponent()
        {
            txtuserID = new TextBox();
            txtUserPass = new TextBox();
            groupBox1 = new GroupBox();
            label4 = new Label();
            environmentBox = new ComboBox();
            button2 = new Button();
            button1 = new Button();
            label2 = new Label();
            label1 = new Label();
            pictureBox1 = new PictureBox();
            label3 = new Label();
            groupBox1.SuspendLayout();
            ((System.ComponentModel.ISupportInitialize)pictureBox1).BeginInit();
            SuspendLayout();
            // 
            // txtuserID
            // 
            txtuserID.Location = new Point(68, 20);
            txtuserID.Margin = new Padding(3, 2, 3, 2);
            txtuserID.Name = "txtuserID";
            txtuserID.Size = new Size(265, 23);
            txtuserID.TabIndex = 0;
            txtuserID.KeyDown += txtUserPass_KeyDown;
            // 
            // txtUserPass
            // 
            txtUserPass.Location = new Point(425, 20);
            txtUserPass.Margin = new Padding(3, 2, 3, 2);
            txtUserPass.Name = "txtUserPass";
            txtUserPass.Size = new Size(265, 23);
            txtUserPass.TabIndex = 1;
            txtUserPass.UseSystemPasswordChar = true;
            txtUserPass.KeyDown += txtUserPass_KeyDown;
            // 
            // groupBox1
            // 
            groupBox1.Controls.Add(label4);
            groupBox1.Controls.Add(environmentBox);
            groupBox1.Controls.Add(button2);
            groupBox1.Controls.Add(button1);
            groupBox1.Controls.Add(label2);
            groupBox1.Controls.Add(label1);
            groupBox1.Controls.Add(txtuserID);
            groupBox1.Controls.Add(txtUserPass);
            groupBox1.Dock = DockStyle.Bottom;
            groupBox1.Location = new Point(0, 263);
            groupBox1.Margin = new Padding(3, 2, 3, 2);
            groupBox1.Name = "groupBox1";
            groupBox1.Padding = new Padding(3, 2, 3, 2);
            groupBox1.Size = new Size(700, 75);
            groupBox1.TabIndex = 2;
            groupBox1.TabStop = false;
            groupBox1.Text = "Log In!";
            // 
            // label4
            // 
            label4.AutoSize = true;
            label4.Location = new Point(380, 51);
            label4.Name = "label4";
            label4.Size = new Size(75, 15);
            label4.TabIndex = 7;
            label4.Text = "Environment";
            // 
            // environmentBox
            // 
            environmentBox.FormattingEnabled = true;
            environmentBox.Location = new Point(461, 47);
            environmentBox.Name = "environmentBox";
            environmentBox.Size = new Size(157, 23);
            environmentBox.TabIndex = 6;
            // 
            // button2
            // 
            button2.DialogResult = DialogResult.Cancel;
            button2.Location = new Point(13, 49);
            button2.Margin = new Padding(3, 2, 3, 2);
            button2.Name = "button2";
            button2.Size = new Size(66, 22);
            button2.TabIndex = 5;
            button2.Text = "Cancel";
            button2.UseVisualStyleBackColor = true;
            // 
            // button1
            // 
            button1.Location = new Point(624, 49);
            button1.Margin = new Padding(3, 2, 3, 2);
            button1.Name = "button1";
            button1.Size = new Size(66, 22);
            button1.TabIndex = 4;
            button1.Text = "Log In";
            button1.UseVisualStyleBackColor = true;
            button1.Click += button1_Click;
            // 
            // label2
            // 
            label2.AutoSize = true;
            label2.Location = new Point(359, 22);
            label2.Name = "label2";
            label2.Size = new Size(57, 15);
            label2.TabIndex = 3;
            label2.Text = "Password";
            // 
            // label1
            // 
            label1.AutoSize = true;
            label1.Location = new Point(13, 22);
            label1.Name = "label1";
            label1.Size = new Size(44, 15);
            label1.TabIndex = 2;
            label1.Text = "User ID";
            // 
            // pictureBox1
            // 
            pictureBox1.Image = Properties.Resources.Chronicle;
            pictureBox1.Location = new Point(292, -2);
            pictureBox1.Margin = new Padding(3, 2, 3, 2);
            pictureBox1.Name = "pictureBox1";
            pictureBox1.Size = new Size(408, 268);
            pictureBox1.SizeMode = PictureBoxSizeMode.Zoom;
            pictureBox1.TabIndex = 3;
            pictureBox1.TabStop = false;
            // 
            // label3
            // 
            label3.AutoSize = true;
            label3.Font = new Font("OCR A Extended", 35F, FontStyle.Italic);
            label3.Location = new Point(12, 65);
            label3.Name = "label3";
            label3.Size = new Size(274, 147);
            label3.TabIndex = 4;
            label3.Text = "Chronicle\r\nSoftware\r\nSolutions";
            // 
            // Auth
            // 
            AutoScaleDimensions = new SizeF(7F, 15F);
            AutoScaleMode = AutoScaleMode.Font;
            ClientSize = new Size(700, 338);
            ControlBox = false;
            Controls.Add(label3);
            Controls.Add(pictureBox1);
            Controls.Add(groupBox1);
            FormBorderStyle = FormBorderStyle.FixedDialog;
            Margin = new Padding(3, 2, 3, 2);
            Name = "Auth";
            Text = "Chronicle Solutions";
            groupBox1.ResumeLayout(false);
            groupBox1.PerformLayout();
            ((System.ComponentModel.ISupportInitialize)pictureBox1).EndInit();
            ResumeLayout(false);
            PerformLayout();
        }

        #endregion

        private TextBox txtuserID;
        private TextBox txtUserPass;
        private GroupBox groupBox1;
        private Button button2;
        private Button button1;
        private Label label2;
        private Label label1;
        private PictureBox pictureBox1;
        private Label label3;
        private Label label4;
        private ComboBox environmentBox;
    }
}