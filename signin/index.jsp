
<%@page language="java" contentType="text/html"%>




<html> 
<head> 


<link type="text/css" rel="stylesheet" href="/style.css" rel="stylesheet"/>

</head> 

<body>


<div id="outer">
	<div id="site">
		<%@ include file="/nav.html" %>

		<form id="signinForm" method="post" action="/signin/signinCheck/" >
			<p>
				<input id="usernameId" name="username" placeholder="username" value="sdmcelroy">
			</p>
			<p>
				<input id="passwordId" name="password" placeholder="password" type="password">
			</p>
			<p>
				<input type="submit" value="sign in">
			</p>
		</form>

		
	</div>
</div>	
	
	
</body> 
</html>

