using System;
using System.Collections.Generic;

namespace MDAR.Commons.Parts
{
    /// <summary>
    /// Exceptionの拡張メソッド
    /// </summary>
    public static class ExceptionEx
    {
        /// <summary>
        /// 全てのエラーメッセージを取得する
        /// </summary>
        public static string MessageAll(this Exception ex)
        {
            var list = new List<string>();

            var e = ex;

            do
            {
                list.Add(e.Message);
                e = e.InnerException;

            } while (e != null);


            return string.Join(" => ", list);
        }
    }
}
