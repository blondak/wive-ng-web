<% executeCommand("wl scan;sleep 5s"); %>
<script type="text/javascript">
	var scanresultsarray =  (<% executeCommand("wl scanresults| sed 's/^$/###break###/g' | sed \'s/\\\042/\\\\\042/g\' |sed 's/^\\(.*\\)$/\\\042\\1####\\\042+/g'");%>"").split("###break###");
	function find(where, what){
		try {
			srch = new RegExp(what+'[\\s]*:[ ]*([^\\s]+)','gi');
			return srch.exec(where)[1].replace(/####/,"");
		} catch(err){
			return "";
		}
	}
	var scanresults = [];
	$.each(scanresultsarray, function (index, element){
		scanresults[scanresults.length] = {
			mode : find(element, "mode"),
			essid : find(element, "essid"),
			bssid : find(element, "bssid"),
			channel : find(element, "channel"),
			band : find(element, "band").replace(/[()]/g,""),
			rssi : find(element, "rssi")+" %",
			signal : find(element, "gnal")+" %",
			encryption : find(element, "encrypt"),
			beacon : find(element, "beacon"),
			preamble : find(element, "preamble"),
			pcf : find(element, "pcf"),
			basicRates : element.match(/Basic Rates:[\s]*([^#]+)/)[1],
			supportedRates : element.match(/Supported Rates:[\s]*([^#]+)/)[1],
			dtim : find(element, "dtim"),
			timestamp : find(element, "tstamp"),
		};
	});
</script>

<h1>Wireless Site Survey</h1>
<p>This page provides a tool to scan the wireless network. By clicking on individual entries in the table you can obtain additional data about detected network.</p>
<div class="frame">
	<h2>Scan Results</h2>
	<table id="scanresults" class="nice">
		<thead>
			<tr>
				<th>ESSID</th>
				<th>Mode</th>
				<th>Band</th>
				<th>Channel</th>
				<th>RSSI</th>
				<th>SQ</th>
				<th>Encrypt</th>
			</tr>
		</thead>
		<tbody>
		</tbody>
	</table>
	<div id="details">
		<table class="nice details">
			<tr><td>SSID:</td><td class="ssid"></td></tr>
			<tr><td>BSSID:</td><td class="bssid"></td></tr>
			<tr><td>Basic Rates [Mbit/s]:</td><td class="basicrates"></td></tr>
			<tr><td>Supported Rates [Mbit/s]:</td><td class="supportedrates"></td></tr>
			<tr><td>Preamble Type:</td><td class="preamble"></td></tr>
			<tr><td>Beacon:</td><td class="beacon"></td></tr>
			<tr><td>Pcf:</td><td class="pcf"></td></tr>
			<tr><td>Dtim:</td><td class="dtim"></td></tr>
			<tr><td>Timestamp:</td><td class="timestamp"></td></tr>
		</table>
	</div>
</div>
<script type="text/javascript">
	$.each(scanresults,function(index,element){
		if (element.mode=="")
			return;
		el =  $('<tr class="'+element.band.replace(/\+/,'')+' encrypt_'+element.encryption+'"></tr>');
		el.data('info',element);
		el.append('<td>'+element.essid+'</td><td>'+element.mode+'</td><td>'+element.band+'</td><td>'+element.channel+'</td><td>'+element.rssi+'</td><td>'+element.signal+'</td><td>'+element.encryption+'</td>');
		$("#scanresults tbody:last").append(el);
		el.bind('click', function(){
			$("#details td.ssid").text($(this).data('info').essid);
			$("#details td.bssid").html(
				$(this).data('info').bssid+" <a href='http://standards.ieee.org/cgi-bin/ouisearch?"+$(this).data('info').bssid.substr(0,8).replace(/:/g,"-")+"'>more info&hellip;</a>"
			);
			$("#details td.basicrates").text($(this).data('info').basicRates);
			$("#details td.supportedrates").text($(this).data('info').supportedRates);
			$("#details td.preamble").text($(this).data('info').preamble);
			$("#details td.beacon").text($(this).data('info').beacon);
			$("#details td.pcf").text($(this).data('info').pcf);
			$("#details td.dtim").text($(this).data('info').dtim);
			$("#details td.timestamp").text($(this).data('info').timestamp);
			$("#details").fadeIn(200);
			$("#details").css("top",($(this).position().top+$(this).height())+"px");
			$("#details").css("left",($(this).position().left+20)+"px");
		});
	});
	$.getScript("./js/jquery.tablesorter.min.js", function (){$("#scanresults").tablesorter( {sortList: [[5,1]]});});	
	detailclose = $("<div class='detailclose'></div>").click(function(){$("#details").fadeOut(200);});
	$("#details").append(detailclose);
</script>