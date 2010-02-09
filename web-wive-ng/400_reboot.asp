<h1>Reboot Device</h1>
<div class="frame">
<p>
	Click "Reboot System" button to restart your AP.
</p>
<form enctype="multipart/form-data" action="./goform/formCommands" method="post">
	<input type="hidden" name="command" value="reboot" />
	<input type="submit" value="Reboot System" id="rebootCommand">
</form>
</div>

<div class="loading" id="waitRebooting" style="display:none">
	<h2>System is rebooting, please wait ...</h2>
</div>


<script type="text/javascript">
	function checkUp(){
		$.get("./systemstate", {ts: new Date().getTime()}, function(data){
			if (data == "UP"){
				$('#waitRebooting').fadeOut(200);
				return;
			} else {
				setTimeout("checkUp()", 5000);		
			}
		});
	} 
	
	$("#rebootCommand").click(function(){
		$('#waitRebooting').fadeIn(200);
		$.post("./goform/formCommands", {command:"reboot", ts: new Date().getTime()});
		setTimeout("checkUp();", 10000);
		return false;
	});
</script>