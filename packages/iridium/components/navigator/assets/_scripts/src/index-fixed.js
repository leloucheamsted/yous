//
//  Copyright 2021 Readium Foundation. All rights reserved.
//  Use of this source code is governed by the BSD-style license
//  available in the top-level LICENSE file of the project.
//

// Script used for fixed layouts resources.

import "./index";

/*eslint no-unused-vars: ["error", { "args": "none" }]*/
readium.setBookmarkIndexes = function (bookmarkIndexes) {};

var originalScale = 1;
var initialScaleIsInit = false;

// On ios visualviewport is not set until the webview really show for the first time
// and resize event is called when it happens...
// but ... it can be called several time, with differents values in visualViewport
var trySetupInitialScale = function()
{
    // On some phone and with some publication, viewport and screen doesn't have same size, causing page to be cropped
    // we need to apply some transform on html to fix this
    // That kind of fix already existed in previous readium library but in even more complex way, so maybe this one doesn't handle all cases
    var viewportScaleWidth = window.visualViewport.width / document.documentElement.clientWidth;
    var viewportScaleHeight = window.visualViewport.height / document.documentElement.clientHeight;
    var viewportScale = Math.min(viewportScaleWidth, viewportScaleHeight);
    originalScale = window.visualViewport.scale;

    if (viewportScale > 0)
    {
        var htmlTags = document.getElementsByTagName("html");
        if (htmlTags.length > 0) // should always be true
        {
            var htmlTag = htmlTags[0];
            htmlTag.style.transform = "scale(" + viewportScale + ")";
            htmlTag.style.transformOrigin = "0 0";
            htmlTag.style.minWidth = window.visualViewport.width + "px";
            htmlTag.style.minHeight = window.visualViewport.height  + "px";
        }
    }
}

// we don't want to allow to go on next page when page is zoomed in
window.visualViewport.addEventListener("resize", () => {
    if (!initialScaleIsInit) {
        trySetupInitialScale();
    }
    else {
        let ratio = Math.round((window.visualViewport.scale / originalScale) * 100);
        flutter.onLeftOverlayVisibilityChanged(
            ratio == 100
        );
        flutter.onRightOverlayVisibilityChanged(
            ratio == 100
        );
    }
});

window.addEventListener("load", (event) => {
    var body = document.getElementsByTagName('body')[0];
    body.addEventListener('touchstart', function() {
        initialScaleIsInit = true;
    });
});



readium.initPagination = function () {
    trySetupInitialScale();
    document.fonts.ready.then(async function () {
      /** set visibility to true on loading **/
      flutter.onLeftOverlayVisibilityChanged(true);
      flutter.onRightOverlayVisibilityChanged(true);   
    });
  };
