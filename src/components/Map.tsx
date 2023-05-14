import { World } from "../maps/world";
import SVGMap from "./svg-map";
import React from "react";

function Map(): JSX.Element {
  return (
    <div id="world-map" style={{ height: "100%" }}>
      <SVGMap map={World} />
    </div>
  );
}

export default Map;
