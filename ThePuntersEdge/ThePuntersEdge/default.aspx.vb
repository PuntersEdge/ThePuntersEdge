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

End Class