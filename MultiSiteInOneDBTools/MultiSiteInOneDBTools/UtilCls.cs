using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.IO;
using System.Xml;
using Utility.SqlUtil;
using Utility.StringUtil;
using System.Data;

namespace MultiSiteInOneDBTools
{
    public class UtilCls
    {
        private string _sourcePath;
        private string _outputPath;
        private string _exceptionPath;
        private string _connString;

        public UtilCls(string sourcePath, string outputPath, string exceptionPath)
        {
            _sourcePath = sourcePath.TrimEnd(new char[] { '\\', ' ' });
            _outputPath = outputPath.TrimEnd(new char[] { '\\', ' ' });
            _exceptionPath = exceptionPath.TrimEnd(new char[] { '\\', ' ' });
        }

        public UtilCls(string sourcePath, string outputPath, string exceptionPath, string connString)
        {
            _sourcePath = sourcePath.TrimEnd(new char[] { '\\', ' ' });
            _outputPath = outputPath.TrimEnd(new char[] { '\\', ' ' });
            _exceptionPath = exceptionPath.TrimEnd(new char[] { '\\', ' ' });
            _connString = connString;
        }

        public void ProcessSSRSFiles()
        {
            List<string> fileNames = GetFileList(_sourcePath);
            foreach(string fileName in fileNames)
            {
                ProcessSingleSSRSFile(fileName);
            }
        }

        public void ProcessStoredProcedures()
        {
            List<string> fileNames = GetFileList(_sourcePath);
            foreach (string fileName in fileNames)
            {
                ProcessSingleSP(fileName);
            }
        }

        public void ProcessTriggers()
        {
            List<string> fileNames = GetFileList(_sourcePath);
            foreach (string fileName in fileNames)
            {
                ProcessSingleTrigger(fileName);
            }
        }

        private void ProcessSingleTrigger(string fileName)
        {
            string triggerName = fileName.Replace(".trg", "");
            string tableName = "";
            string[] fileLines = File.ReadAllLines(_sourcePath + "\\" + fileName);

            try
            {
                if (triggerName.ToUpper().EndsWith("IUP") || triggerName.ToUpper().EndsWith("DEL"))
                {
                    tableName = triggerName.Substring(0, triggerName.Length - 3);
                }

                if (triggerName == "" || tableName == "" || triggerName.Contains("_mst") || tableName.Contains("_mst"))
                {
                    File.WriteAllLines(_exceptionPath + "\\" + fileName, fileLines);
                    return;
                }

                for (int i = 0; i < fileLines.Length; i++)
                {
                    string lineStr = fileLines[i].Trim().Replace(" ", "").ToUpper();

                    if (lineStr.StartsWith("IFOBJECT_ID(") ||
                        lineStr.StartsWith("IFEXISTS(SELECT*FROMSYSOBJECTSWHEREID=OBJECT_ID(") ||
                        lineStr.StartsWith("IFEXISTS(SELECT1FROMSYSOBJECTSWHEREID=OBJECT_ID(") ||
                        lineStr.StartsWith("IFEXISTS(SELECT*FROMSYS.OBJECTSWHEREOBJECT_ID=OBJECT_ID(") ||
                        lineStr.StartsWith("IFEXISTS(SELECT1FROMSYS.OBJECTSWHEREOBJECT_ID=OBJECT_ID(") ||
                        lineStr.StartsWith("IFEXISTS(SELECT*FROMSYS.TRIGGERSWHEREOBJECT_ID=OBJECT_ID(") ||
                        lineStr.StartsWith("IFEXISTS(SELECT1FROMSYS.TRIGGERSWHEREOBJECT_ID=OBJECT_ID(") ||
                        lineStr.StartsWith("EXECSP_SETTRIGGERORDER@TRIGGERNAME=") ||
                        lineStr.StartsWith("IFEXISTS(SELECT*FROMDBO.SYSOBJECTSWHEREID=OBJECT_ID(") ||
                        lineStr.StartsWith("IFEXISTS(SELECT*FROMDBO.SYSOBJECTSWHEREID=OBJECT_ID("))
                    {
                        fileLines[i] = fileLines[i].Replace(tableName, tableName + "_mst");
                    }

                    if (lineStr.StartsWith("DROPTRIGGER"))
                    {
                        fileLines[i] = fileLines[i].Replace(tableName, tableName + "_mst");
                    }

                    if (lineStr.StartsWith("CREATETRIGGER"))
                    {
                        fileLines[i] = fileLines[i].Replace(tableName, tableName + "_mst");
                        string nextLineStr = fileLines[i + 1].Trim().Replace(" ", "").ToUpper();
                        if(nextLineStr.StartsWith("ON") && nextLineStr.Contains(tableName.ToUpper()))
                        {
                            fileLines[i + 1] = fileLines[i + 1].Replace(tableName, tableName + "_mst");
                            break;
                        }
                    }
                }

                File.WriteAllLines(_outputPath + "\\" + fileName, fileLines);
            }
            catch
            {
                File.WriteAllLines(_exceptionPath + "\\" + fileName, fileLines);
            }
        }

