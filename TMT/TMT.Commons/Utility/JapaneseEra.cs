using System;
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
                var cEraNm = eDate.ToString("ggg", ci);

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
    }
}
