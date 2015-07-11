<%@ page import="java.sql.*" %>
<%@ page import="javax.naming.InitialContext" %>
<%class Env {
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


Connection conn = null;
ResultSet rs = null;
Statement st = null;
Env env = new Env();

String sql = "";
String usrName = request.getParameter("usrName");
String postSubject = "";
String postBody = request.getParameter("postBody");

if (usrName == null || postBody == null) {
out.print("nothing");
} else {
out.print("working");

sql = "INSERT INTO post (postUsrName, postSubject, postBody) VALUES ('"+usrName+"', '"+postSubject+"', '"+postBody+"')";
Class.forName(env.dbDriver).newInstance(); 
conn = DriverManager.getConnection(env.dbConn, env.dbUser, env.dbPass);    
st = conn.createStatement(); 
Integer resultInt = st.executeUpdate(sql);


conn.close();

}
%>