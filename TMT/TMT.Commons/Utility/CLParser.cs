using System.Collections.Generic;
using System.Linq;

namespace TMT.Commons.Utility
{
    /// <summary>
    /// Command Line Arguments
    /// </summary>
    public class CLArg
    {
        public string Option { get; }

        public IList<string> Values { get; }

        public CLArg(string opt)
        {
            Option = opt;
            Values = new List<string>();
        }
    }

    /// <summary>
    /// Command Line Parser
    /// </summary>
    public class CLParser
    {
        public IList<CLArg> CLArgs { get; }

        public bool HasError { get; protected set; }

        private string[] CLArgsOrg { get; }

        /// <summary>
        /// Constructor
        /// </summary>
        public CLParser(string[] clArgs)
        {
            CLArgsOrg = clArgs;

            CLArgs = new List<CLArg>();

            HasError = !Parse();
        }

        /// <summary>
        /// Parse arguments
        /// </summary>
        public bool Parse()
        {
            foreach(var r in CLArgsOrg.Skip(1)) // [0]番目の実行ファイル名はSKIP
            {
                if (r[0] == '-')
                {
                    CLArgs.Add(new CLArg(r));
                }
                else
                {
                    if (CLArgs.Any())
                    {
                        CLArgs.Last().Values.Add(r);
                    }
                    else
                    {
                        return false;
                    }
                }
            }

            return true;
        }
    }
}
