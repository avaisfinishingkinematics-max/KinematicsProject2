// FEA data
const feaAngleRad = [0, 0.00726905, 0.0537966, 0.167122, 0.36304, 0.648346, 1.02363, 1.47936, 1.99938, 2.56467, 3.15329, 3.73785, 4.29132, 4.80049, 5.24684, 5.61551, 5.89763, 6.09132, 6.203, 6.24878, 6.25594];
const feaAngleDeg = feaAngleRad.map(x => x * 180 / Math.PI);
const feaTorque = [0, 1.97981, 3.31438, 4.17533, 5.04975, 6.45796, 6.85722, 3.06572, -0.399818, 0.0679123, 0.0142731, -0.402143, -0.67084, -2.38641, -5.52725, -6.60455, -5.70624, -4.64669, -3.44431, -2.02513, -0.0336789];
const feaDisp = [0, 0.00350914, 0.0200544, 0.0169957, -0.133946, -0.668357, -1.82689, -3.5238, -5.06482, -5.85339, -6.01585, -5.7427, -5.03893, -3.86047, -2.44291, -1.25216, -0.522753, -0.18078, -0.0552356, -0.0200568, -0.0154327];

let baselineDispChart, currentDispChart, mechCtx;
let baselinePRB;
let baselineParams;

window.onload = function() {
    const ctxBaselineDisp = document.getElementById('baselineDispChart').getContext('2d');
    const ctxCurrentDisp = document.getElementById('currentDispChart').getContext('2d');
    mechCtx = document.getElementById('mechCanvas').getContext('2d');

    const xTickCallback = function(value) {
        if (Math.abs(value - 0) < 1e-6) return '0';
        if (Math.abs(value - Math.PI / 2) < 1e-6) return 'π/2';
        if (Math.abs(value - Math.PI) < 1e-6) return 'π';
        if (Math.abs(value - 3 * Math.PI / 2) < 1e-6) return '3π/2';
        if (Math.abs(value - 2 * Math.PI) < 1e-6) return '2π';
        return value.toFixed(2);
    };

    const currentChartOptions = {
        responsive: true,
        maintainAspectRatio: false,
        layout: { padding: { left: 40, right: 20, top: 20, bottom: 20 } },
        legend: { display: true },
        elements: { line: { tension: 0 } },
        scales: {
            xAxes: [{
                type: 'linear',
                position: 'bottom',
                scaleLabel: { display: true, labelString: 'Crank Angle (rad)', fontSize: 16 },
                gridLines: { display: true },
                ticks: { min: 0, max: 2 * Math.PI, stepSize: Math.PI / 2, callback: xTickCallback, fontSize: 14 }
            }],
            yAxes: [{
                scaleLabel: { display: true, labelString: 'Slider displacement', fontSize: 16 },
                gridLines: { display: true },
                ticks: { callback: value => value.toFixed(1), fontSize: 14, maxTicksLimit: 11 }
            }]
        }
    };

    const baselineChartOptions = {
        responsive: true,
        maintainAspectRatio: false,
        layout: { padding: { left: 40, right: 20, top: 20, bottom: 20 } },
        legend: { display: true },
        elements: { line: { tension: 0 } },
        scales: {
            xAxes: [{
                type: 'linear',
                position: 'bottom',
                scaleLabel: { display: true, labelString: 'Crank Angle (rad)', fontSize: 16 },
                gridLines: { display: true },
                ticks: { min: 0, max: 2 * Math.PI, stepSize: Math.PI / 2, callback: xTickCallback, fontSize: 14 }
            }],
            yAxes: [{
                scaleLabel: { display: true, labelString: 'Normalized displacement', fontSize: 16 },
                gridLines: { display: true },
                ticks: { min: 0, max: 1, stepSize: 0.2, callback: value => value.toFixed(1), fontSize: 14, maxTicksLimit: 6 }
            }]
        }
    };

    baselineDispChart = new Chart(ctxBaselineDisp, {
        type: 'line',
        data: { datasets: [] },
        options: baselineChartOptions
    });

    currentDispChart = new Chart(ctxCurrentDisp, {
        type: 'line',
        data: { datasets: [] },
        options: currentChartOptions
    });

    baselineParams = {
        r1: 3.00,
        Lc: 5.00,
        offset: 0.50,
        gamma: 0.8517,
        EI: 16.00
    };
    baselinePRB = computePRBModel(baselineParams, 0, 2 * Math.PI);

    document.getElementById('updateButton').addEventListener('click', updatePlots);
    updateCurrentParams();
    updatePlots();
};

