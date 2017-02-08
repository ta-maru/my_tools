using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.IO;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;
using TMT.Commons.Utility;

namespace TMT.App
{
    public partial class MainForm : Form
    {
        public MainForm()
        {
            InitializeComponent();

            // イベント追加
            this.AllowDrop = true;
            this.DragEnter += MainForm_DragEnter;
            this.DragDrop += MainForm_DragDrop;
        }

        private void MainForm_DragEnter(object sender, DragEventArgs e)
        {
            if (e.Data.GetDataPresent(DataFormats.FileDrop))
            {
                e.Effect = DragDropEffects.Copy;
            }
        }

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
                while ( File.Exists(fpath))
                {
                    cnt++;
                    fname = string.Format("{0}_{1}.jpg", dt.ToString("yyyyMMdd"), cnt);
                    fpath = Path.Combine(fi.Directory.FullName, fname);
                }

                fi.CopyTo(fpath);

                textBox_debug.Text += fpath + Environment.NewLine;
            }
        }
    }
}
