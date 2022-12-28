import React, { useEffect, useState } from "react";
import Popover from "react-bootstrap/Popover";
import Button from "react-bootstrap/Button";
import OverlayTrigger from "react-bootstrap/OverlayTrigger";
import { Placement } from "react-bootstrap/esm/types";

type Location = {
  path: string;
  id: string;
  name?: string;
};

type Map = {
  viewBox: string;
  locations: Location[];
  label: string;
};

type MapProps = {
  map: Map;
  className?: string;
  role?: string;

  // Locations properties
  locationClassName?: string | any;
  locationTabIndex?: string | any;
  locationRole?: string;
  locationAriaLabel?: any;
  onLocationMouseOver?: any;
  onLocationMouseOut?: any;
  onLocationMouseMove?: any;
  onLocationClick?: any;
  onLocationKeyDown?: any;
  onLocationFocus?: any;
  onLocationBlur?: any;
  isLocationSelected?: any;
  test?: any;

  // Slots
  childrenBefore?: any;
  childrenAfter?: any;
};

type CountryData = {
  has_visited?: boolean;
};

function SVGMap(props: MapProps) {
  const [selectedCountry, setSelectedCountry] = useState<Location>();
  const [placement, setPlacement] = useState<Placement>("right");
  const [countryMetadata, setCountryMetadata] = useState<
    Record<string, CountryData>
  >({});

  const popover = (
    <Popover id="popover-basic">
      <Popover.Header as="h3">
        {selectedCountry && selectedCountry.name}
      </Popover.Header>
      <Popover.Body>{"Nothing to say for now :)"}</Popover.Body>
      {selectedCountry &&
        selectedCountry.name &&
        !(
          countryMetadata[selectedCountry.name] &&
          countryMetadata[selectedCountry.name].has_visited
        ) && (
          <Button
            variant="primary"
            onClick={() =>
              updateCountry(
                countryMetadata,
                selectedCountry,
                setCountryMetadata,
                true
              )
            }
          >
            Visited?
          </Button>
        )}
      {selectedCountry &&
        selectedCountry.name &&
        countryMetadata[selectedCountry.name] &&
        countryMetadata[selectedCountry.name].has_visited && (
          <Button variant="primary">Visited again?</Button>
        )}
      {selectedCountry &&
        selectedCountry.name &&
        countryMetadata[selectedCountry.name] &&
        countryMetadata[selectedCountry.name].has_visited && (
          <Button
            variant="secondary"
            onClick={() =>
              updateCountry(
                countryMetadata,
                selectedCountry,
                setCountryMetadata,
                false
              )
            }
          >
            Not visited?
          </Button>
        )}
    </Popover>
  );

  return (
    <svg
      xmlns="http://www.w3.org/2000/svg"
      viewBox={props.map.viewBox}
      className={props.className}
      role={props.role}
      aria-label={props.map.label}
    >
      {props.childrenBefore}
      {props.map.locations.map((location, index) => {
        return (
          <OverlayTrigger
            trigger="click"
            rootClose
            overlay={popover}
            placement={placement}
          >
            <path
              id={location.id}
              name={location.name}
              d={location.path}
              className={
                typeof props.locationClassName === "function"
                  ? props.locationClassName(location, index)
                  : props.locationClassName
              }
              tabIndex={
                typeof props.locationTabIndex === "function"
                  ? props.locationTabIndex(location, index)
                  : props.locationTabIndex
              }
              role={props.locationRole}
              aria-label={
                typeof props.locationAriaLabel === "function"
                  ? props.locationAriaLabel(location, index)
                  : location.name
              }
              aria-checked={getAria(location, countryMetadata)}
              onMouseOver={props.onLocationMouseOver}
              onMouseOut={props.onLocationMouseOut}
              onMouseMove={props.onLocationMouseMove}
              onClick={(event) => {
                setPlacement(getPlacement(event));
                setSelectedCountry(location);
              }}
              onKeyDown={props.onLocationKeyDown}
              onFocus={props.onLocationFocus}
              onBlur={props.onLocationBlur}
              key={location.id}
            />
          </OverlayTrigger>
        );
      })}
      {props.childrenAfter}
    </svg>
  );
}

function getAria(
  location: Location,
  country_visited: Record<string, CountryData>
) {
  if (
    location.name &&
    location.name in country_visited &&
    country_visited[location.name].has_visited
  ) {
    return true;
  } else {
    return false;
  }
}

function getPlacement(event: React.MouseEvent<SVGPathElement, MouseEvent>) {
  const half_x = window.innerWidth / 2;
  const x_coord = event.clientX;

  if (x_coord >= half_x) {
    return "left";
  } else return "right";
}

function updateCountry(
  countries: Record<string, CountryData>,
  selectedCountry: Location | undefined,
  setCountryMetadata: React.Dispatch<
    React.SetStateAction<Record<string, CountryData>>
  >,
  isVisited: boolean
) {
  if (selectedCountry && selectedCountry.name) {
    if (selectedCountry.name in countries) {
      var copy = { ...countries };
      copy[selectedCountry.name].has_visited = isVisited;
      setCountryMetadata(copy);
    } else {
      var copy = { ...countries };
      copy[selectedCountry.name] = { has_visited: isVisited };
      setCountryMetadata(copy);
    }
  }
}

SVGMap.defaultProps = {
  className: "svg-map",
  role: "none", // No role for map
  locationClassName: "svg-map__location",
  locationTabIndex: "0",
  locationRole: "none",
};

export default SVGMap;
