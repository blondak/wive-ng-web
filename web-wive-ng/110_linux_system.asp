<% language=javascript %> 
<h1>Access Point Status</h1>
<div class="frame">
	<h2>Interface Configuration</h2>
	<pre><% executeCommand("export LANG=C; echo 'Settings: ';echo;/sbin/ifconfig;/sbin/route -n");%></pre>
</div>

<div class="frame">
	<h2>Wireless Configuration</h2>
	<pre><% executeCommand("cat /proc/wlan0/mib_staconfig");%></pre>
</div>

<div class="frame">
	<h2>MAC table</h2>
	<pre><% executeCommand("cat /proc/net/arp");%></pre>
</div>

<div class="frame">
	<h2>Process List</h2>
	<pre><% executeCommand("ps w");%></pre>
</div>

<div class="frame">
	<h2>Memory Information</h2>
	<pre><% executeCommand("free");%></pre>
</div>

<div class="frame">
	<h2>Filesystem Information</h2>
	<pre><% executeCommand("export LANG=C; /bin/df -h");%></pre>
</div>
