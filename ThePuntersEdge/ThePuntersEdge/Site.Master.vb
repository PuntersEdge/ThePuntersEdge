Imports ThePuntersEdge.DatabseActions

Public Class Site
    Inherits System.Web.UI.MasterPage
    Public Username As String = ""
    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load

        If Session("user") Is Nothing Then


            lbl_login.Text = "Login"

        Else

            lbl_login.Text = "Logout"
            Username = Session("user").ToString


        End If

    End Sub

    Private Sub Login_Click(sender As Object, e As EventArgs) Handles Login.Click

        If tb_username.Text = "" Then

            tb_username.Style.Add("borde", "1px solid red !IMPORTANT")
            tb_username.Focus()
            up_loginsignup.Update()

        ElseIf tb_pwd.Text = "" Then

            tb_pwd.Style.Add("borde", "1px solid red !IMPORTANT")
            tb_pwd.Focus()
            up_loginsignup.Update()

        Else

            Dim db As New DatabseActions

            Dim username As String = tb_username.Text.ToString
            Dim pass As String = tb_pwd.Text.ToString
            Dim result As DataTable = db.SELECTSTATEMENT("COUNT(0)", "Users", "WHERE [USER ID] = '" & username & "' AND User_Password='" & pass & "'")


            If result.Rows(0).Item(0) > 0 Then

                Session("User") = username
                Response.Redirect("picks.aspx")


            Else

                tb_pwd.Style.Add("border", "1px solid red !IMPORTANT")
                tb_pwd.Focus()
                up_loginsignup.Update()

            End If

        End If

    End Sub
End Class