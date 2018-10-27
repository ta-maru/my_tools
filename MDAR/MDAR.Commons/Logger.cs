using MDAR.Commons.Utils;
using System;
using System.Windows.Forms;

namespace MDAR.Commons
{
    /// <summary>
    /// ログ種類
    /// </summary>
    public enum LogType
    {
        None,
        Info,
        Warn,
        Error
    }

    /// <summary>
    /// ログクラス
    /// </summary>
    public static class Logger
    {
        /// <summary>
        /// テキストのログファイルを出力する（エラー）
        /// </summary>
        public static void WriteLog(Exception ex)
        {
            var e = ex;

            do
            {
                WriteLog(LogType.Error, e.Message, e.StackTrace);
                e = ex.InnerException;

            } while (e != null);
        }

        /// <summary>
        /// テキストのログファイルを出力する
        /// </summary>
        public static void WriteLog(LogType tp, string msg)
        {
            WriteLog(tp, msg, "-");
        }

        /// <summary>
        /// テキストのログファイルを出力する
        /// </summary>
        public static void WriteLog(LogType tp, string msg, string stackTrace)
        {
            var file = @".\application.log";

            WriteLog(file, tp, msg, stackTrace);
        }

        /// <summary>
        /// テキストのログファイルを出力する
        /// </summary>
        public static void WriteLog(string filePath, LogType tp, string msg)
        {
            WriteLog(filePath, tp, msg, "-");
        }

        /// <summary>
        /// テキストのログファイルを出力する
        /// </summary>
        public static void WriteLog(string filePath, LogType tp, string msg, string stackTrace)
        {
            string[] log = new string[8];

            log[0] = DateTime.Now.ToString("yyyy/MM/dd HH:mm:ss.fff");
            log[1] = Environment.MachineName;
            log[2] = Environment.UserName;
            log[3] = Misc.GetIPAddress();
            log[4] = Application.ExecutablePath;
            log[5] = tp.ToString();
            log[6] = msg;
            log[7] = stackTrace;

            FileUtility.WriteCSVFile(filePath, new string[][] { log }, true);
        }
    }
}
