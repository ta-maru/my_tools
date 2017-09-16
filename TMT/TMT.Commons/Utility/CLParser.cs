using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace TMT.Commons.Utility
{
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
    /// コマンドラインパーサー
    /// </summary>
    public class CLParser
    {
        public IList<CLArg> CLArgs { get; }

        public bool HasError { get; protected set; }

        private string[] CLArgsOrg { get; }

        public CLParser(string[] clArgs)
        {
            CLArgsOrg = clArgs;

            CLArgs = new List<CLArg>();

            HasError = !Parse();
        }

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
