using System.Windows.Forms;

namespace MDAR.Commons.Utils
{
    /// <summary>
    /// ダイアログ表示のためのクラス
    /// </summary>
    public static class MessageBoxUtility
    {
        /// <summary>
        /// エラーダイアログを表示する
        /// </summary>
        public static void ShowError(string msg)
        {
            MessageBox.Show(msg, "エラー", MessageBoxButtons.OK, MessageBoxIcon.Error);
        }

        /// <summary>
        /// エラーダイアログを表示する
        /// </summary>
        public static void ShowError(string msg, object arg1)
        {
            ShowError(string.Format(msg, arg1));
        }

        /// <summary>
        /// 警告ダイアログを表示する
        /// </summary>
        public static void ShowWarn(string msg)
        {
            MessageBox.Show(msg, "警告", MessageBoxButtons.OK, MessageBoxIcon.Warning);
        }

        /// <summary>
        /// 警告ダイアログを表示する
        /// </summary>
        public static void ShowWarn(string msg, object arg1)
        {
            ShowWarn(string.Format(msg, arg1));
        }

        /// <summary>
        /// 警告ダイアログを表示する
        /// </summary>
        public static void ShowWarn(string msg, object arg1, object arg2)
        {
            ShowWarn(string.Format(msg, arg1, arg2));
        }

        /// <summary>
        /// 警告ダイアログを表示する（OK／Cancelの選択あり）
        /// </summary>
        public static bool ShowWarnWithConfirm(string msg)
        {
            DialogResult ret = MessageBox.Show(msg, "警告", MessageBoxButtons.OKCancel, MessageBoxIcon.Warning);

            return (ret == DialogResult.OK);
        }

        /// <summary>
        /// 通知ダイアログを表示する
        /// </summary>
        public static void ShowInformation(string msg)
        {
            MessageBox.Show(msg, "通知", MessageBoxButtons.OK, MessageBoxIcon.Information);
        }

        /// <summary>
        /// 通知ダイアログを表示する
        /// </summary>
        public static void ShowInformation(string msg, object arg1)
        {
            ShowInformation(string.Format(msg, arg1));
        }

        /// <summary>
        /// 確認ダイアログを表示する
        /// </summary>
        public static bool ShowConfirm(string msg)
        {
            DialogResult ret = MessageBox.Show(msg, "確認", MessageBoxButtons.YesNo, MessageBoxIcon.Question);

            return (ret == DialogResult.Yes);
        }

        /// <summary>
        /// 確認ダイアログを表示する
        /// </summary>
        public static bool ShowConfirm(string msg, object arg1)
        {
            return ShowConfirm(string.Format(msg, arg1));
        }
    }
}
