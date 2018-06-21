<%@ Page Language="VB" AutoEventWireup="false" CodeFile="default.aspx.vb" Inherits="_default" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title>无标题页</title>
<%--    <link href="general.css" rel="stylesheet" type="text/css">--%>
</head>
<body>
    <form id="form1" runat="server">
    <div style="text-align: center">
        欢迎光临BBS论坛<br />
        <br />
        <table border="0" width="90%">
            <tr>
                <td align="left">
                    请输入关键字<asp:TextBox ID="keyword" runat="server" Text="全部"></asp:TextBox>
                    <asp:Button ID="enter" runat="server" OnClick="enter_click" Text=" 查 找 " />
                </td>
                <td align="right">
                    <a href="add.aspx">发表文章</a>
                </td>
            </tr>
        </table>
        <br />
        <br />
        <asp:GridView ID="GridView1" runat="server"  AllowPaging="True" AllowSorting="True"
            AutoGenerateColumns="False" DataKeyNames="bbs_id" Height="179px" Width="90%"  HeaderStyle-BackColor="#C5EDE7" PageSize="5" CellPadding=4 ForeColor="#333333" GridLines="None">
            <Columns>
                <asp:BoundField DataField="bbs_id" HeaderText="序号" InsertVisible="False" ReadOnly="True"
                    SortExpression="bbs_id">
                    <ItemStyle Width="5%" />
                </asp:BoundField>
                <asp:HyperLinkField DataNavigateUrlFields="bbs_id" DataNavigateUrlFormatString="hits.aspx?bbs_id={0}"
                    DataTextField="title" HeaderText="主题" SortExpression="title">
                    <ItemStyle Width="45%" />
                </asp:HyperLinkField>
                <asp:BoundField DataField="child" HeaderText="回复" SortExpression="child">
                    <ItemStyle Width="5%" />
                </asp:BoundField>
                <asp:BoundField DataField="hits" HeaderText="点击" SortExpression="hits">
                    <ItemStyle Width="5%" />
                </asp:BoundField>
                <asp:BoundField DataField="user_id" HeaderText="发言人" SortExpression="user_id">
                    <ItemStyle Width="15%" />
                </asp:BoundField>
                <asp:BoundField DataField="user_email" HeaderText="user_email" SortExpression="user_email">
                    <ItemStyle Width="15%" />
                </asp:BoundField>
                <asp:BoundField DataField="ip" HeaderText="ip" SortExpression="ip" />
                <asp:BoundField DataField="submit_date" HeaderText="发言时间" SortExpression="submit_date">
                    <ItemStyle Width="10%" />
                </asp:BoundField>
            </Columns>
            <FooterStyle BackColor="#5D7B9D" Font-Bold="True" ForeColor="White" />
            <RowStyle BackColor="#F7F6F3" ForeColor="#333333" />
            <EditRowStyle BackColor="#999999" />
            <SelectedRowStyle BackColor="#E2DED6" Font-Bold="True" ForeColor="#333333" />
            <PagerStyle BackColor="#284775" ForeColor="White" HorizontalAlign="Center" />
            <HeaderStyle BackColor="#5D7B9D" Font-Bold="True" ForeColor="White" />
            <AlternatingRowStyle BackColor="White" ForeColor="#284775" />
        </asp:GridView>
        &nbsp;
        <br />
        <br />
        <asp:Label ID="MySortField" runat="server" Text="bbs_id" Visible="False"></asp:Label>
        <asp:Label ID="message" runat="server"></asp:Label>
    
    </div>
    </form>
</body>
</html>
