<!doctype html>
<html>
<head>

<meta charset="utf-8">

<title>DX SPIDER WEB BASIC CLUSTER XX1XXX</title>

<meta http-equiv="refresh" content="5">

</head>
<style type="text/css">
.console {
  font-family:Courier;
 color: #CCCCCC;
  background: #000000;
  border: 3px double #CCCCCC;
  padding: 10px;
}
</style>

<body>

<table border="0" cellspacing="0" cellpadding="1">
  <tbody style="font-family:'Courier New';font-size:18px;">
    	<tr>
	<td width="80"><h5><b>TIME</b></h5></td>
	<td width="150"><h5><b>FREQ</b></h5></td>
	<td width="150"><h5><b>CALL</b></h5></td>
	<td width="100"><h5><b>SPOTTER</b></h5></td>
	<td><h5><b>COMMENT</b></h5></td>
	</tr>
<?php
#header("Refresh: 5");

include 'db_config_dxspider.php';

#$servername = "cluster-db";
#$username = "sysop";
#$password = "sysop";
#$dbname = "dxcluster";

$unwantedstrings = array("<tr>", "</tr>", "<td>", "</td>", "<b>" , "</b>" , "<br>" , "</br>", "<script>" , "</script>", "<TR>", "</TR>", "<TD>", "</TD>", "<B>" , "</B>" , "<BR>" , "</BR>", "<SCRIPT>" , "</SCRIPT>");

$conn = new mysqli($servername, $username, $password, $dbname, $dbport);
if ($conn->connect_error) { die("SQL ERROR: " . $conn->connect_error); }
else { $sql = "SELECT * FROM spot ORDER BY rowid DESC LIMIT 20;"; }
$result = $conn->query($sql);

if ($result->num_rows > 0) {
    while($row = $result->fetch_assoc()) {
	echo "<tr><td>" . date('H:i', $row["time"]) . "</td><td><b>" . $row["freq"] ."</b></td><td><a href=\"http://www.qrz.com/db/".$row['spotcall']."\" style=\"text-decoration: none\" target=\"_blank\">🌐</a>                                  <b>" . $row["spotcall"] . "</b></td><td>" . $row["spotter"] . "</td><td>" . utf8_decode(str_replace($unwantedstrings,"-",$row["comment"])) . "</td></tr>";
    }
} else {
    echo "0 results";
}
$conn->close();
?>
</tbody>
</table>
<?php echo "Cluster $clustercall - Latest spots";  ?>
<?php echo "</br><small>Webinterface by IZ3MEZ (Copyleft)</small>";  ?>
</body>
</html>

