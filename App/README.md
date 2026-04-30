# PRB vs FEA Interactive Web App

## Overview

This web application provides an interactive comparison between Pseudo-Rigid-Body (PRB) model predictions and Finite Element Analysis (FEA) results for a compliant slider-crank mechanism. The mechanism uses parametric deflection approximations for end-loaded, large deflection beams in compliant mechanisms.

## Launching the App

1. Open `index.html` in a web browser.
2. The app will load with default PRB parameters and display the comparison plots.

## Features

- **Interactive Parameter Adjustment**: Modify key PRB design parameters (crank length, coupler length, offset, beam parameter, flexural rigidity) and see real-time updates to the analytical predictions.
- **Crank Angle Range Control**: Set minimum and maximum crank angles (in degrees) to customize the analysis range.
- **2D Mechanism Visualization**: View a 2D schematic of the crank-slider mechanism at a specified crank angle, showing the crank, rigid coupler (dashed), actual deflected coupler, and slider position.
- **Visualization**:
  - 2D mechanism diagram
  - Slider displacement vs. crank angle
  - Input torque vs. crank angle
  - Percent error between PRB and FEA results
- **Error Quantification**: Displays average and maximum errors for displacement and torque.

## Mechanism Description

The compliant mechanism is a slider-crank system where the coupler is a flexible beam modeled using parametric deflection approximations. The PRB model captures large deflections of the beam under end loading.

## Data Sources

- FEA data is loaded from `../FEA Model/Working Model Dynamic/MechanismTake3.rpt`
- PRB model implements the analytical formulation based on the parametric deflection approximations

## Hosting on GitHub

To host this app on GitHub Pages:

1. Commit the `App` folder contents to your GitHub repository.
2. Enable GitHub Pages in the repository settings, selecting the main branch and `/App` as the source folder.
3. The app will be accessible at `https://<username>.github.io/<repo>/App/`

## Notes

- The app runs entirely in the browser using JavaScript and Chart.js for plotting.
- No server-side processing is required.
- FEA data is embedded in the JavaScript for static hosting.
