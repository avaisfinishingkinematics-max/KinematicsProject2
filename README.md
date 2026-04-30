# Project 2 — Compliant Mechanism PRB and FEA

This repository contains the complete work for MECHENG 7751 Project 2, including analytical derivations, FEA validation, the final report, and an interactive web app.

## Key files and locations

- **Derivation**: `PRB Model/My_PRB_derivation.tex`
- **Final report**: `final report/ME7751_Project2_Report.tex`
- **Presentation**: `final report/ME7751_Project2_Presentation.pptx`
- **Final FEA model**: `FEA Model/Compliant Beam/MechanismTake3.cae`
- **Alternate FEA model / root file**: `RedoMechanism.cae`
- **MATLAB analysis**: `MATLAB/QUICKSTART.m`, `MATLAB/run_comparison.m`, `MATLAB/main_analysis.m`
- **Interactive web app**: `App/index.html`, `App/script.js`, `App/chart.min.js`
- **GitHub Pages web app copy**: `docs/`

## Running the MATLAB analysis

1. Open MATLAB.
2. Set the current folder to:
   `project 2/MATLAB`
3. Run the comparison script:
   ```matlab
   run_comparison
   ```

This will:
- load FEA data,
- compute PRB analytical predictions,
- generate comparison plots,
- save results into `MATLAB/results/`.

If needed, the full quick-start instructions are in `MATLAB/QUICKSTART.m`.

## Running the interactive web app locally

### Option 1: Open directly
1. Open `App/index.html` in any modern browser.
2. The app runs entirely in the browser using JavaScript and Chart.js.

### Option 2: Run a local server
If you want a local server view (recommended for some browsers):
1. Install Node.js if not already installed.
2. From the project root, run:
   ```powershell
   cd "project 2\App"
   node server.js
   ```
3. Open `http://localhost:8000` in your browser.

## Hosting the web app on GitHub Pages

This project includes a GitHub Pages site copy in the `docs/` folder. To host the app publicly:

1. Create a GitHub repository for this project.
2. Add a remote to your local repo, for example:
   ```powershell
   git remote add origin https://github.com/<username>/<repo>.git
   ```
3. Push the local repository:
   ```powershell
   git push -u origin main
   ```
4. In GitHub repository settings, enable Pages and select:
   - Source branch: `main`
   - Folder: `/docs`
5. The hosted web app will be available at:
   ```text
   https://<username>.github.io/<repo>/
   ```

The app files are copied into `docs/` so GitHub Pages can serve them directly.

## Notes

- `App/` contains the original interactive web app.
- `docs/` contains the GitHub Pages deployment copy.
- The final report and presentation are located in `final report/`.
- The final FEA model is stored in `FEA Model/Compliant Beam/MechanismTake3.cae`.
