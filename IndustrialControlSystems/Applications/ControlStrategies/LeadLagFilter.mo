within IndustrialControlSystems.Applications.ControlStrategies;
model LeadLagFilter
  "Noisy sensor with low-pass filter and lead-lag speed recovery"
  extends Modelica.Icons.Example;

  // Required for MSL BandLimitedWhiteNoise; fixed seed ensures reproducible runs
  inner Modelica.Blocks.Noise.GlobalSeed globalSeed(fixedSeed = 1234)
    annotation (Placement(transformation(extent={{59.76,59.89},{80.24,80.11}},rotation = 0.0,origin = {0.0,0.0})));

  // ---- Process signal ----
  parameter Real step_height    = 10.0 "Height of the process step"
    annotation(Dialog(group = "Process signal"));
  parameter Real step_startTime = 10.0 "Start time of the process step [s]"
    annotation(Dialog(group = "Process signal"));

  // ---- Sensor ----
  parameter Real tau_sensor = 0.5
    "Sensor first-order time constant [s]"
    annotation(Dialog(group = "Sensor"));

  // ---- Noise ----
  parameter Real noise_samplePeriod = 0.05
    "Noise sample period [s]; recommended << tau_sensor"
    annotation(Dialog(group = "Noise"));
  parameter Real noise_power = 0.02
    "Noise power spectral density [1/Hz]; sigma = sqrt(noise_power/noise_samplePeriod)"
    annotation(Dialog(group = "Noise"));

  // ---- Low-pass filter ----
  parameter Real process_offset = 10.0
    "Low-pass filter time constant [s]; 10 x tau_sensor — strong noise rejection"
    annotation(Dialog(group = "Low-pass filter"));


  // ---- Observable signals ----
  output Real noisySignal   = addNoise.y      "Noisy sensor measurement";
  output Real lowPassOutput = lowPassFilter.y "Smooth but slow LP output";
  output Real leadLagOutput = leadLagFilter.y "Speed-recovered lead-lag output";

  // ---- Components ----
  Modelica.Blocks.Sources.Step processStep(
    height    = step_height,
    offset=process_offset,
    startTime = step_startTime)
    annotation (Placement(transformation(extent={{-80.0,20.0},{-60.0,40.0}},rotation = 0.0,origin = {0.0,0.0})));

  LinearSystems.Continuous.FirstOrder sensor(
    tau     = tau_sensor,
    mu      = 1,
    y_start=process_offset)
    annotation (Placement(transformation(extent={{-39.71,0.29},{-20.29,19.71}},rotation = 0.0,origin = {0.0,0.0})));

  Modelica.Blocks.Noise.BandLimitedWhiteNoise noiseSource(
    samplePeriod = noise_samplePeriod,
    noisePower   = noise_power)
    annotation (Placement(transformation(extent={{-80.15,-20.4},{-59.85,0.4}},rotation = 0.0,origin = {0.0,0.0})));

  Modelica.Blocks.Math.Add addNoise(k1 = 1, k2 = 1)
    annotation (Placement(transformation(extent={{0.1,-9.9},{19.9,9.9}},rotation = 0.0,origin = {0.0,0.0})));

  LinearSystems.Continuous.FirstOrder lowPassFilter(
    tau=2,
    mu      = 1,
    y_start=process_offset)
    annotation (Placement(transformation(extent={{30.1,-9.9},{49.9,9.9}},rotation = 0.0,origin = {0.0,0.0})));

  LinearSystems.Continuous.LeadLag leadLagFilter(
    T1=2,
    T2=0.5,
    mu      = 1,
    y_start=-30)
    annotation (Placement(transformation(extent={{80.44,-9.56},{99.56,9.56}},rotation = 0.0,origin = {0.0,0.0})));