function drawMechanism(params) {
    const canvas = document.getElementById('mechCanvas');
    const ctx = mechCtx;
    const width = canvas.width;
    const height = canvas.height;
    ctx.clearRect(0, 0, width, height);

    const scale = Math.min((width - 120) / (params.Lc + params.r1 + 20), (height - 60) / (params.Lc + Math.abs(params.offset) + 20));
    const centerX = 80;
    const centerY = height / 2;
    const phi1 = Math.PI / 4;

    const crankX = centerX + params.r1 * scale * Math.cos(phi1);
    const crankY = centerY - params.r1 * scale * Math.sin(phi1);
    const sliderY = centerY - params.offset * scale;
    const verticalGap = sliderY - crankY;
    const rodLength = params.Lc * scale;
    const chord = Math.max(0, rodLength * rodLength - verticalGap * verticalGap);
    const sliderX = crankX + Math.sqrt(chord);

    // Draw slider guide
    ctx.strokeStyle = '#555';
    ctx.lineWidth = 2;
    ctx.beginPath();
    ctx.moveTo(centerX + 20, sliderY);
    ctx.lineTo(width - 20, sliderY);
    ctx.stroke();

    // Draw crank center
    ctx.fillStyle = '#000';
    ctx.beginPath();
    ctx.arc(centerX, centerY, 6, 0, 2 * Math.PI);
    ctx.fill();

    // Draw crank
    ctx.strokeStyle = '#007bff';
    ctx.lineWidth = 6;
    ctx.beginPath();
    ctx.moveTo(centerX, centerY);
    ctx.lineTo(crankX, crankY);
    ctx.stroke();

    // Draw pin
    ctx.fillStyle = '#007bff';
    ctx.beginPath();
    ctx.arc(crankX, crankY, 5, 0, 2 * Math.PI);
    ctx.fill();

    // Draw connecting rod
    ctx.strokeStyle = '#ff6600';
    ctx.lineWidth = 5;
    ctx.beginPath();
    ctx.moveTo(crankX, crankY);
    ctx.lineTo(sliderX, sliderY);
    ctx.stroke();

    // Draw slider block
    ctx.fillStyle = '#28a745';
    ctx.fillRect(sliderX - 20, sliderY - 15, 40, 30);
    ctx.strokeStyle = '#1d7a33';
    ctx.lineWidth = 2;
    ctx.strokeRect(sliderX - 20, sliderY - 15, 40, 30);

    // Draw labels
    ctx.fillStyle = '#000';
    ctx.font = '14px Arial';
    ctx.fillText(`r1 = ${params.r1.toFixed(2)}`, 10, 20);
    ctx.fillText(`Lc = ${params.Lc.toFixed(2)}`, 10, 38);
    ctx.fillText(`offset = ${params.offset.toFixed(2)}`, 10, 56);
}

function animateMechanism() {
    drawMechanism(currentParams);
}

