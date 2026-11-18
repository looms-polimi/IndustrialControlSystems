within Tests.Logical.MCDC.And;
model Base "MC/DC base: IndustrialControlSystems.Logical.LogicalOperations.And, continuous, 3 inputs"
  extends Modelica.Icons.Example;
  parameter Integer n = 3 "Number of inputs" annotation(Evaluate=true);
  parameter Real Ts = 0 "Sampling time (0: continuous)" annotation(Evaluate=true);
  Modelica.Blocks.Sources.BooleanPulse src[n](period={2^i for i in 1:n}, each width=50, each startTime=0.03)
    "Inputs: every combination once in 2^n s"
    annotation (Placement(transformation(extent={{-50,-10},{-30,10}})));
  IndustrialControlSystems.Logical.LogicalOperations.And dut(nInput=n, Ts=Ts) "Gate under test"
    annotation (Placement(transformation(extent={{-10,-10},{10,10}})));
  Tests.Utilities.CheckRealWhile chkY(
      actual=if dut.y[1] then 1 else 0,
      expected=if Modelica.Math.BooleanVectors.allTrue(src.y) then 1 else 0,
      active=Ts <= 0 or (abs((time - floor(time)) - 0.03) > 0.15 and abs((time - floor(time)) - 0.03 - 1) > 0.15),
      absTol=0.5,
      tStart=0.01,
      dt=0.05)
    "y = AND of all inputs, for every input combination (sampled: away from the input edges)"
    annotation (Placement(transformation(extent={{30,-10},{50,10}})));
  Boolean passed = chkY.passed
    "true if every enabled check of this configuration passed";
equation
  connect(src.y, dut.u) annotation (Line(points={{-29,0},{-8,0}}, color={255,0,255}));
  annotation (
    experiment(StopTime=8.5, Interval=0.005, Tolerance=1e-6),
    Diagram(coordinateSystem(extent={{-60,-20},{60,20}}, grid={1,1})),
    Documentation(info="<html>
<p>Base of the MC/DC tests of <a href=\"modelica://IndustrialControlSystems.Logical.LogicalOperations.And\">And</a>: Boolean pulses of periods 2, 4, 8 s run through every input combination; the expected output is stated with <code>Modelica.Math.BooleanVectors</code>.</p>
<p>Checks (each enabled only where it applies; <code>passed</code> is their conjunction):</p>
<ul><li><code>chkY</code>: y = AND of all inputs, for every input combination (sampled: away from the input edges)</li></ul>
</html>"));
end Base;
