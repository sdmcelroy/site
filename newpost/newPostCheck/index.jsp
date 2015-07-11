<%@ page import="javax.naming.InitialContext" %>
<%@ page import="site.*" %>
<%
String usrName = (String)session.getAttribute("usrName");
if (usrName == null) {
	out.print("signin");
} else {
	String postSubject = request.getParameter("newPostSubject");
	String postBody = request.getParameter("newPostBody");
	DB db = new DB();
	out.print(db.postNew(usrName, postSubject, postBody));
}
%>