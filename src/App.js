import React, { Suspense, lazy } from 'react';
import "./style/App.scss";
import Navbar from "./components/Navbar";
import Footer from "./components/Footer";
import { useState } from "react";
import { BrowserRouter as Router, Route, Routes, } from "react-router-dom";
import "./style/map.scss";


const About = lazy(() => import('./components/About'));
const Home = lazy(() => import ('./components/map'));


function App() {
  return (
    <div className="App">
      <Navbar />
      <Router>
        <Routes>
          <Route path="/about" element={<About />}/>
          <Route path="/" element={<Home />}/>
        </Routes>
    </Router>
    </div>
  );
}

export default App;
