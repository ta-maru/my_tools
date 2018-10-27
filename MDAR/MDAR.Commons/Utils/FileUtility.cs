using System;
using System.Collections.Generic;
using System.IO;
using System.Text;

namespace MDAR.Commons.Utils
{
    /// <summary>
    /// ファイルユーティリティクラス
    /// </summary>
    public static class FileUtility
    {
        /// <summary>
        /// ファイルパスのフォルダが存在しなければフォルダを作成する
        /// </summary>
        public static void CreateDirectoryOfFilePath(string path)
        {
            string directory = Path.GetDirectoryName(path);

            if (!string.IsNullOrEmpty(directory) && !Directory.Exists(directory))
            {
                try
                {
                    Directory.CreateDirectory(directory);
                }
                catch (IOException ex)
                {
                    throw ConvertToAppException(ex);
                }
            }
        }

        /// <summary>
        /// 指定された文字列の二次元配列からCSVファイルを作成する
        /// </summary>
        public static void WriteCSVFile(string filePath, IEnumerable<string[]> valueArrays)
        {
            WriteCSVFile(filePath, valueArrays, true, Encoding.Default);
        }

        /// <summary>
        /// 指定された文字列の二次元配列からCSVファイルを作成する
        /// </summary>
        public static void WriteCSVFile(string filePath, IEnumerable<string[]> valueArrays, bool isAppend)
        {
            WriteCSVFile(filePath, valueArrays, isAppend, Encoding.Default);
        }

        /// <summary>
        /// 指定された文字列の二次元配列からCSVファイルを作成する
        /// </summary>
        public static void WriteCSVFile(string filePath, IEnumerable<string[]> valueArrays, bool isAppend, Encoding encoding)
        {
            CreateDirectoryOfFilePath(filePath);

            try
            {
                using (StreamWriter fileStreamWriter = new StreamWriter(filePath, isAppend, encoding ?? Encoding.Default))
                {
                    foreach (string[] values in valueArrays)
                    {
                        string[] resultValues = new string[values.Length];

                        for (int j = 0; j < resultValues.Length; j++)
                        {
                            if (values[j] == null)
                            {
                                resultValues[j] = string.Empty;
                            }
                            else if (values[j].Contains(","))
                            {
                                resultValues[j] = string.Format("\"{0}\"", values[j].ToString());
                            }
                            else
                            {
                                resultValues[j] = values[j].ToString();
                            }
                        }

                        fileStreamWriter.WriteLine(string.Join(",", resultValues));
                    }
                }
            }
            catch (IOException ex)
            {
                throw ConvertToAppException(ex);
            }
        }

        /// <summary>
        /// ファイル処理関連の例外をアプリケーション例外に変換する
        /// </summary>
        public static ApplicationException ConvertToAppException(IOException ex)
        {
            string msg = "ファイル処理で何らかのエラーが発生しました。";

            return new ApplicationException(msg, ex);
        }
    }
}
