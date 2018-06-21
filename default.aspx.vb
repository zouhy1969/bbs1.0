
Imports System.Data
Imports  System.Data.OleDb

Partial Class _default
    Inherits System.Web.UI.Page
    Dim Myconn As New OleDbConnection
    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        '     Myconn = New OleDbConnection("Provider=Microsoft.Jet.OLEDB.4.0;Data Source=" & Server.MapPath("~//app_data/bbs.mdb"))                                                                        '建立Connection对象
        Myconn = New OleDbConnection("Provider=Microsoft.ACE.OLEDB.12.0;Data Source=" & Server.MapPath("~//app_data/bbs.accdb"))                                                                        '建立Connection对象
        If Not IsPostBack Then
            Call BindData()                                            '绑定数据                              
        End If

    End Sub
    Sub Enter_Click(ByVal Sender As Object, ByVal E As EventArgs) Handles enter.Click
        '查找记录时，绑定数据时会自动根据keyword文本框中的关键字选择相应的数据
        Call BindData()
    End Sub
    '数据绑定子程序，供其它过程调用
    Sub BindData()
        '建立SQL语句字符串，默认显示全部内容，也可以根据关键词显示相应网站内容
        Dim strSql As String
        If Trim(keyword.Text) = "" Or Trim(keyword.text) = "全部" Then
            strSql = "Select * From bbs Where layer=1"
        Else
            strSql = "Select * From bbs Where layer=1 And title Like '%" & Trim(keyword.Text) & "%'"
        End If
        '直接建立DataAdapter对象
        Dim adp As New OleDbDataAdapter(strSql, Myconn)
        Dim ds As New DataSet()                                        '建立DataSet对象
        adp.Fill(ds, "link")                                           '填充DataSet
        ds.Tables("link").DefaultView.Sort = MySortField.Text & " DESC"  '从Label控件中指定排序字段
        GridView1.DataSource = ds.Tables("link").DefaultView            '指定数据源
        GridView1.DataBind()
    End Sub

    Protected Sub GridView1_Sorting(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.GridViewSortEventArgs) Handles GridView1.Sorting
        MySortField.Text = e.SortExpression                              '将选定的排序字段存放到Label控件中
        Call BindData()                                                '绑定数据                         

    End Sub

    Protected Sub GridView1_PageIndexChanging(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.GridViewPageEventArgs) Handles GridView1.PageIndexChanging
        GridView1.PageIndex = e.NewPageIndex
        Call BindData()                                                '绑定数据                         

    End Sub
End Class
