<h1>Access Point Logs</h1>
<p>
This page allows to browse Access Point logs files.
</p>
<div class="frame">
	<h2>Messages Log</h2>
	<pre class="log"><% executeCommand("cat /var/log/messages"); %></pre>
</div>
<div class="frame">
	<h2>Cron Log</h2>
	<pre class="log"><% executeCommand("cat /var/log/cron.log"); %></pre>
</div>
<div class="frame">
	<h2>Boot Log</h2>
	<pre class="log"><% executeCommand("cat /var/log/boot.log"); %></pre>
</div>
<script type="text/javascript">
	$(document).ready(function() {
		$("pre.log").each(function(index, element){
			if ($(this).height()<=150) 
				return;
			pre = $('<div class="rollup"><span></span></div>');
			pre.data("collapsed", false);
			pre.click(function(){
				if ($(this).data("collapsed")){
					$(this).parent().css("height","");
					$(this).children().text("Collapse");
					$(this).addClass('expanded');
				}else{
					$(this).parent().css("height","150px");
					$(this).children().text("Expand");
					$(this).removeClass('expanded');
				}
				$(this).data("collapsed", !$(this).data("collapsed"));
			});
			$(element).prepend(pre);
			pre.click();
		});
	});
</script>