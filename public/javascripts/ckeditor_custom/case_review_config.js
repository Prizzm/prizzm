﻿/*
Copyright (c) 2003-2011, CKSource - Frederico Knabben. All rights reserved.
For licensing, see LICENSE.html or http://ckeditor.com/license
*/

CKEDITOR.editorConfig = function( config )
{
	config.language = 'en';
	// config.uiColor = '#AADC6E';
    config.toolbar = 'CaseReviewToolbar';
    config.width = 538;
    config.height = 250;
 
    config.toolbar_CaseReviewToolbar =
    [
      //{ name: 'document', items : [ 'NewPage','Preview' ] },
      //{ name: 'clipboard', items : [ 'Cut','Copy','Paste','PasteText','PasteFromWord','-','Undo','Redo' ] },
      //{ name: 'editing', items : [ 'Find','Replace','-','SelectAll','-','Scayt' ] },
      //{ name: 'insert', items : [ 'Image','Flash','Table','HorizontalRule','Smiley','SpecialChar','PageBreak'
        //          ,'Iframe' ] },
          //        '/',
      { name: 'styles', items : [ 'Styles','Format' ] },
      { name: 'basicstyles', items : [ 'Bold','Italic','Strike','-','RemoveFormat' ] },
      { name: 'paragraph', items : [ 'NumberedList','BulletedList','-','Outdent','Indent','-','Blockquote' ] },
      //{ name: 'links', items : [ 'Link','Unlink','Anchor' ] },
      //{ name: 'tools', items : [ 'Maximize','-','About' ] }
    ];
};
