using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Windows.Forms;
using CodeEngine;
using Utility;

namespace Encode_Engine
{
    public partial class FrmEncodeEngine : Form
    {
        #region Private Member
        private string _fileName;
        #endregion

        #region Constructor
        public FrmEncodeEngine()
        {
            InitializeComponent();
            _fileName = "";
            txtCodeText.Text = "";
            txtEncodeString.Text = "";
            txtCfEncodeString.Text = "";
            FrmSplash frmSplash = new FrmSplash();
            frmSplash.ShowDialog();
        }

        #endregion

        #region Control Method
        #region Buttons
        #region btnEncode_Click
        private void btnEncode_Click(object sender, EventArgs e)
        {
            if (txtCodeText.Text == "")
            {
                MessageBox.Show("Text cannot be empty", "Warning", MessageBoxButtons.OK, MessageBoxIcon.Exclamation);
                return;
            }

            if (txtEncodeString.Text == "")
            {
                MessageBox.Show("Encode String cannot be empty", "Warning", MessageBoxButtons.OK, MessageBoxIcon.Exclamation);
                return;
            }

            if (txtEncodeString.Text != txtCfEncodeString.Text)
            {
                MessageBox.Show("Confirm Encode String does not match Encode String", "Warning", MessageBoxButtons.OK, MessageBoxIcon.Exclamation);
                return;
            }

            try
            {
                Core core = new Core(txtCodeText.Text, txtEncodeString.Text);
                txtCodeText.Text = core.Encode();
            }
            catch
            {
                MessageBox.Show("Error occurred when encoding your text", "Error", MessageBoxButtons.OK, MessageBoxIcon.Error);
            }
        }
        #endregion

        #region btnDecode_Click
        private void btnDecode_Click(object sender, EventArgs e)
        {
            if (txtCodeText.Text == "")
            {
                MessageBox.Show("Text cannot be empty", "Warning", MessageBoxButtons.OK, MessageBoxIcon.Exclamation);
                return;
            }

            if (txtEncodeString.Text == "")
            {
                MessageBox.Show("Encode String cannot be empty", "Warning", MessageBoxButtons.OK, MessageBoxIcon.Exclamation);
                return;
            }

            if (txtEncodeString.Text != txtCfEncodeString.Text)
            {
                MessageBox.Show("Confirm Encode String does not match Encode String", "Warning", MessageBoxButtons.OK, MessageBoxIcon.Exclamation);
                return;
            }

            try
            {
                Core core = new Core(txtCodeText.Text, txtEncodeString.Text);
                txtCodeText.Text = core.Decode();
            }
            catch
            {
                MessageBox.Show("Error occurred when encoding your text", "Error", MessageBoxButtons.OK, MessageBoxIcon.Error);
            }
        }
        #endregion
        #endregion

        #region Main Menu
        #region mnuNew_Click
        private void mnuNew_Click(object sender, EventArgs e)
        {
            this.txtCodeText.Text = "";
            _fileName = "";
        }
        #endregion

        #region mnuOpen_Click
        private void mnuOpen_Click(object sender, EventArgs e)
        {
            OpenFileDialog openFileDlg = new OpenFileDialog();
            openFileDlg.Filter = "Text File(*.txt)|*.txt";
            if (openFileDlg.ShowDialog() == DialogResult.OK)
            {
                _fileName = openFileDlg.FileName;
                Utility.File.TextFile textFile = new Utility.File.TextFile(_fileName);
                txtCodeText.Text = textFile.ReadAllText();
            }
        }
        #endregion

        #region mnuSave_Click
        private void mnuSave_Click(object sender, EventArgs e)
        {
            if (_fileName != "")
            {
                Utility.File.TextFile textFile = new Utility.File.TextFile(_fileName);
                if (textFile.Exist())
                {
                    textFile.WriteAllText(txtCodeText.Text);
                }
                else
                {
                    mnuSaveAs_Click(sender, e);
                }
            }
            else
            {
                mnuSaveAs_Click(sender, e);
            }
        }
        #endregion

        #region mnuSaveAs_Click
        private void mnuSaveAs_Click(object sender, EventArgs e)
        {
            SaveFileDialog saveFileDlg = new SaveFileDialog();
            saveFileDlg.Filter = "Text File(*.txt)|*.txt";
            if(saveFileDlg.ShowDialog() == DialogResult.OK)
            {
                _fileName = saveFileDlg.FileName;
                Utility.File.TextFile textFile = new Utility.File.TextFile(_fileName);
                textFile.WriteAllText(txtCodeText.Text);
            }
        }
        #endregion

        #region mnuAbout_Click
        private void mnuAbout_Click(object sender, EventArgs e)
        {
            FrmAbout frmAbout = new FrmAbout();
            frmAbout.ShowDialog();
        }
        #endregion

        #region mnuHelpTopic_Click
        private void mnuHelpTopic_Click(object sender, EventArgs e)
        {
            FrmHelpTopic frmHelpTopic = new FrmHelpTopic();
            frmHelpTopic.Show();
        }
        #endregion

        #region mnuExit_Click
        private void mnuExit_Click(object sender, EventArgs e)
        {
            this.Close();
        }
        #endregion
        #endregion

        #region KeyEvent
        private void txtCodeText_KeyDown(object sender, KeyEventArgs e) {
            if (e.Modifiers == Keys.Control && e.KeyCode == Keys.A) {
                txtCodeText.SelectAll();
            }
        }
        #endregion

        #region ContextMenuStrip
        #region cmsSelectAll_Click
        private void cmsSelectAll_Click(object sender, EventArgs e)
        {
            txtCodeText.SelectAll();
        }
        #endregion

        #region cmsCopyAll_Click
        private void cmsCopyAll_Click(object sender, EventArgs e)
        {
            if (txtCodeText.Text != "")
            {
                Clipboard.SetText(txtCodeText.Text);
                txtCodeText.Focus();
                txtCodeText.SelectAll();
            }
        }
        #endregion

        #region cmsCopySelection_Click
        private void cmsCopySelection_Click(object sender, EventArgs e)
        {
            if (txtCodeText.SelectedText != "")
            {
                Clipboard.SetText(txtCodeText.SelectedText);
            }
        }
        #endregion

        #region cmsPaste_Click
        private void cmsPaste_Click(object sender, EventArgs e)
        {
            txtCodeText.Text += Clipboard.GetText();
        }
        #endregion

        #region cmsEmpty_Click
        private void cmsEmpty_Click(object sender, EventArgs e)
        {
            txtCodeText.Text = "";
        }
        #endregion
        #endregion
        #endregion
    }
}