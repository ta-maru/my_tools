using System;
using System.Collections.Generic;
using System.Collections.Specialized;
using System.Linq;
using System.Reflection;
using System.Text;
using System.Threading.Tasks;

namespace TMT.Commons.Utility
{
    /// <summary>
    /// Misellaneousクラス
    /// </summary>
    public static class Misc
    {
        public static T GetValueFromConfig<T>(NameValueCollection config, string valueName, T defaultValue)
            where T : struct
        {
            if (config == null) return defaultValue;

            string sValue = config[valueName];

            if (sValue == null) return defaultValue;

            T result = defaultValue;

            try
            {
                Type t = typeof(T);
                MethodInfo method = t.GetMethod("TryParse", new Type[] { typeof(string), typeof(T).MakeByRefType() });

                if (method != null)
                {
                    object[] parameters = new object[] { sValue, result };

                    if ((bool)method.Invoke(null, parameters)) return (T)parameters[1];
                }
            }
            catch (ArgumentException ex)
            {
                return defaultValue;
            }

            return defaultValue;
        }
    }
}
