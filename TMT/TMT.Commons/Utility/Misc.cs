using Microsoft.Win32;
using System;
using System.Collections.Generic;
using System.Collections.Specialized;
using System.Reflection;

namespace TMT.Commons.Utility
{
    /// <summary>
    /// Misellaneousクラス
    /// </summary>
    public static class Misc
    {
        /// <summary>
        /// app.configより値を取得
        /// </summary>
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
            catch (ArgumentException)
            {
                return defaultValue;
            }

            return defaultValue;
        }

        /// <summary>
        /// Get registry names.
        /// </summary>
        public static string[] GetRegValueNames(string key)
        {
            var rKey = Registry.LocalMachine.OpenSubKey(key);

            return rKey.GetValueNames();
        }

        /// <summary>
        /// Get registry values.
        /// </summary>
        public static string[] GetRegValues(string key)
        {
            var rKey = Registry.LocalMachine.OpenSubKey(key);

            var list = new List<string>();

            foreach(var nm in GetRegValueNames(key))
            {
                list.Add((string)rKey.GetValue(nm));
            }

            return list.ToArray();
        }
    }
}
