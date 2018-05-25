using System;
using System.Drawing;
using System.Runtime.InteropServices;
using System.Windows.Forms;

namespace TMT.Commons.Utility
{
    /// <summary>
    /// BitMap Utility Class
    /// </summary>
    public class BMap
    {
        private const int SRCCOPY = 13369376;
        private const int CAPTUREBLT = 1073741824;

        [DllImport("user32.dll")]
        private static extern IntPtr GetDC(IntPtr hwnd);

        [DllImport("gdi32.dll")]
        private static extern int BitBlt(IntPtr hDestDC,
            int x,
            int y,
            int nWidth,
            int nHeight,
            IntPtr hSrcDC,
            int xSrc,
            int ySrc,
            int dwRop);

        [DllImport("user32.dll")]
        private static extern IntPtr ReleaseDC(IntPtr hwnd, IntPtr hdc);

        /// <summary>
        /// プライマリスクリーンの画像を取得（FromImage, BitBlt）
        /// </summary>
        public static Bitmap CaptureScreen(int x, int y, int sx, int sy)
        {
            IntPtr disDC = GetDC(IntPtr.Zero);

            Bitmap bmp = new Bitmap(sx, sy);

            Graphics g = Graphics.FromImage(bmp);

            IntPtr hDC = g.GetHdc();

            BitBlt(hDC, 0, 0, sx, sy, disDC, x, y, SRCCOPY);

            g.ReleaseHdc(hDC);
            g.Dispose();
            ReleaseDC(IntPtr.Zero, disDC);

            return bmp;
        }

        /// <summary>
        /// プライマリスクリーンの画像を取得（CopyFromScreen）
        /// </summary>
        public static Bitmap CaptureScreen2()
        {
            Bitmap bmp = new Bitmap(Screen.PrimaryScreen.Bounds.Width, Screen.PrimaryScreen.Bounds.Height);

            Graphics g = Graphics.FromImage(bmp);

            g.CopyFromScreen(new Point(0, 0), new Point(0, 0), new Size(Screen.PrimaryScreen.Bounds.Width, Screen.PrimaryScreen.Bounds.Height));

            g.Dispose();

            return bmp;
        }

        [StructLayout(LayoutKind.Sequential)]
        private struct RECT
        {
            public int left;
            public int top;
            public int right;
            public int bottom;
        }

        [DllImport("user32.dll")]
        private static extern IntPtr GetWindowDC(IntPtr hwnd);

        [DllImport("user32.dll")]
        private static extern IntPtr GetForegroundWindow();

        [DllImport("user32.dll")]
        private static extern int GetWindowRect(IntPtr hwnd,
            ref RECT lpRect);

        /// <summary>
        /// アクティブなウィンドウの画像を取得
        /// </summary>
        public static Bitmap CaptureActiveWindow()
        {
            IntPtr hWnd = GetForegroundWindow();
            IntPtr winDC = GetWindowDC(hWnd);

            RECT rect = new RECT();
            GetWindowRect(hWnd, ref rect);

            Bitmap bmp = new Bitmap(rect.right - rect.left, rect.bottom - rect.top);
            Graphics g = Graphics.FromImage(bmp);

            IntPtr hDC = g.GetHdc();

            BitBlt(hDC, 0, 0, bmp.Width, bmp.Height, winDC, 0, 0, SRCCOPY);

            g.ReleaseHdc(hDC);
            g.Dispose();
            ReleaseDC(hWnd, winDC);

            return bmp;
        }
    }
}
