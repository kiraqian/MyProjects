using System;
using System.Collections.Generic;
using System.Data;
using System.IO;

namespace PickupUtil
{
    public class Text : IText
    {
        public DataTable ListFiles(string path)
        {
            DataTable dataTable = new DataTable();
            dataTable.Columns.Add("Select", typeof(bool));
            dataTable.Columns.Add("FullName", typeof(string));

            DirectoryInfo directoryInfo = Directory.CreateDirectory(path);
            FileInfo[] filesInfo = directoryInfo.GetFiles("*.txt", SearchOption.TopDirectoryOnly);
            foreach(FileInfo fileInfo in filesInfo)
            {
                dataTable.Rows.Add(false, fileInfo.FullName);
            }
            return dataTable;
        }

        public string ListToText(List<string> textInList)
        {
            string resultText = string.Empty;
            foreach(string line in textInList)
            {
                resultText += line + "\r\n";
            }
            return resultText;
        }

        public string ReadFileContent(string fileName)
        {
            return File.ReadAllText(fileName);
        }

        public List<string> TextToList(string textInLine, bool removeDuplicate = true)
        {
            List<string> lstText = new List<string>();
            string[] lines = textInLine.Split(new char[] { '\r', '\n' }, StringSplitOptions.RemoveEmptyEntries);
            foreach(string line in lines)
            {
                lstText.Add(line);
            }
            return lstText;
        }
    }
}
