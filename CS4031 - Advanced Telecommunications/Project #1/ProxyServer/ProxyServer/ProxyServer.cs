using System;
using System.Collections.Generic;
using System.Net;
using System.Windows.Forms;

namespace ProxyServer
{

    public partial class ProxyServer : Form
    {

        List<IPAddress> blacklist;

        public ProxyServer()
        {

            InitializeComponent();
            blacklist = new List<IPAddress>();

        }

        private void BlockAddress(object sender, EventArgs e)
        {

            string rawIp = InputBox.Text;
            
            if (IPAddress.TryParse(rawIp, out IPAddress address))
            {

                blacklist.Add(address);

                if (!BlockedBox.Items.Contains(address))
                    BlockedBox.Items.Add(address);

            }
            
            InputBox.Clear();

        }

        private void UnblockAddress(object sender, EventArgs e)
        {

            BlockedBox.Items.Remove(BlockedBox.SelectedItem);

        }

    }

}
