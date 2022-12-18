import React, { useEffect, useState } from "react";

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

function SVGMap(props: MapProps) {
  const [selectedCountry, setSelectedCountry] = useState<any>();

  console.log(selectedCountry);

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
            aria-checked={
              props.isLocationSelected &&
              props.isLocationSelected(location, index)
            }
            onMouseOver={props.onLocationMouseOver}
            onMouseOut={props.onLocationMouseOut}
            onMouseMove={props.onLocationMouseMove}
            onClick={() => setSelectedCountry(location)}
            onKeyDown={props.onLocationKeyDown}
            onFocus={props.onLocationFocus}
            onBlur={props.onLocationBlur}
            key={location.id}
          />
        );
      })}
      {props.childrenAfter}
    </svg>
  );
}

SVGMap.defaultProps = {
  className: "svg-map",
  role: "none", // No role for map
  locationClassName: "svg-map__location",
  locationTabIndex: "0",
  locationRole: "none",
};

export default SVGMap;
