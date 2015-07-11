<FORM METHOD="POST" ACTION="WEB-INF/classes/user/UserData">
What's your name? <INPUT TYPE="TEXT" NAME="username" SIZE=20><BR>
What's your e-mail address? <INPUT TYPE="TEXT" NAME="email" SIZE=20><BR>
What's your age? <INPUT TYPE="TEXT" NAME="age" SIZE=4>
<P><INPUT TYPE="SUBMIT">
<input type="submit" value="Submit Async">
</FORM>
<p></p>


<%
var xmlhttp;
xmlhttp=new XMLHttpRequest();
xmlhttp.open("POST","ajax_info.txt",true);
xmlhttp.setRequestHeader("Content-type","application/x-www-form-urlencoded");
xmlhttp.send("username=henry&email=thit");


%>

<p></p>

<%
xmlhttp.onreadystatechange=function()
  {
  if (xmlhttp.readyState==4 && xmlhttp.status==200)
    {
    document.getElementById("myDiv").innerHTML=xmlhttp.responseText;
    }
  }

%>