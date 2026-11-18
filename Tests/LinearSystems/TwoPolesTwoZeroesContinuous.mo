within Tests.LinearSystems;
model TwoPolesTwoZeroesContinuous
  "Continuous TwoPolesTwoZeroes against the MSL transfer function"
  extends Modelica.Icons.Example;
  Modelica.Blocks.Sources.Step step(startTime=0.5) "Unit step at t = 0.5 s"
    annotation (Placement(transformation(extent={{-160,10},{-140,30}})));
  IndustrialControlSystems.LinearSystems.Continuous.TwoPolesTwoZeroes tptz_T1(mu=1, T1=4, T2=2, T3=10)
    annotation (Placement(transformation(extent={{-120,-10},{-100,10}})));
  Modelica.Blocks.Continuous.TransferFunction ref_T1(b={1*4*2, 1*(4 + 2), 1}, a={10, 1, 0}, initType=Modelica.Blocks.Types.Init.InitialState) "Reference mu(1+sT1)(1+sT2)/(s(1+sT3))"
    annotation (Placement(transformation(extent={{-120,-40},{-100,-20}})));
  Utilities.CheckReal chk_T1(absTol=1e-4, relTol=1e-3, tStart=0.05, dt=0.1)
    annotation (Placement(transformation(extent={{-60,-30},{-40,-10}})));
  IndustrialControlSystems.LinearSystems.Continuous.TwoPolesTwoZeroes tptz_T1eq1(mu=1, T1=1, T2=2, T3=10)
    annotation (Placement(transformation(extent={{-120,-70},{-100,-50}})));
  Modelica.Blocks.Continuous.TransferFunction ref_T1eq1(b={1*1*2, 1*(1 + 2), 1}, a={10, 1, 0}, initType=Modelica.Blocks.Types.Init.InitialState) "Reference mu(1+sT1)(1+sT2)/(s(1+sT3))"
    annotation (Placement(transformation(extent={{-120,-100},{-100,-80}})));
  Utilities.CheckReal chk_T1eq1(absTol=1e-4, relTol=1e-3, tStart=0.05, dt=0.1)
    annotation (Placement(transformation(extent={{-60,-90},{-40,-70}})));
  Boolean passed = chk_T1.passed and chk_T1eq1.passed "true if every check in this test passed";
equation
  connect(step.y, tptz_T1.u) annotation (Line(points={{-139,20},{-130,20},{-130,0},{-118,0}}, color={0,0,127}));
  connect(step.y, ref_T1.u) annotation (Line(points={{-139,20},{-130,20},{-130,-30},{-122,-30}}, color={0,0,127}));
  connect(tptz_T1.y, chk_T1.actual) annotation (Line(points={{-101,0},{-80,0},{-80,-14},{-62,-14}}, color={0,0,127}));
  connect(ref_T1.y, chk_T1.expected) annotation (Line(points={{-99,-30},{-70,-30},{-70,-26},{-62,-26}}, color={0,0,127}));
  connect(step.y, tptz_T1eq1.u) annotation (Line(points={{-139,20},{-130,20},{-130,-60},{-118,-60}}, color={0,0,127}));
  connect(step.y, ref_T1eq1.u) annotation (Line(points={{-139,20},{-130,20},{-130,-90},{-122,-90}}, color={0,0,127}));
  connect(tptz_T1eq1.y, chk_T1eq1.actual) annotation (Line(points={{-101,-60},{-80,-60},{-80,-74},{-62,-74}}, color={0,0,127}));
  connect(ref_T1eq1.y, chk_T1eq1.expected) annotation (Line(points={{-99,-90},{-70,-90},{-70,-86},{-62,-86}}, color={0,0,127}));
  annotation (
    experiment(StopTime=20, Tolerance=1e-8, Interval=0.01),
    Diagram(coordinateSystem(extent={{-170,-110},{-30,40}}, grid={1,1})),
    Documentation(info="<html>
<p>Compares <a href=\"modelica://IndustrialControlSystems.LinearSystems.Continuous.TwoPolesTwoZeroes\">TwoPolesTwoZeroes</a>
with the transfer function its description states, mu(1+sT1)(1+sT2)/(s(1+sT3)), realised by
<code>Modelica.Blocks.Continuous.TransferFunction</code>, for a unit step at t = 0.5 s from rest.
Each row is block under test, reference, check. Tolerance: 1e-4 + 1e-3*|expected|, checked every 0.1 s.</p>
<ul><li><code>_T1</code>: the block's default parameters (T1=4, T2=2, T3=10).</li>
<li><code>_T1eq1</code>: the same with T1=1.</li></ul>
<p>The verdict is <code>passed</code>.</p>
</html>"));
end TwoPolesTwoZeroesContinuous;
