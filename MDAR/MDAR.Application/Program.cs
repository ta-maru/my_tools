using MDAR.Commons;
using MDAR.Commons.Parts;
using MDAR.Commons.Utils;
using System;
using System.Threading;
using System.Windows.Forms;

namespace MDAR.App
{
    static class Program
    {
        /// <summary>
        /// アプリケーションのメイン エントリ ポイントです。
        /// </summary>
        [STAThread]
        static void Main()
        {
            try
            {
                Application.ThreadException += new ThreadExceptionEventHandler(Application_ThreadException);

                Application.EnableVisualStyles();
                Application.SetCompatibleTextRenderingDefault(false);

                Application.Run(new MainForm());
            }
            catch(Exception ex)
            {
                WriteErrorLogAndShowMsg(ex);
            }
        }

        /// <summary>
        /// エラーのログ出力及びメッセージ通知を行う
        /// </summary>
        private static void WriteErrorLogAndShowMsg(Exception ex)
        {
            try
            {
                Logger.WriteLog(ex);
            }
            catch (Exception ex2)
            {
                MessageBoxUtility.ShowError(string.Format("ログ出力中にエラーが発生しました。 => {0}", ex2.MessageAll()));
            }

            MessageBoxUtility.ShowError(string.Format("エラーが発生しました。 => {0}", ex.MessageAll()));
        }

        /// <summary>
        /// ハンドルされなかった例外に対する処理を行う
        /// </summary>
        private static void Application_ThreadException(object sender, ThreadExceptionEventArgs e)
        {
            try
            {
                WriteErrorLogAndShowMsg(e.Exception);
            }
            finally
            {
                //Application.Exit();
            }
        }
    }
}
