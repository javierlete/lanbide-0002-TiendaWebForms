<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="WebForm1.aspx.cs" Inherits="PresentacionWebForms.WebForm1" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
        <div>
            <asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>
            <asp:UpdatePanel ID="UpdatePanel1" runat="server">
                <ContentTemplate>
                    <asp:LinkButton OnClick="Button1_Click" ID="Button1" runat="server" Text="Button" />
                    <asp:TextBox ID="TextBox1" runat="server" Text="1"></asp:TextBox>
                </ContentTemplate>
            </asp:UpdatePanel>

            <asp:LinkButton OnClick="Button2_Click" ID="Button2" runat="server" Text="Button" />
            <asp:TextBox ID="TextBox2" runat="server" Text="1"></asp:TextBox>
        </div>
    </form>
</body>
</html>
