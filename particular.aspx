<%--<%@ Page  Debug="true" %>--%>
<%@ Import Namespace="System.Data" %>
<%@ Import Namespace="System.Data.OleDb" %>
<script language="VB" runat="server">
	
	Sub Page_Load(Sender As Object, E As EventArgs)
		If Not Page.IsPostBack Then
			bbs_id.Text=Request.QueryString("bbs_id")
			Call BindData()                                '���ú�����������
		End If
	End Sub

	'����ĺ���ר������������
	Sub BindData()
        Dim conn As New OleDbConnection("Provider=Microsoft.Jet.OLEDB.4.0;Data Source=" & Server.MapPath("~//app_data/bbs.mdb")) '����Connection����
		Dim cmd As New OleDbCommand("select * from bbs Where bbs_id=" & bbs_id.Text & " Or father_id=" & bbs_id.Text & " order by submit_date", conn)  '����Command����
		conn.Open()                                              '�����ݿ����� 
		Dim dr As OleDbDataReader = cmd.ExecuteReader()          '����DataReader����
		MyRepeater.DataSource = dr                               'ָ������Դ
		MyRepeater.DataBind()                                    'ִ�а�
		conn.Close()                                             '�ر����ݿ�����
	End Sub


	'����ĺ������������¼
	Sub Enter_Click(Sender As Object, E As EventArgs)
		'����Connection����
        Dim conn As New OleDbConnection("Provider=Microsoft.Jet.OLEDB.4.0;Data Source=" & Server.MapPath("~//app_data/bbs.mdb"))

		'��ȡ�й�����
		Dim thistitle,thisbody,layer,father_id,child,hits,ip,thisuser_id,thisuser_email       '������������ʹ��
		thistitle=title.Text                            '�������±���
		thisbody=body.Text                          '������������
		thisuser_id=user_id.Text                  '������������
		layer=2                                           '���ǵ�һ��
		father_id=bbs_id.Text                               '��Ϊ�ǵ�һ�㣬�������Ϊ0
		child=0                                           '�ظ�������ĿΪ0
		hits=0                                            '�����Ϊ0
		ip=Request.ServerVariables("remote_addr")              '����IP��ַ
		thisuser_email=user_email.Text

	   '����SQL�ַ���
		Dim strA,strB,strSql As String
		strA="Insert Into bbs(title,layer,father_id,child,hits,ip,user_id,submit_date"
		strB=" Values('" & thistitle & "'," & layer & "," & father_id & "," & child & "," & hits & ",'" & ip & "','" & thisuser_id & "','" & now() & "'"
		If Trim(body.Text)<>"" Then               '������ݲ�Ϊ�գ���ִ��
			strA=strA & ",body"
			strB=strB & ",'" & thisbody & "'"
		End If
		If Trim(user_email.Text)<>"" Then               '���email��Ϊ�գ���ִ��
			strA=strA & ",user_email"
			strB=strB & ",'" & thisuser_email & "'"
		End If
		strSql=strA & ")" & strB & ")"
		Dim cmd As New OleDbCommand(strSql, conn)
		Dim Exp As Exception
		Try
			'ִ�в����������¼
			conn.open()                             
			cmd.ExecuteNonQuery()
			conn.close()   
			'���潫����¼�ظ�������
			strSql="update bbs Set child=child+1 Where bbs_id=" & bbs_id.Text
			cmd.CommandText=strSql
			conn.open()                             
			cmd.ExecuteNonQuery()
			conn.close()  
			'������Ӻ󣬷�����ҳ
            Response.Redirect("default.aspx")
		Catch Exp 
			message.Text="��������û�����������¼"
		End Try
	End Sub
</script>
<HTML>
<head>
	<title>BBS��̳</title>
	<link href="general.css" rel="stylesheet" type="text/css">
    <style type="text/css">
        .auto-style1
        {
            height: 63px;
        }
    </style>
</head>
<body >
	<h4 align="center">�������</h4>

	<p>
	<center>
	<table width="90%" border="0">
		<tr>
		<td align="left">
			&nbsp;
		</td>
		<td align="right">
			<a href="index.aspx">������ҳ</a> 
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
					&nbsp&nbsp&nbsp&nbsp����ʱ�䣺<%# Container.DataItem("submit_date") %>&nbsp&nbsp�����<%# Container.DataItem("hits") %>��</font></I>
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
			<td>���⣺</td>
			<td>
				<asp:textbox id="title" columns="60" runat="server"/>
				<asp:RequiredFieldValidator id="require1" ControlToValidate="title" ErrorMessage="���ⲻ��Ϊ��"  runat="server"/>
			</td>
		</tr>
		<tr>
			<td class="auto-style1">���ݣ�</td>
			<td class="auto-style1">
				<asp:Textbox id="body" Textmode="multiline" columns="60" rows="4" runat="server"/>
			</td>
		</tr>
		<tr>
			<td>������</td>
			<td>
				<asp:textbox id="user_id" runat="server"/>
				<asp:RequiredFieldValidator id="require2" ControlToValidate="user_id" ErrorMessage="��������Ϊ��"  runat="server"/>
			</td>
		</tr>
		<tr>
			<td>email��</td><td>
				<asp:textbox id="user_email" columns="50" runat="server"/>
			</td>
		</tr>
		<tr>
			<td><asp:textbox id="bbs_id" visible="False" runat="server"/></td>
			<td>
				<asp:button id="Enter" text="  �� ��  "  onclick="Enter_Click" runat="server" />
			</td>
		</tr>
		</form>
	</table>
	<asp:label id="message" runat="server" />
	<p><a href="default.aspx">������ҳ</a>
	</center>
	
</body>
</html>
