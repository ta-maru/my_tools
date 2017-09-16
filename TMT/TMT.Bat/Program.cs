using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Text;
using System.Text.RegularExpressions;
using System.Threading.Tasks;
using TMT.Commons.Utility;

namespace TMT.Bat
{
    class Program
    {
        static void Main(string[] args)
        {
            var s = Environment.GetCommandLineArgs();

            var a = new CLParser(s);

            var b = new CSTCLParser(s);

            Console.ReadLine();


            // NP
        }
    }
}
