<link rel="stylesheet" href="stylesheets/dashboard.css?v=2">

<aside class="grid_5 left">
  
  <div class="userbit">
    <img src="images/me.png" alt="" class="fl thumb" />
    <div class="fr">
      <a class="uname" href="">Geoffrey Chong</a>
      <a href="">Edit Profile</a>
    </div>
    <div class="clear"></div>
  </div>
  
  <nav>
    <a href="">Welcome</a>
    <ul>
      <li><a class="active" href="">Live Feed</a></li>
      <li><a href="?page=products">Products</a></li>
      <li><a href="">Brands</a></li>
      <li><a href="">People</a></li>
      <li><a href="">Cases</a></li>
    </ul>
  	<ul>
  		<li><a href="">Tags</a></li>
  	</ul>
  </nav>
  
</aside>

<div id="content" class="grid_14">

<nav class="action-menu">
	<ul>
		<li>category: <a class="active" href="">Have</a> <a href="">Want</a> <a href="">New</a></li>
		<li> - <a href="">Open Case</a></li>
	</ul>
</nav>

<form class="action table addhave" action="">
    <input type="text" placeholder="Item name" />
    <input type="text" placeholder="Add a URL" />
    <div id="url_preview">
      <div id="img_selector_parent" style="display: block; ">
        <table class="fl">
          <tbody>
          <tr>
            <td align="center" id="img_selector"><img src="http://i.dell.com/images/global/brand/ui/storm80/logo80.gif"></td>
          </tr>
          <tr>
            <td align="center" id="img_controls">
              <button disabled="disabled" id="prev_image">&lt;</button>
              <button id="next_image">&gt;</button>
            </td>
          </tr>
          </tbody>
        </table>
        <textarea class="fr" name="" id="" placeholder="What did you think of this product?"></textarea>
        <div class="clear"></div>
      </div>
    </div>
    <input type="submit" class="button blue" value="save" />
    <input type="submit" class="button" id="clear_item_fields" value="clear" />
</form>


