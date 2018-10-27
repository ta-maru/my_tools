using System;
using System.Linq;
using System.Net;
using System.Net.Sockets;

namespace MDAR.Commons.Utils
{
    /// <summary>
    /// 雑多な処理を担うクラス
    /// </summary>
    public static class Misc
    {
        /// <summary>
        /// アプリ起動端末のIPアドレスを取得する
        /// </summary>
        public static string GetIPAddress()
        {
            string hostname = Dns.GetHostName();

            IPAddress[] adrList = Dns.GetHostAddresses(hostname).ToArray();

            foreach (IPAddress adr in adrList)
            {
                // IP4をアドレスを返す
                if (adr.AddressFamily == AddressFamily.InterNetwork)
                {
                    return adr.ToString();
                }
            }

            return String.Empty;
        }
    }
}
