within Tests.LinearSystems;
model TwoPolesTwoZeroesDiscrete
  "Discrete TwoPolesTwoZeroes (BE, FE, Tustin) against the continuous transfer function"
  extends Modelica.Icons.Example;
  parameter Real Ts = 0.01 "Sampling time";
  Modelica.Blocks.Sources.Step step(startTime=0.5) "Unit step at t = 0.5 s"
    annotation (Placement(transformation(extent={{-160,10},{-140,30}})));
  Modelica.Blocks.Sources.Sine sine(f=0.5) "Sine input"
    annotation (Placement(transformation(extent={{-160,-20},{-140,0}})));
  IndustrialControlSystems.LinearSystems.Discrete.TwoPolesTwoZeroes step_BE(Ts=Ts, method=IndustrialControlSystems.LinearSystems.Discrete.Types.discrMethod.BE, mu=1, T1=2, T2=0.03, T3=0.5)
    annotation (Placement(transformation(extent={{-110,-10},{-90,10}})));
  Modelica.Blocks.Continuous.TransferFunction ref_step_BE(b={1*2*0.03, 1*(2 + 0.03), 1}, a={0.5, 1, 0}, initType=Modelica.Blocks.Types.Init.InitialState) "Reference mu(1+sT1)(1+sT2)/(s(1+sT3))"
    annotation (Placement(transformation(extent={{-110,-40},{-90,-20}})));
  Utilities.CheckReal chk_step_BE(absTol=0.02, relTol=0.02, tStart=1 + Ts/100, dt=5*Ts)
    annotation (Placement(transformation(extent={{-50,-30},{-30,-10}})));
  IndustrialControlSystems.LinearSystems.Discrete.TwoPolesTwoZeroes step_FE(Ts=Ts, method=IndustrialControlSystems.LinearSystems.Discrete.Types.discrMethod.FE, mu=1, T1=2, T2=0.03, T3=0.5)
    annotation (Placement(transformation(extent={{-110,-70},{-90,-50}})));
  Modelica.Blocks.Continuous.TransferFunction ref_step_FE(b={1*2*0.03, 1*(2 + 0.03), 1}, a={0.5, 1, 0}, initType=Modelica.Blocks.Types.Init.InitialState) "Reference mu(1+sT1)(1+sT2)/(s(1+sT3))"
    annotation (Placement(transformation(extent={{-110,-100},{-90,-80}})));
  Utilities.CheckReal chk_step_FE(absTol=0.02, relTol=0.02, tStart=1 + Ts/100, dt=5*Ts)
    annotation (Placement(transformation(extent={{-50,-90},{-30,-70}})));
  IndustrialControlSystems.LinearSystems.Discrete.TwoPolesTwoZeroes step_TU(Ts=Ts, method=IndustrialControlSystems.LinearSystems.Discrete.Types.discrMethod.TU, mu=1, T1=2, T2=0.03, T3=0.5)
    annotation (Placement(transformation(extent={{-110,-130},{-90,-110}})));
  Modelica.Blocks.Continuous.TransferFunction ref_step_TU(b={1*2*0.03, 1*(2 + 0.03), 1}, a={0.5, 1, 0}, initType=Modelica.Blocks.Types.Init.InitialState) "Reference mu(1+sT1)(1+sT2)/(s(1+sT3))"
    annotation (Placement(transformation(extent={{-110,-160},{-90,-140}})));
  Utilities.CheckReal chk_step_TU(absTol=0.02, relTol=0.02, tStart=1 + Ts/100, dt=5*Ts)
    annotation (Placement(transformation(extent={{-50,-150},{-30,-130}})));
  IndustrialControlSystems.LinearSystems.Discrete.TwoPolesTwoZeroes sine_TU(Ts=Ts, method=IndustrialControlSystems.LinearSystems.Discrete.Types.discrMethod.TU, mu=1, T1=2, T2=0.03, T3=0.5)
    annotation (Placement(transformation(extent={{-110,-190},{-90,-170}})));
  Modelica.Blocks.Continuous.TransferFunction ref_sine_TU(b={1*2*0.03, 1*(2 + 0.03), 1}, a={0.5, 1, 0}, initType=Modelica.Blocks.Types.Init.InitialState) "Reference mu(1+sT1)(1+sT2)/(s(1+sT3))"
    annotation (Placement(transformation(extent={{-110,-220},{-90,-200}})));
  Utilities.CheckReal chk_sine_TU(absTol=0.02, relTol=0.02, tStart=1 + Ts/100, dt=5*Ts)
    annotation (Placement(transformation(extent={{-50,-210},{-30,-190}})));
  Boolean passed = chk_step_BE.passed and chk_step_FE.passed and chk_step_TU.passed and chk_sine_TU.passed "true if every check in this test passed";
