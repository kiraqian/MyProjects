namespace Encode_Engine
{
    partial class FrmEncodeEngine
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
            this.components = new System.ComponentModel.Container();
            System.ComponentModel.ComponentResourceManager resources = new System.ComponentModel.ComponentResourceManager(typeof(FrmEncodeEngine));
            this.groupBox1 = new System.Windows.Forms.GroupBox();
            this.txtCodeText = new System.Windows.Forms.TextBox();
            this.cmsText = new System.Windows.Forms.ContextMenuStrip(this.components);
            this.cmsSelectAll = new System.Windows.Forms.ToolStripMenuItem();
            this.cmsCopyAll = new System.Windows.Forms.ToolStripMenuItem();
            this.cmsCopySelection = new System.Windows.Forms.ToolStripMenuItem();
            this.cmsPaste = new System.Windows.Forms.ToolStripMenuItem();
            this.cmsEmpty = new System.Windows.Forms.ToolStripMenuItem();
            this.groupBox2 = new System.Windows.Forms.GroupBox();
            this.txtCfEncodeString = new System.Windows.Forms.TextBox();
            this.label2 = new System.Windows.Forms.Label();
            this.btnDecode = new System.Windows.Forms.Button();
            this.btnEncode = new System.Windows.Forms.Button();
            this.txtEncodeString = new System.Windows.Forms.TextBox();
            this.label1 = new System.Windows.Forms.Label();
            this.msMainMenu = new System.Windows.Forms.MenuStrip();
            this.mnuFile = new System.Windows.Forms.ToolStripMenuItem();
            this.mnuNew = new System.Windows.Forms.ToolStripMenuItem();
            this.mnuOpen = new System.Windows.Forms.ToolStripMenuItem();
            this.mnuSave = new System.Windows.Forms.ToolStripMenuItem();
            this.mnuSaveAs = new System.Windows.Forms.ToolStripMenuItem();
            this.mnuExit = new System.Windows.Forms.ToolStripMenuItem();
            this.mnuHelp = new System.Windows.Forms.ToolStripMenuItem();
            this.mnuHelpTopic = new System.Windows.Forms.ToolStripMenuItem();
            this.mnuAbout = new System.Windows.Forms.ToolStripMenuItem();
            this.groupBox1.SuspendLayout();
            this.cmsText.SuspendLayout();
            this.groupBox2.SuspendLayout();
            this.msMainMenu.SuspendLayout();
            this.SuspendLayout();
            // 
            // groupBox1
            // 
            this.groupBox1.Anchor = ((System.Windows.Forms.AnchorStyles)((((System.Windows.Forms.AnchorStyles.Top | System.Windows.Forms.AnchorStyles.Bottom) 
            | System.Windows.Forms.AnchorStyles.Left) 
            | System.Windows.Forms.AnchorStyles.Right)));
            this.groupBox1.Controls.Add(this.txtCodeText);
            this.groupBox1.Location = new System.Drawing.Point(12, 27);
            this.groupBox1.Name = "groupBox1";
            this.groupBox1.Size = new System.Drawing.Size(461, 406);
            this.groupBox1.TabIndex = 0;
            this.groupBox1.TabStop = false;
            this.groupBox1.Text = "Text";
            // 
            // txtCodeText
            // 
            this.txtCodeText.ContextMenuStrip = this.cmsText;
            this.txtCodeText.Dock = System.Windows.Forms.DockStyle.Fill;
            this.txtCodeText.Location = new System.Drawing.Point(3, 16);
            this.txtCodeText.Multiline = true;
            this.txtCodeText.Name = "txtCodeText";
            this.txtCodeText.ScrollBars = System.Windows.Forms.ScrollBars.Vertical;
            this.txtCodeText.Size = new System.Drawing.Size(455, 387);
            this.txtCodeText.TabIndex = 0;
            this.txtCodeText.KeyDown += new System.Windows.Forms.KeyEventHandler(this.txtCodeText_KeyDown);
            // 
            // cmsText
            // 
            this.cmsText.Items.AddRange(new System.Windows.Forms.ToolStripItem[] {
            this.cmsSelectAll,
            this.cmsCopyAll,
            this.cmsCopySelection,
            this.cmsPaste,
            this.cmsEmpty});
            this.cmsText.Name = "cmsText";
            this.cmsText.Size = new System.Drawing.Size(153, 136);
            // 
            // cmsSelectAll
            // 
            this.cmsSelectAll.Name = "cmsSelectAll";
            this.cmsSelectAll.Size = new System.Drawing.Size(152, 22);
            this.cmsSelectAll.Text = "Select &All";
            this.cmsSelectAll.Click += new System.EventHandler(this.cmsSelectAll_Click);
            // 
            // cmsCopyAll
            // 
            this.cmsCopyAll.Name = "cmsCopyAll";
            this.cmsCopyAll.Size = new System.Drawing.Size(152, 22);
            this.cmsCopyAll.Text = "&Copy All";
            this.cmsCopyAll.Click += new System.EventHandler(this.cmsCopyAll_Click);
            // 
            // cmsCopySelection
            // 
            this.cmsCopySelection.Name = "cmsCopySelection";
            this.cmsCopySelection.Size = new System.Drawing.Size(152, 22);
            this.cmsCopySelection.Text = "Copy &Selection";
            this.cmsCopySelection.Click += new System.EventHandler(this.cmsCopySelection_Click);
            // 
            // cmsPaste
            // 
            this.cmsPaste.Name = "cmsPaste";
            this.cmsPaste.Size = new System.Drawing.Size(152, 22);
            this.cmsPaste.Text = "&Paste";
            this.cmsPaste.Click += new System.EventHandler(this.cmsPaste_Click);
            // 
            // cmsEmpty
            // 
            this.cmsEmpty.Name = "cmsEmpty";
            this.cmsEmpty.Size = new System.Drawing.Size(152, 22);
            this.cmsEmpty.Text = "&Empty";
            this.cmsEmpty.Click += new System.EventHandler(this.cmsEmpty_Click);
            // 
            // groupBox2
            // 
            this.groupBox2.Anchor = ((System.Windows.Forms.AnchorStyles)(((System.Windows.Forms.AnchorStyles.Bottom | System.Windows.Forms.AnchorStyles.Left) 
            | System.Windows.Forms.AnchorStyles.Right)));
            this.groupBox2.Controls.Add(this.txtCfEncodeString);
            this.groupBox2.Controls.Add(this.label2);
            this.groupBox2.Controls.Add(this.btnDecode);
            this.groupBox2.Controls.Add(this.btnEncode);
            this.groupBox2.Controls.Add(this.txtEncodeString);
            this.groupBox2.Controls.Add(this.label1);
            this.groupBox2.Location = new System.Drawing.Point(12, 434);
            this.groupBox2.Name = "groupBox2";
            this.groupBox2.Size = new System.Drawing.Size(461, 90);
            this.groupBox2.TabIndex = 1;
            this.groupBox2.TabStop = false;
            // 
            // txtCfEncodeString
            // 
            this.txtCfEncodeString.Anchor = System.Windows.Forms.AnchorStyles.Left;
            this.txtCfEncodeString.Location = new System.Drawing.Point(124, 54);
            this.txtCfEncodeString.Name = "txtCfEncodeString";
            this.txtCfEncodeString.PasswordChar = '*';
            this.txtCfEncodeString.Size = new System.Drawing.Size(223, 20);
            this.txtCfEncodeString.TabIndex = 2;
            // 
            // label2
            // 
            this.label2.AutoSize = true;
            this.label2.Location = new System.Drawing.Point(6, 57);
            this.label2.Name = "label2";
            this.label2.Size = new System.Drawing.Size(112, 13);
            this.label2.TabIndex = 4;
            this.label2.Text = "Confirm Encode String";
            // 
            // btnDecode
            // 
            this.btnDecode.Anchor = System.Windows.Forms.AnchorStyles.Right;
            this.btnDecode.Location = new System.Drawing.Point(368, 52);
            this.btnDecode.Name = "btnDecode";
            this.btnDecode.Size = new System.Drawing.Size(75, 23);
            this.btnDecode.TabIndex = 4;
            this.btnDecode.Text = "Decode";
            this.btnDecode.UseVisualStyleBackColor = true;
            this.btnDecode.Click += new System.EventHandler(this.btnDecode_Click);
            // 
            // btnEncode
            // 
            this.btnEncode.Anchor = System.Windows.Forms.AnchorStyles.Right;
            this.btnEncode.Location = new System.Drawing.Point(368, 19);
            this.btnEncode.Name = "btnEncode";
            this.btnEncode.Size = new System.Drawing.Size(75, 23);
            this.btnEncode.TabIndex = 3;
            this.btnEncode.Text = "Encode";
            this.btnEncode.UseVisualStyleBackColor = true;
            this.btnEncode.Click += new System.EventHandler(this.btnEncode_Click);
            // 
            // txtEncodeString
            // 
            this.txtEncodeString.Anchor = System.Windows.Forms.AnchorStyles.Left;
            this.txtEncodeString.Location = new System.Drawing.Point(124, 21);
            this.txtEncodeString.Name = "txtEncodeString";
            this.txtEncodeString.PasswordChar = '*';
            this.txtEncodeString.Size = new System.Drawing.Size(223, 20);
            this.txtEncodeString.TabIndex = 1;
            // 
            // label1
            // 
            this.label1.Anchor = System.Windows.Forms.AnchorStyles.Left;
            this.label1.AutoSize = true;
            this.label1.Location = new System.Drawing.Point(6, 24);
            this.label1.Name = "label1";
            this.label1.Size = new System.Drawing.Size(74, 13);
            this.label1.TabIndex = 0;
            this.label1.Text = "Encode String";
            // 
            // msMainMenu
            // 
            this.msMainMenu.Items.AddRange(new System.Windows.Forms.ToolStripItem[] {
            this.mnuFile,
            this.mnuHelp});
            this.msMainMenu.Location = new System.Drawing.Point(0, 0);
            this.msMainMenu.Name = "msMainMenu";
            this.msMainMenu.Size = new System.Drawing.Size(485, 24);
            this.msMainMenu.TabIndex = 2;
            this.msMainMenu.Text = "menuStrip1";
            // 
            // mnuFile
            // 
            this.mnuFile.DropDownItems.AddRange(new System.Windows.Forms.ToolStripItem[] {
            this.mnuNew,
            this.mnuOpen,
            this.mnuSave,
            this.mnuSaveAs,
            this.mnuExit});
            this.mnuFile.Name = "mnuFile";
            this.mnuFile.Size = new System.Drawing.Size(37, 20);
            this.mnuFile.Text = "&File";
            // 
            // mnuNew
            // 
            this.mnuNew.Name = "mnuNew";
            this.mnuNew.Size = new System.Drawing.Size(114, 22);
            this.mnuNew.Text = "&New";
            this.mnuNew.Click += new System.EventHandler(this.mnuNew_Click);
            // 
            // mnuOpen
            // 
            this.mnuOpen.Name = "mnuOpen";
            this.mnuOpen.Size = new System.Drawing.Size(114, 22);
            this.mnuOpen.Text = "&Open";
            this.mnuOpen.Click += new System.EventHandler(this.mnuOpen_Click);
            // 
            // mnuSave
            // 
            this.mnuSave.Name = "mnuSave";
            this.mnuSave.Size = new System.Drawing.Size(114, 22);
            this.mnuSave.Text = "&Save";
            this.mnuSave.Click += new System.EventHandler(this.mnuSave_Click);
            // 
            // mnuSaveAs
            // 
            this.mnuSaveAs.Name = "mnuSaveAs";
            this.mnuSaveAs.Size = new System.Drawing.Size(114, 22);
            this.mnuSaveAs.Text = "Save &As";
            this.mnuSaveAs.Click += new System.EventHandler(this.mnuSaveAs_Click);
            // 
            // mnuExit
            // 
            this.mnuExit.Name = "mnuExit";
            this.mnuExit.Size = new System.Drawing.Size(114, 22);
            this.mnuExit.Text = "E&xit";
            this.mnuExit.Click += new System.EventHandler(this.mnuExit_Click);
            // 
            // mnuHelp
            // 
            this.mnuHelp.DropDownItems.AddRange(new System.Windows.Forms.ToolStripItem[] {
            this.mnuHelpTopic,
            this.mnuAbout});
            this.mnuHelp.Name = "mnuHelp";
            this.mnuHelp.Size = new System.Drawing.Size(44, 20);
            this.mnuHelp.Text = "&Help";
            // 
            // mnuHelpTopic
            // 
            this.mnuHelpTopic.Name = "mnuHelpTopic";
            this.mnuHelpTopic.Size = new System.Drawing.Size(132, 22);
            this.mnuHelpTopic.Text = "Help &Topic";
            this.mnuHelpTopic.Click += new System.EventHandler(this.mnuHelpTopic_Click);
            // 
            // mnuAbout
            // 
            this.mnuAbout.Name = "mnuAbout";
            this.mnuAbout.Size = new System.Drawing.Size(132, 22);
            this.mnuAbout.Text = "&About";
            this.mnuAbout.Click += new System.EventHandler(this.mnuAbout_Click);
            // 
            // FrmEncodeEngine
            // 
            this.AutoScaleDimensions = new System.Drawing.SizeF(6F, 13F);
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.ClientSize = new System.Drawing.Size(485, 537);
            this.Controls.Add(this.groupBox2);
            this.Controls.Add(this.groupBox1);
            this.Controls.Add(this.msMainMenu);
            this.Icon = ((System.Drawing.Icon)(resources.GetObject("$this.Icon")));
            this.MainMenuStrip = this.msMainMenu;
            this.MinimumSize = new System.Drawing.Size(493, 564);
            this.Name = "FrmEncodeEngine";
            this.StartPosition = System.Windows.Forms.FormStartPosition.CenterScreen;
            this.Text = "Encode Engine";
            this.groupBox1.ResumeLayout(false);
            this.groupBox1.PerformLayout();
            this.cmsText.ResumeLayout(false);
            this.groupBox2.ResumeLayout(false);
            this.groupBox2.PerformLayout();
            this.msMainMenu.ResumeLayout(false);
            this.msMainMenu.PerformLayout();
            this.ResumeLayout(false);
            this.PerformLayout();

        }

        #endregion

        private System.Windows.Forms.GroupBox groupBox1;
        private System.Windows.Forms.TextBox txtCodeText;
        private System.Windows.Forms.GroupBox groupBox2;
        private System.Windows.Forms.Label label1;
        private System.Windows.Forms.TextBox txtEncodeString;
        private System.Windows.Forms.Button btnDecode;
        private System.Windows.Forms.Button btnEncode;
        private System.Windows.Forms.MenuStrip msMainMenu;
        private System.Windows.Forms.ToolStripMenuItem mnuFile;
        private System.Windows.Forms.ToolStripMenuItem mnuOpen;
        private System.Windows.Forms.ToolStripMenuItem mnuSave;
        private System.Windows.Forms.ToolStripMenuItem mnuSaveAs;
        private System.Windows.Forms.ToolStripMenuItem mnuExit;
        private System.Windows.Forms.ToolStripMenuItem mnuHelp;
        private System.Windows.Forms.ToolStripMenuItem mnuHelpTopic;
        private System.Windows.Forms.ToolStripMenuItem mnuAbout;
        private System.Windows.Forms.ToolStripMenuItem mnuNew;
        private System.Windows.Forms.TextBox txtCfEncodeString;
        private System.Windows.Forms.Label label2;
        private System.Windows.Forms.ContextMenuStrip cmsText;
        private System.Windows.Forms.ToolStripMenuItem cmsSelectAll;
        private System.Windows.Forms.ToolStripMenuItem cmsCopyAll;
        private System.Windows.Forms.ToolStripMenuItem cmsPaste;
        private System.Windows.Forms.ToolStripMenuItem cmsEmpty;
        private System.Windows.Forms.ToolStripMenuItem cmsCopySelection;
    }
}