function updatePlots() {
    const params = {
        r1: parseFloat(document.getElementById('r1').value),
        Lc: parseFloat(document.getElementById('Lc').value),
        offset: parseFloat(document.getElementById('offset').value),
        gamma: parseFloat(document.getElementById('gamma').value),
        EI: parseFloat(document.getElementById('EI').value)
    };

    const minAngleRad = 0;
    const maxAngleRad = 2 * Math.PI;
    const currentPRB = computePRBModel(params, minAngleRad, maxAngleRad);

    // Compute Howell-Midha for the current parameter set
    const howellParams = {
        r1: params.r1,
        Lc: params.Lc,
        offset: params.offset,
        Kb: 0.85,
        EI: params.EI
    };
    const howellPRB = computeHowellMidha(howellParams, minAngleRad, maxAngleRad);

    // Compute baseline My PRB for the static comparison chart
    const myPRB = computePRBModel(baselineParams, minAngleRad, maxAngleRad);

    // Normalize
    const norm_fea_disp = feaDisp.map(d => (d - Math.min(...feaDisp)) / (Math.max(...feaDisp) - Math.min(...feaDisp)));
    const norm_howell_disp = howellPRB.prbDisp.map(d => (d - Math.min(...howellPRB.prbDisp)) / (Math.max(...howellPRB.prbDisp) - Math.min(...howellPRB.prbDisp)));
    const norm_my_disp = myPRB.prbDisp.map(d => (d - Math.min(...myPRB.prbDisp)) / (Math.max(...myPRB.prbDisp) - Math.min(...myPRB.prbDisp)));

    const feaData = [];
    for (let i = 0; i < feaAngleRad.length; i++) {
        feaData.push({ x: feaAngleRad[i], y: norm_fea_disp[i] });
    }
    const howellData = [];
    for (let i = 0; i < howellPRB.prbAngleRad.length; i++) {
        howellData.push({ x: howellPRB.prbAngleRad[i], y: norm_howell_disp[i] });
    }
    const myData = [];
    for (let i = 0; i < myPRB.prbAngleRad.length; i++) {
        myData.push({ x: myPRB.prbAngleRad[i], y: norm_my_disp[i] });
    }

    baselineDispChart.data.datasets = [
        { label: 'FEA', data: feaData, borderColor: 'blue', backgroundColor: 'blue', fill: false, pointRadius: 2, borderWidth: 2, spanGaps: true },
        { label: 'Howell-Midha', data: howellData, borderColor: 'orange', backgroundColor: 'orange', fill: false, pointRadius: 2, borderWidth: 2, spanGaps: true },
        { label: 'My PRB', data: myData, borderColor: 'green', backgroundColor: 'green', fill: false, pointRadius: 2, borderWidth: 2, spanGaps: true }
    ];
    baselineDispChart.update();

    currentDispChart.data.datasets = [
        { label: 'Current My PRB', data: currentPRB.prbAngleRad.map((x, i) => ({ x, y: currentPRB.prbDisp[i] })), borderColor: 'red', backgroundColor: 'red', fill: false, pointRadius: 2, borderWidth: 2, spanGaps: true },
        { label: 'Current Howell-Midha', data: howellPRB.prbAngleRad.map((x, i) => ({ x, y: howellPRB.prbDisp[i] })), borderColor: 'orange', backgroundColor: 'orange', fill: false, pointRadius: 2, borderWidth: 2, spanGaps: true }
    ];

    const allCurrentValues = currentPRB.prbDisp.concat(howellPRB.prbDisp);
    const currentMin = Math.min(...allCurrentValues);
    const currentMax = Math.max(...allCurrentValues);
    const currentPadding = Math.max(0.05 * (currentMax - currentMin), 0.2);

    currentDispChart.options.scales.yAxes[0].ticks.min = currentMin - currentPadding;
    currentDispChart.options.scales.yAxes[0].ticks.max = currentMax + currentPadding;
    currentDispChart.update();

    document.getElementById('results').innerHTML = `
        Static plot shows FEA, Howell-Midha, and My PRB comparison.<br>
        Current My PRB results update when parameters change.
    `;

    updateCurrentParams();
    animateMechanism();
}

