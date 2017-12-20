Imports ThePuntersEdge.DatabseActions
Imports System.Data
Imports System.Web.Services
Imports System.Configuration
Imports System.Data.SqlClient
Imports System.Web
Public Class Site
    Inherits System.Web.UI.MasterPage
    Public Username As String = ""
    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load

        Call LatestWinners()


        If Session("user") Is Nothing Then

            login_mobile.Text = "Login"
            lbl_login.Text = "Login"

        Else

            lbl_login.Text = "Logout"
            login_mobile.Text = "Logout"
            Username = Session("user").ToString


        End If



    End Sub


    Private Sub LatestWinners()

        lbl_latest_winners.Text = ""
        Dim db As New DatabseActions

        Dim results As DataTable = db.SELECTSTATEMENT("TOP 1 A.Meeting, CONVERT(VARCHAR(5), A.RaceTime) AS RaceTime, A.Horse, A.Odds", "algo_b_results A", "INNER JOIN Results R ON R.[Time] = A.RaceTime AND R.Horse = A.Horse WHERE R.Result ='1st' ORDER BY A.RaceTime DESC   ")

        For Each row As DataRow In results.Rows()

            lbl_latest_winners.Text = lbl_latest_winners.Text & "WINNER! " & row.Item(1).ToString & " " & row.Item(0).ToString & " - " & row.Item(2).ToString & " at odds of " & row.Item(3)


        Next

    End Sub

    Private Sub Login_Click(sender As Object, e As EventArgs) Handles Login.Click

        If tb_username.Text = "" Then

            tb_username.Style.Add("border", "1px solid red !IMPORTANT")
            tb_username.Focus()
            up_loginsignup.Update()

        ElseIf tb__pwd.Text = "" Then

            tb__pwd.Style.Add("border", "1px solid red !IMPORTANT")
            tb__pwd.Focus()
            up_loginsignup.Update()

        Else

            Dim db As New DatabseActions

            Dim username As String = tb_username.Text.ToString
            Dim pass As String = tb__pwd.Text.ToString
            Dim result As DataTable = db.SELECTSTATEMENT("COUNT(0)", "Users", "WHERE [USER ID] = '" & username & "' AND User_Password='" & pass & "'")


            If result.Rows(0).Item(0) > 0 Then

                Dim time As String = DateTime.Now.ToString("yyyy-MM-dd HH:mm:ss")
                Session("User") = username
                db.INSERT("ChatLog", "Username, Message, MessageTime", "'" & username & "', '" & username & " just logged in.', '" & time & "'")
                Response.Redirect("picks.aspx")



            Else

                tb__pwd.Style.Add("border", "1px solid red !IMPORTANT")
                tb__pwd.Focus()
                tb__pwd.BackColor = Drawing.Color.DarkSalmon
                up_loginsignup.Update()

            End If

        End If

    End Sub

    Private Sub tmr_winners_Tick(sender As Object, e As EventArgs) Handles tmr_winners.Tick

        Me.LatestWinners()

    End Sub


End Class