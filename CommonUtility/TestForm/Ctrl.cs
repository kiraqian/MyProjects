using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

using Utility.SqlUtil;

namespace TestForm
{
    public class Ctrl
    {
        private string _connString;
        private string _sourcePath;
        private string _targetPath;
        private List<string> _userSpList;
        private List<string> _sysSpList;

        public Ctrl(string connString)
        {
            _connString = connString;
            _sysSpList = new List<string>();
        }

        public void SetPath(string sourcePath, string targetPath)
        {
            _sourcePath = sourcePath;
            _targetPath = targetPath;
        }

        private void LoadUserSp()
        {
            string errMsg;
            _userSpList = SqlUtility.GetAllUserSPInDB(_connString, out errMsg);
            _userSpList.Remove("spetpcodesp");
            _userSpList.Remove("ht");
            _userSpList.Remove("ft");
            _userSpList.Remove("fp");
            _userSpList.Remove("whereis");
            _userSpList.Remove("grep");
            //_sysSpList.Add("sp_executesql");
        }

        public void ProcessSingleSP(string fileName)
        {
            string codeContent = File.ReadAllText(_sourcePath + "\\" + fileName);
            string modifiedContent = SqlUtility.AddDBObjPrefixForScript(codeContent, _userSpList, _sysSpList);
            if (codeContent != modifiedContent)
            {
                File.WriteAllText(_targetPath + "\\" + fileName, modifiedContent);
            }
        }

        public void ProcessAllSP()
        {
            List<string> fileNames = GetFileList(_sourcePath);
            LoadUserSp();
            foreach (string fileName in fileNames)
            {
                ProcessSingleSP(fileName);
            }
        }

        private List<string> GetFileList(string folder)
        {
            List<string> fileList = new List<string>();
            DirectoryInfo dir = new DirectoryInfo(folder);
            FileInfo[] fileInfos = dir.GetFiles("*.*", SearchOption.AllDirectories);
            foreach (FileInfo file in fileInfos)
            {
                fileList.Add(file.Name);
            }
            return fileList;
        }
    }
}
