<script type="text/javascript">
	var conntracktablearray =  [<% executeCommand('cat /proc/net/ip_conntrack | sed \'s/^\\(.*\\)$/\\\042\\1\\\042,/g\''); %>""];
</script>

<h1>Connection Tracking Statistics</h1>
<div class="frame">
	<h2>Recent Tracking Data</h2>
	<table id="conntracktable" class="nice">
		<thead>
			<tr>
				<th>Source IP</th>
				<th>Src Port</th>
				<th>Destination IP</th>
				<th>Dst Port</th>
				<th>Protocol</th>
				<th>Status</th>
			</tr>
		</thead>
		<tbody>
		</tbody>
	</table>
</div>
<script type="text/javascript">
	$.each(conntracktablearray,function(index,element){
		if (element=="")
			return;
		_match = element.match(/^([^\s]+)[\s]+[\d]+[\s]+([\d]+)[\s]+([A-Z_]*)/);
		data = {
			protocol : _match[1],
			ttl : _match[2],
			status : _match[3],
			srcip : element.match(/src=([\d]+\.[\d]+\.[\d]+\.[\d]+)/)[1],
			srcport : '',
			dstip : element.match(/dst=([\d]+\.[\d]+\.[\d]+\.[\d]+)/)[1],
			dstport : '',
		};
		if ((p=element.match(/sport=([\d]+)/))) data.srcport = p[1];
		if ((p=element.match(/dport=([\d]+)/))) data.dstport = p[1];
		
		el =  $('<tr class="'+data.protocol+' '+data.status+'"></tr>');
		el.data('info',element);
		el.append('<td>'+data.srcip+'</td><td>'+data.srcport+'</td><td>'+data.dstip+'</td><td>'+data.dstport+'</td><td>'+data.protocol+'</td><td>'+data.status+'</td>');
		$("#conntracktable tbody:last").append(el);
	});
	
	$.getScript("./js/jquery.tablesorter.min.js", function (){$("#conntracktable").tablesorter();});	
</script>