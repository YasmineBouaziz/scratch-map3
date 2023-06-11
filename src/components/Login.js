import React, { useState } from "react";
import {
  BrowserRouter as Router,
  Route,
  Routes,
  Navigate,
  useNavigate,
} from "react-router-dom";
import { ToastContainer, toast } from "react-toastify";
import "./_Login.scss";
import logo from "./map_icon.png";

const Login = () => {
  const [email, setEmail] = useState("");
  const [password, setPassword] = useState("");
  const navigate = useNavigate(); // get the navigate function

  const handleEmailChange = (event) => setEmail(event.target.value);
  const handlePasswordChange = (event) => setPassword(event.target.value);

  const handleSubmit = async (event) => {
    event.preventDefault();
    try {
      const response = await fetch("http://localhost:5000/login", {
        method: "POST",
        headers: {
          "Content-Type": "application/json",
          withCredentials: false,
        },
        body: JSON.stringify({
          email,
          password,
        }),
      });
      const data = await response.json();
      const { token } = data;
      localStorage.setItem("jwtToken", token);
      console.log(data); // handle success
      toast.success("Logged in successfully!", {
        toastId: "login",
      });
      navigate("/map");
    } catch (error) {
      console.error(error); // handle error
    }
  };

  return (
    <div>
      <img src={logo} class="App-logo" alt="logo" />
      <div class="login-container">
        <div class="form-container">
          <h1 class="login-title">Sign In</h1>
          <p>
            New to Scratch Map?{" "}
            <a class="sign-up-link" href="./signup">
              Sign up for free!
            </a>
          </p>
          <form onSubmit={handleSubmit}>
            <div>
              <label class="email-label">Email</label>
              <input
                class="email"
                type="email"
                value={email}
                onChange={handleEmailChange}
              />
            </div>
            <div>
              <label class="password-label">Password</label>
              <input
                class="password"
                type="password"
                value={password}
                onChange={handlePasswordChange}
              />
            </div>
            <button tabindex="0" class="continue-button" type="submit">
              Continue
            </button>
          </form>
        </div>
      </div>
    </div>
  );
};

export default Login;
