﻿using System;
using System.Collections.Generic;
using System.Globalization;

namespace TMT.Commons.Utility
{
    /// <summary>
    /// Japanese Era Class
    /// </summary>
    public class JapaneseEra
    {
        public int Code;

        public string EraName; // 明治、大正、昭和、平成
        public string EraNameShort; // 明、大、昭、平
        public string EraNameShortEng; // M, T, S, H

        public DateTime StartDate;

        public DateTime FirstYearEndDate;


        /// <summary>
        /// Constructor
        /// </summary>
        public JapaneseEra(int code, string eNm, string eNmS)
        {
            var ci = GetJapaneseCultureInfo();

            this.Code = code;
            this.EraName = eNm;
            this.EraNameShort = eNmS;

            this.StartDate = calcStartDate(this.EraName);

            this.FirstYearEndDate = DateTime.Parse(this.EraName + "1年12月31日", ci);

            this.EraNameShortEng = GetJapaneseEraAlphabet(this.Code);
        }

        /// <summary>
        /// Get Japanese Era Start date
        /// </summary>
        private DateTime calcStartDate(string eraNm)
        {
            var ci = GetJapaneseCultureInfo();

            var eDate = DateTime.Parse(eraNm + "1年12月31日", ci);
            var sDate = eDate.AddYears(-1);

            while(sDate < eDate)
            {
                var cEraNm = eDate.ToString("gg", ci);

                if (cEraNm != eraNm)
                {
                    break;
                }

                eDate = eDate.AddDays(-1);
            }

            return eDate.AddDays(1);
        }

        /// <summary>
        /// Get Japanese Era Alphabet
        /// </summary>
        private string GetJapaneseEraAlphabet(int code)
        {
            var ci = GetJapaneseCultureInfo();

            for (char e = 'A'; e <= 'Z'; e++)
            {
                int eraIndex = ci.DateTimeFormat.GetEra(e.ToString());

                if (eraIndex == code)
                {
                    return e.ToString();
                }
            }

            return "?";
        }

        /// <summary>
        /// Get Japanese CultureInfo
        /// </summary>
        public static CultureInfo GetJapaneseCultureInfo()
        {
            var ci = new CultureInfo("ja-JP");
            ci.DateTimeFormat.Calendar = new JapaneseCalendar();

            return ci;
        }

        /// <summary>
        /// Get Japaneses Eras
        /// </summary>
        public static JapaneseEra[] GetJapaneseEras()
        {
            var ci = GetJapaneseCultureInfo();

            var fi = ci.DateTimeFormat;

            var list = new List<JapaneseEra>();

            foreach(var cd in fi.Calendar.Eras)
            {
                var eNm = fi.GetEraName(cd);
                var eNmS = fi.GetAbbreviatedEraName(cd);

                list.Add(new JapaneseEra(cd, eNm, eNmS));
            }

            list.Sort((a, b) => a.Code - b.Code);

            return list.ToArray();
        }

        /// <summary>
        /// 指定した書式設定で日付を表示
        /// </summary>
        public static string Format(string format, DateTime dt)
        {
            if (IsFirstYear(dt))
            {
                if (format.Contains("yy"))
                {
                    format = format.Replace("yy", "元");
                } 
                else if (format.Contains("y"))
                {
                    format = format.Replace("y", "元");
                }
            }

            return dt.ToString(format, GetJapaneseCultureInfo());
        }

        /// <summary>
        /// 元年の判定
        /// </summary>
        public static bool IsFirstYear(int y, int m, int d)
        {
            return IsFirstYear(new DateTime(y, m, d));
        }

        /// <summary>
        /// 元年の判定
        /// </summary>
        public static bool IsFirstYear(DateTime dt)
        {
            var jpnYear = int.Parse(dt.ToString("yy", GetJapaneseCultureInfo()));

            return (jpnYear == 1);
        }

        /// <summary>
        /// 年度の文字列の取得
        /// </summary>
        public static string ConvFiscalYearStr(string format, DateTime dt)
        {
            var ci = GetJapaneseCultureInfo();

            var fiscalStartDate = new DateTime(GetFiscalYear(dt), 4, 1);

            var jpnYearStr = fiscalStartDate.ToString("ggyy", ci);

            // 元年対応
            if (IsFirstYear(fiscalStartDate))
            {
                jpnYearStr = fiscalStartDate.ToString("gg", ci) + "元";
            }

            return string.Format(format, jpnYearStr);
        }

        /// <summary>
        /// 「○○年度」の取得
        /// </summary>
        public static string ConvFiscalYearStr(int y)
        {
            return ConvFiscalYearStr("{0}年度", new DateTime(y, 4, 1));
        }

        /// <summary>
        /// 「○○年度」の取得
        /// </summary>
        public static string ConvFiscalYearStr(int y, int m , int d)
        {
            return ConvFiscalYearStr("{0}年度", new DateTime(y, m, d));
        }

        /// <summary>
        /// 「○○年度」の取得
        /// </summary>
        public static string ConvFiscalYearStr(DateTime dt)
        {
            return ConvFiscalYearStr("{0}年度", dt);
        }

        /// <summary>
        /// Get Fiscal Year(A.D.)
        /// </summary>
        public static int GetFiscalYear(DateTime dt)
        {
            if ((1 <= dt.Month) && (dt.Month <= 3))
            {
                return (dt.Year - 1);
            }

            return dt.Year;
        }
    }
}
