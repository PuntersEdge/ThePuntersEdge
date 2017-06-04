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




End Class