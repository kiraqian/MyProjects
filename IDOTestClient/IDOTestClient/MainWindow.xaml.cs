using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows;
using System.Windows.Controls;
using System.Windows.Data;
using System.Windows.Documents;
using System.Windows.Input;
using System.Windows.Media;
using System.Windows.Media.Imaging;
using System.Windows.Navigation;
using System.Windows.Shapes;
using IDOTestClient.Properties;

namespace IDOTestClient
{
    /// <summary>
    /// Interaction logic for MainWindow.xaml
    /// </summary>
    public partial class MainWindow : Window
    {
        private IDOExecute _iDOExecute;
        private DataTable _resultTable;
        private string _token;
        private Settings _settings;
        public MainWindow()
        {
            InitializeComponent();
            _settings = new Settings();            
            txtMachineName.Text = _settings.MachineName;
            txtConfigName.Text = _settings.ConfigName;
            txtUserId.Text = _settings.UserID;
            txtPassword.Password = _settings.Password;
            txtIDOName.Text = _settings.IDOName;
            txtMethodName.Text = _settings.MethodName;

            _token = "";

            _iDOExecute = new IDOExecute();
            _resultTable = new DataTable();

            this.Closing += MainWindow_Closing;
        }

        private void MainWindow_Closing(object sender, System.ComponentModel.CancelEventArgs e)
        {
            _settings.MachineName = txtMachineName.Text;
            _settings.ConfigName = txtConfigName.Text;
            _settings.UserID = txtUserId.Text;
            _settings.Password = txtPassword.Password;
            _settings.IDOName = txtIDOName.Text;
            _settings.MethodName = txtMethodName.Text;
            _settings.Save();
        }

        private void btnRunTest_Click(object sender, RoutedEventArgs e)
        {
            string machineName = txtMachineName.Text;
            string site = txtConfigName.Text;
            string uid = txtUserId.Text;
            string pw = txtPassword.Password;

            string ido = txtIDOName.Text;
            string method = txtMethodName.Text;
            string parms = txtMethodParms.Text;
            string output = "";

            try
            {
                ckHideEmptyColumn.IsChecked = false;

                if (string.IsNullOrEmpty(_token))
                {
                    _token = _iDOExecute.GetToken(machineName, site, uid, pw);
                }

                List<DataTable> resultTables = _iDOExecute.ExecuteCustomLoadMethod(machineName, ido, parms, output, method, _token);
                if (resultTables.Count > 1)
                {
                    _resultTable = resultTables[1];
                    dgResult.ItemsSource = _resultTable.DefaultView;
                }
            }
            catch(Exception ex)
            {
                MessageBox.Show(ex.Message);
            }
        }

        private void btnRefreshToken_Click(object sender, RoutedEventArgs e)
        {
            string machineName = txtMachineName.Text;
            string site = txtConfigName.Text;
            string uid = txtUserId.Text;
            string pw = txtPassword.Password;
            try
            {
                _token = _iDOExecute.GetToken(machineName, site, uid, pw);
                if (!string.IsNullOrEmpty(_token))
                {
                    MessageBox.Show("Refresh Success.");
                }
            }
            catch (Exception ex)
            {
                MessageBox.Show(ex.Message);
            }
        }

        private void ckHideEmptyColumn_Checked(object sender, RoutedEventArgs e)
        {
            HideEmptyColumnsCheckChanged(true);
        }

        private void ckHideEmptyColumn_Unchecked(object sender, RoutedEventArgs e)
        {
            HideEmptyColumnsCheckChanged(false);
        }

        private void HideEmptyColumnsCheckChanged(bool hideEmpty)
        {
            foreach (DataGridColumn dgc in dgResult.Columns)
            {
                bool shouldHide = hideEmpty ? true : false;
                for (int i = 0; i < dgResult.Items.Count; i++)
                {
                    TextBlock textBlock = dgc.GetCellContent(dgResult.Items[i]) as TextBlock;
                    if (textBlock != null && textBlock.Text.Length > 0)
                    {
                        shouldHide = false;
                        break;
                    }
                }
                dgc.Visibility = shouldHide ? Visibility.Hidden : Visibility.Visible;
            }
        }
    }
}