        private void ProcessSingleSSRSFile(string fileName)
        {
            string[] fileLines = File.ReadAllLines(_sourcePath + "\\" + fileName);
            string siteNodeXml = File.ReadAllText("ParmNodeTmp.txt");
            string rptParmSiteNodeXml = File.ReadAllText("RptParmNodeTmp.txt");
            string finalContent = "";

            for (int i = 0; i < fileLines.Length; i++)
            {
                string line = fileLines[i];
                if (line.Trim().StartsWith("</QueryParameters>"))
                {
                    finalContent += siteNodeXml;
                    finalContent += "\r\n";
                }

                if(line.Trim().StartsWith("</ReportParameters>"))
                {
                    finalContent += rptParmSiteNodeXml;
                    finalContent += "\r\n";
                }

                finalContent += line;
                finalContent += "\r\n";
            }
            File.WriteAllText(_outputPath + "\\" + fileName, finalContent);
        }

        private void ProcessSingleSP(string fileName)
        {
            string[] fileContentLine = File.ReadAllLines(_sourcePath + "\\" + fileName);
            List<string> fileContentList = StringUtility.LinesStringToStringList(fileContentLine);
            string finalContent = "";
            int indexOfCreateProcedure = 0;
            int indexOfLastParm = 0;
            int indexOfAs = 0;
            string errMsg;

            try
            {
                string spName = fileName.Replace(".sp", "");
                spName = spName.Replace(".Sp", "");                
                spName = spName.Replace(".SP", "");
                spName = spName.Replace(".sql", "");
                spName = spName.Replace(".SQL", "");

                DataTable dtParms = SqlUtility.GetSPParameterList(_connString, spName, out errMsg);
                string lastParmName = dtParms.Rows[dtParms.Rows.Count - 1]["name"].ToString();

                for (int i = 0; i < fileContentList.Count; i++)
                {
                    string line = fileContentList[i].Replace(" ", "");
                    if (line.TrimStart().ToUpper().StartsWith("CREATEPROCEDURE"))
                    {
                        indexOfCreateProcedure = i;
                        break;
                    }
                }

                for (int i = indexOfCreateProcedure; i < fileContentList.Count; i++)
                {
                    if (fileContentList[i].Contains(lastParmName))
                    {
                        fileContentList.Insert(i + 1, " , @pSite SiteType = NULL");
                        indexOfLastParm = i + 1;
                        break;
                    }
                }

                for (int i = indexOfLastParm; i < fileContentList.Count; i++)
                {
                    string line = fileContentList[i].Trim().Replace(" ", "").ToUpper();
                    if (line == "AS" || line == ")AS")
                    {
                        indexOfAs = i;
                        break;
                    }
                }

                for(int i = indexOfAs; i < fileContentList.Count; i++)
                {
                    string line = fileContentList[i].Trim();
                    if(line == "EXEC @EXTGEN_Severity = @EXTGEN_SpName")
                    {
                        for(int j = i; j < fileContentList.Count; j++)
                        {
                            line = fileContentList[j].Trim();
                            if(line.Contains(lastParmName))
                            {
                                fileContentList.Insert(j + 1, "         , @pSite");
                                break;
                            }
                        }
                    }
                }

                for (int i = indexOfAs; i < fileContentList.Count; i++)
                {
                    string line = fileContentList[i].Trim();
                    string siteParmCodeLine = "   , @Site        = @pSite";
                    if (line.Contains("InitSessionContextSp"))
                    {
                        fileContentList.Insert(i + 3, siteParmCodeLine);
                    }
                }
            }
            catch
            {
                finalContent = StringUtility.StringListToText(fileContentList);
                File.WriteAllText(_exceptionPath + "\\" + fileName, finalContent);
            }

            finalContent = StringUtility.StringListToText(fileContentList);
            File.WriteAllText(_outputPath + "\\" + fileName, finalContent);
        }

        public List<string> GetFileList(string folder)
        {
            List<string> fileList = new List<string>();
            DirectoryInfo dir = new DirectoryInfo(folder);
            FileInfo[] fileInfos = dir.GetFiles("*.*", SearchOption.AllDirectories);
            foreach(FileInfo file in fileInfos)
            {
                fileList.Add(file.Name);
            }
            return fileList;
        }
    }
}
