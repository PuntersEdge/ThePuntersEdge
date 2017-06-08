Imports ThePuntersEdge.DatabseActions
Imports System.Data
Imports System.Web.Services
Imports System.Configuration
Imports System.Data.SqlClient
Imports System.Web

Public Class _default
    Inherits System.Web.UI.Page

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load

    End Sub

    <WebMethod(EnableSession:=True)>
    Public Shared Function Logout() As String

        HttpContext.Current.Session.Abandon()

        Dim Message As String = "User Logged Out!"

        Return Message

    End Function

    <WebMethod(EnableSession:=True)>
    Public Shared Function UpdateSettings(ByVal stake As Int16, ByVal pwd As String, ByVal pwd_new As String) As String

        Dim user As String = HttpContext.Current.Session("user")
        Dim message As String = ""
        Dim db As New DatabseActions
        Dim result As DataTable = db.SELECTSTATEMENT("COUNT(0)", "Users", "WHERE [USER ID] = '" & user & "' AND User_Password='" & pwd & "'")



        If result.Rows(0).Item(0) > 0 Then


            If Not IsNothing(stake) Then

                If Day(Date.Now) = 1 Then
                    db.UPDATE("UsersStake", "Stake", "'" & stake & "'", "WHERE UserName = '" & user & "'")
                    message = "Updated stake to " & stake

                Else
                    message = "You can only change your stake on the 1st of each month"

                End If

            Else
                message = "Please enter a stake!"
            End If

            If Not pwd_new = "" Then


                db.UPDATE("Users", "User_Password", "'" & pwd_new & "'", "WHERE [USER ID] = '" & user & "'")
                message = message & ". Password updated."

            End If

        Else

            message = "Invalid password!"

        End If


        Return Message

    End Function

End Class