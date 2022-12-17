import './style/App.scss';
import Navbar from "./components/Navbar";
import Footer from "./components/Footer";
import World from '@svg-maps/world';
import { SVGMap } from "react-svg-map";
import './style/map.scss';

function App() {
  return (
    <div className="App">
      < Navbar />
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
