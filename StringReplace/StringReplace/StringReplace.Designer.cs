namespace StringReplace
{
    partial class StringReplace
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
            this.label1 = new System.Windows.Forms.Label();
            this.groupBox1 = new System.Windows.Forms.GroupBox();
            this.btnUnitTest = new System.Windows.Forms.Button();
            this.ckCaseSensitive = new System.Windows.Forms.CheckBox();
            this.ckOutputOnlyModified = new System.Windows.Forms.CheckBox();
            this.btnPasteData = new System.Windows.Forms.Button();
            this.btnReplace = new System.Windows.Forms.Button();
            this.btnLoadFiles = new System.Windows.Forms.Button();
            this.txtOutputFolder = new System.Windows.Forms.TextBox();
            this.label2 = new System.Windows.Forms.Label();
            this.txtInputFolder = new System.Windows.Forms.TextBox();
            this.groupBox2 = new System.Windows.Forms.GroupBox();
            this.dgvRepList = new System.Windows.Forms.DataGridView();
            this.groupBox3 = new System.Windows.Forms.GroupBox();
            this.progressBar = new System.Windows.Forms.ProgressBar();
            this.dgvResults = new System.Windows.Forms.DataGridView();
            this.ckMatchWholeWord = new System.Windows.Forms.CheckBox();
            this.groupBox1.SuspendLayout();
            this.groupBox2.SuspendLayout();
            ((System.ComponentModel.ISupportInitialize)(this.dgvRepList)).BeginInit();
            this.groupBox3.SuspendLayout();
            ((System.ComponentModel.ISupportInitialize)(this.dgvResults)).BeginInit();
            this.SuspendLayout();
            // 
            // label1
            // 
            this.label1.AutoSize = true;
            this.label1.Location = new System.Drawing.Point(24, 16);
            this.label1.Name = "label1";
            this.label1.Size = new System.Drawing.Size(66, 13);
            this.label1.TabIndex = 0;
            this.label1.Text = "Input Folder:";
            // 
            // groupBox1
            // 
            this.groupBox1.Controls.Add(this.ckMatchWholeWord);
            this.groupBox1.Controls.Add(this.btnUnitTest);
            this.groupBox1.Controls.Add(this.ckCaseSensitive);
            this.groupBox1.Controls.Add(this.ckOutputOnlyModified);
            this.groupBox1.Controls.Add(this.btnPasteData);
            this.groupBox1.Controls.Add(this.btnReplace);
            this.groupBox1.Controls.Add(this.btnLoadFiles);
            this.groupBox1.Controls.Add(this.txtOutputFolder);
            this.groupBox1.Controls.Add(this.label2);
            this.groupBox1.Controls.Add(this.txtInputFolder);
            this.groupBox1.Controls.Add(this.label1);
            this.groupBox1.Location = new System.Drawing.Point(4, 1);
            this.groupBox1.Name = "groupBox1";
            this.groupBox1.Size = new System.Drawing.Size(925, 69);
            this.groupBox1.TabIndex = 1;
            this.groupBox1.TabStop = false;
            // 
            // btnUnitTest
            // 
            this.btnUnitTest.Location = new System.Drawing.Point(678, 10);
            this.btnUnitTest.Name = "btnUnitTest";
            this.btnUnitTest.Size = new System.Drawing.Size(43, 23);
            this.btnUnitTest.TabIndex = 10;
            this.btnUnitTest.Text = "Test";
            this.btnUnitTest.UseVisualStyleBackColor = true;
            this.btnUnitTest.Visible = false;
            this.btnUnitTest.Click += new System.EventHandler(this.btnUnitTest_Click);
            // 
            // ckCaseSensitive
            // 
            this.ckCaseSensitive.AutoSize = true;
            this.ckCaseSensitive.Location = new System.Drawing.Point(504, 41);
            this.ckCaseSensitive.Name = "ckCaseSensitive";
            this.ckCaseSensitive.Size = new System.Drawing.Size(96, 17);
            this.ckCaseSensitive.TabIndex = 9;
            this.ckCaseSensitive.Text = "Case Sensitive";
            this.ckCaseSensitive.UseVisualStyleBackColor = true;
            // 
            // ckOutputOnlyModified
            // 
            this.ckOutputOnlyModified.AutoSize = true;
            this.ckOutputOnlyModified.Checked = true;
            this.ckOutputOnlyModified.CheckState = System.Windows.Forms.CheckState.Checked;
            this.ckOutputOnlyModified.Location = new System.Drawing.Point(504, 16);
            this.ckOutputOnlyModified.Name = "ckOutputOnlyModified";
            this.ckOutputOnlyModified.Size = new System.Drawing.Size(125, 17);
            this.ckOutputOnlyModified.TabIndex = 8;
            this.ckOutputOnlyModified.Text = "Output Only Modified";
            this.ckOutputOnlyModified.UseVisualStyleBackColor = true;
            // 
            // btnPasteData
            // 
            this.btnPasteData.Location = new System.Drawing.Point(791, 17);
            this.btnPasteData.Name = "btnPasteData";
            this.btnPasteData.Size = new System.Drawing.Size(59, 43);
            this.btnPasteData.TabIndex = 7;
            this.btnPasteData.Text = "Paste List";
            this.btnPasteData.UseVisualStyleBackColor = true;
            this.btnPasteData.Click += new System.EventHandler(this.btnPasteData_Click);
            // 
            // btnReplace
            // 
            this.btnReplace.Location = new System.Drawing.Point(855, 16);
            this.btnReplace.Name = "btnReplace";
            this.btnReplace.Size = new System.Drawing.Size(59, 43);
            this.btnReplace.TabIndex = 6;
            this.btnReplace.Text = "Replace";
            this.btnReplace.UseVisualStyleBackColor = true;
            this.btnReplace.Click += new System.EventHandler(this.btnReplace_Click);
            // 
            // btnLoadFiles
            // 
            this.btnLoadFiles.Location = new System.Drawing.Point(727, 16);
            this.btnLoadFiles.Name = "btnLoadFiles";
            this.btnLoadFiles.Size = new System.Drawing.Size(59, 43);
            this.btnLoadFiles.TabIndex = 4;
            this.btnLoadFiles.Text = "Load Files";
            this.btnLoadFiles.UseVisualStyleBackColor = true;
            this.btnLoadFiles.Click += new System.EventHandler(this.btnLoadFiles_Click);
            // 
            // txtOutputFolder
            // 
            this.txtOutputFolder.Location = new System.Drawing.Point(96, 40);
            this.txtOutputFolder.Name = "txtOutputFolder";
            this.txtOutputFolder.Size = new System.Drawing.Size(402, 20);
            this.txtOutputFolder.TabIndex = 3;
            // 
            // label2
            // 
            this.label2.AutoSize = true;
            this.label2.Location = new System.Drawing.Point(16, 43);
            this.label2.Name = "label2";
            this.label2.Size = new System.Drawing.Size(74, 13);
            this.label2.TabIndex = 2;
            this.label2.Text = "Output Folder:";
            // 
            // txtInputFolder
            // 
            this.txtInputFolder.Location = new System.Drawing.Point(96, 13);
            this.txtInputFolder.Name = "txtInputFolder";
            this.txtInputFolder.Size = new System.Drawing.Size(402, 20);
            this.txtInputFolder.TabIndex = 1;
            // 
            // groupBox2
            // 
            this.groupBox2.Controls.Add(this.dgvRepList);
            this.groupBox2.Location = new System.Drawing.Point(4, 69);
            this.groupBox2.Name = "groupBox2";
            this.groupBox2.Size = new System.Drawing.Size(322, 546);
            this.groupBox2.TabIndex = 2;
            this.groupBox2.TabStop = false;
            this.groupBox2.Text = "String Replace List";
            // 
            // dgvRepList
            // 
            this.dgvRepList.ColumnHeadersHeightSizeMode = System.Windows.Forms.DataGridViewColumnHeadersHeightSizeMode.AutoSize;
            this.dgvRepList.Location = new System.Drawing.Point(8, 19);
            this.dgvRepList.Name = "dgvRepList";
            this.dgvRepList.Size = new System.Drawing.Size(308, 518);
            this.dgvRepList.TabIndex = 0;
            // 
            // groupBox3
            // 
            this.groupBox3.Controls.Add(this.progressBar);
            this.groupBox3.Controls.Add(this.dgvResults);
            this.groupBox3.Location = new System.Drawing.Point(332, 69);
            this.groupBox3.Name = "groupBox3";
            this.groupBox3.Size = new System.Drawing.Size(597, 546);
            this.groupBox3.TabIndex = 3;
            this.groupBox3.TabStop = false;
            this.groupBox3.Text = "Results";
            // 
            // progressBar
            // 
            this.progressBar.Location = new System.Drawing.Point(6, 523);
            this.progressBar.Name = "progressBar";
            this.progressBar.Size = new System.Drawing.Size(580, 17);
            this.progressBar.TabIndex = 1;
            // 
            // dgvResults
            // 
            this.dgvResults.ColumnHeadersHeightSizeMode = System.Windows.Forms.DataGridViewColumnHeadersHeightSizeMode.AutoSize;
            this.dgvResults.Location = new System.Drawing.Point(6, 19);
            this.dgvResults.Name = "dgvResults";
            this.dgvResults.Size = new System.Drawing.Size(585, 499);
            this.dgvResults.TabIndex = 0;
            // 
            // ckMatchWholeWord
            // 
            this.ckMatchWholeWord.AutoSize = true;
            this.ckMatchWholeWord.Location = new System.Drawing.Point(603, 41);
            this.ckMatchWholeWord.Name = "ckMatchWholeWord";
            this.ckMatchWholeWord.Size = new System.Drawing.Size(119, 17);
            this.ckMatchWholeWord.TabIndex = 11;
            this.ckMatchWholeWord.Text = "Match Whole Word";
            this.ckMatchWholeWord.UseVisualStyleBackColor = true;
            // 
            // StringReplace
            // 
            this.AutoScaleDimensions = new System.Drawing.SizeF(6F, 13F);
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.ClientSize = new System.Drawing.Size(930, 618);
            this.Controls.Add(this.groupBox3);
            this.Controls.Add(this.groupBox2);
            this.Controls.Add(this.groupBox1);
            this.Name = "StringReplace";
            this.Text = "Form1";
            this.groupBox1.ResumeLayout(false);
            this.groupBox1.PerformLayout();
            this.groupBox2.ResumeLayout(false);
            ((System.ComponentModel.ISupportInitialize)(this.dgvRepList)).EndInit();
            this.groupBox3.ResumeLayout(false);
            ((System.ComponentModel.ISupportInitialize)(this.dgvResults)).EndInit();
            this.ResumeLayout(false);

        }

        #endregion

        private System.Windows.Forms.Label label1;
        private System.Windows.Forms.GroupBox groupBox1;
        private System.Windows.Forms.TextBox txtInputFolder;
        private System.Windows.Forms.Label label2;
        private System.Windows.Forms.TextBox txtOutputFolder;
        private System.Windows.Forms.Button btnLoadFiles;
        private System.Windows.Forms.GroupBox groupBox2;
        private System.Windows.Forms.DataGridView dgvRepList;
        private System.Windows.Forms.GroupBox groupBox3;
        private System.Windows.Forms.DataGridView dgvResults;
        private System.Windows.Forms.Button btnReplace;
        private System.Windows.Forms.Button btnPasteData;
        private System.Windows.Forms.ProgressBar progressBar;
        private System.Windows.Forms.CheckBox ckOutputOnlyModified;
        private System.Windows.Forms.CheckBox ckCaseSensitive;
        private System.Windows.Forms.Button btnUnitTest;
        private System.Windows.Forms.CheckBox ckMatchWholeWord;
    }
}

