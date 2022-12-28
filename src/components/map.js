import World from "@svg-maps/world";
import SVGMap from "./svg-map";


import React from "react";

function  Home () {
  return (
    <div id="world-map" style={{ height: "100%" }}>
      <SVGMap map={World} />
    </div>
  )
}

export default Home;
