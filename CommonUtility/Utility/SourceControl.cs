using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Utility.Cmd;
using Utility.StringUtil;

namespace Utility.SourceControl
{
    #region Git
    public class Git
    {
        #region Members
        private string _workingFolder;
        private Branch _currentBranch;
        private string _repositoryUrl;
        private bool _showCmdWindow;
        #endregion

        #region Constructor
        public Git(string workingFolder)
        {
            _workingFolder = workingFolder;
            _showCmdWindow = false;
        }

        public Git(string workingFolder, string repositoryUrl)
        {
            _workingFolder = workingFolder;
            _repositoryUrl = repositoryUrl;
        }
        #endregion

        #region Properties
        public string RepositoryUrl
        {
            get
            {
                return _repositoryUrl;
            }
        }

        public string WorkingFolder
        {
            get
            {
                return _workingFolder;
            }
        }

        public bool ShowCommandWindow
        {
            get
            {
                return _showCmdWindow;
            }
        }

        public Branch CurrentBranch
        {
            get
            {
                return _currentBranch;
            }
        }
        #endregion

        #region Methods
        public void ResetWorkingFolder(string workingFolder)
        {
            _workingFolder = workingFolder;
        }

        public void ChangeRepositoryUrl(string repositoryUrl)
        {
            _repositoryUrl = repositoryUrl;
        }

        public void SetShowCommandWindow(bool isShow)
        {
            _showCmdWindow = isShow;
        }

        public void Clone(string repositoryUrl)
        {
            _repositoryUrl = repositoryUrl;
            string cmdText = "git clone \"" + repositoryUrl + "\"";
            CommandLine.ExecuteCommandSync(_workingFolder, cmdText, _showCmdWindow);
        }

        public string CheckOut(Branch branch)
        {
            string cmdText;
            string result;            
            cmdText = "git checkout \"" + branch.FullName + "\"";
            result = CommandLine.ExecuteCommandSync(_workingFolder, cmdText, _showCmdWindow);            
            _currentBranch = branch;
            return result;
        }

        public string CreateBranch(Branch branch)
        {
            string result;
            string cmdText = "git checkout -b \"" + branch.FullName + "\"";
            result = CommandLine.ExecuteCommandSync(_workingFolder, cmdText, _showCmdWindow);
            _currentBranch = branch;
            return result;
        }

        public string DeleteBranch(Branch branch)
        {
            string result;
            string cmdText = "git branch -d \"" + branch.FullName + "\"";
            result = CommandLine.ExecuteCommandSync(_workingFolder, cmdText, _showCmdWindow);
            return result;
        }

        public List<string> GetAllBranches(out string currentBranchName)
        {
            string result;
            currentBranchName = "";
            List<string> branches = new List<string>();
            string cmdText = "git branch";
            result = CommandLine.ExecuteCommandSync(_workingFolder, cmdText, _showCmdWindow);
            string[] textInLines = StringUtility.TextToLinesString(result);
            foreach(string line in textInLines)
            {
                string branchName = line.Trim();
                if (branchName.StartsWith("*"))
                {
                    currentBranchName = branchName.Replace("*", "").Trim();
                    branchName = currentBranchName;
                }
                
                if (branchName != string.Empty)
                {
                    branches.Add(branchName);
                }
            }
            return branches;
        }

        public string Pull()
        {
            string result;
            string cmdText = "git pull";
            result = CommandLine.ExecuteCommandSync(_workingFolder, cmdText, _showCmdWindow);
            return result;
        }

        public string Push()
        {
            string result;
            string cmdText = "git push";
            result = CommandLine.ExecuteCommandSync(_workingFolder, cmdText, _showCmdWindow);
            return result;
        }

        public string MergeFrom(Branch branch)
        {
            string result;
            string cmdText = "git merge \"" + branch.FullName + "\"";
            result = CommandLine.ExecuteCommandSync(_workingFolder, cmdText, _showCmdWindow);
            return result;
        }

        public string GetLog()
        {
            string result;
            string cmdText = "git log";
            result = CommandLine.ExecuteCommandSync(_workingFolder, cmdText, _showCmdWindow);
            return result;
        }
        #endregion
    }
    #endregion

