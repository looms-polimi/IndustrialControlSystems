within Tests.MathOperations.MCDC.IntegerType.Expression;
model Base "MC/DC base: IndustrialControlSystems.MathOperations.IntegerType.Expression, continuous"
  extends Modelica.Icons.Example;
  parameter Real Ts = 0 "Sampling time (0: continuous)" annotation(Evaluate=true);
  Modelica.Blocks.Sources.IntegerTable u[3](table={[0,1; 1.03,-3; 2.03,4], [0,2; 1.03,5; 2.03,-6], [0,3; 1.03,0; 2.03,7]}) "Inputs"
    annotation (Placement(transformation(extent={{-50,-10},{-30,10}})));
  IndustrialControlSystems.MathOperations.IntegerType.Expression dut(nInput=3, Ts=Ts, redeclare function f = Tests.MathOperations.SumSquare,
    fname="sum of squares") "Expression under test"
    annotation (Placement(transformation(extent={{-10,-10},{10,10}})));
  Tests.Utilities.CheckRealWhile chkY(
      actual=dut.y,
      expected=sum(u[i].y^2 for i in 1:3),
      active=Ts <= 0 or (abs((time - floor(time)) - 0.03) > 0.15 and abs((time - floor(time)) - 0.03 - 1) > 0.15),
      absTol=0.5,
      tStart=0.01,
      dt=0.05)
    "y = sum of the squares of the inputs"
    annotation (Placement(transformation(extent={{30,-10},{50,10}})));
  Boolean passed = chkY.passed
    "true if every enabled check of this configuration passed";
equation
  connect(u.y, dut.u) annotation (Line(points={{-29,0},{-8,0}}, color={255,127,0}));
  annotation (
    experiment(StopTime=3.5, Interval=0.005, Tolerance=1e-6),
    Diagram(coordinateSystem(extent={{-60,-20},{60,20}}, grid={1,1})),
    Documentation(info="<html>
<p>Base of the MC/DC tests of <a href=\"modelica://IndustrialControlSystems.MathOperations.IntegerType.Expression\">Expression</a> with f = sum of squares (<code>Tests.MathOperations.SumSquare</code>).</p>
<p>Checks (each enabled only where it applies; <code>passed</code> is their conjunction):</p>
<ul><li><code>chkY</code>: y = sum of the squares of the inputs</li></ul>
</html>"));
end Base;