equation
  connect(step.y, step_BE.u) annotation (Line(points={{-139,20},{-120,20},{-120,0},{-108,0}}, color={0,0,127}));
  connect(step.y, ref_step_BE.u) annotation (Line(points={{-139,20},{-120,20},{-120,-30},{-112,-30}}, color={0,0,127}));
  connect(step_BE.y, chk_step_BE.actual) annotation (Line(points={{-91,0},{-70,0},{-70,-14},{-52,-14}}, color={0,0,127}));
  connect(ref_step_BE.y, chk_step_BE.expected) annotation (Line(points={{-89,-30},{-60,-30},{-60,-26},{-52,-26}}, color={0,0,127}));
  connect(step.y, step_FE.u) annotation (Line(points={{-139,20},{-120,20},{-120,-60},{-108,-60}}, color={0,0,127}));
  connect(step.y, ref_step_FE.u) annotation (Line(points={{-139,20},{-120,20},{-120,-90},{-112,-90}}, color={0,0,127}));
  connect(step_FE.y, chk_step_FE.actual) annotation (Line(points={{-91,-60},{-70,-60},{-70,-74},{-52,-74}}, color={0,0,127}));
  connect(ref_step_FE.y, chk_step_FE.expected) annotation (Line(points={{-89,-90},{-60,-90},{-60,-86},{-52,-86}}, color={0,0,127}));
  connect(step.y, step_TU.u) annotation (Line(points={{-139,20},{-120,20},{-120,-120},{-108,-120}}, color={0,0,127}));
  connect(step.y, ref_step_TU.u) annotation (Line(points={{-139,20},{-120,20},{-120,-150},{-112,-150}}, color={0,0,127}));
  connect(step_TU.y, chk_step_TU.actual) annotation (Line(points={{-91,-120},{-70,-120},{-70,-134},{-52,-134}}, color={0,0,127}));
  connect(ref_step_TU.y, chk_step_TU.expected) annotation (Line(points={{-89,-150},{-60,-150},{-60,-146},{-52,-146}}, color={0,0,127}));
  connect(sine.y, sine_TU.u) annotation (Line(points={{-139,-10},{-130,-10},{-130,-180},{-108,-180}}, color={0,0,127}));
  connect(sine.y, ref_sine_TU.u) annotation (Line(points={{-139,-10},{-130,-10},{-130,-210},{-112,-210}}, color={0,0,127}));
  connect(sine_TU.y, chk_sine_TU.actual) annotation (Line(points={{-91,-180},{-70,-180},{-70,-194},{-52,-194}}, color={0,0,127}));
  connect(ref_sine_TU.y, chk_sine_TU.expected) annotation (Line(points={{-89,-210},{-60,-210},{-60,-206},{-52,-206}}, color={0,0,127}));
  annotation (
    experiment(StopTime=10, Tolerance=1e-8, Interval=0.001),
    Diagram(coordinateSystem(extent={{-170,-230},{-20,40}}, grid={1,1})),
    Documentation(info="<html>
<p>Compares <a href=\"modelica://IndustrialControlSystems.LinearSystems.Discrete.TwoPolesTwoZeroes\">Discrete.TwoPolesTwoZeroes</a>
(and its function <code>Functions.f2p2z</code>) with the continuous transfer function it discretises,
mu(1+sT1)(1+sT2)/(s(1+sT3)) with T1=2, T2=0.03, T3=0.5 and Ts=0.01. Each row is block under test, reference, check:</p>
<ul><li><code>step_BE</code>, <code>step_FE</code>, <code>step_TU</code>: unit step at t = 0.5 s with each discretisation method.</li>
<li><code>sine_TU</code>: a 0.5 Hz sine, Tustin.</li></ul>
<p>Checks start at t = 1 s, every 5 samples, just after a sampling instant, with tolerance
0.02 + 0.02*|expected| (the output is a ramp of slope mu, about 10 at the end).</p>
<p>The verdict is <code>passed</code>.</p>
</html>"));
end TwoPolesTwoZeroesDiscrete;
