using System;
using System.Collections.Generic;
using System.Data;
using System.IO;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

using System.Windows.Forms;
using Utility.StringUtil;

namespace StringReplace
{
    public class Tool
    {
        public static int ReplaceText(string content, string originalString, string newString, out string replacedContent)
        {
            int modified = 1;
            int unchanged = 0;

            if(content.Contains(originalString))
            {
                replacedContent = content.Replace(originalString, newString);
                return modified;
            }
            else
            {
                replacedContent = content;
                return unchanged;
            }
        }

        public static void SaveFile(string fullName, string content)
        {
            int index = fullName.LastIndexOf("\\");
            string path = fullName.Substring(0, index);
            if(!Directory.Exists(path))
            {
                Directory.CreateDirectory(path);
            }
            File.WriteAllText(fullName, content);
        }

        public static string[] GetFileList(string path)
        {
            return Directory.GetFiles(path, "*.*", SearchOption.AllDirectories);
        }

        public static DataTable PasteExcelDataToDataTable(List<string> columnNameList)
        {
            DataTable dt = new DataTable();
            foreach (string columnName in columnNameList)
            {
                dt.Columns.Add(columnName);
            }

            string clipboardContent = Clipboard.GetText();

            string[] textInLines = clipboardContent.Split(new string[] { "\r\n" }, StringSplitOptions.RemoveEmptyEntries);
            foreach (string lineText in textInLines)
            {
                string[] textInCell = lineText.Split(new char[] { '\t' });
                if (textInCell.Length == dt.Columns.Count)
                {
                    DataRow newRow = dt.NewRow();
                    int columnIndex = 0;
                    foreach (string cellText in textInCell)
                    {
                        newRow[columnIndex] = cellText;
                        columnIndex++;
                    }
                    dt.Rows.Add(newRow);
                }
            }
            return dt;
        }

        public static int StringReplace(string contentToReplace, string oldValue, string newValue, 
                                        out string replacedContent, bool caseSensitive, bool matchWholeWord)
        {
            int modified = 1;
            int unchanged = 0;
            bool changed = false;

            changed = StringUtility.StringReplace(contentToReplace, oldValue, newValue, out replacedContent, caseSensitive, matchWholeWord);

            return changed ? modified : unchanged;
        }
    }
}
