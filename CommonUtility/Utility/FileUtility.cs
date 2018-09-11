using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Utility.FileUtil
{
    public class FileUtility
    {
        #region CreateFolder
        public static void CreateFolder(string path)
        {
            if (!Directory.Exists(path))
            {
                Directory.CreateDirectory(path);
            }
        }
        #endregion

        #region GetFileList
        public static string [] GetFileList(string directory, string searchPattern, bool searchSubFolders)
        {
            SearchOption searchOption = searchSubFolders ? SearchOption.AllDirectories : SearchOption.TopDirectoryOnly;
            string[] fileName = Directory.GetFiles(directory, searchPattern, searchOption);

            return fileName;
        }
        #endregion

        public static string CopyFileByName(string sourcePath, string targetPath, string fileName)
        {
            targetPath = targetPath.TrimEnd(new char[] { '\\' }) + "\\";
            DirectoryInfo dir = new DirectoryInfo(sourcePath);
            FileInfo[] files = dir.GetFiles(fileName + ".s*", SearchOption.AllDirectories);
            foreach (FileInfo file in files)
            {
                if (!File.Exists(targetPath + file.Name))
                {
                    file.CopyTo(targetPath + file.Name);
                    return targetPath + file;
                }
            }
            return "";
        }
    }
}
