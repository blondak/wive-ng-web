<script type="text/javascript">
	var dhcp=<% executeCommand("echo '['; dumpleases | tail -n+2 | awk '{ print \"{mac:\\042\"$1\"\\042,ip:\\042\"$2\"\\042,hostname:\\042\"$3\"\\042,expire:\\042\"$4\"\\042},\" }';echo ']'");%>;
</script>
<h1>Active DHCP Client Table</h1>
<p>This table shows the assigned IP address, MAC address and a lease expire time for each DHCP client.</p>
<div class="frame">
	<h2>DHCP Clients</h2>
	<table id="dhcptable" class="nice">
		<thead>
			<tr>
				<th>IP Address</th>
				<th>Hostname</th>
				<th>MAC Address</th>
				<th>Expire Time</th>
			</tr>
		</thead>
		<tbody>
		</tbody>
	</table>
	<div id="details">
		<table class="nice details">
			<tr><td>IP Address:</td><td class="ip"></td></tr>
			<tr><td>Hostname:</td><td class="hostname"></td></tr>
			<tr><td>MAC Address:</td><td class="mac"></td></tr>
			<tr><td>Expire Time:</td><td class="expire"></td></tr>
		</table>
	</div>
</div>
<script type="text/javascript">
	$.each(dhcp,function(index,element){
		el = $('<tr></tr>');
		el.append('<td>'+element.ip+'</td><td>'+element.hostname+'</td><td>'+element.mac+'</td><td>'+element.expire+'</td>');
		el.data('info',element);
		$("#dhcptable tbody:last").append(el);
		el.bind('click', function(){
			$("#details td.ip").text($(this).data('info').ip);
			$("#details td.hostname").text($(this).data('info').hostname);
			$("#details td.mac").html(
				$(this).data('info').mac+" <a href='http://standards.ieee.org/cgi-bin/ouisearch?"+$(this).data('info').mac.substr(0,8).replace(/:/g,"-")+"'>more info&hellip;</a>"
			);
			$("#details td.expire").text($(this).data('info').expire);
			$("#details").fadeIn(200);
			$("#details").css("top",($(this).position().top+$(this).height())+"px");
			$("#details").css("left",($(this).position().left+20)+"px");
		});
	});

	$.getScript("./js/jquery.tablesorter.min.js", function (){$("#dhcptable").tablesorter();});	
	detailclose = $("<div class='detailclose'></div>").click(function(){$("#details").fadeOut(200);});
	$("#details").append(detailclose);
</script>