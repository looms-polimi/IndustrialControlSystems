within Tests.LinearSystems;
model TwoPolesTwoZeroesDiscrete
  "Discrete TwoPolesTwoZeroes (BE, FE, Tustin) against the continuous transfer function"
  extends Modelica.Icons.Example;
  parameter Real Ts = 0.01 "Sampling time";
  Modelica.Blocks.Sources.Step step(startTime=0.5) "Unit step at t = 0.5 s"
    annotation (Placement(transformation(extent={{-100,82},{-84,98}})));
  Modelica.Blocks.Sources.Sine sine(f=0.5) "Sine input"
    annotation (Placement(transformation(extent={{-100,57},{-84,73}})));
  Modelica.Blocks.Continuous.TransferFunction ref_step(b={1*2*0.03, 1*(2 + 0.03), 1}, a={0.5, 1, 0}, initType=Modelica.Blocks.Types.Init.InitialState) "Reference mu(1+sT1)(1+sT2)/(s(1+sT3)) from MSL"
    annotation (Placement(transformation(extent={{-50,82},{-34,98}})));
  Modelica.Blocks.Continuous.TransferFunction ref_sine(b={1*2*0.03, 1*(2 + 0.03), 1}, a={0.5, 1, 0}, initType=Modelica.Blocks.Types.Init.InitialState) "Reference mu(1+sT1)(1+sT2)/(s(1+sT3)) from MSL"
    annotation (Placement(transformation(extent={{-50,57},{-34,73}})));
  IndustrialControlSystems.LinearSystems.Discrete.TwoPolesTwoZeroes step_BE(Ts=Ts, method=IndustrialControlSystems.LinearSystems.Discrete.Types.discrMethod.BE, mu=1, T1=2, T2=0.03, T3=0.5)
    annotation (Placement(transformation(extent={{0,82},{16,98}})));
  Utilities.CheckReal chk_step_BE(absTol=0.02, relTol=0.02, tStart=1 + Ts/100, dt=5*Ts)
    annotation (Placement(transformation(extent={{50,82},{66,98}})));
  IndustrialControlSystems.LinearSystems.Discrete.TwoPolesTwoZeroes step_FE(Ts=Ts, method=IndustrialControlSystems.LinearSystems.Discrete.Types.discrMethod.FE, mu=1, T1=2, T2=0.03, T3=0.5)
    annotation (Placement(transformation(extent={{0,57},{16,73}})));
  Utilities.CheckReal chk_step_FE(absTol=0.02, relTol=0.02, tStart=1 + Ts/100, dt=5*Ts)
    annotation (Placement(transformation(extent={{50,57},{66,73}})));
  IndustrialControlSystems.LinearSystems.Discrete.TwoPolesTwoZeroes step_TU(Ts=Ts, method=IndustrialControlSystems.LinearSystems.Discrete.Types.discrMethod.TU, mu=1, T1=2, T2=0.03, T3=0.5)
    annotation (Placement(transformation(extent={{0,32},{16,48}})));
  Utilities.CheckReal chk_step_TU(absTol=0.02, relTol=0.02, tStart=1 + Ts/100, dt=5*Ts)
    annotation (Placement(transformation(extent={{50,32},{66,48}})));
  IndustrialControlSystems.LinearSystems.Discrete.TwoPolesTwoZeroes sine_TU(Ts=Ts, method=IndustrialControlSystems.LinearSystems.Discrete.Types.discrMethod.TU, mu=1, T1=2, T2=0.03, T3=0.5)
    annotation (Placement(transformation(extent={{0,7},{16,23}})));
  Utilities.CheckReal chk_sine_TU(absTol=0.02, relTol=0.02, tStart=1 + Ts/100, dt=5*Ts)
    annotation (Placement(transformation(extent={{50,7},{66,23}})));
  Boolean passed = chk_step_BE.passed and chk_step_FE.passed and chk_step_TU.passed and chk_sine_TU.passed "true if every check in this test passed";
equation
  connect(step.y, ref_step.u);
  connect(sine.y, ref_sine.u);
  connect(step.y, step_BE.u);
  connect(step_BE.y, chk_step_BE.actual);
  connect(ref_step.y, chk_step_BE.expected);
  connect(step.y, step_FE.u);
  connect(step_FE.y, chk_step_FE.actual);
  connect(ref_step.y, chk_step_FE.expected);
  connect(step.y, step_TU.u);
  connect(step_TU.y, chk_step_TU.actual);
  connect(ref_step.y, chk_step_TU.expected);
  connect(sine.y, sine_TU.u);
  connect(sine_TU.y, chk_sine_TU.actual);
  connect(ref_sine.y, chk_sine_TU.expected);
  annotation (
    experiment(StopTime=10, Tolerance=1e-8, Interval=0.001),
    Diagram(coordinateSystem(extent={{-110,-3},{76,100}})),
    Documentation(info="<html>
<p>Compares <a href=\"modelica://IndustrialControlSystems.LinearSystems.Discrete.TwoPolesTwoZeroes\">Discrete.TwoPolesTwoZeroes</a>
(and its function <code>Functions.f2p2z</code>) with the continuous transfer function it discretises,
mu(1+sT1)(1+sT2)/(s(1+sT3)) with T1=2, T2=0.03, T3=0.5 and Ts=0.01:</p>
<ul><li><code>step_BE</code>, <code>step_FE</code>, <code>step_TU</code>: unit step at t = 0.5 s with each discretisation method.</li>
<li><code>sine_TU</code>: a 0.5 Hz sine, Tustin.</li></ul>
<p>Checks start at t = 1 s, every 5 samples, just after a sampling instant, with tolerance
0.02 + 0.02*|expected| (the output is a ramp of slope mu, about 10 at the end).</p>
<p>The verdict is <code>passed</code>.</p>
</html>"));
end TwoPolesTwoZeroesDiscrete;
