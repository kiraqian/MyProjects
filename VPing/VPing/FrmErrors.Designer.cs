namespace VPing {
    partial class FrmErrors {
        /// <summary>
        /// Required designer variable.
        /// </summary>
        private System.ComponentModel.IContainer components = null;

        /// <summary>
        /// Clean up any resources being used.
        /// </summary>
        /// <param name="disposing">true if managed resources should be disposed; otherwise, false.</param>
        protected override void Dispose(bool disposing) {
            if (disposing && (components != null)) {
                components.Dispose();
            }
            base.Dispose(disposing);
        }

        #region Windows Form Designer generated code

        /// <summary>
        /// Required method for Designer support - do not modify
        /// the contents of this method with the code editor.
        /// </summary>
        private void InitializeComponent() {
            this.lbxErrors = new System.Windows.Forms.ListBox();
            this.SuspendLayout();
            // 
            // lbxErrors
            // 
            this.lbxErrors.Dock = System.Windows.Forms.DockStyle.Fill;
            this.lbxErrors.FormattingEnabled = true;
            this.lbxErrors.Location = new System.Drawing.Point(0, 0);
            this.lbxErrors.Name = "lbxErrors";
            this.lbxErrors.Size = new System.Drawing.Size(363, 301);
            this.lbxErrors.TabIndex = 0;
            // 
            // FrmErrors
            // 
            this.AutoScaleDimensions = new System.Drawing.SizeF(6F, 13F);
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.ClientSize = new System.Drawing.Size(363, 301);
            this.Controls.Add(this.lbxErrors);
            this.Name = "FrmErrors";
            this.StartPosition = System.Windows.Forms.FormStartPosition.CenterParent;
            this.Text = "Errors";
            this.ResumeLayout(false);

        }

        #endregion

        private System.Windows.Forms.ListBox lbxErrors;
    }
}