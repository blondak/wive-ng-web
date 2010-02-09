<h1>Access Point Status</h1>
<div class="frame">
	<h2>System</h2>
	<table class="details">
		<tr><td>Alias Name:</td><td><% executeCommand("/bin/hostname");%></td></tr>
		<tr><td>Uptime:</td><td class="uptime"><span><% executeCommand("cat /proc/uptime | cut -d\\  -f1");%></span></td></tr>
		<tr><td>Kernel:</td><td><% executeCommand("uname -rv");%></td></tr>
	</table>
</div>

<script type="text/javascript">
	var time = parseInt($("td.uptime span").text());
	var ff = [{ text : " sec ", div : 60 },{ text : " min ", div  : 60 },{ text : " hod ", div  : 24 },{ text : " days ", div  : 365 },{ text : " years ", div  : 100000 },];

	var timestr="";	
	$.each(ff, function(index, element){
		if (time>0){
			frac = (time % element.div);
			timestr = frac + element.text+timestr;
			time = (time - frac) / element.div;
		}
	});
	$("td.uptime").text(timestr);
</script>