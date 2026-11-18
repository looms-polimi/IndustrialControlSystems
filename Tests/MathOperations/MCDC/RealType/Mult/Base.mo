within Tests.MathOperations.MCDC.RealType.Mult;
model Base "MC/DC base: IndustrialControlSystems.MathOperations.RealType.Mult, continuous, floating point"
  extends Modelica.Icons.Example;
  parameter Real Ts = 0 "Sampling time (0: continuous)" annotation(Evaluate=true);
  parameter Boolean FixedPoint = false "Fixed-point arithmetic (16 bit, scale 100)" annotation(Evaluate=true);
  Modelica.Blocks.Sources.TimeTable u1(table=[0,0.5; 1.03,0.5; 1.03,2; 2.0300000000000002,2; 2.03,-2; 3.03,-2; 3.03,1.2; 4.029999999999999,1.2]) "First operand"
    annotation (Placement(transformation(extent={{-70,10},{-50,30}})));
  Modelica.Blocks.Sources.TimeTable u2(table=[0,1.5; 1.03,1.5; 1.03,2; 2.0300000000000002,2; 2.03,2; 3.03,2; 3.03,-0.7; 4.029999999999999,-0.7]) "Second operand"
    annotation (Placement(transformation(extent={{-70,-30},{-50,-10}})));
  IndustrialControlSystems.MathOperations.RealType.Mult dut(Ts=Ts, FixedPoint=FixedPoint, Nbit=16, scaleFactor=100) "Operator under test"
    annotation (Placement(transformation(extent={{-10,-10},{10,10}})));
  Tests.Utilities.CheckRealWhile chkY(
      actual=dut.y,
      expected=if FixedPoint then max(-32767/100^2, min(32768/100^2, u1.y*u2.y)) else u1.y*u2.y,
      active=Ts <= 0 or (abs((time - floor(time)) - 0.03) > 0.15 and abs((time - floor(time)) - 0.03 - 1) > 0.15),
      absTol=if FixedPoint then 0.02 else 1e-9,
      relTol=if FixedPoint then 0.02 else 1e-9,
      tStart=0.01,
      dt=0.05)
    "y = u1*u2; fixed point: limited to the representable range, within the quantisation (0.02 + 2 %)"
    annotation (Placement(transformation(extent={{30,0},{50,20}})));
  Tests.Utilities.Witness saturates(
      enable=FixedPoint,
      u=abs(dut.y - (32768/100^2)) < 1e-9 or abs(dut.y - (-32767/100^2)) < 1e-9)
    "fixed point: the result reaches a limit of the representable range in the saturating phases"
    annotation (Placement(transformation(extent={{60,0},{80,20}})));
  Boolean passed = chkY.passed and saturates.passed
    "true if every enabled check of this configuration passed";
equation
  connect(u1.y, dut.u1) annotation (Line(points={{-49,20},{-30,20},{-30,4},{-8,4}}, color={0,0,127}));
  connect(u2.y, dut.u2) annotation (Line(points={{-49,-20},{-24,-20},{-24,-4},{-8,-4}}, color={0,0,127}));
  annotation (
    experiment(StopTime=4.5, Interval=0.005, Tolerance=1e-6),
    Diagram(coordinateSystem(extent={{-80,-40},{90,40}}, grid={1,1})),
    Documentation(info="<html>
<p>Base of the MC/DC tests of <a href=\"modelica://IndustrialControlSystems.MathOperations.RealType.Mult\">Mult</a>: one operand pair per second (u1 = [0.5, 2, -2, 1.2], u2 = [1.5, 2, 2, -0.7]), including pairs whose fixed-point result leaves the 16-bit range (scale 100: [-327.67, 327.68]). The fixed-point product is scaled by scaleFactor^2, so it saturates at 3.2768. Note the library default Ts = 0.1; the base sets Ts = 0.</p>
<p>Checks (each enabled only where it applies; <code>passed</code> is their conjunction):</p>
<ul><li><code>chkY</code>: y = u1*u2; fixed point: limited to the representable range, within the quantisation (0.02 + 2 %)</li><li><code>saturates</code>: fixed point: the result reaches a limit of the representable range in the saturating phases</li></ul>
</html>"));
end Base;
