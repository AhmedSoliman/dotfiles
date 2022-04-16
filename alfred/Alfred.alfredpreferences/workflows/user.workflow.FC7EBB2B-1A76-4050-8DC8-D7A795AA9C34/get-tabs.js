#!/usr/bin/env osascript -l JavaScript

const browsers = new Map();
browsers.set("Google Chrome", "1EF5C902-0F47-47F1-BCBB-5BA273DE5101.png");
browsers.set("Safari", "safari.png");
browsers.set("Brave Browser", "brave.png");
browsers.set("Microsoft Edge", "edge.png");

function run(args) {
  var lookup_browsers = browsers.keys();
  if (args.length >= 1) {
    if (!browsers.has(args[0])) {
      console.log(`Unknown browser ${args[0]}!`);
      return JSON.stringify({
        variables : {},
        items : [],
      });
    }
    lookup_browsers = [ args[0] ];
  }

  let tabs = [];
  for (const browser of lookup_browsers) {
    console.log(`Checking browser ${browser}!`);
    let icon = browsers.get(browser);
    try {
      if (Application(browser).running()) {
        populateForBrowser(tabs, browser, icon);
      }
    } catch (err) {
      console.log(`[NOTE] Not getting browser tabs from ${browser}:`, err);
    }
  }

  return JSON.stringify({
    variables : {},
    items : tabs,
  });
}

function populateForBrowser(tabs, browser, icon) {
  let app = Application(browser);
  app.includeStandardAdditions = true;
  let windowCount = app.windows.length;
  let tabsTitle = browser === "Safari" ? app.windows.tabs.name()
                                       : app.windows.tabs.title();
  let tabsUrl = app.windows.tabs.url();

  for (let w = 0; w < windowCount; w++) {
    for (let t = 0; t < tabsTitle[w].length; t++) {
      let url = tabsUrl[w][t] || "";
      let matchUrl = url.replace(/(^\w+:|^)\/\//, "");
      let title = tabsTitle[w][t] || matchUrl;

      tabs.push({
        title,
        url,
        subtitle : url,
        windowIndex : w,
        tabIndex : t,
        quicklookurl : url,
        variables : {"browser" : browser},
        icon : {
          "path" : icon,
        },
        arg : `${w},${t},${url}`,
        match : `${title} ${
            decodeURIComponent(matchUrl).replace(
                /[^\w]/g,
                " ",
                )}`,
      });
    }
  }
}
