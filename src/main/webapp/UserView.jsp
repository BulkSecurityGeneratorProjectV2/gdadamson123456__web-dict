<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.5/css/bootstrap.min.css">
    <link href="../css/main.css" rel="stylesheet" type="text/css">
    <script src="https://apis.google.com/js/platform.js" async defer></script>
    <meta name="google-signin-client_id" content="976118425813-o3mt3u1t3navdle20s4u8g081ichch7d.apps.googleusercontent.com">
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Home</title>
</head>
<body>
<div align="center" class="shadow op blockUser">
    <H2>Hello, ${sessionUser.login}!</H2>
    <br>
    <c:url value="/logout" var="logoutUrl"/>
    <form action="${logoutUrl}" method="post" id="logoutForm">
        <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
    </form>
    <script>
        function formSubmit() {
            if (typeof gapi !== 'undefined') {
                googleSingOut();
            } else {
                document.getElementById("logoutForm").submit();
            }
        }
        function googleSingOut() {
            var auth2 = gapi.auth2;
            if (typeof auth2 !== 'undefined') {
                authSingOut();
            } else {
                gapi.load('auth2', function () {
                    gapi.auth2.init().then(function () {
                        authSingOut();
                    });

                });
            }
        }
        function authSingOut() {
            var auth2 = gapi.auth2;
            if (typeof auth2 !== 'undefined') {
                var auth2In = auth2.getAuthInstance();
                auth2In.signOut().then(function () {
                    console.log('User signed out.');
                    document.getElementById("logoutForm").submit();
                });
            }
        }
    </script>
    <c:if test="${pageContext.request.userPrincipal.name != null || sessionUser != null}">
        <div>
            click <a href="javascript:formSubmit()">here</a> to logout
        </div>
    </c:if>
</div>
</body>
</html>