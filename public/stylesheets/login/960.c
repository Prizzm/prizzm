/*
	960 Grid System ~ Core CSS.
	Learn more ~ http://960.gs/

	Licensed under GPL and MIT.
*/

/*
	Forces backgrounds to span full width,
	even if there is horizontal scrolling.
	Increase this if your layout is wider.

	Note: IE6 works fine without this fix.
*/

body {
	min-width: 960px;
}

/* `Containers
----------------------------------------------------------------------------------------------------*/

.container_12,
.container_16 {
	margin-left: auto;
	margin-right: auto;
	width: 960px;
}

/* `Grid >> Global
----------------------------------------------------------------------------------------------------*/

.grid_1,
.grid_2,
.grid_3,
.grid_4,
.grid_5,
.grid_6,
.grid_7,
.grid_8,
.grid_9,
.grid_10,
.grid_11,
.grid_12,
.grid_13,
.grid_14,
.grid_15,
.grid_16 {
	display: inline;
	float: left;
	margin-left: 10px;
	margin-right: 10px;
}

.push_1, .pull_1,
.push_2, .pull_2,
.push_3, .pull_3,
.push_4, .pull_4,
.push_5, .pull_5,
.push_6, .pull_6,
.push_7, .pull_7,
.push_8, .pull_8,
.push_9, .pull_9,
.push_10, .pull_10,
.push_11, .pull_11,
.push_12, .pull_12,
.push_13, .pull_13,
.push_14, .pull_14,
.push_15, .pull_15 {
	position: relative;
}

.container_12 .grid_3,
.container_16 .grid_4 {
	width: 220px;
}

.container_12 .grid_6,
.container_16 .grid_8 {
	width: 460px;
}

.container_12 .grid_9,
.container_16 .grid_12 {
	width: 700px;
}

.container_12 .grid_12,
.container_16 .grid_16 {
	width: 940px;
}

/* `Grid >> Children (Alpha ~ First, Omega ~ Last)
----------------------------------------------------------------------------------------------------*/

.alpha {
	margin-left: 0;
}

.omega {
	margin-right: 0;
}

/* `Grid >> 12 Columns
----------------------------------------------------------------------------------------------------*/

.container_12 .grid_1 {
	width: 60px;
}

.container_12 .grid_2 {
	width: 140px;
}

.container_12 .grid_4 {
	width: 300px;
}

.container_12 .grid_5 {
	width: 380px;
}

.container_12 .grid_7 {
	width: 540px;
}

.container_12 .grid_8 {
	width: 620px;
}

.container_12 .grid_10 {
	width: 780px;
}

.container_12 .grid_11 {
	width: 860px;
}

/* `Grid >> 16 Columns
----------------------------------------------------------------------------------------------------*/

.container_16 .grid_1 {
	width: 40px;
}

.container_16 .grid_2 {
	width: 100px;
}

.container_16 .grid_3 {
	width: 160px;
}

.container_16 .grid_5 {
	width: 280px;
}

.container_16 .grid_6 {
	width: 340px;
}

.container_16 .grid_7 {
	width: 400px;
}

.container_16 .grid_9 {
	width: 520px;
}

.container_16 .grid_10 {
	width: 580px;
}

.container_16 .grid_11 {
	width: 640px;
}

.container_16 .grid_13 {
	width: 760px;
}

.container_16 .grid_14 {
	width: 820px;
}

.container_16 .grid_15 {
	width: 880px;
}

/* `Prefix Extra Space >> Global
----------------------------------------------------------------------------------------------------*/

.container_12 .prefix_3,
.container_16 .prefix_4 {
	padding-left: 240px;
}

.container_12 .prefix_6,
.container_16 .prefix_8 {
	padding-left: 480px;
}

.container_12 .prefix_9,
.container_16 .prefix_12 {
	padding-left: 720px;
}

/* `Prefix Extra Space >> 12 Columns
----------------------------------------------------------------------------------------------------*/

.container_12 .prefix_1 {
	padding-left: 80px;
}

.container_12 .prefix_2 {
	padding-left: 160px;
}

.container_12 .prefix_4 {
	padding-left: 320px;
}