function computePRBModel(params, minAngleRad, maxAngleRad) {
    const { r1, Lc, offset, gamma, EI } = params;
    const K_theta = gamma * 2.67617 * EI / Lc;
    const phi1_range = linspace(minAngleRad, maxAngleRad, 500);
    const Theta_grid = linspace(-Math.PI, Math.PI, 2001);

    const param_x = (Theta) => Lc * (1 - gamma * (1 - Math.cos(Theta)));
    const param_y = (Theta) => gamma * Lc * Math.sin(Theta);
    const y_tip_func = (Theta, phi1) => offset + r1 * Math.sin(phi1) + param_y(Theta);

    const Theta_sol = [];
    let Theta_prev = Math.PI / 2;

    for (let phi1 of phi1_range) {
        const f_vals = Theta_grid.map(Theta => y_tip_func(Theta, phi1));
        const sign_changes = [];
        for (let i = 0; i < f_vals.length - 1; i++) {
            if (Math.sign(f_vals[i]) !== Math.sign(f_vals[i + 1])) {
                sign_changes.push(i);
            }
        }
        if (sign_changes.length === 0) {
            Theta_sol.push(Theta_prev);
        } else {
            const roots = sign_changes.map(idx => bisection(Theta_grid[idx], Theta_grid[idx + 1], (Theta) => y_tip_func(Theta, phi1), 1e-6));
            const closest = roots.reduce((prev, curr) => Math.abs(curr - Theta_prev) < Math.abs(prev - Theta_prev) ? curr : prev);
            Theta_sol.push(closest);
            Theta_prev = closest;
        }
    }

    const x_slider = phi1_range.map((phi1, i) => r1 * Math.cos(phi1) + param_x(Theta_sol[i]));
    const x_slider_shifted = x_slider.map(x => x - x_slider[0]);

    const dTheta_dphi1 = gradient(Theta_sol, phi1_range);
    const prbTorque = Theta_sol.map((Theta, i) => -K_theta * Theta * dTheta_dphi1[i]);

    return {
        prbAngleRad: phi1_range,
        prbAngleDeg: phi1_range.map(x => x * 180 / Math.PI),
        prbDisp: x_slider_shifted,
        prbTorque
    };
}

function computeHowellMidha(params, minAngleRad, maxAngleRad) {
    const { r1, Lc, offset, Kb, EI } = params;
    const K_theta = 12.7 * EI / Lc;
    const phi1_range = linspace(minAngleRad, maxAngleRad, 500);
    const Theta_grid = linspace(-Math.PI, Math.PI, 2001);

    const param_x = (Theta) => Lc * (1 - (2 * Kb / Math.PI) * Math.sin(Theta / 2)) * Math.cos(Theta);
    const param_y = (Theta) => Lc * (1 - (2 * Kb / Math.PI) * Math.sin(Theta / 2)) * Math.sin(Theta);
    const y_tip_func = (Theta, phi1) => offset + r1 * Math.sin(phi1) + param_y(Theta);

    const Theta_sol = [];
    let Theta_prev = 0.5;

    for (let phi1 of phi1_range) {
        const f_vals = Theta_grid.map(Theta => y_tip_func(Theta, phi1));
        const sign_changes = [];
        for (let i = 0; i < f_vals.length - 1; i++) {
            if (Math.sign(f_vals[i]) !== Math.sign(f_vals[i + 1])) {
                sign_changes.push(i);
            }
        }
        if (sign_changes.length === 0) {
            Theta_sol.push(Theta_prev);
        } else {
            const roots = sign_changes.map(idx => bisection(Theta_grid[idx], Theta_grid[idx + 1], (Theta) => y_tip_func(Theta, phi1), 1e-6));
            const closest = roots.reduce((prev, curr) => Math.abs(curr - Theta_prev) < Math.abs(prev - Theta_prev) ? curr : prev);
            Theta_sol.push(closest);
            Theta_prev = closest;
        }
    }

    const x_slider = phi1_range.map((phi1, i) => r1 * Math.cos(phi1) + param_x(Theta_sol[i]));
    const x_slider_shifted = x_slider.map(x => x - x_slider[0]);

    const dTheta_dphi1 = gradient(Theta_sol, phi1_range);
    const prbTorque = Theta_sol.map((Theta, i) => -K_theta * Theta * dTheta_dphi1[i]);

    return {
        prbAngleRad: phi1_range,
        prbAngleDeg: phi1_range.map(x => x * 180 / Math.PI),
        prbDisp: x_slider_shifted,
        prbTorque
    };
}

