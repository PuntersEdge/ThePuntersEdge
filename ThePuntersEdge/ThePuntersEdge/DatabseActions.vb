﻿Imports System.Web
Imports System.Net
Imports System.Web.Script.Serialization
Imports System.IO

Imports System.Data.SqlClient

Public Module GlobalVars

    Public con As New SqlConnection(ConfigurationManager.ConnectionStrings("PuntersEdgeDB").ConnectionString)
    Public command As New SqlCommand

End Module

Public Class DatabseActions
    Implements IHttpModule

    Private WithEvents _context As HttpApplication

    ''' <summary>
    '''  You will need to configure this module in the Web.config file of your
    '''  web and register it with IIS before being able to use it. For more information
    '''  see the following link: http://go.microsoft.com/?linkid=8101007
    ''' </summary>
#Region "IHttpModule Members"

    Public Sub Dispose() Implements IHttpModule.Dispose

        ' Clean-up code here

    End Sub

    Public Sub Init(ByVal context As HttpApplication) Implements IHttpModule.Init
        _context = context
    End Sub

#End Region

    Public Sub OnLogRequest(ByVal source As Object, ByVal e As EventArgs) Handles _context.LogRequest

        ' Handles the LogRequest event to provide a custom logging 
        ' implementation for it

    End Sub

    Public Sub UPDATESession(ByVal table As String, value As String)

        Dim result As String = ""

        Try
            command.CommandType = CommandType.Text
            command.CommandText = "UPDATE [" & table & "] SET [SessionToken] = '" & value & "' WHERE [SessionToken] = '-1'"
            command.Connection = con
            con.Open()
            command.ExecuteNonQuery()
            con.Close()
            result = "Success:" & command.CommandText.ToString

        Catch ex As Exception
            result = ex.Message.ToString
        End Try

    End Sub 'For PuntersEdge ONLY - deals with session token for API access
    Public Sub INSERT(ByVal table As String, ByVal columns As String, values As String)

        Using conn As New SqlConnection(ConfigurationManager.ConnectionStrings("PuntersEdgeDB").ConnectionString)

            command.CommandText = "INSERT INTO " & table & "(" & columns & ")" & " VALUES (" & values & ")"
            command.Connection = conn

            conn.Open()
            command.ExecuteNonQuery()
            con.Close()

        End Using



    End Sub 'General INSERT statement. Accepts table name, columns in string (column1, column2 etc), and values in string ('varchar', int etc)
    Public Function SELECTSTATEMENT(ByVal ColumnsToSelect As String, ByVal table As String, ByVal whereClause As String)



        Dim strSql As String = "SELECT " & ColumnsToSelect & " FROM " & table & " " & whereClause
        Dim Resultset As New DataTable
        Using cnn As New SqlConnection(ConfigurationManager.ConnectionStrings("PuntersEdgeDB").ConnectionString)
            cnn.Open()
            Using dad As New SqlDataAdapter(strSql, cnn)
                dad.Fill(Resultset)
            End Using
            cnn.Close()
        End Using


        Return Resultset
    End Function 'General Select statement. Accepts table name, columns or *, and a where clause if needed (if not, pass in "")
    Public Function SELECTSTATEMENT_Scalar(ByVal ColumnsToSelect As String, ByVal table As String, ByVal whereClause As String)



        Dim strSql As String = "SELECT " & ColumnsToSelect & " FROM " & table & " " & whereClause
        Dim Resultset As String
        Using cnn As New SqlConnection(ConfigurationManager.ConnectionStrings("PuntersEdgeDB").ConnectionString)
            cnn.Open()

            command.CommandText = strSql
            command.Connection = cnn

            Resultset = command.ExecuteScalar

            cnn.Close()
        End Using


        Return Resultset
    End Function 'General Select statement. Accepts table name, columns or *, and a where clause if needed (if not, pass in "")
    Public Function EXECSPROC(ByVal SPROCNAME As String, variables As String)
        Dim Result As String = ""

        command.CommandText = "EXECUTE " & SPROCNAME & " " & variables
        command.Connection = con

        Try

            con.Open()
            Result = command.ExecuteScalar
            con.Close()

        Catch ex As Exception

        End Try

        Return Result

    End Function
    Public Function EXECSPROC_STATS(ByVal User As String, usertable As String, archive As String)
        Dim Result As DataTable

        Using conn As New SqlConnection(ConfigurationManager.ConnectionStrings("PuntersEdgeDB").ConnectionString)

            Dim con = New SqlConnection()
            con.ConnectionString = ConfigurationManager.ConnectionStrings("PuntersEdgeDB").ConnectionString
            Dim com = New SqlCommand()
            com.Connection = con
            com.CommandType = CommandType.StoredProcedure
            com.CommandText = "Stats_Board"
            com.Parameters.AddWithValue("@User", "'" & User & "'")
            com.Parameters.AddWithValue("@usertable", usertable)
            com.Parameters.AddWithValue("@usertable_archive", archive)
            Dim adapt = New SqlDataAdapter()
            adapt.SelectCommand = com
            Dim DataSet = New DataSet()
            adapt.Fill(DataSet, "Results")
            Result = DataSet.Tables("Results")

            conn.Close()

        End Using



        Return Result

    End Function
    Public Function EXECSPROC_GRAPH(ByVal User As String, usertable As String, archive As String)
        Dim Result As DataTable

        Using conn As New SqlConnection(ConfigurationManager.ConnectionStrings("PuntersEdgeDB").ConnectionString)

            Dim con = New SqlConnection()
            con.ConnectionString = ConfigurationManager.ConnectionStrings("PuntersEdgeDB").ConnectionString
            Dim com = New SqlCommand()
            com.Connection = con
            com.CommandType = CommandType.StoredProcedure
            com.CommandText = "Stats_graph"
            com.Parameters.AddWithValue("@User", "'" & User & "'")
            com.Parameters.AddWithValue("@usertable", usertable)
            com.Parameters.AddWithValue("@usertable_archive", archive)
            Dim adapt = New SqlDataAdapter()
            adapt.SelectCommand = com
            Dim DataSet = New DataSet()
            adapt.Fill(DataSet, "Results")
            Result = DataSet.Tables("Results")

            conn.Close()

        End Using



        Return Result

    End Function
    Public Function EXECSPROC_NOTIFICATIONS(ByVal User As String)
        Dim Result As DataTable

        Using conn As New SqlConnection(ConfigurationManager.ConnectionStrings("PuntersEdgeDB").ConnectionString)

            Dim con = New SqlConnection()
            con.ConnectionString = ConfigurationManager.ConnectionStrings("PuntersEdgeDB").ConnectionString
            Dim com = New SqlCommand()
            com.Connection = con
            com.CommandType = CommandType.StoredProcedure
            com.CommandText = "notifications"
            com.Parameters.AddWithValue("@user", User)
            Dim adapt = New SqlDataAdapter()
            adapt.SelectCommand = com
            Dim DataSet = New DataSet()
            adapt.Fill(DataSet, "Results")
            Result = DataSet.Tables("Results")

            conn.Close()

        End Using



        Return Result

    End Function
    Public Function BindUnmatched(ByVal User As String)
        Dim Result As DataTable

        Using conn As New SqlConnection(ConfigurationManager.ConnectionStrings("PuntersEdgeDB").ConnectionString)

            Dim con = New SqlConnection()
            con.ConnectionString = ConfigurationManager.ConnectionStrings("PuntersEdgeDB").ConnectionString
            Dim com = New SqlCommand()
            com.Connection = con
            com.CommandType = CommandType.StoredProcedure
            com.CommandText = "UserUnmatchedHorses"
            com.Parameters.AddWithValue("@UserName", User)
            Dim adapt = New SqlDataAdapter()
            adapt.SelectCommand = com
            Dim DataSet = New DataSet()
            adapt.Fill(DataSet, "Results")
            Result = DataSet.Tables("Results")

            conn.Close()

        End Using



        Return Result

    End Function

    Public Sub UPDATE(ByVal table As String, columnToUpdate As String, valueToInsert As String, WHERE_CLAUSE As String)

        If Not columnToUpdate.Contains("Stake") Or columnToUpdate.Contains("dds") Then

            valueToInsert = "'" & valueToInsert & "'"

        End If

        command.CommandText = "UPDATE " & table & " SET " & columnToUpdate & "=" & valueToInsert & " " & WHERE_CLAUSE
        command.Connection = con

        con.Open()
        command.ExecuteNonQuery()
        con.Close()



    End Sub
    Public Sub SELECT_INTO(ByVal Table As String, ByVal columns As String, ByVal FromSQL As String)

        Using connection As New SqlConnection(ConfigurationManager.ConnectionStrings("PuntersEdgeDB").ConnectionString)

            command.CommandText = "SELECT " & columns & " INTO " & Table & " FROM (" & FromSQL & ")"
            command.Connection = connection

            connection.Open()
            command.ExecuteNonQuery()
            connection.Close()

        End Using





    End Sub

    Public Sub SQL(ByVal sql As String)

        command.CommandText = sql
        command.Connection = con

        con.Open()
        command.ExecuteNonQuery()
        con.Close()

    End Sub

End Class
