within Tests.Controllers.MCDC.Blocks.ComplexPoles;
model Base "MC/DC base: IndustrialControlSystems.Controllers.Blocks.ComplexPoles, every option off"
  extends Modelica.Icons.Example;
  parameter Boolean AntiWindup = false "Output limits and anti-windup" annotation(Evaluate=true);
  parameter Boolean useTS = false "Tracking inputs TS, TR" annotation(Evaluate=true);
  parameter Real Ymin = 0 "Lower output limit";
  parameter Real Ymax = 1 "Upper output limit";
  parameter Real tolAW = 0.1 "Tolerance of the limit checks";
  Modelica.Blocks.Sources.BooleanTable ts(table={6.02, 8.02, 20.02, 23.02}, startValue=false) if useTS "Track switch"
    annotation (Placement(transformation(extent={{-70,50},{-50,70}})));
  Modelica.Blocks.Sources.TimeTable tr(table=[0,0.5; 14,0.5; 14,1.5; 40,1.5]) if useTS "Track reference"
    annotation (Placement(transformation(extent={{-70,20},{-50,40}})));
  Modelica.Blocks.Sources.TimeTable u(table=[0,0; 1.02,0; 1.02,1; 15.02,1; 15.02,-1.5; 30.02,-1.5; 30.02,0; 40,0]) "Input"
    annotation (Placement(transformation(extent={{-70,-10},{-50,10}})));
  IndustrialControlSystems.Controllers.Blocks.ComplexPoles dut(AntiWindup=AntiWindup, useTS=useTS, Ymin=Ymin, Ymax=Ymax, mu=2, omega=1, xi=0.5) "Block under test"
    annotation (Placement(transformation(extent={{-10,-10},{10,10}})));
  Modelica.Blocks.Sources.TimeTable uRef(table=[0,0; 1.02,0; 1.02,1; 15.02,1; 15.02,-1.5; 30.02,-1.5; 30.02,0; 40,0]) "Input of the reference"
    annotation (Placement(transformation(extent={{-70,-50},{-50,-30}})));
  Modelica.Blocks.Continuous.SecondOrder ref(k=2, w=1, D=0.5, initType=Modelica.Blocks.Types.Init.InitialState, y_start=0, yd_start=0) "Reference: 2/(1 + s + s^2)"
    annotation (Placement(transformation(extent={{-30,-50},{-10,-30}})));
  Tests.Utilities.CheckRealWhile chkStart(
      actual=dut.y,
      expected=0,
      active=time < 1,
      absTol=1e-3,
      tStart=0.05,
      dt=0.1)
    "Output before the first input step: 0"
    annotation (Placement(transformation(extent={{40,50},{60,70}})));
  Tests.Utilities.CheckRealWhile chkRef(
      enable=not AntiWindup and not useTS,
      actual=dut.y,
      expected=ref.y,
      absTol=1e-3,
      relTol=1e-3,
      tStart=0.9,
      dt=1)
    "Without limits and tracking: y = 2/(1 + s + s^2) of u (Modelica.Blocks reference)"
    annotation (Placement(transformation(extent={{70,50},{90,70}})));
  Tests.Utilities.CheckRealWhile chkTrack(
      enable=useTS,
      actual=dut.y,
      expected=if AntiWindup then max(Ymin, min(Ymax, dut.tr)) else dut.tr,
      active=(time > 7.1 and time < 8.0) or (time > 21.1 and time < 23.0),
      absTol=0.01,
      tStart=0.05,
      dt=0.1)
    "Tracking: y = TR (limited if AntiWindup), 1 s after TS rises"
    annotation (Placement(transformation(extent={{40,20},{60,40}})));
  Tests.Utilities.Never limits(
      enable=AntiWindup,
      u=dut.y > Ymax + tolAW or dut.y < Ymin - tolAW)
    "AntiWindup: y stays in [Ymin, Ymax]"
    annotation (Placement(transformation(extent={{70,20},{90,40}})));
  Tests.Utilities.Witness recovers(
      enable=AntiWindup,
      u=time > 15.02 and time < 18 and dut.y < Ymax - tolAW)
    "AntiWindup: y leaves Ymax within 3 s of the input reversal"
    annotation (Placement(transformation(extent={{40,-10},{60,10}})));
  Tests.Utilities.Witness exceedsMax(
      enable=not AntiWindup,
      u=dut.y > Ymax + tolAW)
    "No anti-windup: y goes above Ymax"
    annotation (Placement(transformation(extent={{70,-10},{90,10}})));
  Tests.Utilities.Witness exceedsMin(
      enable=not AntiWindup,
      u=dut.y < Ymin - tolAW)
    "No anti-windup: y goes below Ymin"
    annotation (Placement(transformation(extent={{40,-40},{60,-20}})));
  Boolean passed = chkStart.passed and chkRef.passed and chkTrack.passed and limits.passed and recovers.passed and exceedsMax.passed and exceedsMin.passed
    "true if every enabled check of this configuration passed";
equation
  connect(ts.y, dut.TS) annotation (Line(points={{-49,60},{5,60},{5,8}}, color={255,0,255}));
  connect(tr.y, dut.TR) annotation (Line(points={{-49,30},{0,30},{0,8}}, color={0,0,127}));
  connect(u.y, dut.u) annotation (Line(points={{-49,0},{-8,0}}, color={0,0,127}));
  connect(uRef.y, ref.u) annotation (Line(points={{-49,-40},{-32,-40}}, color={0,0,127}));
  annotation (
    experiment(StopTime=40, Interval=0.01, Tolerance=1e-6),
    Diagram(coordinateSystem(extent={{-80,-60},{100,80}}, grid={1,1})),
    Documentation(info="<html>
<p>Base of the MC/DC tests of <a href=\"modelica://IndustrialControlSystems.Controllers.Blocks.ComplexPoles\">IndustrialControlSystems.Controllers.Blocks.ComplexPoles</a>
(mu=2, omega=1, xi=0.5): <code>dut</code> with every option off, its input, a reference from
<code>Modelica.Blocks</code> (2/(1 + s + s^2)), and the checks. The variants extend it and change one option or
an MC/DC pair.</p>
<p>Open loop, PV = 0: the input is 0, steps to 1 at t = 1.02 s, to -1.5 at 15.02 s and
back to 0 at 30.02 s, so the output of every class leaves [CSmin, CSmax] = [0, 1] upwards and
downwards when nothing limits it. Event times are off the sampling grid of the sampled
variants. Tracking (<code>useTS</code>): TS is true on [6.02, 8.02] (TR = 0.5, inside the
limits) and [20.02, 23.02] (TR = 1.5, above CSmax). Bias (<code>useBIAS</code>): 0.3 from
3.02 s.</p>
<p>Checks (each enabled only where it applies; <code>passed</code> is their conjunction):</p>
<ul><li><code>chkStart</code>: Output before the first input step: 0</li><li><code>chkRef</code>: Without limits and tracking: y = 2/(1 + s + s^2) of u (Modelica.Blocks reference)</li><li><code>chkTrack</code>: Tracking: y = TR (limited if AntiWindup), 1 s after TS rises</li><li><code>limits</code>: AntiWindup: y stays in [Ymin, Ymax]</li><li><code>recovers</code>: AntiWindup: y leaves Ymax within 3 s of the input reversal</li><li><code>exceedsMax</code>: No anti-windup: y goes above Ymax</li><li><code>exceedsMin</code>: No anti-windup: y goes below Ymin</li></ul>
</html>"));
end Base;
