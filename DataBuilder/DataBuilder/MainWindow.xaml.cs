using System;
using System.Data.SqlClient;
using System.Linq;
using System.Windows;
using System.Windows.Controls;
using System.Data;
using System.Xml;

namespace DataBuilder
{
    /// <summary>
    /// Interaction logic for MainWindow.xaml
    /// </summary>
    public partial class MainWindow : Window
    {
        private string connString;
        private DataTable tableData;
        private DataTable tableEdit;
        private Functions functions;

        public MainWindow()
        {
            InitializeComponent();
            functions = new Functions();
            tableData = new DataTable();
            tableEdit = new DataTable();
            tableEdit.Columns.Add("Column");
            tableEdit.Columns.Add("Value");
            dgEditColumns.ItemsSource = tableEdit.DefaultView;

            string server;
            string dbName;
            string userId;
            string password;
            bool trustedConnection;
            functions.GetConfig(AppDomain.CurrentDomain.BaseDirectory + "\\Config.xml", out server, out dbName, out userId, out password, out trustedConnection);
            connString = functions.GetConnectionString(server, dbName, userId, password, trustedConnection);
        }

        private void btnQuery_Click(object sender, RoutedEventArgs e)
        {
            string errMsg;
            tableData = functions.QueryTableData(connString, txtSelection.Text, out errMsg);
            if(errMsg != string.Empty)
            {
                MessageBox.Show(errMsg);
            }
            else
            {
                dgTableData.ItemsSource = null;
                dgTableData.ItemsSource = tableData.DefaultView;
            }
        }

        private void dgTableData_SelectionChanged(object sender, SelectionChangedEventArgs e)
        {
            tableEdit.Rows.Clear();
            int selectedIndex = dgTableData.SelectedIndex;

            for(int i = 0; selectedIndex >= 0 && i < tableData.Columns.Count; i++)
            {
                Type dataType = tableData.Columns[i].DataType;
                string columnName = tableData.Columns[i].ColumnName;
                object value = tableData.Rows[selectedIndex][i];
                
                DataRow dr = tableEdit.NewRow();
                dr[0] = columnName;
                dr[1] = functions.GetValueByDataType(dataType, value);
                tableEdit.Rows.Add(dr);
            }
        }

        private void btnGenCode_Click(object sender, RoutedEventArgs e)
        {
            string insertColumnList = "";
            string insertValueList = "";

            for (int i = 0; i < tableEdit.Rows.Count; i++)
            {
                DataRow dr = tableEdit.Rows[i];
                string columnName = dr[0].ToString();
                string valueStr = dr[1].ToString();
                if (ckExcludeSystemColumns.IsChecked == true && functions.IsSystemColumns(columnName))
                {
                    continue;
                }
                insertColumnList += columnName;
                insertValueList += valueStr;

                insertColumnList += ", ";
                insertColumnList += (bool)ckColumnPerLine.IsChecked ? "\r\n" : "";
                insertValueList += ", ";
                insertValueList += (bool)ckColumnPerLine.IsChecked ? "\r\n" : "";
            }

            string tableName = functions.GetTableFromQuery(txtSelection.Text);
            insertColumnList = insertColumnList.TrimEnd(' ', ',', '\r', '\n');
            insertValueList = insertValueList.TrimEnd(' ', ',', '\r', '\n');
            string codeBlock = $"INSERT INTO {tableName} ({insertColumnList})\r\nVALUES({insertValueList})";
            txtCode.Text = codeBlock;
        }
    }
}