    #region Branch
    public class Branch
    {
        #region Members
        private string _fullName;
        private List<string> _changedFiles;
        private List<string> _stagedFiles;
        private Git _git;
        #endregion

        #region Constructor
        public Branch(string branchFullName, Git git)
        {
            _fullName = branchFullName;
            _changedFiles = new List<string>();
            _stagedFiles = new List<string>();
            _git = git;
        }
        #endregion

        #region Properties
        public Git Git
        {
            get
            {
                return _git;
            }
        }

        public string FullName
        {
            get
            {
                return _fullName;
            }
        }
        
        public List<string> ChangedFiles
        {
            get
            {
                string cmdText = "git status";
                string cmdResult = CommandLine.ExecuteCommandSync(_git.WorkingFolder, cmdText, _git.ShowCommandWindow);
                _changedFiles = FetchModifiedFilesInText(cmdResult, false);
                return _changedFiles;
            }
        }
        public List<string> StagedFiles
        {
            get
            {
                string cmdText = "git status";
                string cmdResult = CommandLine.ExecuteCommandSync(_git.WorkingFolder, cmdText, _git.ShowCommandWindow);
                _stagedFiles = FetchModifiedFilesInText(cmdResult, true);
                return _stagedFiles;
            }
        }
        #endregion

        #region Methods
        public string Commit()
        {
            string result = "";
            string cmdText = @"git commit";
            result = CommandLine.ExecuteCommandSync(_git.WorkingFolder, cmdText, _git.ShowCommandWindow);
            return result;
        }

        public string Stage(string fileFullName)
        {
            string result = "";
            string cmdText = "git add \"" + fileFullName + "\"";
            result = CommandLine.ExecuteCommandSync(_git.WorkingFolder, cmdText, _git.ShowCommandWindow);
            return result;
        }

        public string Unstage(string fileFullName)
        {
            string result;
            string cmdText = "git reset HEAD -- \"" + fileFullName + "\"";
            result = CommandLine.ExecuteCommandSync(_git.WorkingFolder, cmdText, _git.ShowCommandWindow);
            return result;
        }

        public string ShowDifference()
        {
            string result;
            string cmdText = "git diff";
            result = CommandLine.ExecuteCommandSync(_git.WorkingFolder, cmdText, _git.ShowCommandWindow);
            return result;
        }

        private List<string> FetchModifiedFilesInText(string text, bool staged)
        {
            List<string> fileList = new List<string>();
            string[] textInLine = StringUtility.TextToLinesString(text);

            bool passStagedBlock = false;
            bool passNotStagedBlock = false;

            foreach(string lineText in textInLine)
            {
                if (lineText.Trim() == "Changes to be committed:")
                {
                    passStagedBlock = true;
                }

                if (lineText.Trim() == "Changes not staged for commit:")
                {
                    passNotStagedBlock = true;
                }

                if (passStagedBlock && !passNotStagedBlock && staged == true)
                {
                    if (lineText.Trim().StartsWith("modified:"))
                    {
                        fileList.Add("[M]:" + lineText.Substring(10).Trim());
                    }
                    if (lineText.Trim().StartsWith("deleted:"))
                    {
                        fileList.Add("[D]:" + lineText.Substring(9).Trim());
                    }
                    if (lineText.Trim().StartsWith("new file:"))
                    {
                        fileList.Add("[A]:" + lineText.Substring(10).Trim());
                    }
                }

                if(passNotStagedBlock && staged == false)
                {
                    if (lineText.Trim().StartsWith("modified:"))
                    {
                        fileList.Add("[M]:" + lineText.Substring(10).Trim());
                    }
                    if (lineText.Trim().StartsWith("deleted:"))
                    {
                        fileList.Add("[D]:" + lineText.Substring(9).Trim());
                    }
                    if (lineText.Trim().StartsWith("new file:"))
                    {
                        fileList.Add("[A]:" + lineText.Substring(10).Trim());
                    }
                }
            }
            return fileList;
        }
        #endregion
    }
    #endregion
}