.container_12 .prefix_5 {
	padding-left: 400px;
}

.container_12 .prefix_7 {
	padding-left: 560px;
}

.container_12 .prefix_8 {
	padding-left: 640px;
}

.container_12 .prefix_10 {
	padding-left: 800px;
}

.container_12 .prefix_11 {
	padding-left: 880px;
}

/* `Prefix Extra Space >> 16 Columns
----------------------------------------------------------------------------------------------------*/

.container_16 .prefix_1 {
	padding-left: 60px;
}

.container_16 .prefix_2 {
	padding-left: 120px;
}

.container_16 .prefix_3 {
	padding-left: 180px;
}

.container_16 .prefix_5 {
	padding-left: 300px;
}

.container_16 .prefix_6 {
	padding-left: 360px;
}

.container_16 .prefix_7 {
	padding-left: 420px;
}

.container_16 .prefix_9 {
	padding-left: 540px;
}

.container_16 .prefix_10 {
	padding-left: 600px;
}

.container_16 .prefix_11 {
	padding-left: 660px;
}

.container_16 .prefix_13 {
	padding-left: 780px;
}

.container_16 .prefix_14 {
	padding-left: 840px;
}

.container_16 .prefix_15 {
	padding-left: 900px;
}

/* `Suffix Extra Space >> Global
----------------------------------------------------------------------------------------------------*/

.container_12 .suffix_3,
.container_16 .suffix_4 {
	padding-right: 240px;
}

.container_12 .suffix_6,
.container_16 .suffix_8 {
	padding-right: 480px;
}

.container_12 .suffix_9,
.container_16 .suffix_12 {
	padding-right: 720px;
}

/* `Suffix Extra Space >> 12 Columns
----------------------------------------------------------------------------------------------------*/

.container_12 .suffix_1 {
	padding-right: 80px;
}

.container_12 .suffix_2 {
	padding-right: 160px;
}

.container_12 .suffix_4 {
	padding-right: 320px;
}

.container_12 .suffix_5 {
	padding-right: 400px;
}

.container_12 .suffix_7 {
	padding-right: 560px;
}

.container_12 .suffix_8 {
	padding-right: 640px;
}

.container_12 .suffix_10 {
	padding-right: 800px;
}

.container_12 .suffix_11 {
	padding-right: 880px;
}

/* `Suffix Extra Space >> 16 Columns
----------------------------------------------------------------------------------------------------*/

.container_16 .suffix_1 {
	padding-right: 60px;
}

.container_16 .suffix_2 {
	padding-right: 120px;
}

.container_16 .suffix_3 {
	padding-right: 180px;
}

.container_16 .suffix_5 {
	padding-right: 300px;
}

.container_16 .suffix_6 {
	padding-right: 360px;
}

.container_16 .suffix_7 {
	padding-right: 420px;
}

.container_16 .suffix_9 {
	padding-right: 540px;
}

.container_16 .suffix_10 {
	padding-right: 600px;
}

.container_16 .suffix_11 {
	padding-right: 660px;
}

.container_16 .suffix_13 {
	padding-right: 780px;
}

.container_16 .suffix_14 {
	padding-right: 840px;
}

.container_16 .suffix_15 {
	padding-right: 900px;
}

/* `Push Space >> Global
----------------------------------------------------------------------------------------------------*/

.container_12 .push_3,
.container_16 .push_4 {
	left: 240px;
}

.container_12 .push_6,
.container_16 .push_8 {
	left: 480px;
}

.container_12 .push_9,
.container_16 .push_12 {
	left: 720px;
}

/* `Push Space >> 12 Columns
----------------------------------------------------------------------------------------------------*/

.container_12 .push_1 {
	left: 80px;
}

.container_12 .push_2 {
	left: 160px;
}

.container_12 .push_4 {
	left: 320px;
}

.container_12 .push_5 {
	left: 400px;
}

.container_12 .push_7 {
	left: 560px;
}

.container_12 .push_8 {
	left: 640px;
}

.container_12 .push_10 {
	left: 800px;
}

.container_12 .push_11 {
	left: 880px;
}

/* `Push Space >> 16 Columns
----------------------------------------------------------------------------------------------------*/

