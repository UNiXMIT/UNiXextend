using System;
using System.Collections.Generic;
using System.Text;

namespace OutlookWrapper
{
    public class Outlook
    {
		private Microsoft.Office.Interop.Outlook.Application oApp = null;
		private Microsoft.Office.Interop.Outlook.NameSpace oNS = null;
		private Microsoft.Office.Interop.Outlook.MailItem oMsg = null;
		private string recip = "";
		private Dictionary<string, string> attachments = new Dictionary<string, string>();
		public void Initialize() {
			if (oApp == null)
			{
				oApp = new Microsoft.Office.Interop.Outlook.Application();

				// Get the NameSpace and Logon information.
				oNS = oApp.GetNamespace("mapi");

				// Log on by using a dialog box to choose the profile.
				oNS.Logon();
			}

			recip = "";
			attachments.Clear();
		}

		public void Send(string accountSender, string title, string body, bool isHTML)
		{
			accountSender = accountSender.Trim();
			title = title.Trim();
			body = body.Trim();

			oMsg = (Microsoft.Office.Interop.Outlook.MailItem)oApp.CreateItem(Microsoft.Office.Interop.Outlook.OlItemType.olMailItem);

			// Set the subject.
			oMsg.Subject = title; // TITLE

			if(isHTML)
				oMsg.HTMLBody = body; // BODY
			else
				oMsg.Body = body; // BODY

			oMsg.To = recip; // Destination

			if (!string.IsNullOrEmpty(accountSender))
			{
				string nomeAccount = accountSender;

				var sendAccount = oMsg.Session.Accounts[nomeAccount];

				oMsg.SendUsingAccount = sendAccount; // Send using support account
			}

			int index = 0;
			foreach (var attach in attachments)
			{
				index++;
				oMsg.Attachments.Add(attach.Key, Microsoft.Office.Interop.Outlook.OlAttachmentType.olByValue, index, attach.Value);
			}

			// Send.
			(oMsg as Microsoft.Office.Interop.Outlook._MailItem).Send();
		}

		public void AddRecipient(string recipient) {
			recipient = recipient.Trim();
			if (recip != "")
				recip += ";";
			recip += recipient;
		}

		public void AddAttachment(string attach, string displayName)
		{
			attach = attach.Trim();
			displayName = displayName.Trim();
			attachments.Add(attach, displayName);
		}

		public void Logout()
		{
			// Log off.
			oNS.Logoff();

			// Clean up.
			//oRecip = null;
			//oRecips = null;
			oMsg = null;
			oNS = null;
			oApp = null;

			recip = "";
			attachments.Clear();
		}
	}
}
