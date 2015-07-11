
<%@ page import="java.sql.*" %>

<%@ page import="javax.naming.InitialContext" %>

<%
class Env {
	String dbName;
	String dbConn;
	String dbDriver;
	String dbUser;
	String dbPass;
	
    Env() { 
		try {
			InitialContext ic = new InitialContext();
			dbName = (String) ic.lookup("java:comp/env/dbName");
			dbConn = (String) ic.lookup("java:comp/env/dbConn");
			dbDriver = (String) ic.lookup("java:comp/env/dbDriver");
			dbUser = (String) ic.lookup("java:comp/env/dbUser");
			dbPass = (String) ic.lookup("java:comp/env/dbPass");
		} catch (Exception e) {
		} 
    }
}
%>


<%
Connection conn = null;
ResultSet rs = null;
Statement st = null;
Env env = new Env();

String sql = "";
String usrName = request.getParameter("username");
String usrPassword = request.getParameter("password");
String usrDisplayName = "";

sql = "SELECT * FROM usr WHERE usrName = '"+usrName+"' AND usrPassword = '"+usrPassword+"'";
Class.forName(env.dbDriver).newInstance(); 
conn = DriverManager.getConnection(env.dbConn, env.dbUser, env.dbPass);    
st = conn.createStatement(); 
rs = st.executeQuery(sql);

if (rs.next()) {
	session.setAttribute("usrName", usrName);
	out.print("welcome");
} else {
	out.print("goodbye");
}

rs.close();
conn.close();

%>


<html> 
<head> 

<link type="text/css" rel="stylesheet" href="/style.css" rel="stylesheet"/>
<link type="text/css" rel="stylesheet" href="/scripts/jquery-te-1.4.0.css"/>

<script type="text/javascript" src="/scripts/jquery-2.1.1.min.js"></script>
<script type="text/javascript" src="/scripts/jquery-te-1.4.0.min.js"></script>
<script type="text/javascript" src="/scripts/jquery-ui.min.js"></script>

</head> 



<body>


</body> 
</html>

