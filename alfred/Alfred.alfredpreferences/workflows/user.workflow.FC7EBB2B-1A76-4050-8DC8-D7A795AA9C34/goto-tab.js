#!/usr/bin/env osascript -l JavaScript

function run(args) {
  ObjC.import("stdlib");
  let browser = $.getenv("browser");
  console.log(`Browser is ${browser}`);
  let app = Application(browser);
  let [arg1, arg2, _] = args[0].split(",");
  let windowIndex = parseInt(arg1);
  let tabIndex = parseInt(arg2);
  if (browser == "Safari") {
    run_webkit_based(app, windowIndex, tabIndex);
  } else {
    run_chromium_based(app, windowIndex, tabIndex);
  }
}

function run_chromium_based(app, windowIndex, tabIndex) {
  app.windows[windowIndex].visible = true;
  app.windows[windowIndex].activeTabIndex = tabIndex + 1;
  app.windows[windowIndex].index = 1;
  app.activate();
}

function run_webkit_based(app, windowIndex, tabIndex) {
  let window = app.windows[windowIndex]();
  let tab = window.tabs[tabIndex.toString()]();

  // Important if Safari is in the different desktop
  window.visible = false;
  app.activate();
  window.currentTab = tab;
  // Force tab window to front
  window.visible = true;
}
