import { World } from "../maps/world";
import DemoMap from "./DemoMap";
import React from "react";

function Demo() {
  return (
    <div id="world-map" style={{ height: "100%" }}>
      <DemoMap map={World} />
    </div>
  );
}

export default Demo;
