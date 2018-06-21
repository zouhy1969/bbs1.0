<%@ Import Namespace="System.Data" %>
<%@ Import Namespace="System.Data.OleDb" %>
<script language="VB" runat="server">
Sub Page_Load(Sender As Object, E As EventArgs)
	'建立Connection对象
        Dim conn As New OleDbConnection("Provider=Microsoft.Jet.OLEDB.4.0;Data Source=" & Server.MapPath("~//app_data/bbs.mdb"))

   '建立SQL字符串
	Dim strSql As String
	strSql="update bbs Set hits=hits+1 Where bbs_id=" & Request.QueryString("bbs_id")
	Dim cmd As New OleDbCommand(strSql, conn)
	conn.open()                             
	cmd.ExecuteNonQuery()
	conn.close()   
	'正常添加后，定向到particular.aspx
	Server.Transfer("particular.aspx?bbs_id=" & Request.QueryString("bbs_id"))         
End Sub
</script>
