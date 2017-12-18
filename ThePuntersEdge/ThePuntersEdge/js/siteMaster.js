function LoginModal(button) {
    var state = document.getElementById("lbl_login").innerHTML
    if (state == "Login") { document.getElementById('id01').style.display = 'block'; return !1 } else if (state == "Logout") { $.ajax({ type: 'POST', dataType: 'json', contentType: 'application/json', url: 'default.aspx/Logout', success: function (response) { window.location = "default.aspx" } }) }
}
function checkKey() { if (window.event.keyCode == 13) { $("#Login").click() } }
var modal = document.getElementById('id01'); window.onclick = function (event) { if (event.target == modal) { modal.style.display = "none" } }