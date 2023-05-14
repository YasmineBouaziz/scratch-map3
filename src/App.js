import React from "react";
import "./style/App.scss";
import Navbar from "./components/Navbar";
import {
  BrowserRouter as Router,
  Route,
  Routes,
  Navigate,
} from "react-router-dom";
import "./style/map.scss";
import Home from "./components/map";
import About from "./components/About";
import Login from "./components/Login";
import Logout from "./components/Logout";
import Demo from "./components/Demo";
import Signup from "./components/Signup";
import { ToastContainer, toast } from "react-toastify";
import "react-toastify/dist/ReactToastify.css";

const RequireAuth = ({ children }) => {
  const isAuthenticated = localStorage.getItem("jwtToken") != null;
  if (!isAuthenticated) {
    toast.error("You must be logged in to access your map", {
      toastId: "error",
    });
    return <Navigate to="/login" />;
  }
  return children;
};

const App = () => {
  const isAuthenticated = localStorage.getItem("jwtToken") != null;

  return (
    <div className="App">
      <Navbar />
      <ToastContainer />
      <Router>
        <Routes>
          <Route
            path="/"
            element={
              isAuthenticated ? (
                <Navigate to="/map" />
              ) : (
                <Navigate to="/login" />
              )
            }
          />
          <Route path="/login" element={<Login />} />
          <Route path="/signup" element={<Signup />} />
          <Route path="/about" element={<About />} />
          <Route path="/logout" element={<Logout />} />
          <Route path="/Demo" element={<Demo />} />
          <Route
            path="/map"
            element={
              <RequireAuth>
                <Home />
              </RequireAuth>
            }
          />
        </Routes>
      </Router>
    </div>
  );
};

export default App;
