using Microsoft.CSharp;
using System;
using System.CodeDom.Compiler;
using System.Collections.Generic;
using System.Linq;
using System.Reflection;
using System.Web;

namespace DynamicWeb
{
    public class CodeHelper
    {
        public static string InvokeServerMethod(string csCode, string className, string methodName, object[] parameters = null)
        {
            var csc = new CSharpCodeProvider();
            var parm = new CompilerParameters(new[] { "mscorlib.dll", "System.Core.dll" }, null, true);
            parm.GenerateExecutable = false;
            CompilerResults cresults = csc.CompileAssemblyFromSource(parm, csCode);
            Assembly asm = cresults.CompiledAssembly;
            Type type = asm.GetType(className);
            MethodInfo methodInfo = type.GetMethod(methodName);
            object classInstance = Activator.CreateInstance(type, null);
            object result = methodInfo.Invoke(classInstance, parameters);
            return result.ToString();
        }
    }
}