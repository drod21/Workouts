

import * as React from "react";
import LogoSvg from "./logo.svg";
import * as About$MyRescriptApp from "./Pages/About/About.bs.js";
import * as RescriptReactRouter from "@rescript/react/src/RescriptReactRouter.bs.js";
import * as Exercises$MyRescriptApp from "./Pages/Exercises/Exercises.bs.js";

import './App.css';
;

var logo = LogoSvg;

function App$Default(Props) {
  return React.createElement("div", undefined, React.createElement("h1", undefined, "Hello, world!"), React.createElement("p", undefined, "This is a simple example of a React component."), React.createElement("p", undefined, "For more info, see ", React.createElement("a", {
                      href: "https://reactjs.org",
                      target: "_blank"
                    }, "https://reactjs.org")));
}

var Default = {
  make: App$Default
};

function App(Props) {
  var url = RescriptReactRouter.useUrl(undefined, undefined);
  var match = url.path;
  if (!match) {
    return React.createElement(App$Default, {});
  }
  switch (match.hd) {
    case "about" :
        if (!match.tl) {
          return React.createElement(About$MyRescriptApp.make, {});
        }
        break;
    case "exercises" :
        if (!match.tl) {
          return React.createElement(Exercises$MyRescriptApp.make, {});
        }
        break;
    default:
      
  }
  return React.createElement("div", undefined, "404");
}

var make = App;

export {
  logo ,
  Default ,
  make ,
  
}
/*  Not a pure module */
