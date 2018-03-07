namespace SQLRunner
{
    partial class SQLRunner
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
            this.gbDBCfg = new System.Windows.Forms.GroupBox();
            this.ckAfterRun = new System.Windows.Forms.CheckBox();
            this.ckPreRun = new System.Windows.Forms.CheckBox();
            this.btnSelectDir = new System.Windows.Forms.Button();
            this.txtFolderPath = new System.Windows.Forms.TextBox();
            this.label5 = new System.Windows.Forms.Label();
            this.btnLoad = new System.Windows.Forms.Button();
            this.btnRun = new System.Windows.Forms.Button();
            this.cmbDatabase = new System.Windows.Forms.ComboBox();
            this.label4 = new System.Windows.Forms.Label();
            this.btnTestConnection = new System.Windows.Forms.Button();
            this.txtPassword = new System.Windows.Forms.TextBox();
            this.label3 = new System.Windows.Forms.Label();
            this.txtUserName = new System.Windows.Forms.TextBox();
            this.label2 = new System.Windows.Forms.Label();
            this.txtServer = new System.Windows.Forms.TextBox();
            this.label1 = new System.Windows.Forms.Label();
            this.groupBox1 = new System.Windows.Forms.GroupBox();
            this.progressBar = new System.Windows.Forms.ProgressBar();
            this.dgvResults = new System.Windows.Forms.DataGridView();
            this.ckWinAuth = new System.Windows.Forms.CheckBox();
            this.gbDBCfg.SuspendLayout();
            this.groupBox1.SuspendLayout();
            ((System.ComponentModel.ISupportInitialize)(this.dgvResults)).BeginInit();
            this.SuspendLayout();
            // 
            // gbDBCfg
            // 
            this.gbDBCfg.Controls.Add(this.ckWinAuth);
            this.gbDBCfg.Controls.Add(this.ckAfterRun);
            this.gbDBCfg.Controls.Add(this.ckPreRun);
            this.gbDBCfg.Controls.Add(this.btnSelectDir);
            this.gbDBCfg.Controls.Add(this.txtFolderPath);
            this.gbDBCfg.Controls.Add(this.label5);
            this.gbDBCfg.Controls.Add(this.btnLoad);
            this.gbDBCfg.Controls.Add(this.btnRun);
            this.gbDBCfg.Controls.Add(this.cmbDatabase);
            this.gbDBCfg.Controls.Add(this.label4);
            this.gbDBCfg.Controls.Add(this.btnTestConnection);
            this.gbDBCfg.Controls.Add(this.txtPassword);
            this.gbDBCfg.Controls.Add(this.label3);
            this.gbDBCfg.Controls.Add(this.txtUserName);
            this.gbDBCfg.Controls.Add(this.label2);
            this.gbDBCfg.Controls.Add(this.txtServer);
            this.gbDBCfg.Controls.Add(this.label1);
            this.gbDBCfg.Location = new System.Drawing.Point(4, 2);
            this.gbDBCfg.Name = "gbDBCfg";
            this.gbDBCfg.Size = new System.Drawing.Size(830, 130);
            this.gbDBCfg.TabIndex = 1;
            this.gbDBCfg.TabStop = false;
            this.gbDBCfg.Text = "Configuration";
            // 
            // ckAfterRun
            // 
            this.ckAfterRun.AutoSize = true;
            this.ckAfterRun.Location = new System.Drawing.Point(559, 104);
            this.ckAfterRun.Name = "ckAfterRun";
            this.ckAfterRun.Size = new System.Drawing.Size(109, 17);
            this.ckAfterRun.TabIndex = 15;
            this.ckAfterRun.Text = "Include After-Run";
            this.ckAfterRun.UseVisualStyleBackColor = true;
            // 
            // ckPreRun
            // 
            this.ckPreRun.AutoSize = true;
            this.ckPreRun.Location = new System.Drawing.Point(450, 104);
            this.ckPreRun.Name = "ckPreRun";
            this.ckPreRun.Size = new System.Drawing.Size(103, 17);
            this.ckPreRun.TabIndex = 14;
            this.ckPreRun.Text = "Include Pre-Run";
            this.ckPreRun.UseVisualStyleBackColor = true;
            // 
            // btnSelectDir
            // 
            this.btnSelectDir.Location = new System.Drawing.Point(371, 73);
            this.btnSelectDir.Name = "btnSelectDir";
            this.btnSelectDir.Size = new System.Drawing.Size(32, 23);
            this.btnSelectDir.TabIndex = 13;
            this.btnSelectDir.Text = "...";
            this.btnSelectDir.UseVisualStyleBackColor = true;
            this.btnSelectDir.Click += new System.EventHandler(this.btnSelectDir_Click);
            // 
            // txtFolderPath
            // 
            this.txtFolderPath.Location = new System.Drawing.Point(75, 74);
            this.txtFolderPath.Name = "txtFolderPath";
            this.txtFolderPath.Size = new System.Drawing.Size(292, 20);
            this.txtFolderPath.TabIndex = 12;
            // 
            // label5
            // 
            this.label5.AutoSize = true;
            this.label5.Location = new System.Drawing.Point(34, 78);
            this.label5.Name = "label5";
            this.label5.Size = new System.Drawing.Size(39, 13);
            this.label5.TabIndex = 11;
            this.label5.Text = "Folder:";
            // 
            // btnLoad
            // 
            this.btnLoad.Location = new System.Drawing.Point(75, 100);
            this.btnLoad.Name = "btnLoad";
            this.btnLoad.Size = new System.Drawing.Size(67, 23);
            this.btnLoad.TabIndex = 10;
            this.btnLoad.Text = "Load";
            this.btnLoad.UseVisualStyleBackColor = true;
            this.btnLoad.Click += new System.EventHandler(this.btnLoad_Click);
            // 
            // btnRun
            // 
            this.btnRun.Location = new System.Drawing.Point(149, 100);
            this.btnRun.Name = "btnRun";
            this.btnRun.Size = new System.Drawing.Size(67, 23);
            this.btnRun.TabIndex = 9;
            this.btnRun.Text = "Run";
            this.btnRun.UseVisualStyleBackColor = true;
            this.btnRun.Click += new System.EventHandler(this.btnRun_Click);
            // 
            // cmbDatabase
            // 
            this.cmbDatabase.FormattingEnabled = true;
            this.cmbDatabase.Location = new System.Drawing.Point(75, 47);
            this.cmbDatabase.Name = "cmbDatabase";
            this.cmbDatabase.Size = new System.Drawing.Size(292, 21);
            this.cmbDatabase.TabIndex = 8;
            this.cmbDatabase.DropDown += new System.EventHandler(this.cmbDatabase_DropDown);
            // 
            // label4
            // 
            this.label4.AutoSize = true;
            this.label4.Location = new System.Drawing.Point(13, 51);
            this.label4.Name = "label4";
            this.label4.Size = new System.Drawing.Size(56, 13);
            this.label4.TabIndex = 7;
            this.label4.Text = "Database:";
            // 
            // btnTestConnection
            // 
            this.btnTestConnection.Location = new System.Drawing.Point(748, 19);
            this.btnTestConnection.Name = "btnTestConnection";
            this.btnTestConnection.Size = new System.Drawing.Size(56, 45);
            this.btnTestConnection.TabIndex = 6;
            this.btnTestConnection.Text = "Test Connect";
            this.btnTestConnection.UseVisualStyleBackColor = true;
            this.btnTestConnection.Click += new System.EventHandler(this.btnTestConnection_Click);
            // 
            // txtPassword
            // 
            this.txtPassword.Location = new System.Drawing.Point(450, 47);
            this.txtPassword.Name = "txtPassword";
            this.txtPassword.PasswordChar = '*';
            this.txtPassword.Size = new System.Drawing.Size(292, 20);
            this.txtPassword.TabIndex = 5;
            // 
            // label3
            // 
            this.label3.AutoSize = true;
            this.label3.Location = new System.Drawing.Point(388, 51);
            this.label3.Name = "label3";
            this.label3.Size = new System.Drawing.Size(56, 13);
            this.label3.TabIndex = 4;
            this.label3.Text = "Password:";
            // 
            // txtUserName
            // 
            this.txtUserName.Location = new System.Drawing.Point(450, 19);
            this.txtUserName.Name = "txtUserName";
            this.txtUserName.Size = new System.Drawing.Size(292, 20);
            this.txtUserName.TabIndex = 3;
            // 
            // label2
            // 
            this.label2.AutoSize = true;
            this.label2.Location = new System.Drawing.Point(381, 23);
            this.label2.Name = "label2";
            this.label2.Size = new System.Drawing.Size(63, 13);
            this.label2.TabIndex = 2;
            this.label2.Text = "User Name:";
            // 
            // txtServer
            // 
            this.txtServer.Location = new System.Drawing.Point(75, 19);
            this.txtServer.Name = "txtServer";
            this.txtServer.Size = new System.Drawing.Size(292, 20);
            this.txtServer.TabIndex = 1;
            // 
            // label1
            // 
            this.label1.AutoSize = true;
            this.label1.Location = new System.Drawing.Point(28, 23);
            this.label1.Name = "label1";
            this.label1.Size = new System.Drawing.Size(41, 13);
            this.label1.TabIndex = 0;
            this.label1.Text = "Server:";
            // 
            // groupBox1
            // 
            this.groupBox1.Controls.Add(this.progressBar);
            this.groupBox1.Controls.Add(this.dgvResults);
            this.groupBox1.Location = new System.Drawing.Point(4, 131);
            this.groupBox1.Name = "groupBox1";
            this.groupBox1.Size = new System.Drawing.Size(830, 514);
            this.groupBox1.TabIndex = 2;
            this.groupBox1.TabStop = false;
            // 
            // progressBar
            // 
            this.progressBar.Location = new System.Drawing.Point(6, 494);
            this.progressBar.Name = "progressBar";
            this.progressBar.Size = new System.Drawing.Size(818, 13);
            this.progressBar.TabIndex = 1;
            // 
            // dgvResults
            // 
            this.dgvResults.ColumnHeadersHeightSizeMode = System.Windows.Forms.DataGridViewColumnHeadersHeightSizeMode.AutoSize;
            this.dgvResults.Location = new System.Drawing.Point(6, 12);
            this.dgvResults.Name = "dgvResults";
            this.dgvResults.Size = new System.Drawing.Size(818, 476);
            this.dgvResults.TabIndex = 0;
            // 
            // ckWinAuth
            // 
            this.ckWinAuth.AutoSize = true;
            this.ckWinAuth.Location = new System.Drawing.Point(450, 76);
            this.ckWinAuth.Name = "ckWinAuth";
            this.ckWinAuth.Size = new System.Drawing.Size(141, 17);
            this.ckWinAuth.TabIndex = 16;
            this.ckWinAuth.Text = "Windows Authentication";
            this.ckWinAuth.UseVisualStyleBackColor = true;
            // 
            // SQLRunner
            // 
            this.AutoScaleDimensions = new System.Drawing.SizeF(6F, 13F);
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.ClientSize = new System.Drawing.Size(838, 650);
            this.Controls.Add(this.groupBox1);
            this.Controls.Add(this.gbDBCfg);
            this.Name = "SQLRunner";
            this.Text = "SQL Runner";
            this.FormClosing += new System.Windows.Forms.FormClosingEventHandler(this.SQLRunner_FormClosing);
            this.gbDBCfg.ResumeLayout(false);
            this.gbDBCfg.PerformLayout();
            this.groupBox1.ResumeLayout(false);
            ((System.ComponentModel.ISupportInitialize)(this.dgvResults)).EndInit();
            this.ResumeLayout(false);

        }

        #endregion

        private System.Windows.Forms.GroupBox gbDBCfg;
        private System.Windows.Forms.ComboBox cmbDatabase;
        private System.Windows.Forms.Label label4;
        private System.Windows.Forms.Button btnTestConnection;
        private System.Windows.Forms.TextBox txtPassword;
        private System.Windows.Forms.Label label3;
        private System.Windows.Forms.TextBox txtUserName;
        private System.Windows.Forms.Label label2;
        private System.Windows.Forms.TextBox txtServer;
        private System.Windows.Forms.Label label1;
        private System.Windows.Forms.Button btnRun;
        private System.Windows.Forms.GroupBox groupBox1;
        private System.Windows.Forms.DataGridView dgvResults;
        private System.Windows.Forms.Button btnLoad;
        private System.Windows.Forms.TextBox txtFolderPath;
        private System.Windows.Forms.Label label5;
        private System.Windows.Forms.ProgressBar progressBar;
        private System.Windows.Forms.Button btnSelectDir;
        private System.Windows.Forms.CheckBox ckPreRun;
        private System.Windows.Forms.CheckBox ckAfterRun;
        private System.Windows.Forms.CheckBox ckWinAuth;
    }
}

