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

        Else
            ScriptManager.RegisterStartupScript(Page, Page.GetType(), "dialog", "<script type='text/javascript'>notifications();portfolio()</script>", False)




        End If

            If username = "00alawre" Then
            btn_deleted.Style("display") = "none"
            btn_gone.Style("display") = "none"
            btn_invoices.Style("display") = "none"
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
        username = Session("user").ToString
        Dim usertable As String = username & "_matched"
        Dim dt As New DataSet
        Dim db As New DatabseActions

        If username = "00alawre" Then
            usertable = "Algo_b_results"
        End If

        If Grid_Type = "Matched" Then

            search_box.Visible = True

            gv_gone.DataSource = Nothing
            gv_gone.DataBind()
            gv_unmatched.DataSource = Nothing
            gv_unmatched.DataBind()
            gv_deleted.DataSource = Nothing
            gv_deleted.DataBind()
            gv_invoices.DataSource = Nothing
            gv_invoices.DataBind()

            lbl_heading.Text = "Matched"

            Dim selections_matched As DataTable = db.SELECTSTATEMENT("A.Meeting, A.RaceTime, A.Horse, B.Bookie, A.Odds, R.Result, CASE WHEN R.Result = '1st' THEN SUM(A.Odds - 1) WHEN R.Result = 'NR' THEN 0 WHEN R.Result IS NULL THEN NULL ELSE -1 END AS PL", usertable & " A INNER JOIN Bookies B ON B.BookieID = A.Bookmaker INNER JOIN Results R ON R.Horse = A.Horse AND R.[Time] = A.Racetime WHERE A.Deleted = 0 GROUP BY A.Meeting, A.RaceTime, A.Horse, B.Bookie, A.Odds, R.Result ORDER BY A.RaceTime, A.Horse, B.Bookie, A.Odds, R.Result", "")


            gv_matched.DataSource = selections_matched
            gv_matched.DataBind()



        ElseIf Grid_Type = "Dismissed" Then


            search_box.Visible = False

            gv_matched.DataSource = Nothing
            gv_unmatched.DataSource = Nothing
            gv_matched.DataBind()
            gv_unmatched.DataBind()
            gv_deleted.DataSource = Nothing
            gv_deleted.DataBind()
            gv_invoices.DataSource = Nothing
            gv_invoices.DataBind()

            lbl_heading.Text = "Dismissed"


            Dim selections As DataTable = db.SELECTSTATEMENT("Meeting, RaceTime, Horse, Bookmaker, Odds", username & "_gone", "")

            gv_gone.DataSource = selections
            gv_gone.DataBind()

        ElseIf Grid_Type = "Deleted" Then

            search_box.Visible = False

            gv_matched.DataSource = Nothing
            gv_unmatched.DataSource = Nothing
            gv_gone.DataSource = Nothing
            gv_gone.DataBind()
            gv_matched.DataBind()
            gv_unmatched.DataBind()
            gv_invoices.DataSource = Nothing
            gv_invoices.DataBind()

            lbl_heading.Text = "Deleted"


            Dim selections As DataTable = db.SELECTSTATEMENT("L.Meeting, L.RaceTime, L.Horse, B.Bookie AS Bookmaker, L.Odds", username & "_matched L ", "INNER JOIN Bookies B ON B.BookieID = L.Bookmaker WHERE Deleted=1")



            gv_deleted.DataSource = selections
            gv_deleted.DataBind()

        ElseIf Grid_Type = "Invoices" Then

            search_box.Visible = False

            gv_matched.DataSource = Nothing
            gv_unmatched.DataSource = Nothing
            gv_gone.DataSource = Nothing
            gv_deleted.DataSource = Nothing
            gv_deleted.DataBind()
            gv_gone.DataBind()
            gv_matched.DataBind()
            gv_unmatched.DataBind()

            lbl_heading.Text = "Invoices"


            Dim selections As DataTable = db.SELECTSTATEMENT("[Period], 
	                                                          CONVERT(Decimal(6,2), Stake) AS Stake, 
	                                                          CONVERT(Decimal(10,2),Profit) AS Profit, 
	                                                          CONCAT(CONVERT(Decimal(2,0), (Commission * 100)), '%') AS Commission, 
	                                                          CONVERT(Decimal(9,2),BalanceDue) AS BalanceDue, 	                                                         
	                                                          CASE(InvoicePaid) WHEN 0 THEN 'No' ELSE 'YES' END AS Paid, 
	                                                          Notes",
                                                              "Invoices",
                                                             "WHERE [USER ID] ='" & username & "'")



            gv_invoices.DataSource = selections
            gv_invoices.DataBind()

        ElseIf Grid_Type = "Portfolio" Then

            search_box.Visible = False

            gv_matched.DataSource = Nothing
            gv_unmatched.DataSource = Nothing
            gv_matched.DataBind()
            gv_unmatched.DataBind()
            gv_deleted.DataSource = Nothing
            gv_deleted.DataBind()
            gv_invoices.DataSource = Nothing
            gv_invoices.DataBind()
            gv_gone.DataSource = Nothing
            gv_gone.DataBind()

            lbl_heading.Text = "Portfolio"
            iframe_portfolio.Attributes.Add("src", "portfolio.aspx")


        Else


            Dim selections As DataTable


            search_box.Visible = False
            gv_gone.DataSource = Nothing
            gv_gone.DataBind()
            gv_matched.DataSource = Nothing
            gv_matched.DataBind()
            gv_deleted.DataSource = Nothing
            gv_deleted.DataBind()
            gv_invoices.DataSource = Nothing
            gv_invoices.DataBind()


            lbl_heading.Text = "Unmatched"

            If username = "00alawre" Then
                selections = db.SELECTSTATEMENT("LS.Meeting, LS.RaceTime, LS.Horse, B.Bookie, LS.Odds", "LiveSelections_algo_b LS Right JOIN(Select L.Meeting, L.Racetime, L.Horse FROM LiveSelections_algo_b L EXCEPT Select A.Meeting, A.RaceTime, A.Horse FROM " & usertable & " A WHERE A.Deleted = 0) U On U.Horse = LS.Horse And U.Meeting = LS.Meeting And U.RaceTime = LS.RaceTime INNER JOIN Bookies B On B.BookieID = LS.Bookmaker", "WHERE LS.Bookmaker Not In('BD','BF','MA','MR','PS','BX','OE','RD','WN') AND LS.lastTradedPrice > 0")

            Else

                selections = db.BindUnmatched(username)

            End If


            gv_unmatched.DataSource = selections
            gv_unmatched.DataBind()



        End If

        If Not username = "00alawre" Then
            Call Notifications()
        End If




    End Sub
    Private Sub Notifications()

        username = Session("user").ToString
        Dim db As New DatabseActions
        Dim dt As DataTable = db.EXECSPROC_NOTIFICATIONS(username)

        If dt.Rows(0).Item(0) > 0 Then
            notify_matched.InnerHtml = dt.Rows(0).Item(0).ToString
            notify_matched.Style("display") = "inline"

        Else
            notify_matched.Style("display") = "none"

        End If

        If dt.Rows(0).Item(1) > 0 Then
            notify_unmatched.InnerHtml = dt.Rows(0).Item(1).ToString
            notify_unmatched.Style("display") = "inline"


        Else
            notify_unmatched.Style("display") = "none"


        End If

        If dt.Rows(0).Item(2) > 0 Then
            notify_dismissed.InnerHtml = dt.Rows(0).Item(2).ToString
            notify_dismissed.Style("display") = "inline"

        Else
            notify_dismissed.Style("display") = "none"
        End If

        If dt.Rows(0).Item(3) > 0 Then
            notify_deleted.InnerHtml = dt.Rows(0).Item(3).ToString
            notify_deleted.Style("display") = "inline"

        Else
            notify_deleted.Style("display") = "none"
        End If

        If dt.Rows(0).Item(4) > 0 Then
            notify_invoices.InnerHtml = dt.Rows(0).Item(4).ToString
            notify_invoices.Style("display") = "inline"

        Else
            notify_invoices.Style("display") = "none"
        End If


        ScriptManager.RegisterStartupScript(Page, Page.GetType(), "dialog", "<script type='text/javascript'>notifications();</script>", False)




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
    <WebMethod(EnableSession:=True)>
    Public Shared Function MatchHorse(ByVal meeting As String, ByVal horse As String, ByVal time As String, ByVal bookie As String) As String

        Dim Result As String = ""
        Dim username As String = HttpContext.Current.Session("user")
        Dim now As String = DateTime.Now.ToLocalTime.ToString("HH:mm:ss")

        Dim db As New DatabseActions

        Try
            Dim usertable As String = username & "_matched"

            If username = "00alawre" Then
                usertable = "Algo_b_results"
            End If


            db.SQL("INSERT INTO " & usertable & " SELECT L.Meeting, L.RaceTime, L.Horse, B.BookieID, L.Odds, L.LastTradedPrice, L.TradedVolume, '" & now & "', 0 FROM LiveSelections_algo_b L INNER JOIN Bookies B ON B.BookieID = L.Bookmaker WHERE L.Horse = '" & horse & "' AND L.RaceTime = '" & time & "' AND L.Meeting = '" & meeting & "' AND B.Bookie = '" & bookie & "'")


            Result = "success"

        Catch ex As Exception

            Result = ex.InnerException.ToString

        End Try

        Return Result

    End Function
    <WebMethod(EnableSession:=True)>
    Public Shared Function ReMatch(ByVal meeting As String, ByVal horse As String, ByVal time As String, ByVal bookie As String) As String

        Dim Result As String = ""
        Dim username As String = HttpContext.Current.Session("user")
        Dim now As String = DateTime.Now.ToLocalTime.ToString("HH:mm:ss")

        Dim db As New DatabseActions

        Try
            Dim usertable As String = username & "_matched"



            db.SQL("UPDATE " & usertable & " SET Deleted=0 WHERE Meeting='" & meeting & "' AND Horse='" & horse & "' AND RaceTime='" & time & "' AND Bookmaker=(SELECT BookieID FROM Bookies WHERE Bookie = '" & bookie & "')")


            Result = "success"

        Catch ex As Exception

            Result = ex.InnerException.ToString

        End Try

        Return Result

    End Function

    <WebMethod(EnableSession:=True)>
    Public Shared Function GoneHorse(ByVal meeting As String, ByVal horse As String, ByVal time As String, ByVal bookie As String) As String

        Dim Result As String = ""
        Dim username As String = HttpContext.Current.Session("user")
        Dim now As String = DateTime.Now.ToLocalTime.ToString("HH:mm:ss")

        Dim db As New DatabseActions

        Try
            Dim usertable As String = username & "_gone"

            db.SQL("INSERT INTO " & usertable & "(Meeting, RaceTime, Horse, Bookmaker, Odds, LastTradedPrice, TradedVolume, TimeSuggested, TimeGone) SELECT L.Meeting, L.RaceTime, L.Horse, B.Bookie, L.Odds, L.LastTradedPrice, L.TradedVolume, L.TimeSuggested,  '" & now & "' FROM LiveSelections_algo_b L INNER JOIN Bookies B On B.BookieID = L.Bookmaker WHERE L.Horse = '" & horse & "' AND L.RaceTime = '" & time & "' AND L.Meeting = '" & meeting & "' AND B.Bookie = '" & bookie & "'")

            Result = "success"

        Catch ex As Exception

            Result = ex.InnerException.ToString

        End Try

        Return Result

    End Function

    <WebMethod(EnableSession:=True)>
    Public Shared Function MarkPaid(ByVal period As String, ByVal method As String) As String

        Dim Result As String = ""
        Dim username As String = HttpContext.Current.Session("user")
        Dim now As String = DateTime.Now.ToLocalTime.ToString("HH:mm:ss")

        Dim db As New DatabseActions

        Try

            db.SQL("UPDATE Invoices SET InvoicePaid = 1, DatePaid = GETDATE(), PaymentMethod='" & method & "' WHERE Period='" & period & "' AND [USER ID] = '" & username & "'")

            Result = "success"

        Catch ex As Exception

            Result = ex.InnerException.ToString

        End Try

        Return Result

    End Function


    <WebMethod(EnableSession:=True)>
    Public Shared Function DeleteHorse(ByVal meeting As String, ByVal horse As String, ByVal time As String, ByVal bookie As String) As String

        Dim Result As String = ""
        Dim username As String = HttpContext.Current.Session("user")

        Try
            Dim usertable As String = username & "_matched"

            If username = "00alawre" Then
                usertable = "Algo_b_results"
            End If

            Dim db As New DatabseActions
            db.UPDATE(usertable, "Deleted", 1, "WHERE RaceTime = '" & time & "' AND Horse = '" & horse & "' AND Meeting = '" & meeting & "' AND Bookmaker=(SELECT BookieID FROM Bookies WHERE Bookie = '" & bookie & "')")

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
    <WebMethod(EnableSession:=True)>
    Public Shared Function RestoreHorse(ByVal meeting As String, ByVal horse As String, ByVal time As String, ByVal bookie As String) As String

        Dim Result As String = ""
        Dim username As String = HttpContext.Current.Session("user")
        Dim now As String = DateTime.Now.ToLocalTime.ToString("HH:mm:ss")

        Dim db As New DatabseActions

        Try
            Dim usertable As String = username & "_gone"


            db.SQL("DELETE FROM " & usertable & " WHERE Meeting = '" & meeting & "' AND Horse='" & horse & "' AND RaceTime = '" & time & "' AND Bookmaker='" & bookie & "'")


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

    Private Sub gv_matched_DataBound(sender As Object, e As EventArgs) Handles gv_matched.DataBound
        ClientScript.RegisterStartupScript(Me.GetType, "Javascript", "javascript:color(); ", True)

    End Sub

    Private Sub btn_gone_Click(sender As Object, e As EventArgs) Handles btn_gone.Click

        Me.BindGrid("Dismissed")


    End Sub

    Private Sub btn_deleted_Click(sender As Object, e As EventArgs) Handles btn_deleted.Click
        Me.BindGrid("Deleted")

    End Sub

    Private Sub btn_invoices_Click(sender As Object, e As EventArgs) Handles btn_invoices.Click
        Me.BindGrid("Invoices")

    End Sub

    Private Sub btn_portfolio_Click(sender As Object, e As EventArgs) Handles btn_portfolio.Click

        Me.BindGrid("Portfolio")

    End Sub
End Class