
<html> 
<head> 

<link type="text/css" rel="stylesheet" href="/style.css" rel="stylesheet"/>
<link type="text/css" rel="stylesheet" href="/scripts/jquery-te-1.4.0.css"/>

<script src="/ckeditor/ckeditor.js"></script>
<script type="text/javascript" src="/scripts/jquery-2.1.1.min.js"></script>
<script type="text/javascript" src="/scripts/jquery-te-1.4.0.min.js"></script>
<script type="text/javascript" src="/scripts/jquery-ui.min.js"></script>

</head> 

<body>



<div id="outer">
	<div id="site">
		<%@ include file="/nav.html" %>
		<div id="newPost">
				<p>
				<input id="newPostSubject" name="newPostSubjectName" placeholder="Subject">
				</p>
				<textarea id="newPostBody"></textarea>
				<button id="postReplySubmit">Post</button><span id="postReplyResult"></span>					
		</div>
		<%@ include file="/footer.html" %>
	</div>
</div>





<script type="text/javascript">
	$("#newPostBody").ckeditor();
</script>



<script type="text/javascript">

	CKEDITOR.config.toolbarLocation = 'bottom';
	CKEDITOR.config.toolbar = [
	{ name: 'styles', items: [ 'Font', 'FontSize' , 'Styles'] },
	{ name: 'basicstyles', groups: [ 'basicstyles', 'cleanup' ], items: [ 'Bold', 'Italic', 'Underline', 'Strike', 'Subscript', 'Superscript', '-', 'RemoveFormat' ] },
	{ name: 'paragraph', groups: [ 'list', 'indent', 'align', 'bidi' ], items: [ 'NumberedList', 'BulletedList', '-', 'Outdent', 'Indent', '-', 'Blockquote', '-', 'JustifyLeft', 'JustifyCenter', 'JustifyRight', 'JustifyBlock'] },
	{ name: 'links', items: [ 'Link', 'Unlink', 'Anchor' ] },
	{ name: 'insert', items: [ 'Image'] },
	{ name: 'document', groups: [ 'mode' ], items: [ 'Source' ] }
	];

</script>



<script type="text/javascript">
$(document).ready(function(){
	$("#newPostBody").jqte({
		button: "SEND"
	});
});
</script>





<script type="text/javascript">
$(document).ready(function(){
	$("#postReplySubmit").click(function() {
		var formData = "newPostSubject="+$('#newPostSubject').val()+"&newPostBody="+$('#newPostBody').val()+"";
		//$("#postReplyResult").html(formData);
		$.ajax({
			type: "POST",
			data:formData,
			url:"/newpost/newPostCheck/",
			dataType:"text",
			success: function(result){
				var res  = $.trim(result);
				
				if (res != "failed") {
					location.href="/post/"+res+"/";
				} else {
					$("#postReplyResult").html(res);
				}
				
			}
		});
	});
});
</script>





</body> 
</html>

