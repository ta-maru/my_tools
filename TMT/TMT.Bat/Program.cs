using System;
using TMT.Commons.Utility;

namespace TMT.Bat
{
    class Program
    {
        static void Main(string[] args)
        {
            var ags = Environment.GetCommandLineArgs();

            var p1 = new CLParser(ags);

            var p2 = new CSTCLParser(ags);

            Console.ReadLine();
        }
    }
}
