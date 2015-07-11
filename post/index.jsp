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
String postUsrName = "";
String postSubject = "";
String postBody = "";
String postTime = "";
String postDate = "";
Integer posti = 0;
String postText = "";
String postFooter = "";
String sessUsrName = (String)session.getAttribute("usrName");
String postId = "";
String pathInfo = request.getPathInfo();
boolean bPostIdInvalid = false;

// remove leading '/'
if (pathInfo.charAt(0)=='/') {
	pathInfo = pathInfo.substring(1,pathInfo.length());
	
	// take only upto the next '/'
	if (pathInfo.indexOf('/')!=-1) {
		pathInfo = pathInfo.substring(0,pathInfo.indexOf('/'));
		
		// ensure the value is only of set 0123456789
		for (int i = 0; i < pathInfo.length(); i++){
			String s = pathInfo.substring(i,i+1);
			if (s.equals("0") || s.equals("1") || s.equals("2") || s.equals("3") || s.equals("4") || s.equals("5") || s.equals("6") || s.equals("7") || s.equals("8") || s.equals("9") ) {
			} else {
				bPostIdInvalid = true;
			}
		}
	} else {
		bPostIdInvalid = true;
	}
} else {
	bPostIdInvalid = true;
}

// redirect malformed urls to home
if (bPostIdInvalid) {
	response.sendRedirect("/");
} else {
	
	postId = pathInfo;
	sql = "SELECT *, Date_Format(postTime,'%Y %b %e at %l:%i %p') as postDate  FROM post WHERE postId = "+postId + " OR postIdParent= "+postId + "  ORDER BY postId asc " ;
	
	Class.forName(env.dbDriver).newInstance(); 
	conn = DriverManager.getConnection(env.dbConn, env.dbUser, env.dbPass);    
	st = conn.createStatement(); 
	rs = st.executeQuery(sql);
	
	postFooter = "vote up | flag";
	
		
	if (!rs.isBeforeFirst()) {
		response.sendRedirect("/");
	} else {

		rs.first();
		String reqPath = request.getPathInfo();
		String expPath = "/" + rs.getString("postId") + "/" + rs.getString("postSubjectURL");		
		if (!reqPath.equals(expPath)) {
			response.sendRedirect("/post" + expPath);
		}
		
		do {
			postUsrName = rs.getString("postUsrName");
			postBody = rs.getString("postBody");
			postTime = rs.getString("postTime");
			postDate = rs.getString("postDate");
			
			if (rs.getString("postIdParent").equals("0")) {
				postSubject = rs.getString("postSubject");
			}
			
			postText +=  "<div class=\"post\" id=\"post"+posti+"\">";
			postText +=  	"<div class=\"postHeader\" id=\"postHeader"+posti+"\">";
			postText += 		"<span class=\"postUserName\">" + postUsrName + "</span>";
			postText += 		"<span class=\"postTime\">" + postDate + "</span>";
			postText += 		"<div class=\"clearBoth\" style=\"clear: both\"></div>";
			postText += 	"</div>";		
		
			postText += 	"<div class=\"postBody\" id=\"postBody"+posti+"\">" + postBody + "</div>";
			
			postText += 	"<div class=\"postFooter\" id=\"postFooter"+posti+"\">" + postFooter + "</div>";		
			postText += 	"<div class=\"clearBoth\"  style=\"clear: both\"></div>";
			postText += "</div>";
		
			posti++;
		} while (rs.next());
			
	}
	
	rs.close();
	conn.close();
	

}

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



<div id="outer">
	<div id="site">
		<%@ include file="/nav.html" %>
		<div id="content">
			<table id="contentTable">
				<tr id="contentTableRow">
					<td id="contentTableContent">
					
					<div id="page">	
						<div class="posts">
							<div id="postSubject" postId="<%out.print(postId);%>">
								<%out.print(postSubject); %>
							</div>
							<%out.print(postText); %>
						</div>
					
						<div id="pageFooter">
							<div id="postReply">
								<textarea class="teEditor" name="postEditorName" id="postEditor"></textarea>
							</div>
						</div>
					</div>
					</td>
					
					<td id="contentTableAds">
						<div id="ads">
							Ads Here
						</div>
					</td>
				</tr>
			</table>
		</div>
		<%@ include file="/footer.html" %>
	</div>
</div>



<script type="text/javascript">
$(document).ready(function(){
	$("#postReplyButton").click(function() {
		var formData = "postId="+$('#postSubject').attr("postId")+"&postBody="+$('#postEditor').val();
		$.ajax({
			type: "POST",
			data:formData,
			url:"/comment/",
			dataType:"text",
			success: function(result){
				$("#postReplyResult").html(result);
				if($.trim(result) == "posted") {location.reload(true);}
			},
		});
	});
});
</script>


<script type="text/javascript">
$(document).ready(function(){
	$("#postEditor").jqte({
		button: "SEND"
	});
});
</script>




<script type="text/javascript">
$(document).ready(function(){
	$("#toggleReply").click(function(){
		$("#postReply").toggle();
	});
});
</script>



<script type="text/javascript">
$(document).ready(function(){
	$("#postHeader0").click(function(){
		$("#postBody0").toggle();
	});
	$("#postHeader1").click(function(){
		$("#postBody1").toggle();
	});
});
</script>




</body> 
</html>

