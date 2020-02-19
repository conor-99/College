namespace ProxyServer
{

    partial class ProxyServer
    {

        private System.ComponentModel.IContainer components = null;

        protected override void Dispose(bool disposing)
        {

            if (disposing && (components != null))
                components.Dispose();

            base.Dispose(disposing);

        }

        #region Windows Form Designer generated code

        private void InitializeComponent()
        {
            this.BlockedBox = new System.Windows.Forms.ListBox();
            this.InputBox = new System.Windows.Forms.TextBox();
            this.BlockButton = new System.Windows.Forms.Button();
            this.ConnectionBox = new System.Windows.Forms.ListBox();
            this.UnblockButton = new System.Windows.Forms.Button();
            this.SuspendLayout();
            // 
            // BlockedBox
            // 
            this.BlockedBox.FormattingEnabled = true;
            this.BlockedBox.ItemHeight = 16;
            this.BlockedBox.Location = new System.Drawing.Point(546, 75);
            this.BlockedBox.Name = "BlockedBox";
            this.BlockedBox.Size = new System.Drawing.Size(196, 228);
            this.BlockedBox.TabIndex = 0;
            // 
            // InputBox
            // 
            this.InputBox.Location = new System.Drawing.Point(546, 12);
            this.InputBox.Name = "InputBox";
            this.InputBox.Size = new System.Drawing.Size(196, 22);
            this.InputBox.TabIndex = 1;
            // 
            // BlockButton
            // 
            this.BlockButton.Location = new System.Drawing.Point(546, 40);
            this.BlockButton.Name = "BlockButton";
            this.BlockButton.Size = new System.Drawing.Size(196, 29);
            this.BlockButton.TabIndex = 2;
            this.BlockButton.Text = "Block Connection";
            this.BlockButton.UseVisualStyleBackColor = true;
            this.BlockButton.Click += new System.EventHandler(this.BlockAddress);
            // 
            // ConnectionBox
            // 
            this.ConnectionBox.FormattingEnabled = true;
            this.ConnectionBox.ItemHeight = 16;
            this.ConnectionBox.Location = new System.Drawing.Point(12, 12);
            this.ConnectionBox.Name = "ConnectionBox";
            this.ConnectionBox.Size = new System.Drawing.Size(528, 324);
            this.ConnectionBox.TabIndex = 3;
            // 
            // UnblockButton
            // 
            this.UnblockButton.Location = new System.Drawing.Point(546, 309);
            this.UnblockButton.Name = "UnblockButton";
            this.UnblockButton.Size = new System.Drawing.Size(196, 29);
            this.UnblockButton.TabIndex = 4;
            this.UnblockButton.Text = "Unblock Connection";
            this.UnblockButton.UseVisualStyleBackColor = true;
            this.UnblockButton.Click += new System.EventHandler(this.UnblockAddress);
            // 
            // ProxyServer
            // 
            this.AutoScaleDimensions = new System.Drawing.SizeF(8F, 16F);
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.ClientSize = new System.Drawing.Size(754, 348);
            this.Controls.Add(this.UnblockButton);
            this.Controls.Add(this.ConnectionBox);
            this.Controls.Add(this.BlockButton);
            this.Controls.Add(this.InputBox);
            this.Controls.Add(this.BlockedBox);
            this.Name = "ProxyServer";
            this.Text = "Proxy Server";
            this.ResumeLayout(false);
            this.PerformLayout();

        }

        #endregion

        private System.Windows.Forms.ListBox BlockedBox;
        private System.Windows.Forms.TextBox InputBox;
        private System.Windows.Forms.Button BlockButton;
        private System.Windows.Forms.ListBox ConnectionBox;
        private System.Windows.Forms.Button UnblockButton;

    }

}
