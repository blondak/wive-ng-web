<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd"> 
<html xmlns="http://www.w3.org/1999/xhtml"> 
<head>
	<meta http-equiv="Content-type" content="text/html; charset=UTF-8">
	<link href="./css/main.css" rel="stylesheet" type="text/css">
	<script type="text/javascript" src="./js/jquery.js"></script>
	<title>Wive-ng</title>
	<script>
		$(document).ready(function() {
			$('#menu a').each(function(index, element){
				element.id = element.href.match(/#([\d]{3})_/)[1];
			});
			$('#menu a').bind('click',function(event){
				$('#loading span').html($(this).attr("title")==""?$(this).attr("title")=="":'"'+$(this).html()+'"');
				$('#ajaxContent').load($(this).attr("href").substring(1));
			});		
			$("#loading").bind("ajaxSend", function(event, request, settings){
				if (! settings.url.match(/^[\d]{3}/))
					return;
				$("#ajaxError").hide();
				$(this).show();
			}).bind("ajaxComplete", function(event, request, settings){
				if (! settings.url.match(/^[\d]{3}/))
					return;
				$(this).hide();
			}).bind("ajaxSuccess", function(event, request, settings){
				if (! settings.url.match(/^[\d]{3}/))
					return;
				$('#menu a').each(function(index, el) {
					if (settings.url.substring(0,3) == el.id){
						$(el).addClass('active');
					} else {
						$(el).removeClass('active');
					}
  				});
			});
			$("#ajaxError").bind("ajaxError", function(event, request, settings){
				$(this).prepend("<p>Error requesting page " + settings.url + "</p>");
				$(this).fadeIn(200).delay(2000).fadeOut(200);
			});
			var _doc = unescape(self.document.location.hash.substring(0,4));
			if (_doc == "")
				_doc = "#100";
			$(_doc).click();
		});		
	</script>
</head>
<body>
	<div class="container">
		<div id="header"></div>
	</div>
	<div class="container bg">
		<div id="menu">
			<div>
				<h3>STATUS</h3>
				<a href="#100_ap_status.asp" title="AP Status">AP Status</a>
				<a href="#110_linux_system.asp" title="Linux System">Linux System</a>
				<a href="#120_active_clients.asp" title="Active Clients">Active Clients</a>
				<a href="#130_dhcp_clients.asp" title="DHCP Clients">DHCP Clients</a>
				<a href="#140_site_survey.asp" title="Site Survey">Site Survey</a>
				<a href="#150_conn_track.asp" title="Connection Tracking">Conn. Tracking</a>
			</div>
			<div>
  				<h3>WIRELESS</h3>			
				<a href="#200_wlan_basic.asp" title="WLAN Basic Settings" class="noyet">Basic Settings</a>
				<a href="#210_wlan_advanced.asp" title="WLAN Advanced Settings" class="noyet">Advanced Settings</a>
				<a href="#220_wlan_security.asp" title="WLAN Security Settings" class="noyet">Security</a>
				<a href="#230_wlan_acl.asp" title="WLAN Access Control Settings" class="noyet">Access Control</a>
				<a href="#240_wlan_wds.asp" title="WLAN WDS Settings" class="noyet">WDS Settings</a>
			</div>
			<div>
				<h3>TCP/IP</h3>
				<a href="#300_tcpip_basic.asp" title="TCP/IP Basic Settings" class="noyet">Basic Settings</a>
				<a href="#310_tcpip_advanced.asp" title="TCP/IP Advanced Settings" class="noyet">Advanced Settings</a>
				<a href="#314_enh_ip.asp" title="Enhanced IP Settings" class="noyet">Enhanced IP</a>
				<a href="#317_enh_rout.asp" title="Enhanced Routing Settings" class="noyet">Enhanced Routing</a>
				<a href="#320_tcpip_dhcp.asp" title="DHCP Settings" class="noyet">DHCP Settings</a>
				<a href="#330_tcpip_firewall.asp" title="Firewall Settings" class="noyet">Firewall</a>
				<a href="#340_tcpip_pppoe.asp" title="PPPoE Settings" class="noyet">PPPoE Settings</a>
				<a href="#350_tcpip_pforward.asp" title="Port Forwarding Settings" class="noyet">Port Forwarding</a>
				<a href="#360_tcpip_qos.asp" title="Quality of Service Settings" class="noyet">Quality of Service</a>
				<a href="#370_tcpip_tmanager.asp" title="Traffic Manager Settings" class="noyet">Traffic Manager</a>
			</div>
			<div>
				<h3>OTHER</h3>
				<a href="#400_reboot.asp" title="Reboot System">Reboot</a>
				<a href="#410_firmware_config.asp" title="Firmware / Configuration Management" class="noyet">Firmware / Config</a>
				<a href="#420_password_change.asp" title="Password Change" class="noyet">Password Change</a>
				<a href="#430_system_settings.asp" title="System Settings" class="noyet">System Settings</a>
				<a href="#440_browse_logs.asp" title="Browse Logs">Browse Logs</a>
			</div>
			<div>
				<h3>STATISTICS</h3>
				<a href="#500_stats.asp" title="Data Transfer Statistics" class="noyet">Transfer Statistics</a>
				<a href="#510_tm_stats.asp" title="Traffic Manager Statistics" class="noyet">TM Statistics</a>
			</div>
		</div>
		<div class="maincontent">
			<div id="maincontent">
				<div id="loading" class="loading">
					<h2>Loading page <span></span>...</h2>
				</div>
				<div id="ajaxError">
				</div>
				<div id="ajaxContent">
				</div>
			</div>
		</div>
		<div class="cleaner"></div>
	</div>
	<div class="container">
		<div id="footer"></div>
	</div>
</body>
</html>
