<%@ Import Namespace="System.Data" %>
<%@ Import Namespace="System.Data.OleDb" %>
<script language="VB" runat="server">
Sub Page_Load(Sender As Object, E As EventArgs)
	'����Connection����
        Dim conn As New OleDbConnection("Provider=Microsoft.Jet.OLEDB.4.0;Data Source=" & Server.MapPath("~//app_data/bbs.mdb"))

   '����SQL�ַ���
	Dim strSql As String
	strSql="update bbs Set hits=hits+1 Where bbs_id=" & Request.QueryString("bbs_id")
	Dim cmd As New OleDbCommand(strSql, conn)
	conn.open()                             
	cmd.ExecuteNonQuery()
	conn.close()   
	'������Ӻ󣬶���particular.aspx
	Server.Transfer("particular.aspx?bbs_id=" & Request.QueryString("bbs_id"))         
End Sub
</script>
