within Tests.Logical.MCDC;
model Timer_OffDelay_Fedge "MC/DC scenario: IndustrialControlSystems.Logical.Timers.Timer_OffDelay_Fedge"
  extends Modelica.Icons.Example;
  parameter Real PV = 2 "Programmed time";
  discrete Real tRise(start=-100, fixed=true) "Time of the last rising edge of S";
  discrete Real tFall(start=-100, fixed=true) "Time of the last falling edge of S";
  discrete Boolean latchRise(start=false, fixed=true) "Set by a rising edge of S, cleared by R";
  discrete Boolean latchFall(start=false, fixed=true) "Set by a falling edge of S, cleared by R";
  Modelica.Blocks.Sources.BooleanTable s(table={1.03, 6.03, 8.03, 9.03, 11.03, 16.03}, startValue=false)
    "Set: long, short (< PV), long with a reset inside"
    annotation (Placement(transformation(extent={{-70,10},{-50,30}})));
  Modelica.Blocks.Sources.BooleanTable r(table={13.03, 13.53}, startValue=false) "Reset"
    annotation (Placement(transformation(extent={{-70,-20},{-50,0}})));
  Modelica.Blocks.Sources.Constant pv(k=PV) "Programmed time"
    annotation (Placement(transformation(extent={{-70,-50},{-50,-30}})));
  IndustrialControlSystems.Logical.Timers.Timer_OffDelay_Fedge dut "Timer under test (Ts = 0.01)"
    annotation (Placement(transformation(extent={{-10,-10},{10,10}})));
  Tests.Utilities.CheckRealWhile chkQ(
      actual=if dut.Q then 1 else 0,
      expected=if latchFall and not r.y and time - tFall >= PV then 1 else 0,
      active=abs((time - floor(time)) - 0.03) > 0.05 and abs((time - floor(time)) - 0.03 - 1) > 0.05 and abs((time - floor(time)) - 0.53) > 0.05 and abs((time - floor(time)) - 0.53 - 1) > 0.05,
      absTol=0.5,
      tStart=0.01,
      dt=0.02)
    "delay timer on the falling edge: Q rises PV after a falling edge of S and stays true until R"
    annotation (Placement(transformation(extent={{30,-10},{50,10}})));
  Boolean passed = chkQ.passed
    "true if every enabled check of this configuration passed";
equation
  connect(s.y, dut.S) annotation (Line(points={{-49,20},{-30,20},{-30,4},{-8,4}}, color={255,0,255}));
  connect(r.y, dut.R) annotation (Line(points={{-49,-10},{-20,-10},{-20,-4},{-8,-4}}, color={255,0,255}));
  connect(pv.y, dut.PV) annotation (Line(points={{-49,-40},{-4,-40},{-4,-8}}, color={0,0,127}));
  when s.y then
    tRise = time;
  end when;
  when not s.y then
    tFall = time;
  end when;
  when {s.y, r.y} then
    latchRise = s.y and not r.y;
  end when;
  when {not s.y, r.y} then
    latchFall = not s.y and not r.y;
  end when;
  annotation (
    experiment(StopTime=20, Interval=0.005, Tolerance=1e-6),
    Diagram(coordinateSystem(extent={{-80,-60},{60,40}}, grid={1,1})),
    Documentation(info="<html>
<p>MC/DC scenario of <a href=\"modelica://IndustrialControlSystems.Logical.Timers.Timer_OffDelay_Fedge\">Timer_OffDelay_Fedge</a> (no options; its decisions are run-time): S on [1.03, 6.03] (longer than PV = 2 s), [8.03, 9.03] (shorter) and [11.03, 16.03] with R on [13.03, 13.53]. Expected: delay timer on the falling edge: Q rises PV after a falling edge of S and stays true until R. The edge times and latches are stated independently in the test. Inputs switch between the samples of the timer (Ts = 0.01).</p>
<p>Checks (each enabled only where it applies; <code>passed</code> is their conjunction):</p>
<ul><li><code>chkQ</code>: delay timer on the falling edge: Q rises PV after a falling edge of S and stays true until R</li></ul>
</html>"));
end Timer_OffDelay_Fedge;
