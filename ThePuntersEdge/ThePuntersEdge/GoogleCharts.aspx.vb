Imports Newtonsoft.Json
Imports System.Data
Imports System.Web.Services
Imports System.Configuration
Imports System.Data.SqlClient
Imports System.Web

Public Class GoogleCharts
    Inherits System.Web.UI.Page


    <WebMethod(EnableSession:=True)>
    Public Shared Function GetChartData() As String

        Dim db As New DatabseActions

        Dim user As String = HttpContext.Current.Session("user")
        Dim usertable As String = user & "_matched"
        Dim archive_table As String = user & "_matched_archive"

        If user = "00alawre" Then
            usertable = "algo_results"
            archive_table = "algo_matched_archive"
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
            usertable = "algo_results"
            archive_table = "algo_matched_archive"
        End If

        Dim results As DataTable = db.SELECTSTATEMENT("TOP 7 [Date], ProfitLoss", "Algo_b_daily_profit", "")
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


        Dim results As DataTable = db.SELECTSTATEMENT("[Date], (" & Stake & ")*(SUM(ProfitLoss) OVER (ORDER BY DATE ROWS UNBOUNDED PRECEDING)) AS Balance", "Algo_b_daily_profit", "WHERE [Date] >= DATEADD(mm, -6, GETDATE())")
        Dim chartData As String = JsonConvert.SerializeObject(results)

        Return chartData


    End Function


End Class