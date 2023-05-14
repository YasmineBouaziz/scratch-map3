import React, { useState, useEffect } from "react";
import Popover from "react-bootstrap/Popover";
import Button from "react-bootstrap/Button";
import OverlayTrigger from "react-bootstrap/OverlayTrigger";
import { Placement } from "react-bootstrap/esm/types";
import { TransformWrapper, TransformComponent } from "react-zoom-pan-pinch";
import "../style/map.scss";

type Location = {
  path: string;
  id: string;
  name: string;
  colour?: string;
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
  locationAriaLabel?: any;
  onLocationMouseOver?: any;
  onLocationMouseOut?: any;
  onLocationMouseMove?: any;
  onLocationClick?: any;
  onLocationKeyDown?: any;
  onLocationFocus?: any;
  onLocationBlur?: any;
  isLocationSelected?: any;

  // Slots
  childrenBefore?: any;
  childrenAfter?: any;
};

type CountryData = {
  hasVisited?: boolean;
};

function getTotalVisited(countryMetadata: Record<string, CountryData>): number {
  let totalVisited = 0;
  for (const key in countryMetadata) {
    if (countryMetadata[key].hasVisited) {
      totalVisited += 1;
    }
  }
  return totalVisited;
}

function Demo(props: MapProps) {
  const [selectedCountry, setSelectedCountry] = useState<Location>();
  const [placement, setPlacement] = useState<Placement>("right");
  // Get all countries user has already visited and use this info to set countryMetadata initial state
  const [countryMetadata, setCountryMetadata] = useState<
    Record<string, CountryData>
  >({});
  const [totalVisited, setTotalVisited] = useState<number>(0);

  useEffect(() => {
    setTotalVisited(getTotalVisited(countryMetadata));
  }, [countryMetadata]);

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
          countryMetadata[selectedCountry.name].hasVisited
        ) && (
          <Button
            variant="primary"
            onClick={() =>
              updateCountry(
                countryMetadata,
                selectedCountry,
                setCountryMetadata,
                true,
                setTotalVisited,
                totalVisited
              )
            }
          >
            Visited?
          </Button>
        )}
      {selectedCountry &&
        countryMetadata[selectedCountry.name] &&
        countryMetadata[selectedCountry.name].hasVisited && (
          <Button
            variant="primary"
            onClick={() =>
              updateCountry(
                countryMetadata,
                selectedCountry,
                setCountryMetadata,
                false,
                setTotalVisited,
                totalVisited
              )
            }
          >
            Not visited?
          </Button>
        )}
    </Popover>
  );

  return (
    <TransformWrapper initialScale={1}>
      <TransformComponent
        wrapperStyle={{
          width: "100%",
        }}
        contentStyle={{
          width: "80%",
        }}
      >
        <div
          style={{
            flexGrow: 1,
          }}
        >
          <svg
            xmlns="http://www.w3.org/2000/svg"
            viewBox={props.map.viewBox}
            className={props.className}
            role={props.role}
            aria-label={props.map.label}
            height="100%"
            width="100%"
          >
            <text x="90%" y="10%" fill="red">
              {totalVisited && totalVisited} / 254
            </text>
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
                    aria-label={
                      typeof props.locationAriaLabel === "function"
                        ? props.locationAriaLabel(location, index)
                        : location.name
                    }
                    fill={
                      getAria(location, countryMetadata)
                        ? (location.name &&
                            location.name in countryMetadata &&
                            countryMetadata[location.name].hasVisited &&
                            location.colour) ||
                          "#f4bc59"
                        : "#B5B5B5"
                    }
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
                  >
                    <title>{location.name}</title>
                  </path>
                </OverlayTrigger>
              );
            })}
          </svg>
        </div>
      </TransformComponent>
    </TransformWrapper>
  );
}

function getAria(
  location: Location,
  country_visited: Record<string, CountryData>
) {
  if (
    location.name &&
    location.name in country_visited &&
    country_visited[location.name].hasVisited
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
  isVisited: boolean,
  setTotalVisited: React.Dispatch<React.SetStateAction<number>>,
  totalVisited: number
): void {
  if (selectedCountry && selectedCountry.name) {
    if (selectedCountry.name in countries) {
      const copy = { ...countries };
      copy[selectedCountry.name].hasVisited = isVisited;
      setCountryMetadata(copy);
      console.log(isVisited);
      const visitedChange = isVisited ? 1 : -1;
      setTotalVisited(totalVisited + visitedChange);
    } else {
      const copy = { ...countries };
      copy[selectedCountry.name] = { hasVisited: isVisited };
      setCountryMetadata(copy);
      const visitedChange = isVisited ? 1 : -1;
      setTotalVisited(totalVisited + visitedChange);
    }
  }
}

Demo.defaultProps = {
  className: "svg-map",
  role: "none", // No role for map
  locationClassName: "svg-map__location",
  locationTabIndex: "0",
};

export default Demo;