function linspace(start, end, num) {
    const step = (end - start) / (num - 1);
    const arr = [];
    for (let i = 0; i < num; i++) {
        arr.push(start + i * step);
    }
    return arr;
}

function gradient(y, x) {
    const dx = x.slice(1).map((val, i) => val - x[i]);
    const dy = y.slice(1).map((val, i) => val - y[i]);
    const grad = dy.map((d, i) => d / dx[i]);
    grad.unshift(grad[0]); // approximate first
    return grad;
}

function bisection(a, b, f, tol = 1e-6) {
    let fa = f(a), fb = f(b);
    if (fa * fb > 0) return (a + b) / 2; // no root, return midpoint
    for (let i = 0; i < 100; i++) {
        const c = (a + b) / 2;
        const fc = f(c);
        if (Math.abs(fc) < tol) return c;
        if (fa * fc < 0) b = c, fb = fc;
        else a = c, fa = fc;
    }
    return (a + b) / 2;
}

function computeDiscrepancy(prbAngleRad, prbAngleDeg, prbDisp, prbTorque) {
    const prbDispInterp = interp1(prbAngleRad, prbDisp, feaAngleRad);
    const prbTorqueInterp = interp1(prbAngleDeg, prbTorque, feaAngleDeg);

    const pctDisp = feaDisp.map((fea, i) => Math.abs(fea - prbDispInterp[i]) / Math.max(Math.abs(prbDispInterp[i]), 1e-10) * 100);
    const pctTorque = feaTorque.map((fea, i) => Math.abs(fea - prbTorqueInterp[i]) / Math.max(Math.abs(prbTorqueInterp[i]), 1e-10) * 100);

    const avgDisp = pctDisp.reduce((a, b) => a + b, 0) / pctDisp.length;
    const avgTorque = pctTorque.reduce((a, b) => a + b, 0) / pctTorque.length;
    const maxDisp = Math.max(...pctDisp);
    const maxTorque = Math.max(...pctTorque);

    return { pctDisp, pctTorque, avgDisp, avgTorque, maxDisp, maxTorque };
}

function interp1(x, y, xi) {
    return xi.map(xval => {
        if (xval <= x[0]) return y[0];
        if (xval >= x[x.length - 1]) return y[y.length - 1];
        for (let i = 0; i < x.length - 1; i++) {
            if (x[i] <= xval && xval <= x[i + 1]) {
                return y[i] + (y[i + 1] - y[i]) * (xval - x[i]) / (x[i + 1] - x[i]);
            }
        }
        return 0;
    });
}

let animationId = null;
var currentParams = {
    r1: 3.00,
    Lc: 5.00,
    offset: 0.50,
    gamma: 0.8517,
    EI: 16.00
};

function updateCurrentParams() {
    currentParams = {
        r1: parseFloat(document.getElementById('r1').value),
        Lc: parseFloat(document.getElementById('Lc').value),
        offset: parseFloat(document.getElementById('offset').value),
        gamma: parseFloat(document.getElementById('gamma').value),
        EI: parseFloat(document.getElementById('EI').value)
    };
}

function findTheta(phi1, params) {
    const { r1, Lc, offset, gamma } = params;
    const param_y = (Theta) => gamma * Lc * Math.sin(Theta);
    const y_tip_func = (Theta) => offset + r1 * Math.sin(phi1) + param_y(Theta);

    // Bisection for Theta in [-pi, pi]
    let a = -Math.PI, b = Math.PI;
    for (let i = 0; i < 50; i++) {
        const c = (a + b) / 2;
        if (y_tip_func(c) > 0) a = c;
        else b = c;
    }
    return (a + b) / 2;
}

