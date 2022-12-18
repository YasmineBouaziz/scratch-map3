import React from 'react';
import Navbar from 'react-bootstrap/Navbar';
import Nav from 'react-bootstrap/Nav';
import Container from 'react-bootstrap/Container';
import logo from './map_icon.png';
import './_Navbar.scss';

function NavBar() {
  return (
    <>
    <Navbar collapseOnSelect expand="lg">
      <Container>
      <Navbar.Brand href="#home">
      <img src={logo} className="App-logo" alt="logo" />
          </Navbar.Brand>
          <Navbar.Brand> Scratch Map
          </Navbar.Brand>
      {/* </Navbar.Brand> */}
        <Navbar.Toggle aria-controls="responsive-navbar-nav" />
        <Navbar.Collapse id="responsive-navbar-nav">
          <Nav className="me-auto">
            <Nav.Link href="#features">Map</Nav.Link>
          </Nav>
          <Nav>
            <Nav.Link href="#deets">About</Nav.Link>
          </Nav>
        </Navbar.Collapse>
      </Container>
    </Navbar>
    </>
  );
}

export default NavBar;
