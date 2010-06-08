using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.IO;
using System.Reflection;
using System.Diagnostics;

namespace ProtocolHandlerWrapper
{
    class Program
    {
        static void Main(string[] args)
        {
            var ruby = System.Environment.GetEnvironmentVariable("PATH").Split(';').
                                    Select(path => Path.Combine(path, "ruby.exe")).
                                    First(path => File.Exists(path));

            string wrappedPath = Path.Combine(Path.GetDirectoryName(Assembly.GetExecutingAssembly().Location), "protocol_handler.rb");
            // Console.WriteLine(ruby);
            // Console.WriteLine(wrappedPath);

            Process ProcessObj = new Process();
            ProcessObj.StartInfo.FileName = ruby;
            ProcessObj.StartInfo.Arguments = wrappedPath + " " + String.Join(" ", args);

            ProcessObj.StartInfo.UseShellExecute = false;
            ProcessObj.StartInfo.CreateNoWindow = true;

            ProcessObj.Start();

            ProcessObj.WaitForExit();
        }
    }
}
