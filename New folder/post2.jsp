<html> 
<head> 

<!--

< %
if (request.getParameter("p") == null) {
    out.println("Not found.");
} else {
out.println("Found " + request.getParameter("p"));
}

% >
<!--
 
DB db = new DB();
ResultSet rs = null;
rs = db.getPostById(request.getParameter("p"))
out.println(""+rs.getString("post"));
-->


<link href="style.css" rel="stylesheet" type="text/css"/>
<!--
< %@ page import="site.DB" %>
-->
</head> 
<body>
<div id="outer">
	<div id="site">
		<div id="nav">
			Option 1, Option 2, Option 3
		</div>
		<div id="page">
			<div id ="content">
				Content Here
				<p>
				Here
				<p>
				And Here
			</div>
			<div id="extra">
				Ads Here
				<p>
				And Here
			</div>
		</div>
		<div id="footer">
			Footer Here
		</div>
	</div>
</div>

</body> 
</html>

