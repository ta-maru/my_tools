using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace TMT.Commons.Utility
{
    public class CSTCLParser : CLParser
    {
        public CSTCLParser(string[] clArgs) : base(clArgs)
        {
            HasError = !checkParameters();
        }

        private bool checkParameters()
        {
            if (CLArgs.Count < 3) return false;

            if (!((CLArgs[0].Option == "-A") && (CLArgs[1].Option == "-B") && (CLArgs[2].Option == "-C"))) return false;

            if (!((CLArgs[0].Values.Count == 1) && (CLArgs[1].Values.Count == 1) && (CLArgs[2].Values.Count == 1))) return false;

            return true;
        }
    }
}
