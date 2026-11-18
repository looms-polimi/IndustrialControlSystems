within Tests.MathOperations.MCDC.RealType.Expression;
model Base "MC/DC base: IndustrialControlSystems.MathOperations.RealType.Expression, continuous, floating point"
  extends Modelica.Icons.Example;
  parameter Real Ts = 0 "Sampling time (0: continuous)" annotation(Evaluate=true);
  parameter Boolean FixedPoint = false "Fixed-point arithmetic (16 bit, scale 100)" annotation(Evaluate=true);
  parameter Boolean useInputs = true "Inputs enabled" annotation(Evaluate=true);
  Modelica.Blocks.Sources.TimeTable u[3](table={[0,1; 1.03,1; 1.03,150; 2.0300000000000002,150; 2.03,-150; 3.03,-150; 3.03,0.25; 4.029999999999999,0.25], [0,2; 1.03,2; 1.03,150; 2.0300000000000002,150; 2.03,-150; 3.03,-150; 3.03,-0.5; 4.029999999999999,-0.5], [0,3; 1.03,3; 1.03,150; 2.0300000000000002,150; 2.03,-150; 3.03,-150; 3.03,1.75; 4.029999999999999,1.75]}) if useInputs "Inputs"
    annotation (Placement(transformation(extent={{-50,-10},{-30,10}})));
  IndustrialControlSystems.MathOperations.RealType.Expression dut(nInput=3, Ts=Ts, FixedPoint=FixedPoint, useInputs=useInputs, Nbit=16, scaleFactor=100,
    redeclare function f = Tests.MathOperations.MCDC.RealType.Expression.Sum,
    redeclare function g = Tests.MathOperations.reScale, fname="sum") "Expression under test"
    annotation (Placement(transformation(extent={{-10,-10},{10,10}})));
  Tests.Utilities.CheckRealWhile chkY(
      actual=dut.y,
      expected=if FixedPoint then max(-32767/100, min(32768/100, (if useInputs then sum(dut.u_set) else 0))) else (if useInputs then sum(dut.u_set) else 0),
      active=Ts <= 0 or (abs((time - floor(time)) - 0.03) > 0.15 and abs((time - floor(time)) - 0.03 - 1) > 0.15),
      absTol=if FixedPoint then 0.02 else 1e-9,
      relTol=if FixedPoint then 0.02 else 1e-9,
      tStart=0.01,
      dt=0.05)
    "y = sum of the inputs (0 without inputs); fixed point: limited to the representable range"
    annotation (Placement(transformation(extent={{30,0},{50,20}})));
  Tests.Utilities.Witness saturates(
      enable=FixedPoint,
      u=abs(dut.y - (32768/100)) < 1e-9 or abs(dut.y - (-32767/100)) < 1e-9)
    "fixed point: the sum reaches a limit of the representable range"
    annotation (Placement(transformation(extent={{60,0},{80,20}})));
  Boolean passed = chkY.passed and saturates.passed
    "true if every enabled check of this configuration passed";
equation
  connect(u.y, dut.u) annotation (Line(points={{-29,0},{-8,0}}, color={0,0,127}));
  annotation (
    experiment(StopTime=4.5, Interval=0.005, Tolerance=1e-6),
    Diagram(coordinateSystem(extent={{-60,-20},{90,30}}, grid={1,1})),
    Documentation(info="<html>
<p>Base of the MC/DC tests of <a href=\"modelica://IndustrialControlSystems.MathOperations.RealType.Expression\">Expression</a> with f = sum of three inputs and g = division by the scale factor; one input triple per second, the second and third leaving the fixed-point range. Without inputs (<code>useInputs = false</code>) the block uses zeros.</p>
<p>Checks (each enabled only where it applies; <code>passed</code> is their conjunction):</p>
<ul><li><code>chkY</code>: y = sum of the inputs (0 without inputs); fixed point: limited to the representable range</li><li><code>saturates</code>: fixed point: the sum reaches a limit of the representable range</li></ul>
</html>"));
end Base;
