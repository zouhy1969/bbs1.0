<%--<%@ Page  Debug="true" %>--%>
<%@ Import Namespace="System.Data" %>
<%@ Import Namespace="System.Data.OleDb" %>
<script language="VB" runat="server">
Sub Enter_Click(Sender As Object, E As EventArgs)
	'����Connection����
        Dim conn As New OleDbConnection("Provider=Microsoft.Jet.OLEDB.4.0;Data Source=" & Server.MapPath("~//app_data/bbs.mdb"))

	'��ȡ�й�����
	Dim thetitle,thebody,layer,father_id,child,hits,ip,theuser_id,theuser_email              '������������ʹ��
	thetitle=title.Text                              '�������±���
	thebody=body.Text                                '������������
	theuser_id=user_id.Text                          '������������
	ip=Request.ServerVariables("remote_addr")        '����IP��ַ
	theuser_email=user_email.Text                    '��������Email
	layer=1                                          '���ǵ�һ��
	father_id=0                                      '��Ϊ�ǵ�һ�㣬�������Ϊ0
	child=0                                          '�ظ�������ĿΪ0
	hits=0                                           '�����Ϊ0

   '���SQL�ַ���������Ҫ���ǵ��������ݺ�Email����Ϊ��
	Dim strA,strB,strSql As String
	strA="Insert Into bbs(title,layer,father_id,child,hits,ip,user_id,submit_date"
	strB=" Values('" & thetitle & "'," & layer & "," & father_id & "," & child & "," & hits & ",'" & ip & "','" & theuser_id & "','" & now() & "'"
	If Trim(body.Text)<>"" Then               '������ݲ�Ϊ�գ���ִ��
		strA=strA & ",body"
		strB=strB & ",'" & thebody & "'"
	End If
	If Trim(user_email.Text)<>"" Then               '���email��Ϊ�գ���ִ��
		strA=strA & ",user_email"
		strB=strB & ",'" & theuser_email & "'"
	End If
	strSql=strA & ")" & strB & ")"
	'����Command����
	Dim cmd As New OleDbCommand(strSql, conn)
	Dim Exp As Exception
	Try
		'ִ�в����������¼
		conn.open()                             
		cmd.ExecuteNonQuery()
		conn.close()                            
            Response.Redirect("default.aspx")         '������Ӻ󣬷�����ҳ
	Catch Exp 
            message.Text = "��������û�����������¼" & Exp.Message
            
	End Try
End Sub
</script>
<html>
	<head>
		<title>��������</title>
		<link href="general.css" rel="stylesheet" type="text/css">
	</head>
<body>
	<h4 align="center">��������</h4>
	<center>
	<form runat="server">
	<table border="1" cellpadding="2" bgcolor="#80BFFF" cellspacing="0" style="border-collapse: collapse" bordercolor="#80BFFF" width="90%" id="AutoNumber1" >
	<tr >
			<td>���⣺</td>
			<td><asp:textbox id="title"  columns="60" runat="server"/>
			<asp:RequiredFieldValidator id="Require1" ControlToValidate="title" ErrorMessage="������������" Display="Static" runat="server" /></td>
		</tr>
		<tr>
			<td>���ݣ�</td>
			<td><asp:textbox id="body" textmode="multiline" columns="60" rows="4" runat="server"/></td>
		</tr>
		<tr>
			<td>������</td>
			<td><asp:textbox id="user_id"  runat="server"/>
			<asp:RequiredFieldValidator id="Require2" ControlToValidate="user_id" ErrorMessage="������������" Display="Static" runat="server" /></td>
		</tr>
		<tr>
			<td>E-mail��</td>
			<td><asp:textbox id="user_email" columns="50" runat="server"/>
			</td>
		</tr>

		<tr>
			<td></td>
			<td><asp:button id="Enter" text=" �� �� " onClick="Enter_Click" runat="server"/></td>
		</tr>
	</table>
	<asp:Label id="message" runat="server"/>
	</form>
	<a href="default.aspx">������ҳ</a>
	</center>
</body>
</html>
