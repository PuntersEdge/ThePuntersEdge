Imports System.Data
Imports System.Drawing
Imports Newtonsoft.Json
Imports System.Web.Services


Public Class Picks
    Inherits System.Web.UI.Page
    Public username As String = ""
    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load



        If Session("user") Is Nothing Then


            Response.Redirect("Default.aspx")

        Else

            username = Session("user").ToString


        End If


        If Not IsPostBack Then


            Me.BindGrid("Page_Load")

            Me.LoadStats(username)


        End If



    End Sub
    Private Sub LoadStats(ByVal username As String)

        Dim db As New DatabseActions

        Dim User As String = username
        Dim usertable As String = username & "_matched"
        Dim archive_table As String = username & "_matched_archive"

        If username = "00alawre" Then
            usertable = "algo_b_results"
            archive_table = "algo_b_matched_archive"
        End If

        Dim results As DataTable = db.EXECSPROC_STATS(User, usertable, archive_table)

        lbl_daily_pts.Text = results.Rows(0).Item(0).ToString & " pts today."
        lbl_monthly_pts.Text = results.Rows(0).Item(1).ToString & " pts this month."
        lbl_alltime_pts.Text = results.Rows(0).Item(2).ToString & " alltime."
        tb_stake.Text = results.Rows(0).Item(3).ToString
        lbl_daily_profit.Text = results.Rows(0).Item(4).ToString & " today."
        lbl_monthly_profit.Text = results.Rows(0).Item(5).ToString & " this month."
        lbl_alltime_profit.Text = results.Rows(0).Item(6).ToString & " all time."




    End Sub

    Private Sub BindGrid(ByVal Grid_Type As String)



        'Loads the picks table
        Dim usertable As String = username & "_matched"
        Dim dt As New DataSet
        Dim db As New DatabseActions

        If username = "00alawre" Then
            usertable = "Algo_b_results"
        End If

        If Grid_Type = "Matched" Then

            gv_unmatched.DataSource = Nothing
            gv_unmatched.DataBind()

            lbl_heading.Text = "Matched"

            Dim selections_matched As DataTable = db.SELECTSTATEMENT("A.Meeting, A.RaceTime, A.Horse, B.Bookie, A.Odds, R.Result, CASE WHEN R.Result = '1st' THEN SUM(A.Odds - 1) WHEN R.Result = 'NR' THEN 0 WHEN R.Result IS NULL THEN NULL ELSE -1 END AS PL", usertable & " A INNER JOIN Bookies B ON B.BookieID = A.Bookmaker INNER JOIN Results R ON R.Horse = A.Horse AND R.[Time] = A.Racetime WHERE A.Deleted = 0 GROUP BY A.Meeting, A.RaceTime, A.Horse, B.Bookie, A.Odds, R.Result ORDER BY A.RaceTime, A.Horse, B.Bookie, A.Odds, R.Result", "")

            gv_matched.DataSource = selections_matched
            gv_matched.DataBind()


        Else

            gv_matched.DataSource = Nothing
            gv_matched.DataBind()

            lbl_heading.Text = "Unmatched"

            Dim selections As DataTable = db.SELECTSTATEMENT("LS.Meeting, LS.RaceTime, LS.Horse, B.Bookie,LS.Odds", "LiveSelections_algo_b LS Right JOIN(Select L.Meeting, L.Racetime, L.Horse FROM LiveSelections_algo_b L EXCEPT Select A.Meeting, A.RaceTime, A.Horse FROM " & usertable & " A WHERE A.Deleted = 0) U On U.Horse = LS.Horse And U.Meeting = LS.Meeting And U.RaceTime = LS.RaceTime INNER JOIN Bookies B On B.BookieID = LS.Bookmaker", "WHERE LS.Bookmaker Not In('BD','BF','MA','MR','PS','BX','OE','RD','WN') AND LS.lastTradedPrice > 0")

            gv_unmatched.DataSource = selections
            gv_unmatched.DataBind()

        End If




    End Sub
    Private Sub BindChat()

        DataList1.DataBind()


    End Sub

    Protected Sub Timer2_Tick(sender As Object, e As EventArgs)

        Me.BindChat()

    End Sub

    Private Sub btn_matched_Click(sender As Object, e As EventArgs) Handles btn_matched.Click

            Call BindGrid("Matched")

        End Sub

        Private Sub btn_unmatched_Click(sender As Object, e As EventArgs) Handles btn_unmatched.Click

            Call BindGrid("Unmatched")

        End Sub

        Protected Sub Timer1_Tick(sender As Object, e As EventArgs) Handles Timer1.Tick

            Dim Grid_Type As String = lbl_heading.Text

            Me.BindGrid(Grid_Type)

        End Sub
        Protected Sub MatchHorse_Command(sender As Object, e As CommandEventArgs)

            If (e.CommandName = "MatchTheHorse") Then
                ' Retrieve the row index stored in the CommandArgument property.
                Dim index As Integer = Convert.ToInt32(e.CommandArgument)
                Dim db As New DatabseActions

                'Retrieve the row that contains the button 
                'From the Rows collection.
                Dim row As GridViewRow = gv_unmatched.Rows(index)
                Dim Meeting As String = gv_unmatched.Rows(index).Cells(0).Text.ToString
                Dim racetime As String = gv_unmatched.Rows(index).Cells(1).Text.ToString
                Dim horse As String = gv_unmatched.Rows(index).Cells(2).Text.ToString
                Dim bookie As String = gv_unmatched.Rows(index).Cells(3).Text.ToString
                Dim odds As String = gv_unmatched.Rows(index).Cells(4).Text.ToString

                Dim usertable As String = username & "_matched"

                If username = "00alawre" Then
                usertable = "Algo_b_results"
            End If


                db.SQL("INSERT INTO " & usertable & " SELECT L.Meeting, L.RaceTime, L.Horse, B.BookieID, L.Odds, L.LastTradedPrice, L.TradedVolume FROM LiveSelections L INNER JOIN Bookies B ON B.BookieID = L.Bookmaker WHERE L.Horse = '" & horse & "' AND L.RaceTime = '" & racetime & "' AND L.Meeting = '" & Meeting & "' AND B.Bookie = '" & bookie & "'")



                Me.BindGrid("Matched")

            End If
        End Sub


    <WebMethod(EnableSession:=True)>
    Public Shared Function DeleteHorse(ByVal meeting As String, ByVal horse As String, ByVal time As String) As String

        Dim Result As String = ""
        Dim username As String = HttpContext.Current.Session("user")

        Try
            Dim usertable As String = username & "_matched"

            If username = "00alawre" Then
                usertable = "Algo_b_results"
            End If

            Dim db As New DatabseActions
            db.UPDATE(usertable, "Deleted", 1, "WHERE RaceTime = '" & time & "' AND Horse = '" & horse & "' AND Meeting = '" & meeting & "'")

            Result = "success"

        Catch ex As Exception

            Result = ex.InnerException.ToString

        End Try

        Return Result



    End Function


    <WebMethod(EnableSession:=True)>
    Public Shared Function SendChat(message) As String

        Dim Result As String = ""
        Dim username As String = HttpContext.Current.Session("user")
        Dim time As String = DateTime.Now.ToString("yyyy-MM-dd HH:mm:ss")

        If Not message = "" Then

            Dim db As New DatabseActions

            db.INSERT("ChatLog", "Username, Message, MessageTime", "'" & username & "', '" & message & "', '" & time & "'")
            Result = "success"

        Else

            Result = "blank"

        End If

        Return Result



    End Function

    <WebMethod(EnableSession:=True)>
    Public Shared Function UpdateHorse(ByVal meeting As String, ByVal horse As String, ByVal odds As String, ByVal time As String, ByVal reason As String) As String

        Dim Result As String = ""
        Dim user As String = HttpContext.Current.Session("user")
        Dim usertable As String = user & "_matched"
        Dim now As String = DateTime.Now.ToLocalTime.ToString("yyyy-MM-dd HH:mm:ss")

        If user = "00alawre" Then
            usertable = "algo_b_results"

        End If

        Try
            Dim db As New DatabseActions

            Dim originalodds As String = db.SELECTSTATEMENT_Scalar("Odds", usertable, "WHERE RaceTime = '" & time & "' AND Horse = '" & horse & "'")
            db.UPDATE(usertable, "Odds", odds, "WHERE Horse = '" & horse & "' AND RaceTime = '" & time & "'")



            db.INSERT("PriceChanges", "[User], RaceTime, Meeting, Horse, OriginalPrice, NewPrice, Reason, TimeChanged", "'" & user & "','" & time & "', '" & meeting & "', '" & horse & "', " & originalodds & ", " & odds & ", '" & reason & "','" & now & "'")

            Result = "success"

        Catch ex As Exception

            Result = ex.InnerException.ToString

        End Try



        Return Result



    End Function

    Private Sub Stats_timer_Tick(sender As Object, e As EventArgs) Handles Stats_timer.Tick

        username = Session("user")
        Me.LoadStats(username)

    End Sub
End Class