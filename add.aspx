<%--<%@ Page  Debug="true" %>--%>
<%@ Import Namespace="System.Data" %>
<%@ Import Namespace="System.Data.OleDb" %>
<script language="VB" runat="server">
Sub Enter_Click(Sender As Object, E As EventArgs)
	'建立Connection对象
        Dim conn As New OleDbConnection("Provider=Microsoft.Jet.OLEDB.4.0;Data Source=" & Server.MapPath("~//app_data/bbs.mdb"))

	'获取有关数据
	Dim thetitle,thebody,layer,father_id,child,hits,ip,theuser_id,theuser_email              '声明变量方便使用
	thetitle=title.Text                              '返回文章标题
	thebody=body.Text                                '返回文章内容
	theuser_id=user_id.Text                          '返回作者姓名
	ip=Request.ServerVariables("remote_addr")        '作者IP地址
	theuser_email=user_email.Text                    '返回作者Email
	layer=1                                          '这是第一层
	father_id=0                                      '因为是第一层，父编号设为0
	child=0                                          '回复文章数目为0
	hits=0                                           '点击数为0

   '完成SQL字符串，这里要考虑到文章内容和Email允许为空
	Dim strA,strB,strSql As String
	strA="Insert Into bbs(title,layer,father_id,child,hits,ip,user_id,submit_date"
	strB=" Values('" & thetitle & "'," & layer & "," & father_id & "," & child & "," & hits & ",'" & ip & "','" & theuser_id & "','" & now() & "'"
	If Trim(body.Text)<>"" Then               '如果内容不为空，就执行
		strA=strA & ",body"
		strB=strB & ",'" & thebody & "'"
	End If
	If Trim(user_email.Text)<>"" Then               '如果email不为空，就执行
		strA=strA & ",user_email"
		strB=strB & ",'" & theuser_email & "'"
	End If
	strSql=strA & ")" & strB & ")"
	'建立Command对象
	Dim cmd As New OleDbCommand(strSql, conn)
	Dim Exp As Exception
	Try
		'执行操作，插入记录
		conn.open()                             
		cmd.ExecuteNonQuery()
		conn.close()                            
            Response.Redirect("default.aspx")         '正常添加后，返回首页
	Catch Exp 
            message.Text = "发生错误，没有正常插入记录" & Exp.Message
            
	End Try
End Sub
</script>
<html>
	<head>
		<title>发表文章</title>
		<link href="general.css" rel="stylesheet" type="text/css">
	</head>
<body>
	<h4 align="center">发表文章</h4>
	<center>
	<form runat="server">
	<table border="1" cellpadding="2" bgcolor="#80BFFF" cellspacing="0" style="border-collapse: collapse" bordercolor="#80BFFF" width="90%" id="AutoNumber1" >
	<tr >
			<td>主题：</td>
			<td><asp:textbox id="title"  columns="60" runat="server"/>
			<asp:RequiredFieldValidator id="Require1" ControlToValidate="title" ErrorMessage="必须输入主题" Display="Static" runat="server" /></td>
		</tr>
		<tr>
			<td>内容：</td>
			<td><asp:textbox id="body" textmode="multiline" columns="60" rows="4" runat="server"/></td>
		</tr>
		<tr>
			<td>姓名：</td>
			<td><asp:textbox id="user_id"  runat="server"/>
			<asp:RequiredFieldValidator id="Require2" ControlToValidate="user_id" ErrorMessage="必须输入姓名" Display="Static" runat="server" /></td>
		</tr>
		<tr>
			<td>E-mail：</td>
			<td><asp:textbox id="user_email" columns="50" runat="server"/>
			</td>
		</tr>

		<tr>
			<td></td>
			<td><asp:button id="Enter" text=" 提 交 " onClick="Enter_Click" runat="server"/></td>
		</tr>
	</table>
	<asp:Label id="message" runat="server"/>
	</form>
	<a href="default.aspx">返回首页</a>
	</center>
</body>
</html>
