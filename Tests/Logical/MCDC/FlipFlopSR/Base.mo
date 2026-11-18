within Tests.Logical.MCDC.FlipFlopSR;
model Base "MC/DC base: IndustrialControlSystems.Logical.LogicalOperations.FlipFlopSR, q_start = false"
  extends Modelica.Icons.Example;
  parameter Boolean q_start = false "Initial output" annotation(Evaluate=true);
  discrete Boolean q(start=q_start, fixed=true) "Expected state";
  Modelica.Blocks.Sources.BooleanTable s(table={1.03, 2.03, 5.03, 7.03}, startValue=false) "Set"
    annotation (Placement(transformation(extent={{-70,10},{-50,30}})));
  Modelica.Blocks.Sources.BooleanTable r(table={3.03, 4.03, 6.03, 6.53}, startValue=false) "Reset (inside the second set pulse)"
    annotation (Placement(transformation(extent={{-70,-30},{-50,-10}})));
  IndustrialControlSystems.Logical.LogicalOperations.FlipFlopSR dut(Ts=0.1, q_start=q_start) "Flip-flop under test"
    annotation (Placement(transformation(extent={{-10,-10},{10,10}})));
  Tests.Utilities.CheckRealWhile chkQ(
      actual=if dut.y1 then 1 else 0,
      expected=if q then 1 else 0,
      active=abs((time - floor(time)) - 0.03) > 0.15 and abs((time - floor(time)) - 0.03 - 1) > 0.15 and abs(time - 6.53) > 0.15,
      absTol=0.5,
      tStart=0.01,
      dt=0.05)
    "y1 follows the set-reset logic (reset dominant), from q_start until the first edge"
    annotation (Placement(transformation(extent={{30,10},{50,30}})));
  Tests.Utilities.Never complement(
      u=(dut.y1 and dut.y2) or (not dut.y1 and not dut.y2))
    "y2 = not y1 always"
    annotation (Placement(transformation(extent={{60,10},{80,30}})));
  Boolean passed = chkQ.passed and complement.passed
    "true if every enabled check of this configuration passed";
equation
  connect(s.y, dut.u1) annotation (Line(points={{-49,20},{-30,20},{-30,5},{-8,5}}, color={255,0,255}));
  connect(r.y, dut.u2) annotation (Line(points={{-49,-20},{-24,-20},{-24,-5},{-8,-5}}, color={255,0,255}));
  when r.y then
    q = false;
  elsewhen s.y and not r.y then
    q = true;
  end when;
  annotation (
    experiment(StopTime=8.5, Interval=0.005, Tolerance=1e-6),
    Diagram(coordinateSystem(extent={{-80,-40},{90,40}}, grid={1,1})),
    Documentation(info="<html>
<p>Base of the MC/DC tests of <a href=\"modelica://IndustrialControlSystems.Logical.LogicalOperations.FlipFlopSR\">FlipFlopSR</a> (Ts = 0.1): set alone, hold, reset alone, set and reset together (reset wins), set again after the reset. The expected state <code>q</code> is stated independently.</p>
<p>Checks (each enabled only where it applies; <code>passed</code> is their conjunction):</p>
<ul><li><code>chkQ</code>: y1 follows the set-reset logic (reset dominant), from q_start until the first edge</li><li><code>complement</code>: y2 = not y1 always</li></ul>
</html>"));
end Base;
