<!doctype html>  

<!--[if lt IE 7 ]> <html lang="en" class="no-js ie6"> <![endif]-->
<!--[if IE 7 ]>    <html lang="en" class="no-js ie7"> <![endif]-->
<!--[if IE 8 ]>    <html lang="en" class="no-js ie8"> <![endif]-->
<!--[if IE 9 ]>    <html lang="en" class="no-js ie9"> <![endif]-->
<!--[if (gt IE 9)|!(IE)]><!--> <html lang="en" class="no-js"> <!--<![endif]-->
<head>
  <meta charset="utf-8">
  <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">

  <title>Prizzm - Your voice about your products</title>
  <meta name="description" content="">
  <meta name="author" content="">

  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <link rel="shortcut icon" href="/favicon.ico">
  <link rel="apple-touch-icon" href="/apple-touch-icon.png">
  
  
  <link rel="stylesheet" href="stylesheets/global.css?v=2">
  <link rel="stylesheet" href="stylesheets/fonts.css?v=2">
  <link rel="stylesheet" href="stylesheets/application.css?v=2">

</head>

<body>
	<div id="prizzmbar"></div>
	
	<div id="container" class="container_24">

    <aside class="grid_5 left">
      <h1 id="logo"><a href="index.php">prizzm</a></h1>
      <div class="userbit">
        <img src="images/me.png" alt="" class="fl thumb" />
        <div class="fl">
          <a class="uname" href="">Geoffrey Chong</a>
          <a href="">Edit Profile</a>
        </div>
        <div class="clear"></div>
      </div>
      
      <nav><ul>
        <li><a class="<?php if($_GET[p] == 'welcome') echo 'active'; ?>" href="?p=welcome">Welcome</a></li>
        <li><a class="<?php if($_GET[p] == 'yourstuff') echo 'active'; ?>" href="?p=yourstuff">Your stuff</a></li>
        <li><a class="<?php if($_GET[p] == 'following') echo 'active'; ?>" href="?p=following">Following</a></li>
        <li><a class="<?php if($_GET[p] == 'public') echo 'active'; ?>" href="?p=public">Public</a></li>
      </ul></nav>
      
    </aside>

    <?php
      if(!$_GET[p]){
        include("yourstuff.php");
      }else{
        include("$_GET[p].php");
      }
    ?>
 
		<div class="clear"></div>
		
	</div> <!-- end of #container -->
	
<footer class="container_24">
	<div id="copyright" class="fl">&copy;2011 Prizzm - <a href="">About</a> - <a href="">Terms</a> - <a href="">Privacy</a></div>
  <ul class="fr">
  	<li><a href="">Dashboard</a> . </li>
  	<li><a href="">Browse</a> . </li>
  	<li><a href="">Profile</a> . </li>
  	<li><a href="">Logout</a></li>
  </ul>
    <div class="clear"></div>
</footer>
  
</body>
</html>