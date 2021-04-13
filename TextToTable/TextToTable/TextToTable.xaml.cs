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

namespace TextToTable
{
    /// <summary>
    /// Interaction logic for MainWindow.xaml
    /// </summary>
    public partial class MainWindow : Window
    {
        private DataTable table;
        public MainWindow()
        {
            InitializeComponent();
            table = new DataTable();
        }

        private void btnToTable_Click(object sender, RoutedEventArgs e)
        {
            char[] splitOption = GetSplitOption();
            string[] lines = txtTextInLine.Text.Split(new string[] { Environment.NewLine }, StringSplitOptions.RemoveEmptyEntries);
            PrepareResultTable(table, GetMaxColumnCount(lines, splitOption));

            foreach (string line in lines)
            {
                string[] items = line.Split(splitOption, StringSplitOptions.RemoveEmptyEntries);
                DataRow dr = table.NewRow();
                for (int i = 0; i < items.Length; i++)
                {
                    dr[i] = items[i];
                }
                table.Rows.Add(dr);
            }
            dgTable.ItemsSource = table.DefaultView;
        }

        private void btnToText_Click(object sender, RoutedEventArgs e)
        {
            string resultText = "";
            foreach(DataRow dr in table.Rows)
            {
                string line = "";
                foreach(DataColumn dc in table.Columns)
                {
                    line += dr[dc.ColumnName].ToString();
                    line += " ";
                }
                resultText += line;
                resultText += Environment.NewLine;
            }

            txtTextInLine.Text = resultText;
        }

        private void PrepareResultTable(DataTable resultTable, int columnCount)
        {
            resultTable.Rows.Clear();
            resultTable.Columns.Clear();
            for(int i = 1; i <= columnCount; i++)
            {
                resultTable.Columns.Add("Column" + i.ToString());
            }
        }

        private int GetMaxColumnCount(string[] lines, char[] splitOption)
        {
            int maxColumnCount = 0;
            foreach(string line in lines)
            {
                int len = line.Split(splitOption, StringSplitOptions.RemoveEmptyEntries).Length;
                if (len > maxColumnCount)
                    maxColumnCount = len;
            }
            return maxColumnCount;
        }

        private char[] GetSplitOption()
        {
            List<char> opt = new List<char>();
            if (ckSpace.IsChecked == true)
                opt.Add(' ');

            if (ckTab.IsChecked == true)
                opt.Add('\t');

            return opt.ToArray();
        }
    }
}
