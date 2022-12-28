import "./style/App.scss";
import Navbar from "./components/Navbar";
<<<<<<< HEAD
import World from "./maps/world";
=======
import Footer from "./components/Footer";
import { World } from "./maps/world";
>>>>>>> 3d670f5bb0825b8836e052e4f0eb99988b190344
import SVGMap from "./components/svg-map";

import "./style/map.scss";

function App() {
  return (
    <div className="App">
      <Navbar />
      {/* <header className="App-header">
        Where to next?
      </header> */}
      <div id="world-map" style={{ height: "100%" }}>
        <SVGMap map={World} />
      </div>
    </div>
  );
}

export default App;
