<%--<%@ Page  Debug="true" %>--%>
<%@ Import Namespace="System.Data" %>
<%@ Import Namespace="System.Data.OleDb" %>
<script language="VB" runat="server">
	
	Sub Page_Load(Sender As Object, E As EventArgs)
		If Not Page.IsPostBack Then
			bbs_id.Text=Request.QueryString("bbs_id")
			Call BindData()                                '调用函数，绑定数据
		End If
	End Sub

	'下面的函数专门用来绑定数据
	Sub BindData()
        Dim conn As New OleDbConnection("Provider=Microsoft.Jet.OLEDB.4.0;Data Source=" & Server.MapPath("~//app_data/bbs.mdb")) '建立Connection对象
		Dim cmd As New OleDbCommand("select * from bbs Where bbs_id=" & bbs_id.Text & " Or father_id=" & bbs_id.Text & " order by submit_date", conn)  '建立Command对象
		conn.Open()                                              '打开数据库连接 
		Dim dr As OleDbDataReader = cmd.ExecuteReader()          '建立DataReader对象
		MyRepeater.DataSource = dr                               '指定数据源
		MyRepeater.DataBind()                                    '执行绑定
		conn.Close()                                             '关闭数据库连接
	End Sub


	'下面的函数用来插入记录
	Sub Enter_Click(Sender As Object, E As EventArgs)
		'建立Connection对象
        Dim conn As New OleDbConnection("Provider=Microsoft.Jet.OLEDB.4.0;Data Source=" & Server.MapPath("~//app_data/bbs.mdb"))

		'获取有关数据
		Dim thistitle,thisbody,layer,father_id,child,hits,ip,thisuser_id,thisuser_email       '声明变量方便使用
		thistitle=title.Text                            '返回文章标题
		thisbody=body.Text                          '返回文章内容
		thisuser_id=user_id.Text                  '返回作者姓名
		layer=2                                           '这是第一层
		father_id=bbs_id.Text                               '因为是第一层，父编号设为0
		child=0                                           '回复文章数目为0
		hits=0                                            '点击数为0
		ip=Request.ServerVariables("remote_addr")              '作者IP地址
		thisuser_email=user_email.Text

	   '建立SQL字符串
		Dim strA,strB,strSql As String
		strA="Insert Into bbs(title,layer,father_id,child,hits,ip,user_id,submit_date"
		strB=" Values('" & thistitle & "'," & layer & "," & father_id & "," & child & "," & hits & ",'" & ip & "','" & thisuser_id & "','" & now() & "'"
		If Trim(body.Text)<>"" Then               '如果内容不为空，就执行
			strA=strA & ",body"
			strB=strB & ",'" & thisbody & "'"
		End If
		If Trim(user_email.Text)<>"" Then               '如果email不为空，就执行
			strA=strA & ",user_email"
			strB=strB & ",'" & thisuser_email & "'"
		End If
		strSql=strA & ")" & strB & ")"
		Dim cmd As New OleDbCommand(strSql, conn)
		Dim Exp As Exception
		Try
			'执行操作，插入记录
			conn.open()                             
			cmd.ExecuteNonQuery()
			conn.close()   
			'下面将父记录回复数更新
			strSql="update bbs Set child=child+1 Where bbs_id=" & bbs_id.Text
			cmd.CommandText=strSql
			conn.open()                             
			cmd.ExecuteNonQuery()
			conn.close()  
			'正常添加后，返回首页
            Response.Redirect("default.aspx")
		Catch Exp 
			message.Text="发生错误，没有正常插入记录"
		End Try
	End Sub
</script>
<HTML>
<head>
	<title>BBS论坛</title>
	<link href="general.css" rel="stylesheet" type="text/css">
    <style type="text/css">
        .auto-style1
        {
            height: 63px;
        }
    </style>
</head>
<body >
	<h4 align="center">浏览文章</h4>

	<p>
	<center>
	<table width="90%" border="0">
		<tr>
		<td align="left">
			&nbsp;
		</td>
		<td align="right">
			<a href="index.aspx">返回首页</a> 
		</td>
		</tr>
	</table>

	<asp:Repeater id="MyRepeater" runat="server" >
		<headerTemplate>
			<table border="1" cellpadding="2" bgcolor="#80BFFF" cellspacing="0" style="border-collapse: collapse" bordercolor="#80BFFF" width="90%" id="AutoNumber1">
		</headerTemplate>
		<ItemTemplate>
			<tr bgcolor="#C5EDFF">
				<td width="20%" align="center">
					<asp:HyperLink Text='<%# Container.DataItem("user_id") %>' NavigateUrl='<%# "mailto:" & Container.DataItem("user_email") %>' runat="server"/>
				</td>
				<td>
					&nbsp&nbsp&nbsp&nbsp发布时间：<%# Container.DataItem("submit_date") %>&nbsp&nbsp点击：<%# Container.DataItem("hits") %>次</font></I>
				</td>
			</tr>
			<tr>
				<td>
					
				</td>
				<td>  
					<b>&nbsp&nbsp&nbsp&nbsp<font color=#b40000><%# Container.DataItem("title") %></font></b><p><%# Container.DataItem("body") %>
				</td>
			  </tr>
		</ItemTemplate>
		<footerTemplate>
			</table>
		</footerTemplate>
	</asp:Repeater>
	<P>
	<table border="1" cellpadding="2" bgcolor="#80BFFF" cellspacing="0" style="border-collapse: collapse" bordercolor="#80BFFF" width="90%" id="AutoNumber1" >
		<form runat="server">
		<tr>
			<td>主题：</td>
			<td>
				<asp:textbox id="title" columns="60" runat="server"/>
				<asp:RequiredFieldValidator id="require1" ControlToValidate="title" ErrorMessage="主题不能为空"  runat="server"/>
			</td>
		</tr>
		<tr>
			<td class="auto-style1">内容：</td>
			<td class="auto-style1">
				<asp:Textbox id="body" Textmode="multiline" columns="60" rows="4" runat="server"/>
			</td>
		</tr>
		<tr>
			<td>姓名：</td>
			<td>
				<asp:textbox id="user_id" runat="server"/>
				<asp:RequiredFieldValidator id="require2" ControlToValidate="user_id" ErrorMessage="姓名不能为空"  runat="server"/>
			</td>
		</tr>
		<tr>
			<td>email：</td><td>
				<asp:textbox id="user_email" columns="50" runat="server"/>
			</td>
		</tr>
		<tr>
			<td><asp:textbox id="bbs_id" visible="False" runat="server"/></td>
			<td>
				<asp:button id="Enter" text="  提 交  "  onclick="Enter_Click" runat="server" />
			</td>
		</tr>
		</form>
	</table>
	<asp:label id="message" runat="server" />
	<p><a href="default.aspx">返回首页</a>
	</center>
	
</body>
</html>
