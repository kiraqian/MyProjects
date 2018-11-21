namespace MultiSiteInOneDBTools
{
    partial class Form1
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
            this.btnProcessReport = new System.Windows.Forms.Button();
            this.txtSourcePath = new System.Windows.Forms.TextBox();
            this.label1 = new System.Windows.Forms.Label();
            this.label2 = new System.Windows.Forms.Label();
            this.txtOutputPath = new System.Windows.Forms.TextBox();
            this.btnProcessSp = new System.Windows.Forms.Button();
            this.label3 = new System.Windows.Forms.Label();
            this.txtConnString = new System.Windows.Forms.TextBox();
            this.label4 = new System.Windows.Forms.Label();
            this.txtExpPath = new System.Windows.Forms.TextBox();
            this.btnProcessTrigger = new System.Windows.Forms.Button();
            this.SuspendLayout();
            // 
            // btnProcessReport
            // 
            this.btnProcessReport.Location = new System.Drawing.Point(109, 135);
            this.btnProcessReport.Name = "btnProcessReport";
            this.btnProcessReport.Size = new System.Drawing.Size(89, 23);
            this.btnProcessReport.TabIndex = 0;
            this.btnProcessReport.Text = "Process Report";
            this.btnProcessReport.UseVisualStyleBackColor = true;
            this.btnProcessReport.Click += new System.EventHandler(this.btnProcessReport_Click);
            // 
            // txtSourcePath
            // 
            this.txtSourcePath.Location = new System.Drawing.Point(109, 12);
            this.txtSourcePath.Name = "txtSourcePath";
            this.txtSourcePath.Size = new System.Drawing.Size(331, 20);
            this.txtSourcePath.TabIndex = 1;
            // 
            // label1
            // 
            this.label1.AutoSize = true;
            this.label1.Location = new System.Drawing.Point(39, 15);
            this.label1.Name = "label1";
            this.label1.Size = new System.Drawing.Size(66, 13);
            this.label1.TabIndex = 2;
            this.label1.Text = "Source Path";
            // 
            // label2
            // 
            this.label2.AutoSize = true;
            this.label2.Location = new System.Drawing.Point(41, 40);
            this.label2.Name = "label2";
            this.label2.Size = new System.Drawing.Size(64, 13);
            this.label2.TabIndex = 3;
            this.label2.Text = "Output Path";
            // 
            // txtOutputPath
            // 
            this.txtOutputPath.Location = new System.Drawing.Point(109, 37);
            this.txtOutputPath.Name = "txtOutputPath";
            this.txtOutputPath.Size = new System.Drawing.Size(331, 20);
            this.txtOutputPath.TabIndex = 4;
            // 
            // btnProcessSp
            // 
            this.btnProcessSp.Location = new System.Drawing.Point(204, 135);
            this.btnProcessSp.Name = "btnProcessSp";
            this.btnProcessSp.Size = new System.Drawing.Size(89, 23);
            this.btnProcessSp.TabIndex = 5;
            this.btnProcessSp.Text = "Process SP";
            this.btnProcessSp.UseVisualStyleBackColor = true;
            this.btnProcessSp.Click += new System.EventHandler(this.btnProcessSp_Click);
            // 
            // label3
            // 
            this.label3.AutoSize = true;
            this.label3.Location = new System.Drawing.Point(14, 64);
            this.label3.Name = "label3";
            this.label3.Size = new System.Drawing.Size(91, 13);
            this.label3.TabIndex = 6;
            this.label3.Text = "Connection String";
            // 
            // txtConnString
            // 
            this.txtConnString.Location = new System.Drawing.Point(109, 61);
            this.txtConnString.Name = "txtConnString";
            this.txtConnString.Size = new System.Drawing.Size(331, 20);
            this.txtConnString.TabIndex = 7;
            // 
            // label4
            // 
            this.label4.AutoSize = true;
            this.label4.Location = new System.Drawing.Point(26, 92);
            this.label4.Name = "label4";
            this.label4.Size = new System.Drawing.Size(79, 13);
            this.label4.TabIndex = 8;
            this.label4.Text = "Exception Path";
            // 
            // txtExpPath
            // 
            this.txtExpPath.Location = new System.Drawing.Point(109, 86);
            this.txtExpPath.Name = "txtExpPath";
            this.txtExpPath.Size = new System.Drawing.Size(331, 20);
            this.txtExpPath.TabIndex = 9;
            // 
            // btnProcessTrigger
            // 
            this.btnProcessTrigger.Location = new System.Drawing.Point(299, 135);
            this.btnProcessTrigger.Name = "btnProcessTrigger";
            this.btnProcessTrigger.Size = new System.Drawing.Size(96, 23);
            this.btnProcessTrigger.TabIndex = 10;
            this.btnProcessTrigger.Text = "Process Triggers";
            this.btnProcessTrigger.UseVisualStyleBackColor = true;
            this.btnProcessTrigger.Click += new System.EventHandler(this.btnProcessTrigger_Click);
            // 
            // Form1
            // 
            this.AutoScaleDimensions = new System.Drawing.SizeF(6F, 13F);
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.ClientSize = new System.Drawing.Size(452, 294);
            this.Controls.Add(this.btnProcessTrigger);
            this.Controls.Add(this.txtExpPath);
            this.Controls.Add(this.label4);
            this.Controls.Add(this.txtConnString);
            this.Controls.Add(this.label3);
            this.Controls.Add(this.btnProcessSp);
            this.Controls.Add(this.txtOutputPath);
            this.Controls.Add(this.label2);
            this.Controls.Add(this.label1);
            this.Controls.Add(this.txtSourcePath);
            this.Controls.Add(this.btnProcessReport);
            this.Name = "Form1";
            this.Text = "Form1";
            this.ResumeLayout(false);
            this.PerformLayout();

        }

        #endregion

        private System.Windows.Forms.Button btnProcessReport;
        private System.Windows.Forms.TextBox txtSourcePath;
        private System.Windows.Forms.Label label1;
        private System.Windows.Forms.Label label2;
        private System.Windows.Forms.TextBox txtOutputPath;
        private System.Windows.Forms.Button btnProcessSp;
        private System.Windows.Forms.Label label3;
        private System.Windows.Forms.TextBox txtConnString;
        private System.Windows.Forms.Label label4;
        private System.Windows.Forms.TextBox txtExpPath;
        private System.Windows.Forms.Button btnProcessTrigger;
    }
}