equation
  connect(processStep.y, sensor.u) annotation (Line(
      points={{-59,30},{-46,30},{-46,10},{-37.77,10}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(noiseSource.y, addNoise.u2) annotation (Line(
      points={{-58.83,-10},{-13.34,-10},{-13.34,-5.94},{-1.88,-5.94}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(addNoise.y, lowPassFilter.u) annotation (Line(
      points={{20.89,0},{32.08,0}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(lowPassFilter.y, leadLagFilter.u) annotation (Line(
      points={{48.91,0},{82.35,0}},
      color={0,0,127},
      smooth=Smooth.None));

  connect(sensor.y, addNoise.u1) annotation (Line(points={{-21.26,10},{-12,10},{-12,5.94},{-1.88,5.94}}, color={0,0,127}));
  annotation (
    Diagram(coordinateSystem(
        preserveAspectRatio=false,
        extent={{-100,-100},{100,100}})),
    experiment(StopTime=120, Tolerance=1e-6),
    experimentSetupOutput,
    Documentation(info="
  <HTML>
  <h4>Description</h4>
  <p>
  This example demonstrates a three-stage industrial signal-conditioning chain.
  The process signal is a step from <code>process_offset</code> to
  <code>process_offset + step_height</code> (default: 10 to 20) starting at
  <code>step_startTime = 10 s</code>:
  </p>
  <ol>
    <li><b>Noisy sensor model</b> — the process step passes through a first-order lag
        (<code>tau_sensor = 0.5 s</code>), representing a fast sensor such as a
        pressure transducer or RTD in direct contact. Band-limited white noise is
        added at the sensor output, representing electrical and quantisation noise;
        with the default settings &sigma;&nbsp;&asymp;&nbsp;0.63 (relative to a
        step height of 10).</li>
    <li><b>Low-pass filter</b> — a first-order lag with <code>&tau; = 2 s</code>
        (four times the sensor time constant) attenuates the noise at the cost of
        a slower response: the 5-tau settling time grows to approximately
        10&nbsp;s.</li>
    <li><b>Lead-lag filter</b> — with zero time constant <code>T1 = 2 s</code>
        and pole time constant <code>T2 = 0.5 s</code>, the zero exactly cancels
        the low-pass pole and the new pole matches the sensor dynamics.
        The cascaded LP&nbsp;+&nbsp;lead-lag transfer function simplifies to
        <pre>
   1/(1 + 2s)   (1 + 2s)       1
  ----------- &times; --------- = ---------
       1        (1 + 0.5s)   1 + 0.5s</pre>
        recovering the response speed of the sensor alone while retaining the
        noise reduction provided by the low-pass stage.</li>
  </ol>
  <h4>Suggested plot variables</h4>
  <ul>
    <li><code>processStep.y</code> &mdash; ideal reference (noise-free, no lag)</li>
    <li><code>noisySignal</code> &mdash; raw noisy sensor measurement</li>
    <li><code>lowPassOutput</code> &mdash; smooth but slow LP output</li>
    <li><code>leadLagOutput</code> &mdash; speed-recovered lead-lag output</li>
  </ul>
  <h4>Parameter choices</h4>
  <TABLE BORDER=1 CELLSPACING=0 CELLPADDING=2>
  <TR bgcolor=#e0e0e0><TH>Parameter</TH><TH>Value</TH><TH>Justification</TH></TR>
  <tr><td>process_offset</td><td>10.0</td>
      <td>Initial steady-state value; used as step offset and filter initial
          conditions so the simulation starts at steady state</td></tr>
  <tr><td>step_height</td><td>10.0</td>
      <td>Step magnitude; signal moves from 10 to 20</td></tr>
  <tr><td>step_startTime</td><td>10 s</td>
      <td>Allows the initial transient to settle before the step occurs</td></tr>
  <tr><td>tau_sensor</td><td>0.5 s</td>
      <td>Fast sensor (e.g. pressure transducer); dominant pole at 2 rad/s</td></tr>
  <tr><td>noise_samplePeriod</td><td>0.05 s</td>
      <td>20 Hz &mdash; 40&times; above sensor bandwidth;
          &sigma;&nbsp;=&nbsp;sqrt(0.02/0.05)&nbsp;&asymp;&nbsp;0.63</td></tr>
  <tr><td>noise_power</td><td>0.02</td>
      <td>Moderately strong noise; clearly visible relative to a step of 10</td></tr>
  <tr><td>lowPassFilter.tau</td><td>2 s</td>
      <td>4&times; tau_sensor &mdash; good noise rejection; pole at 0.5 rad/s</td></tr>
  <tr><td>leadLagFilter.T1</td><td>2 s</td>
      <td>Zero exactly cancels the LP pole at &tau;&nbsp;=&nbsp;2 s</td></tr>
  <tr><td>leadLagFilter.T2</td><td>0.5 s</td>
      <td>Pole matches sensor dynamics; net cascade &asymp; 1/(1&nbsp;+&nbsp;0.5s)</td></tr>
  </TABLE>
  <h4>References</h4>
  <dl>
    <dt>Tore H&auml;gglund:</dt>
    <dd><em>Process Control in Practice</em>, De Gruyter, 2023.
        ISBN 978-3-11-110372-3.</dd>
  </dl>
  </HTML>",
    revisions="<html>
<dl><dt>Industrial Control Systems : 2026</dt>
<dl><dt>List of revisions:</dt>
<p><ul>
<li>19 March 2026 (author: H. Tummescheit)</li>
</ul></p>
</dl></html>"));
end LeadLagFilter;
