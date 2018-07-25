<html>
<head>
	<link rel="stylesheet"type="text/css"href="viewer.css"media="all">
	<script>
	<!--

	// -->
	</script>
	<meta http-equiv="Content-Type" content="text/html; charset=EUC-JP">
	<?php
	if($_GET['link']==""){
		$now_contents="home";
	}
else{$now_contents=trim($_GET['link']);}
	?>
</head>
<body>
	<div class="header">
		<span class="header"><a href="./show_detail.php">Github Trend Viewer</a></span>

		</br>
		<font class="contents"><?php echo"contents :  ".$now_contents; ?></font>
		</br></br>
		</div>
</br>
	</div>
</body>
