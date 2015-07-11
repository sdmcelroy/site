<%@ page import="site.*" %>
<%@ page import="javax.naming.InitialContext" %>
<%
String postId = request.getParameter("postId");
String usrName = "" + session.getAttribute("usrName");
String postBody = request.getParameter("postBody");
DB db = new DB();
out.print(db.postComment(postId, usrName, postBody));
%>