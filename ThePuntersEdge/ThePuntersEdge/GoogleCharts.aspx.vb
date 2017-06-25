Imports Newtonsoft.Json
Imports System.Data
Imports System.Web.Services
Imports System.Configuration
Imports System.Data.SqlClient
Imports System.Web

Public Class GoogleCharts
    Inherits System.Web.UI.Page

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load

        If Session("user") Is Nothing Then
            MsgBox("Session Expired! Please log back in!")
            Response.Redirect("Default.aspx")
        End If

    End Sub

    <WebMethod(EnableSession:=True)>
    Public Shared Function GetChartData() As String

        Dim db As New DatabseActions

        Dim user As String = HttpContext.Current.Session("user")
        Dim usertable As String = user & "_matched"
        Dim archive_table As String = user & "_matched_archive"

        If user = "00alawre" Then
            usertable = "algo_b_results"
            archive_table = "algo_b_matched_archive"
        End If

        Dim results As DataTable = db.EXECSPROC_GRAPH(user, usertable, archive_table)
        Dim chartData As String = JsonConvert.SerializeObject(results)

        Return chartData


    End Function

    <WebMethod(EnableSession:=True)>
    Public Shared Function GetPointsData() As String

        Dim db As New DatabseActions

        Dim user As String = HttpContext.Current.Session("user")
        Dim usertable As String = user & "_matched"
        Dim archive_table As String = user & "_matched_archive"

        If user = "00alawre" Then
            usertable = "algo_b_results"
            archive_table = "algo_b_matched_archive"
        End If

        Dim results As DataTable = db.SELECTSTATEMENT("TOP 7 [Date], ProfitLoss", "Algo_b_daily_profit", "ORDER BY [Date] DESC")
        Dim chartData As String = JsonConvert.SerializeObject(results)

        Return chartData


    End Function

    <WebMethod(EnableSession:=True)>
    Public Shared Function GetGrowthData() As String

        Dim db As New DatabseActions


        Dim results As DataTable = db.SELECTSTATEMENT("CONCAT('Week ', DATEPART(wk, [Date])) AS [Week], SUM(25*ProfitLoss) AS ProfitLoss", "Algo_b_daily_profit", "GROUP BY CONCAT('Week ', DATEPART(wk, [Date]))")
        Dim chartData As String = JsonConvert.SerializeObject(results)

        Return chartData


    End Function

    <WebMethod(EnableSession:=True)>
    Public Shared Function GetBalanceData(ByVal Stake As String) As String

        Dim db As New DatabseActions


        Dim results As DataTable = db.SELECTSTATEMENT("[Date], (" & Stake & ")*(SUM(ProfitLoss) OVER (ORDER BY DATE ROWS UNBOUNDED PRECEDING)) + (" & Stake & "*200) AS Balance", "Algo_b_daily_profit", "WHERE [Date] >= DATEADD(mm, -6, GETDATE())")
        Dim chartData As String = JsonConvert.SerializeObject(results)

        Return chartData


    End Function
    <WebMethod()>
    Public Shared Function DaysResults(DateSelected As String) As String

        Dim return_results As String = ""

        Dim user As String = HttpContext.Current.Session("user")

        If user = "00alawre" Then

            return_results = "no user"

        Else



            Dim columns As String = ""
            Dim table As String = ""
            Dim NotLive As String = ""
            Dim DateSelectedQuery As String = ""

            If DateSelected = Date.Now.ToString("yyyy-MM-dd") Then
                columns = "S.Horse, S.Odds, R.Result"
                table = user & "_matched S INNER JOIN Results R ON R.Horse = S.Horse AND R.[Time] = S.RaceTime"
                NotLive = " RaceTime < CONVERT(VARCHAR(8), DATEADD(mm, -15, GETDATE()), 108) AND S.Deleted=0 ORDER BY S.Racetime DESC"
            Else
                columns = "S.Horse, S.Odds, S.Result"
                table = "PuntersEdge_Archive.dbo." & user & "_matched_archive S"
                DateSelectedQuery = " [Date] = '" & DateSelected & "' AND Deleted = 0 ORDER BY S.Racetime DESC"

            End If

            Dim db As New DatabseActions
            Dim success As String = ""

            Dim results As DataTable = db.SELECTSTATEMENT(columns, table, "WHERE" & DateSelectedQuery & "" & NotLive)

            If results.Rows().Count < 1 Then

                return_results = "none"

            Else

                return_results = JsonConvert.SerializeObject(results)

            End If


        End If




        Return return_results

    End Function
    <WebMethod(EnableSession:=True)>
    Public Shared Function GetBookieSpread() As String
        Dim result As String = ""
        Dim db As New DatabseActions

        Dim user As String = HttpContext.Current.Session("user")

        If Not user = "00alawre" Then
            Dim results As DataTable = db.SELECTSTATEMENT("B.Bookie, COUNT(B.Bookie) As [COUNT]", "PuntersEdge_Archive.dbo." & user & "_matched_archive S
			INNER JOIN Bookies B ON S.Bookmaker = B.BookieID GROUP BY B.Bookie", "")

            result = JsonConvert.SerializeObject(results)

        Else

            result = "admin"

        End If



        Return result
    End Function

End Class