<!-- A feed of updates from the people you are following -->
<ul class="fol-f table">
  <!-- post-like structure when a user adds an item to their have/want list or opens a new case -->
	<li class="rv row">
		<div class="user cell">
      <a href="">
      <img src="images/me.png" alt="" />
      <span class="uname">Sidney</span>
      </a>
    </div>
		<div class="post cell">
      <h1>Hermann Mini Review</h1>
      Lorem ipsum dolor sit amet, consectetur adipiscing elit. Praesent congue mi sed ante pellentesque ultricies. Curabitur eget diam nisl, vitae egestas nulla. Nunc at arcu tellus. Proin egestas tincidunt convallis. Mauris porttitor, enim eget pellentesque tempus, arcu mi eleifend magna, id consequat erat nibh a arcu. Vestibulum a erat vel sem rhoncus auctor. Morbi mattis, mi sit amet elementum adipiscing, turpis diam egestas risus, sit amet ultricies tellus dolor sit amet nunc. Quisque vitae erat eu tellus lacinia suscipit. Donec auctor justo ut ligula accumsan porttitor. Donec euismod, tortor ac porta rutrum, turpis odio faucibus enim, nec convallis enim ligula fringilla risus. Phasellus metus elit, elementum ut ultricies aliquam, tempor consectetur lectus. In at erat eros. In enim est, blandit vel ullamcorper sit amet, accumsan sit amet est.
      <div class="footerbit">Added Yesterday | <a href="">10 Comments</a></div>
    </div>
	</li>
  
  <!--
    activity updates from people you follow:
    - when they follow new people
    - when they comment on items/products
  -->
  <li class="activ row">
		<div class="user cell">
      <a href="">
      <img src="images/me.png" alt="" />
      </a>
    </div>
		<div class="post cell"><a href="">Charles</a> is now following <a href="">Sidney Burks</a></div>
	</li>
  
  <li class="activ row">
		<div class="user cell">
      <a href="">
      <img src="images/me.png" alt="" />
      </a>
    </div>
		<div class="post cell"><a href="">Charles</a> is now following <a href="">Sidney Burks</a></div>
	</li>
  
  <li class="activ row">
		<div class="user cell">
      <a href="">
      <img src="images/me.png" alt="" />
      </a>
    </div>
		<div class="post cell"><a href="">Charles</a> is now following <a href="">Sidney Burks</a></div>
	</li>
  
  <li class="rv row">
		<div class="user cell">
      <a href="">
      <img src="images/me.png" alt="" />
      <span class="uname">Charles</span>
      </a>
    </div>
		<div class="post cell">
      <!-- When the item has a product associated this section is added to the post -->
      <div class="product">
        <div class="fl">
          <img src="images/hermann.jpg" alt="" />
        </div>
        <div class="fr">
          <h2><a href="">Hermann Mini</a></h2>
          <!-- Short product description -->
          Lorem ipsum dolor sit amet, consectetur adipiscing elit. Praesent congue mi sed ante pellentesque ultricies. Curabitur eget diam nisl, vitae egestas nulla. Nunc at arcu tellus. Proin egestas tincidunt convallis.
        </div>
        <div class="clear"></div>
        <ul class="p-act">
        	<li><a href="">view product</a></li>
        	<li><a href="">i have this</a></li>
        	<li><a href="">i want this</a></li>
        </ul>
      </div>
      
      <h1>Hermann Mini Review</h1>
      Lorem ipsum dolor sit amet, consectetur adipiscing elit. Praesent congue mi sed ante pellentesque ultricies. Curabitur eget diam nisl, vitae egestas nulla. Nunc at arcu tellus. Proin egestas tincidunt convallis. Mauris porttitor, enim eget pellentesque tempus, arcu mi eleifend magna, id consequat erat nibh a arcu. Vestibulum a erat vel sem rhoncus auctor. Morbi mattis, mi sit amet elementum adipiscing, turpis diam egestas risus, sit amet ultricies tellus dolor sit amet nunc. Quisque vitae erat eu tellus lacinia suscipit. Donec auctor justo ut ligula accumsan porttitor. Donec euismod, tortor ac porta rutrum, turpis odio faucibus enim, nec convallis enim ligula fringilla risus. Phasellus metus elit, elementum ut ultricies aliquam, tempor consectetur lectus. In at erat eros. In enim est, blandit vel ullamcorper sit amet, accumsan sit amet est.
      <div class="footerbit">Added Yesterday</div>
      <!-- Inline comments? -->
      <a class="collapse-comm" href="">collapse 5 comments</a>
      <ul class="comms">
      	<li class="row">
      		<div class="cell img"><a href=""><img src="images/me.png" class="smallthumb" alt="" /></a></div>
      		<div class="cell cont">Donec euismod, tortor ac porta rutrum, turpis odio faucibus enim, nec convallis enim ligula fringilla risus. Phasellus metus elit, elementum ut ultricies aliquam, tempor consectetur lectus. In at erat eros. In enim est, blandit vel ullamcorper sit amet, accumsan sit amet est.
          <div class="comm-ft"><a href="">reply</a></div>
          </div>
          <div class="clear"></div>
      	</li>
        <li class="row">
      		<div class="cell img"><a href=""><img src="images/me.png" class="smallthumb" alt="" /></a></div>
      		<div class="cell cont">Donec euismod, tortor ac porta rutrum, turpis odio faucibus enim, nec convallis enim ligula fringilla risus. Phasellus metus elit, elementum ut ultricies aliquam, tempor consectetur lectus. In at erat eros. In enim est, blandit vel ullamcorper sit amet, accumsan sit amet est.
          <div class="comm-ft"><a href="">reply</a></div>
          </div>
          <div class="clear"></div>
      	</li>
          <li class="row reply">
            <div class="cell img"><a href=""><img src="images/me.png" class="smallthumb" alt="" /></a></div>
            <div class="cell cont">Donec euismod, tortor ac porta rutrum, turpis odio faucibus enim, nec convallis enim ligula fringilla risus. Phasellus metus elit, elementum ut ultricies aliquam, tempor consectetur lectus. In at erat eros. In enim est, blandit vel ullamcorper sit amet, accumsan sit amet est.
            <div class="comm-ft"><a href="">reply</a></div>
            </div>
            <div class="clear"></div>
          </li>
          <li class="row reply">
            <div class="cell img"><a href=""><img src="images/me.png" class="smallthumb" alt="" /></a></div>
            <div class="cell cont">Donec euismod, tortor ac porta rutrum, turpis odio faucibus enim, nec convallis enim ligula fringilla risus. Phasellus metus elit, elementum ut ultricies aliquam, tempor consectetur lectus. In at erat eros. In enim est, blandit vel ullamcorper sit amet, accumsan sit amet est.
            <div class="comm-ft"><a href="">reply</a></div>
            </div>
            <div class="clear"></div>
          </li>
        <li class="row">
      		<div class="cell img"><a href=""><img src="images/me.png" class="smallthumb" alt="" /></a></div>
      		<div class="cell cont">Donec euismod, tortor ac porta rutrum, turpis odio faucibus enim, nec convallis enim ligula fringilla risus. Phasellus metus elit, elementum ut ultricies aliquam, tempor consectetur lectus. In at erat eros. In enim est, blandit vel ullamcorper sit amet, accumsan sit amet est.
          <div class="comm-ft"><a href="">reply</a></div>
          </div>
          <div class="clear"></div>
      	</li>
      </ul>
      <form class="in-comm" action="">
        <input type="text" placeholder="comment" />
        <input type="submit" class="button blue" value="Post" />
        <a href="" class="button">Cancel</a>
        <div class="clear"></div>
      </form>
    </div>
	</li>
  
  <li class="rv row">
		<div class="user cell">
      <a href="">
      <img src="images/me.png" alt="" />
      <span class="uname">Sidney</span>
      </a>
    </div>
		<div class="post cell">
      <h1>Hermann Mini Review</h1>
      Lorem ipsum dolor sit amet, consectetur adipiscing elit. Praesent congue mi sed ante pellentesque ultricies. Curabitur eget diam nisl, vitae egestas nulla. Nunc at arcu tellus. Proin egestas tincidunt convallis. Mauris porttitor, enim eget pellentesque tempus, arcu mi eleifend magna, id consequat erat nibh a arcu. Vestibulum a erat vel sem rhoncus auctor. Morbi mattis, mi sit amet elementum adipiscing, turpis diam egestas risus, sit amet ultricies tellus dolor sit amet nunc. Quisque vitae erat eu tellus lacinia suscipit. Donec auctor justo ut ligula accumsan porttitor. Donec euismod, tortor ac porta rutrum, turpis odio faucibus enim, nec convallis enim ligula fringilla risus. Phasellus metus elit, elementum ut ultricies aliquam, tempor consectetur lectus. In at erat eros. In enim est, blandit vel ullamcorper sit amet, accumsan sit amet est.
      <div class="footerbit">Added Yesterday | <a href="">10 Comments</a></div>
    </div>
	</li>
  
</ul>

<!-- If the user isn't following anyone -->
<div class="empt-f">
  You aren't following anyone yet!<br />
  <a href="">Find friends and other people</a>
</div>

</div>

<aside class="grid_5 right">
  <article>
    <h4>Following 28</h4>
    <ul class="usergal">
    	<li><img src="images/me.png" alt="" class="smallthumb" /></li>
    	<li><img src="images/me.png" alt="" class="smallthumb" /></li>
    	<li><img src="images/me.png" alt="" class="smallthumb" /></li>
    	<li><img src="images/me.png" alt="" class="smallthumb" /></li>
      <li><img src="images/me.png" alt="" class="smallthumb" /></li>
    </ul>
  </article>
</aside>

<div class="clear"></div>  