namespace TMT.App
{
    partial class MainForm
    {
        /// <summary>
        /// 必要なデザイナー変数です。
        /// </summary>
        private System.ComponentModel.IContainer components = null;

        /// <summary>
        /// 使用中のリソースをすべてクリーンアップします。
        /// </summary>
        /// <param name="disposing">マネージ リソースを破棄する場合は true を指定し、その他の場合は false を指定します。</param>
        protected override void Dispose(bool disposing)
        {
            if (disposing && (components != null))
            {
                components.Dispose();
            }
            base.Dispose(disposing);
        }

        #region Windows フォーム デザイナーで生成されたコード

        /// <summary>
        /// デザイナー サポートに必要なメソッドです。このメソッドの内容を
        /// コード エディターで変更しないでください。
        /// </summary>
        private void InitializeComponent()
        {
            System.ComponentModel.ComponentResourceManager resources = new System.ComponentModel.ComponentResourceManager(typeof(MainForm));
            this.textBox_debug = new System.Windows.Forms.TextBox();
            this.tabControl = new System.Windows.Forms.TabControl();
            this.tabPage1 = new System.Windows.Forms.TabPage();
            this.buttonReset = new System.Windows.Forms.Button();
            this.checkBoxBottomRight = new System.Windows.Forms.CheckBox();
            this.checkBoxUpperLeft = new System.Windows.Forms.CheckBox();
            this.textBoxCount = new System.Windows.Forms.TextBox();
            this.textBoxY2 = new System.Windows.Forms.TextBox();
            this.textBoxX2 = new System.Windows.Forms.TextBox();
            this.textBoxY1 = new System.Windows.Forms.TextBox();
            this.textBoxX1 = new System.Windows.Forms.TextBox();
            this.buttonCap = new System.Windows.Forms.Button();
            this.labelState = new System.Windows.Forms.Label();
            this.buttonSwitch = new System.Windows.Forms.Button();
            this.tabPage2 = new System.Windows.Forms.TabPage();
            this.tabControl.SuspendLayout();
            this.tabPage1.SuspendLayout();
            this.SuspendLayout();
            // 
            // textBox_debug
            // 
            this.textBox_debug.Dock = System.Windows.Forms.DockStyle.Bottom;
            this.textBox_debug.Location = new System.Drawing.Point(0, 292);
            this.textBox_debug.Multiline = true;
            this.textBox_debug.Name = "textBox_debug";
            this.textBox_debug.ScrollBars = System.Windows.Forms.ScrollBars.Both;
            this.textBox_debug.Size = new System.Drawing.Size(435, 170);
            this.textBox_debug.TabIndex = 0;
            // 
            // tabControl
            // 
            this.tabControl.Controls.Add(this.tabPage1);
            this.tabControl.Controls.Add(this.tabPage2);
            this.tabControl.Dock = System.Windows.Forms.DockStyle.Fill;
            this.tabControl.Location = new System.Drawing.Point(0, 0);
            this.tabControl.Name = "tabControl";
            this.tabControl.SelectedIndex = 0;
            this.tabControl.Size = new System.Drawing.Size(435, 292);
            this.tabControl.TabIndex = 1;
            // 
            // tabPage1
            // 
            this.tabPage1.Controls.Add(this.buttonReset);
            this.tabPage1.Controls.Add(this.checkBoxBottomRight);
            this.tabPage1.Controls.Add(this.checkBoxUpperLeft);
            this.tabPage1.Controls.Add(this.textBoxCount);
            this.tabPage1.Controls.Add(this.textBoxY2);
            this.tabPage1.Controls.Add(this.textBoxX2);
            this.tabPage1.Controls.Add(this.textBoxY1);
            this.tabPage1.Controls.Add(this.textBoxX1);
            this.tabPage1.Controls.Add(this.buttonCap);
            this.tabPage1.Controls.Add(this.labelState);
            this.tabPage1.Controls.Add(this.buttonSwitch);
            this.tabPage1.Location = new System.Drawing.Point(4, 22);
            this.tabPage1.Name = "tabPage1";
            this.tabPage1.Padding = new System.Windows.Forms.Padding(3);
            this.tabPage1.Size = new System.Drawing.Size(427, 266);
            this.tabPage1.TabIndex = 0;
            this.tabPage1.Text = "Bitmap";
            this.tabPage1.UseVisualStyleBackColor = true;
            // 
            // buttonReset
            // 
            this.buttonReset.Location = new System.Drawing.Point(9, 151);
            this.buttonReset.Name = "buttonReset";
            this.buttonReset.Size = new System.Drawing.Size(76, 27);
            this.buttonReset.TabIndex = 12;
            this.buttonReset.Text = "reset";
            this.buttonReset.UseVisualStyleBackColor = true;
            this.buttonReset.Click += new System.EventHandler(this.buttonReset_Click);
            // 
            // checkBoxBottomRight
            // 
            this.checkBoxBottomRight.AutoSize = true;
            this.checkBoxBottomRight.Location = new System.Drawing.Point(143, 103);
            this.checkBoxBottomRight.Name = "checkBoxBottomRight";
            this.checkBoxBottomRight.Size = new System.Drawing.Size(88, 16);
            this.checkBoxBottomRight.TabIndex = 11;
            this.checkBoxBottomRight.Text = "Bottom right";
            this.checkBoxBottomRight.UseVisualStyleBackColor = true;
            // 
            // checkBoxUpperLeft
            // 
            this.checkBoxUpperLeft.AutoSize = true;
            this.checkBoxUpperLeft.Location = new System.Drawing.Point(143, 76);
            this.checkBoxUpperLeft.Name = "checkBoxUpperLeft";
            this.checkBoxUpperLeft.Size = new System.Drawing.Size(75, 16);
            this.checkBoxUpperLeft.TabIndex = 10;
            this.checkBoxUpperLeft.Text = "Upper left";
            this.checkBoxUpperLeft.UseVisualStyleBackColor = true;
            // 
            // textBoxCount
            // 
            this.textBoxCount.Location = new System.Drawing.Point(9, 126);
            this.textBoxCount.Name = "textBoxCount";
            this.textBoxCount.Size = new System.Drawing.Size(117, 19);
            this.textBoxCount.TabIndex = 9;
            this.textBoxCount.Text = "1";
            // 
            // textBoxY2
            // 
            this.textBoxY2.Location = new System.Drawing.Point(70, 101);
            this.textBoxY2.Name = "textBoxY2";
            this.textBoxY2.Size = new System.Drawing.Size(55, 19);
            this.textBoxY2.TabIndex = 6;
            this.textBoxY2.Text = "128";
            // 
            // textBoxX2
            // 
            this.textBoxX2.Location = new System.Drawing.Point(8, 101);
            this.textBoxX2.Name = "textBoxX2";
            this.textBoxX2.Size = new System.Drawing.Size(55, 19);
            this.textBoxX2.TabIndex = 5;
            this.textBoxX2.Text = "128";
            // 
            // textBoxY1
            // 
            this.textBoxY1.Location = new System.Drawing.Point(70, 76);
            this.textBoxY1.Name = "textBoxY1";
            this.textBoxY1.Size = new System.Drawing.Size(55, 19);
            this.textBoxY1.TabIndex = 4;
            this.textBoxY1.Text = "0";
            // 
            // textBoxX1
            // 
            this.textBoxX1.Location = new System.Drawing.Point(9, 76);
            this.textBoxX1.Name = "textBoxX1";
            this.textBoxX1.Size = new System.Drawing.Size(55, 19);
            this.textBoxX1.TabIndex = 3;
            this.textBoxX1.Text = "0";
            // 
            // buttonCap
            // 
            this.buttonCap.Location = new System.Drawing.Point(90, 8);
            this.buttonCap.Name = "buttonCap";
            this.buttonCap.Size = new System.Drawing.Size(76, 27);
            this.buttonCap.TabIndex = 2;
            this.buttonCap.Text = "cap";
            this.buttonCap.UseVisualStyleBackColor = true;
            this.buttonCap.Click += new System.EventHandler(this.buttonCap_Click);
            // 
            // labelState
            // 
            this.labelState.AutoSize = true;
            this.labelState.Location = new System.Drawing.Point(6, 47);
            this.labelState.Name = "labelState";
            this.labelState.Size = new System.Drawing.Size(27, 12);
            this.labelState.TabIndex = 1;
            this.labelState.Text = "OFF";
            // 
            // buttonSwitch
            // 
            this.buttonSwitch.Enabled = false;
            this.buttonSwitch.Location = new System.Drawing.Point(6, 7);
            this.buttonSwitch.Name = "buttonSwitch";
            this.buttonSwitch.Size = new System.Drawing.Size(78, 28);
            this.buttonSwitch.TabIndex = 0;
            this.buttonSwitch.Text = "switch";
            this.buttonSwitch.UseVisualStyleBackColor = true;
            this.buttonSwitch.Click += new System.EventHandler(this.buttonSwitch_Click);
            // 
            // tabPage2
            // 
            this.tabPage2.Location = new System.Drawing.Point(4, 22);
            this.tabPage2.Name = "tabPage2";
            this.tabPage2.Padding = new System.Windows.Forms.Padding(3);
            this.tabPage2.Size = new System.Drawing.Size(427, 266);
            this.tabPage2.TabIndex = 1;
            this.tabPage2.Text = "Temp";
            this.tabPage2.UseVisualStyleBackColor = true;
            // 
            // MainForm
            // 
            this.AutoScaleDimensions = new System.Drawing.SizeF(6F, 12F);
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.ClientSize = new System.Drawing.Size(435, 462);
            this.Controls.Add(this.tabControl);
            this.Controls.Add(this.textBox_debug);
            this.Icon = ((System.Drawing.Icon)(resources.GetObject("$this.Icon")));
            this.Name = "MainForm";
            this.Text = "MainForm";
            this.Move += new System.EventHandler(this.MainForm_Move);
            this.tabControl.ResumeLayout(false);
            this.tabPage1.ResumeLayout(false);
            this.tabPage1.PerformLayout();
            this.ResumeLayout(false);
            this.PerformLayout();

        }

        #endregion

        private System.Windows.Forms.TextBox textBox_debug;
        private System.Windows.Forms.TabControl tabControl;
        private System.Windows.Forms.TabPage tabPage1;
        private System.Windows.Forms.Label labelState;
        private System.Windows.Forms.TabPage tabPage2;
        private System.Windows.Forms.Button buttonCap;
        private System.Windows.Forms.TextBox textBoxY2;
        private System.Windows.Forms.TextBox textBoxX2;
        private System.Windows.Forms.TextBox textBoxY1;
        private System.Windows.Forms.TextBox textBoxX1;
        private System.Windows.Forms.TextBox textBoxCount;
        private System.Windows.Forms.CheckBox checkBoxBottomRight;
        private System.Windows.Forms.CheckBox checkBoxUpperLeft;
        private System.Windows.Forms.Button buttonReset;
        private System.Windows.Forms.Button buttonSwitch;
    }
}

