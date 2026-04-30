const PptxGenJS = require("pptxgenjs");
const pptx = new PptxGenJS();

const slides = [
  {
    title: "Design and Analysis of a Planar Compliant Mechanism",
    bullets: [
      "ME 7751 Project 2 presentation",
      "Ava Merrifield, The Ohio State University",
      "Spring 2026"
    ]
  },
  {
    title: "Motivation and Objectives",
    bullets: [
      "Compliant mechanisms enable motion through elastic deformation.",
      "Goal: connect PRB analytical modeling, FEA validation, and an interactive app.",
      "Focus on a planar side-crank compliant slider mechanism."
    ]
  },
  {
    title: "Mechanism Description",
    bullets: [
      "Rigid crank drives a flexible coupler to displace a grounded slider.",
      "Planar compliant linkage with large deflections in the coupler.",
      "Relevant for positioning, amplification, and compliant actuation."
    ]
  },
  {
    title: "Problem Definition",
    bullets: [
      "Develop an analytical PRB model for the mechanism.",
      "Validate the model using Abaqus-based FEA.",
      "Compare torque and slider displacement predictions."
    ]
  },
  {
    title: "Analytical Modeling Methodology",
    bullets: [
      "Use Pseudo-Rigid-Body (PRB) reduced-order modeling.",
      "Derive the analytical model for the compliant coupler.",
      "Document assumptions, governing equations, and derived metrics."
    ]
  },
  {
    title: "Howell-Midha PRB Derivation",
    bullets: [
      "Based on classical fixed-pinned beam parametric deflection.",
      "Uses characteristic length ratio \u03bb = 2K_b/\u03c0 \u2248 0.541.",
      "Equivalent torsional stiffness coefficient K_b' = 12.7."
    ]
  },
  {
    title: "My PRB Model Derivation",
    bullets: [
      "Uses a fitted tip path with radius factor \u03b3 = 0.8517.",
      "Includes a characteristic pivot at the crank-coupler joint.",
      "Defines torque via an equivalent spring at the pivot."
    ]
  },
  {
    title: "PRB Coefficient Origins",
    bullets: [
      "\u03b3, c_\u03b8, and K_\u03b8 are drawn from the fixed-pinned vertical-load PRB family.",
      "My PRB coefficients are chosen to match the selected coupler path.",
      "These values differ from the classical Howell-Midha stiffness coefficient."
    ]
  },
  {
    title: "FEA Methodology",
    bullets: [
      "Abaqus model mirrors the PRB concept with rigid members and a torsional spring.",
      "Characteristic pivot is the crank-coupler connection.",
      "Coupler path uses a characteristic radius of 0.85L_c."
    ]
  },
  {
    title: "FEA Implementation Notes",
    bullets: [
      "FEA assumes rigid links and torsional spring behavior at the pivot.",
      "Slider displacement is extracted along the grounded path.",
      "Torque result is included with caution due to numerical validation limits."
    ]
  },
  {
    title: "Results: Torque Comparison",
    bullets: [
      "Compare My PRB and Howell-Midha torque predictions.",
      "Available Abaqus torque result shown as reference.",
      "Different stiffness assumptions drive torque divergence."
    ]
  },
  {
    title: "Results: Displacement Comparison",
    bullets: [
      "Slider displacement is the primary kinematic metric.",
      "Both PRB models show similar trends but differ in path assumptions.",
      "FEA displacement provides a useful numerical check."
    ]
  },
  {
    title: "Model Discrepancies Explained",
    bullets: [
      "Howell-Midha uses classical PRB path with standard stiffness coefficients.",
      "My PRB uses a tailored tip path and coefficient set.",
      "Small changes in path and spring definition affect torque and displacement."
    ]
  },
  {
    title: "Interactive App Description",
    bullets: [
      "MATLAB-based GUI allows parameter modification.",
      "Displays analytical PRB predictions and FEA-based results.",
      "Visualizes discrepancy between models."
    ]
  },
  {
    title: "Conclusions and Future Work",
    bullets: [
      "The PRB models capture general mechanism behavior.",
      "FEA validates the selected PRB geometry, especially displacement.",
      "Future work: improve the analytical model and increase numerical robustness."
    ]
  },
  {
    title: "References",
    bullets: [
      "Howell and Midha, ASME J. Mech. Design, 1995.",
      "Professor H. Su lecture slides, OSU Advanced Kinematics.",
      "Project-specific PRB and FEA methodology."
    ]
  }
];

slides.forEach((slideData) => {
  const slide = pptx.addSlide();
  slide.addText(slideData.title, { x: 0.5, y: 0.3, w: 9, h: 1, fontSize: 32, bold: true });
  slideData.bullets.forEach((text, index) => {
    slide.addText(text, {
      x: 0.5,
      y: 1.2 + index * 0.7,
      w: 9,
      h: 0.7,
      fontSize: 20,
      bullet: true,
      color: "363636"
    });
  });
});

pptx.writeFile({ fileName: "final report/ME7751_Project2_Presentation.pptx" }).then(() => {
  console.log("Presentation created: final report/ME7751_Project2_Presentation.pptx");
});
