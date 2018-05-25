using System;
using System.Drawing;
using System.IO;
using System.Media;
using System.Windows.Forms;
using TMT.Commons.Utility;

namespace TMT.App
{
    /// <summary>
    /// Main Form Class
    /// </summary>
    public partial class MainForm : Form
    {
        MainForm _form;

        BGKeyWatcher _bgk;

        /// <summary>
        /// Constructor
        /// </summary>
        public MainForm()
        {
            InitializeComponent();

            // イベント追加
            this.Load += MainForm_Load;

            this.AllowDrop = true;
            this.DragEnter += MainForm_DragEnter;
            this.DragDrop += MainForm_DragDrop;


            var eras = JapaneseEra.GetJapaneseEras();

            foreach(var r in eras)
            {
                WriteToConsole(string.Format("{0}, {1}, {2}, {3}", r.EraName, r.EraNameShort, r.EraNameShortEng, r.StartDate));
            }

            WriteToConsole(DateTime.Now.ToString("gggyy年MM月dd日", JapaneseEra.GetJapaneseCultureInfo()));
            WriteToConsole(DateTime.Now.ToString("yyyy年MM月dd日", JapaneseEra.GetJapaneseCultureInfo()));
            WriteToConsole(DateTime.Now.ToString("yyyy年MM月dd日"));
        }

        /// <summary>
        /// Load form
        /// </summary>
        private void MainForm_Load(object sender, EventArgs e)
        {
            _bgk = new BGKeyWatcher(cap, new int[] { (int)(Keys.OemBackslash) });

            _form = this;
        }

        /// <summary>
        /// Drag enter 
        /// </summary>
        private void MainForm_DragEnter(object sender, DragEventArgs e)
        {
            if (e.Data.GetDataPresent(DataFormats.FileDrop))
            {
                e.Effect = DragDropEffects.Copy;
            }
        }

        /// <summary>
        /// Drag drop
        /// </summary>
        private void MainForm_DragDrop(object sender, DragEventArgs e)
        {
            var drags = (string[])e.Data.GetData(DataFormats.FileDrop);

            textBox_debug.Text = string.Empty;

            foreach (var r in drags)
            {
                var fi = new FileInfo(r);
                DateTime dt = FileUtility.GetDateTime(r);

                var fname = string.Format("{0}.jpg", dt.ToString("yyyyMMdd"));
                var fpath = Path.Combine(fi.Directory.FullName, fname);

                int cnt = 1;

                while (File.Exists(fpath))
                {
                    cnt++;
                    fname = string.Format("{0}_{1}.jpg", dt.ToString("yyyyMMdd"), cnt);
                    fpath = Path.Combine(fi.Directory.FullName, fname);
                }

                fi.CopyTo(fpath);

                textBox_debug.Text += fpath + Environment.NewLine;
            }
        }

        /// <summary>
        /// Click Switch Button.
        /// </summary>
        private void buttonSwitch_Click(object sender, EventArgs e)
        {
            if (this.labelState.Text == "ON")
            {
                this.labelState.Text = "OFF";

                _bgk.Abort();
            }
            else
            {
                this.labelState.Text = "ON";

                _bgk.Watch();
            }
        }

        /// <summary>
        /// Click Cap Button.
        /// </summary>
        private void buttonCap_Click(object sender, EventArgs e)
        {
            int x1 = Convert.ToInt32(this.textBoxX1.Text);
            int y1 = Convert.ToInt32(this.textBoxY1.Text);
            int x2 = Convert.ToInt32(this.textBoxX2.Text);
            int y2 = Convert.ToInt32(this.textBoxY2.Text);
            int sx = x2 - x1;
            int sy = y2 - y1;

            Bitmap bmp = BMap.CaptureScreen(x1, y1, sx, sy);

            int cnt = Convert.ToInt32(this.textBoxCount.Text);

            bmp.Save(string.Format(@"./{0:0000}.jpg", cnt), System.Drawing.Imaging.ImageFormat.Jpeg);

            this.textBoxCount.Text = (cnt + 1).ToString();

            SystemSounds.Exclamation.Play();
        }

        /// <summary>
        /// Move form
        /// </summary>
        private void MainForm_Move(object sender, EventArgs e)
        {
            if (this.checkBoxUpperLeft.Checked)
            {
                this.textBoxX1.Text = this.Left.ToString();
                this.textBoxY1.Text = this.Top.ToString();
            }

            if (this.checkBoxBottomRight.Checked)
            {
                this.textBoxX2.Text = (this.Left + this.Width).ToString();
                this.textBoxY2.Text = (this.Top + this.Height).ToString();
            }
        }

        /// <summary>
        /// Click Reset button. 
        /// </summary>
        private void buttonReset_Click(object sender, EventArgs e)
        {
            this.textBoxCount.Text = "1";

            WriteToConsole("Reseted.");
        }

        /// <summary>
        /// Capture Screen.
        /// </summary>
        private void cap(object sender, EventArgs e)
        {
            SystemSounds.Exclamation.Play();
        }

        /// <summary>
        /// Write to console.
        /// </summary>
        /// <param name="str"></param>
        public void WriteToConsole(string str)
        {
            this.textBox_debug.Text += (str + Environment.NewLine);
        }
    }
}
