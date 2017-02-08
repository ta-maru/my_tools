using System;
using System.Drawing;
using System.Drawing.Imaging;
using System.IO;
using System.Text;

namespace TMT.Commons.Utility
{
    public static class FileUtility
    {
        public static DateTime GetDateTime(string filePath)
        {
            Bitmap bmp = new Bitmap(filePath);

            DateTime dt = DateTime.Parse("2000/1/1");

            foreach (PropertyItem item in bmp.PropertyItems)
            {
                // Exif情報から撮影時間の取得
                if (item.Id == 0x9003 && item.Type == 2)
                {
                    string val = Encoding.ASCII.GetString(item.Value);

                    val = val.Trim(new char[] { '\0' });

                    dt = DateTime.ParseExact(val, "yyyy:MM:dd HH:mm:ss", null);
                    break;
                }
            }
            bmp.Dispose();

            return dt;
        }
    }
}
