import React from "react";
import Navbar from "react-bootstrap/Navbar";
import Nav from "react-bootstrap/Nav";
import Container from "react-bootstrap/Container";
import logo from "./map_icon.png";

function NavBar() {
  return (
    <>
      <Navbar collapseOnSelect expand="lg" bg="light" variant="light">
        <Container>
          <Navbar.Brand href="/map">
            <img src={logo} class="App-logo" alt="logo" />
          </Navbar.Brand>
          <Navbar.Brand href="/map"> Scratch Map</Navbar.Brand>
          <Navbar.Toggle aria-controls="responsive-navbar-nav" />
          <Navbar.Collapse id="responsive-navbar-nav">
            <Nav>
              <Nav.Link href="/about">About</Nav.Link>
            </Nav>
            <Nav>
              <Nav.Link href="/login">Login</Nav.Link>
            </Nav>
            <Nav>
              <Nav.Link href="/signup">Signup</Nav.Link>
            </Nav>
            {localStorage.getItem("jwtToken") != null ? (
              <Nav>
                <Nav.Link href="/logout">Logout</Nav.Link>
              </Nav>
            ) : null}
            <Nav>
              <Nav.Link href="/demo">Demo</Nav.Link>
            </Nav>
          </Navbar.Collapse>
        </Container>
      </Navbar>
    </>
  );
}

export default NavBar;
