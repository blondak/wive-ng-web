<script type="text/javascript">
	var arp=<% executeCommand("echo '['; tail -n+2 /proc/net/arp | awk '{ mac=$4;gsub(/:/,\"\",mac);print \"{mac:\\042\"mac\"\\042,ip:\\042\"$1\"\\042},\" }';echo ']'");%>;
	var sta=<% executeCommand("echo '['; wl sta |tail -n+2 | awk '{ print \"{aid:\\042\"$1\"\\042,bssid:\\042\"$2\"\\042,rssi:\\042\"$3\"\\042,dB:\\042\"$5\"\\042,TxPackets:\\042\"$6\"\\042,RxPackets:\\042\"$7\"\\042,TxFail:\\042\"$8\"\\042,TxRate:\\042\"$9\"\\042,RxRate:\\042\"$10\"\\042},\"}';echo ']'");%>;
</script>
<h1>Active Wireless Client Table</h1>
<p>This table shows device's address, and connection state information for each associated wireless client.</p>
<div class="frame">
	<h2>Wireless Clients</h2>
	<table id="arptable" class="nice">
		<thead>
			<tr>
				<th>BSSID</th>
				<th>IP</th>
				<th>rssi</th>
				<th>dB</th>
				<th>TxPkts</th>
				<th>RxPkts</th>
				<th>TxFail</th>
				<th>TxRate</th>
				<th>RxRate</th>
			</tr>
		</thead>
		<tbody>
		</tbody>
	</table>
	<div id="details">
		<table class="nice details">
			<tr><td>BSSID:</td><td class="bssid"></td></tr>
			<tr><td>IP:</td><td class="ip"></td></tr>
			<tr><td>rssi:</td><td class="rssi"></td></tr>
			<tr><td>dB:</td><td class="dB"></td></tr>
			<tr><td>Tx Packets:</td><td class="TxPackets"></td></tr>
			<tr><td>Rx Packets:</td><td class="RxPackets"></td></tr>
			<tr><td>TxFail:</td><td class="TxFail"></td></tr>
			<tr><td>TxRate:</td><td class="TxRate"></td></tr>
			<tr><td>RxRate:</td><td class="RxRate"></td></tr>
		</table>
	</div>
	
</div>
<script type="text/javascript">
	function lookupARP(mac){
		var result;
		$.each(arp, function(index,element){
			if (element.mac.toLowerCase() == mac.toLowerCase()) 
				result = element;
		});
		return result;
	}
	$.each(sta,function(index,element){
		if (!(element.aid > 0))
			return;
		ip = lookupARP(element.bssid);
		if (ip && ip.ip)
			ip = ip.ip;
		else
			ip="unknown";
		el = $('<tr></tr>');
		el.data('info',element);
		el.data('ip',ip);
		el.append('<td>'+
			element.bssid+'</td><td>'+ip+'</td><td>'+element.rssi+'%</td><td>'+
			element.dB+'</td><td>'+element.TxPackets+'</td><td>'+element.RxPackets+'</td><td>'+
			element.TxFail+'</td><td>'+element.TxRate+'</td><td>'+element.RxRate+'</td>'
		);
		$("#arptable tbody:last").append(el);
		el.bind('click', function(){
			$("#details td.bssid").html(
				$(this).data('info').bssid+" <a href='http://standards.ieee.org/cgi-bin/ouisearch?"+$(this).data('info').bssid.substr(0,6).replace(/(..)(..)(..)/g,"$1-$2-$3")+"'>more info&hellip;</a>"
			);
			$("#details td.ip").text($(this).data('ip'));
			$("#details td.rssi").text($(this).data('info').rssi+" %");
			$("#details td.dB").text($(this).data('info').dB);
			$("#details td.TxPackets").text($(this).data('info').TxPackets);
			$("#details td.RxPackets").text($(this).data('info').RxPackets);
			$("#details td.TxFail").text($(this).data('info').TxFail);
			$("#details td.TxRate").text($(this).data('info').TxRate);
			$("#details td.RxRate").text($(this).data('info').RxRate);
			$("#details").fadeIn(200);
			$("#details").css("top",($(this).position().top+$(this).height())+"px");
			$("#details").css("left",($(this).position().left+20)+"px");
		});
		
	});
	
	$.getScript("./js/jquery.tablesorter.min.js", function (){$("#arptable").tablesorter();});
	detailclose = $("<div class='detailclose'></div>").click(function(){$("#details").fadeOut(200);});
	$("#details").append(detailclose);
</script>