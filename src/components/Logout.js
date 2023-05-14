import React, { useState } from "react";
import {
  BrowserRouter as Router,
  Route,
  Routes,
  Navigate,
} from "react-router-dom";
import { ToastContainer, toast } from "react-toastify";

const Logout = () => {
  localStorage.removeItem("jwtToken");
  toast.success("Logged out!", {
    toastId: "Logout",
  });

  return <Navigate to="/login" />;
};

export default Logout;
