
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
String usrName = (String)session.getAttribute("usrName");
String postSubject = request.getParameter("newPostSubject");
String postBody = request.getParameter("newPostBody");

sql = "INSERT INTO post (postUsrName, postSubject, postBody) VALUES ('"+usrName+"', '"+postSubject+"', '"+postBody+"')";
Class.forName(env.dbDriver).newInstance(); 
conn = DriverManager.getConnection(env.dbConn, env.dbUser, env.dbPass);    
st = conn.createStatement(); 
out.print(sql);
//Integer resultInt = out.print(st.executeUpdate(sql));

/*
if (resultInt <= 0) {
	out.print("failed");
} else {
	out.print("success");
}
out.print(resultInt);
*/


conn.close();

%>


<html> 
<head> 



</head> 



<body>


</body> 
</html>

