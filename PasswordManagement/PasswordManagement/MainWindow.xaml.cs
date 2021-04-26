using System;
using System.Windows;

namespace PasswordManagement
{
    /// <summary>
    /// Interaction logic for MainWindow.xaml
    /// </summary>
    public partial class MainWindow : Window
    {
        private Core _core;
        public MainWindow()
        {
            InitializeComponent();
            _core = new Core();
        }

        private void btnEncode_Click(object sender, RoutedEventArgs e)
        {
            if(txtPassword.Password != string.Empty &&
                txtPassword.Password == txtPasswordConfirm.Password)
            {
                try
                {
                    _core.CustomEncodeText = txtPassword.Password;
                    _core.OriginalText = txtContent.Text;
                    txtContent.Text = _core.Encode();
                }
                catch(Exception ex)
                {
                    MessageBox.Show(ex.Message);
                }
            }
            else
            {
                MessageBox.Show("Password not matched!");
            }
        }

        private void btnDecode_Click(object sender, RoutedEventArgs e)
        {
            if (txtPassword.Password != string.Empty &&
                txtPassword.Password == txtPasswordConfirm.Password)
            {
                try
                {
                    _core.CustomEncodeText = txtPassword.Password;
                    _core.OriginalText = txtContent.Text;
                    txtContent.Text = _core.Decode();
                }
                catch(Exception ex)
                {
                    MessageBox.Show(ex.Message);
                }
            }
            else
            {
                MessageBox.Show("Password not matched!");
            }
        }
    }
}
