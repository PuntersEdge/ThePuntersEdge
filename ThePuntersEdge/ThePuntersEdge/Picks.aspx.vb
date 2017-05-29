Public Class Picks
    Inherits System.Web.UI.Page
    Public username As String = ""
    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load



        'If Session("user") Is Nothing Then


        '    Response.Redirect("Default.aspx")

        'Else

        '    username = Session("user").ToString

        'End If


        'If Not IsPostBack Then


        '        Me.BindGrid()
        '        'Me.LoadStats(username)


        '    End If



    End Sub

    Private Sub BindGrid()

        'Loads the picks table
        Dim usertable As String = username & "_matched"

        If username = "00alawre" Then
            usertable = "Algo_results"
        End If

        Dim dt As New DataSet
        Dim db As New DatabseActions

        Dim selections As DataTable = db.SELECTSTATEMENT("LS.Meeting, LS.RaceTime, LS.Horse, B.Bookie,LS.Odds", "LiveSelections LS Right JOIN(SELECT L.Meeting, L.Racetime, L.Horse FROM LiveSelections L EXCEPT SELECT A.Meeting, A.RaceTime, A.Horse FROM " & usertable & " A) U ON U.Horse = LS.Horse AND U.Meeting = LS.Meeting AND U.RaceTime = LS.RaceTime INNER JOIN Bookies B ON B.BookieID = LS.Bookmaker", "WHERE LS.Bookmaker NOT IN('BD','BF','MA','MR','PS','BX','OE','RD','WN') AND LS.lastTradedPrice > 0")

        gv_data.DataSource = selections
        gv_data.DataBind()

    End Sub


End Class