within Tests.LinearSystems;
model TwoPolesTwoZeroesContinuous
  "Continuous TwoPolesTwoZeroes against the MSL transfer function"
  extends Modelica.Icons.Example;
  Modelica.Blocks.Sources.Step step(startTime=0.5) "Unit step at t = 0.5 s"
    annotation (Placement(transformation(extent={{-100,82},{-84,98}})));
  IndustrialControlSystems.LinearSystems.Continuous.TwoPolesTwoZeroes tptz_T1(mu=1, T1=4, T2=2, T3=10)
    annotation (Placement(transformation(extent={{0,82},{16,98}})));
  Modelica.Blocks.Continuous.TransferFunction ref_T1(b={1*4*2, 1*(4 + 2), 1}, a={10, 1, 0}, initType=Modelica.Blocks.Types.Init.InitialState) "Reference mu(1+sT1)(1+sT2)/(s(1+sT3)) from MSL"
    annotation (Placement(transformation(extent={{-50,82},{-34,98}})));
  Utilities.CheckReal chk_T1(absTol=1e-4, relTol=1e-3, tStart=0.05, dt=0.1)
    annotation (Placement(transformation(extent={{50,82},{66,98}})));
  IndustrialControlSystems.LinearSystems.Continuous.TwoPolesTwoZeroes tptz_T1eq1(mu=1, T1=1, T2=2, T3=10)
    annotation (Placement(transformation(extent={{0,57},{16,73}})));
  Modelica.Blocks.Continuous.TransferFunction ref_T1eq1(b={1*1*2, 1*(1 + 2), 1}, a={10, 1, 0}, initType=Modelica.Blocks.Types.Init.InitialState) "Reference mu(1+sT1)(1+sT2)/(s(1+sT3)) from MSL"
    annotation (Placement(transformation(extent={{-50,57},{-34,73}})));
  Utilities.CheckReal chk_T1eq1(absTol=1e-4, relTol=1e-3, tStart=0.05, dt=0.1)
    annotation (Placement(transformation(extent={{50,57},{66,73}})));
  Boolean passed = chk_T1.passed and chk_T1eq1.passed "true if every check in this test passed";
equation
  connect(step.y, tptz_T1.u);
  connect(step.y, ref_T1.u);
  connect(tptz_T1.y, chk_T1.actual);
  connect(ref_T1.y, chk_T1.expected);
  connect(step.y, tptz_T1eq1.u);
  connect(step.y, ref_T1eq1.u);
  connect(tptz_T1eq1.y, chk_T1eq1.actual);
  connect(ref_T1eq1.y, chk_T1eq1.expected);
  annotation (
    experiment(StopTime=20, Tolerance=1e-8, Interval=0.01),
    Diagram(coordinateSystem(extent={{-110,47},{76,100}})),
    Documentation(info="<html>
<p>Compares <a href=\"modelica://IndustrialControlSystems.LinearSystems.Continuous.TwoPolesTwoZeroes\">TwoPolesTwoZeroes</a>
with the transfer function its description states, mu(1+sT1)(1+sT2)/(s(1+sT3)), realised by
<code>Modelica.Blocks.Continuous.TransferFunction</code>, for a unit step at t = 0.5 s from rest.
Tolerance: 1e-4 + 1e-3*|expected|, checked every 0.1 s.</p>
<ul><li><code>_T1</code>: the block's default parameters (T1=4, T2=2, T3=10).</li>
<li><code>_T1eq1</code>: the same with T1=1.</li></ul>
<p>The verdict is <code>passed</code>.</p>
</html>"));
end TwoPolesTwoZeroesContinuous;
