Imports ThePuntersEdge.DatabseActions
Imports System.Data
Imports System.Web.Services
Imports System.Configuration
Imports System.Data.SqlClient
Imports System.Web
Imports System.Net.Mail
Imports System.Net
Imports System.Web.UI

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
    Public Shared Function UpdateSettings(ByVal stake As String, ByVal pwd As String, ByVal pwd_new As String) As String

        Dim user As String = HttpContext.Current.Session("user")
        Dim message As String = ""
        Dim db As New DatabseActions
        Dim result As DataTable = db.SELECTSTATEMENT("COUNT(0)", "Users", "WHERE [USER ID] = '" & user & "' AND User_Password='" & pwd & "'")
        Dim originalstake As String = db.SELECTSTATEMENT_Scalar("Stake", "UsersStake", "WHERE Username = '" & user & "'")




        If result.Rows(0).Item(0) > 0 Then

            If Not pwd_new = "" Then


                db.UPDATE("Users", "User_Password", pwd_new, "WHERE [USER ID] = '" & user & "'")
                message = message & "Password updated."

            Else


            End If

            If Not IsNothing(stake) And stake <> originalstake Then

                If Day(Date.Now) = 1 Then
                    db.UPDATE("UsersStake", "Stake", "'" & stake & "'", "WHERE UserName = '" & user & "'")
                    message = "Updated stake to " & stake

                Else

                    db.UPDATE("UsersStake", "NextStake", "'" & stake & "'", "WHERE UserName = '" & user & "'")
                    message = "Your stake will be updated to " & stake & " on the first on the next month."

                End If


            End If



        Else

            message = "Invalid password!"

        End If


        Return message

    End Function
    <WebMethod(EnableSession:=True)>
    Public Shared Function enquire(ByVal name As String, ByVal email As String, ByVal tel As String, ByVal msg As String) As String

        Dim result As String = ""
        Dim recipient As String = "noreply@atthepostprofit.co.uk"
        Dim smtp As New SmtpClient

        Try
            Dim mm As MailMessage = New MailMessage()
            mm.From = New MailAddress("noreply@atthepostprofit.co.uk")
            mm.Subject = "PuntersEdge enquiry from " & name
            mm.Body = "<p>Name: " & name & " </p> <br /> <p>Email: " & email & " </p> <br /> <p>Tel: " & tel & "</p> <br /> <p>Message: <br />" & msg & "</p>"
            mm.IsBodyHtml = True
            mm.To.Add(New MailAddress(recipient))

            smtp.Host = "smtp.office365.com" 'This will be the godaddy smtp server
            smtp.EnableSsl = True
            Dim NetworkCred As NetworkCredential = New System.Net.NetworkCredential()
            NetworkCred.UserName = "noreply@atthepostprofit.co.uk" 'This will be the godaddy smtp server log ins
            NetworkCred.Password = "portsmouth1!" 'This will be the godaddy smtp server log ins
            smtp.UseDefaultCredentials = True
            smtp.Credentials = NetworkCred
            smtp.Port = 587 'This will be the godaddy smtp server port

            smtp.Send(mm)
            result = "success"
        Catch ex As Exception

            result = "fail"

        End Try


        Return result

    End Function

End Class