.container_16 .push_1 {
	left: 60px;
}

.container_16 .push_2 {
	left: 120px;
}

.container_16 .push_3 {
	left: 180px;
}

.container_16 .push_5 {
	left: 300px;
}

.container_16 .push_6 {
	left: 360px;
}

.container_16 .push_7 {
	left: 420px;
}

.container_16 .push_9 {
	left: 540px;
}

.container_16 .push_10 {
	left: 600px;
}

.container_16 .push_11 {
	left: 660px;
}

.container_16 .push_13 {
	left: 780px;
}

.container_16 .push_14 {
	left: 840px;
}

.container_16 .push_15 {
	left: 900px;
}

/* `Pull Space >> Global
----------------------------------------------------------------------------------------------------*/

.container_12 .pull_3,
.container_16 .pull_4 {
	left: -240px;
}

.container_12 .pull_6,
.container_16 .pull_8 {
	left: -480px;
}

.container_12 .pull_9,
.container_16 .pull_12 {
	left: -720px;
}

/* `Pull Space >> 12 Columns
----------------------------------------------------------------------------------------------------*/

.container_12 .pull_1 {
	left: -80px;
}

.container_12 .pull_2 {
	left: -160px;
}

.container_12 .pull_4 {
	left: -320px;
}

.container_12 .pull_5 {
	left: -400px;
}

.container_12 .pull_7 {
	left: -560px;
}

.container_12 .pull_8 {
	left: -640px;
}

.container_12 .pull_10 {
	left: -800px;
}

.container_12 .pull_11 {
	left: -880px;
}

/* `Pull Space >> 16 Columns
----------------------------------------------------------------------------------------------------*/

.container_16 .pull_1 {
	left: -60px;
}

.container_16 .pull_2 {
	left: -120px;
}

.container_16 .pull_3 {
	left: -180px;
}

.container_16 .pull_5 {
	left: -300px;
}

.container_16 .pull_6 {
	left: -360px;
}

.container_16 .pull_7 {
	left: -420px;
}

.container_16 .pull_9 {
	left: -540px;
}

.container_16 .pull_10 {
	left: -600px;
}

.container_16 .pull_11 {
	left: -660px;
}

.container_16 .pull_13 {
	left: -780px;
}

.container_16 .pull_14 {
	left: -840px;
}

.container_16 .pull_15 {
	left: -900px;
}

img, object, embed {
max-width: 100%;
}

img {
	height: auto;
}

/* `Clear Floated Elements
----------------------------------------------------------------------------------------------------*/

/* http://sonspring.com/journal/clearing-floats */

.clear {
	clear: both;
	display: block;
	overflow: hidden;
	visibility: hidden;
	width: 0;
	height: 0;
}

/* http://www.yuiblog.com/blog/2010/09/27/clearfix-reloaded-overflowhidden-demystified */

.clearfix:before,
.clearfix:after {
	content: '\0020';
	display: block;
	overflow: hidden;
	visibility: hidden;
	width: 0;
	height: 0;
}

.clearfix:after {
	clear: both;
}

/*
	The following zoom:1 rule is specifically for IE6 + IE7.
	Move to separate stylesheet if invalid CSS is a problem.
*/

.clearfix {
	zoom: 1;
}

/* Smaller screens */

@media only screen and (max-width: 1023px) {

	body {
	font-size: 0.8em;
	line-height: 1.5em;
	}
	
	}


/* Mobile */

@media handheld, only screen and (max-width: 767px) {

	body {
	font-size: 16px;
		-webkit-text-size-adjust: none;
	}
	
	body, .container_12 , .container_16{
	width: 100%;
	min-width: 0;
	margin-left: 0px;
	margin-right: 0px;
	padding-left: 0px;
	padding-right: 0px;
	}
	
	.grid_1, .grid_2,.grid_3,.grid_4,.grid_5,.grid_6,.grid_7,.grid_8,.grid_9,.grid_10,.grid_11,.grid_12,.grid_13,.grid_14,.grid_15,.grid_16 {
	width: 100% !important;
	margin-left: 0px;
	margin-right: 0px;
	padding-left: 20px;
	padding-right: 20px;
	}

}