within Tests.Controllers.MCDC.D;
model Base "MC/DC base: IndustrialControlSystems.Controllers.D, open loop, every option off"
  extends Modelica.Icons.Example;
  parameter Real Ts = 0 "Sampling time of the controller under test (0: continuous)" annotation(Evaluate=true);
  parameter IndustrialControlSystems.LinearSystems.Discrete.Types.discrMethod method=
    IndustrialControlSystems.LinearSystems.Discrete.Types.discrMethod.BE "Discretisation method (Ts > 0)"
    annotation(Evaluate=true);
  parameter Boolean AntiWindup = false "Output limits and anti-windup" annotation(Evaluate=true);
  parameter Boolean useTS = false "Tracking inputs TS, TR" annotation(Evaluate=true);
  parameter Boolean useBIAS = false "Bias input" annotation(Evaluate=true);
  parameter Boolean useSAT = false "Saturation outputs satHI, satLOW" annotation(Evaluate=true);

  parameter Real CSmin = 0 "Lower output limit";
  parameter Real CSmax = 1 "Upper output limit";
  parameter Real tolAW = 0.1
    "Tolerance of the limit checks: the limits act on CS directly, the anti-windup only once a limit has been passed";


  Modelica.Blocks.Sources.BooleanTable ts(table={6.02, 8.02, 20.02, 23.02}, startValue=false) if useTS "Track switch"
    annotation (Placement(transformation(extent={{-70,70},{-50,90}})));
  Modelica.Blocks.Sources.TimeTable tr(table=[0,0.5; 14,0.5; 14,1.5; 40,1.5]) if useTS "Track reference"
    annotation (Placement(transformation(extent={{-70,40},{-50,60}})));
  Modelica.Blocks.Sources.Step bias(height=0.3, startTime=3.02) if useBIAS "Bias"
    annotation (Placement(transformation(extent={{-70,10},{-50,30}})));
  Modelica.Blocks.Sources.TimeTable sp(table=[0,0; 1.02,0; 1.02,1; 15.02,1; 15.02,-1.5; 30.02,-1.5; 30.02,0; 40,0]) "Set point"
    annotation (Placement(transformation(extent={{-70,-20},{-50,0}})));

  IndustrialControlSystems.Controllers.D dut(Ts=Ts, method=method, AntiWindup=AntiWindup, useTS=useTS, useBIAS=useBIAS,
    useSAT=useSAT, CSmin=CSmin, CSmax=CSmax, CS_start=0, Td=1, N=5, PV=0) "Controller under test"
    annotation (Placement(transformation(extent={{-10,-10},{10,10}})));
  Modelica.Blocks.Sources.TimeTable spRef(table=[0,0; 1.02,0; 1.02,1; 15.02,1; 15.02,-1.5; 30.02,-1.5; 30.02,0; 40,0]) "Set point of the reference"
    annotation (Placement(transformation(extent={{-70,-60},{-50,-40}})));
  Modelica.Blocks.Continuous.TransferFunction ref(b={1, 0}, a={1/5, 1},
    initType=Modelica.Blocks.Types.Init.InitialState) "Continuous ideal: s*Td/(1 + s*Td/N), Td = 1, N = 5"
    annotation (Placement(transformation(extent={{-30,-60},{-10,-40}})));
  Tests.Utilities.CheckRealWhile chkStart(
      actual=dut.CS,
      expected=0,
      active=time < 1,
      absTol=1e-3,
      tStart=0.05,
      dt=0.1)
    "Output before the first set-point step: CS_start = 0 (FBstart for initFromFBstart)"
    annotation (Placement(transformation(extent={{40,70},{60,90}})));
  Tests.Utilities.CheckRealWhile chkRef(
      enable=not AntiWindup and not useTS,
      actual=dut.CS,
      expected=ref.y + dut.bias + 0,
      absTol=if Ts > 0 then 0.05 else 1e-3,
      relTol=if Ts > 0 then 0.05 else 1e-3,
      active=Ts <= 0 or not ((time > 1.02 and time < 3.0) or (time > 15.02 and time < 17.0) or (time > 30.02 and time < 32.0)),
      tStart=0.9,
      dt=1)
    "Without limits and tracking: output = continuous ideal + bias; sampled: within 0.05 + 5 %, except in the 2 s after a set-point step (the discretised derivative filter decays differently)"
    annotation (Placement(transformation(extent={{70,70},{90,90}})));
  Tests.Utilities.CheckRealWhile chkTrack(
      enable=useTS,
      actual=dut.CS,
      expected=if AntiWindup then max(CSmin, min(CSmax, dut.tr)) else dut.tr,
      active=(time > 7.1 and time < 8.0) or (time > 21.1 and time < 23.0),
      absTol=0.01,
      tStart=0.05,
      dt=0.1)
    "Tracking: CS = TR (limited if AntiWindup), 1 s after TS rises"
    annotation (Placement(transformation(extent={{40,40},{60,60}})));
  Tests.Utilities.Never limits(
      enable=AntiWindup,
      u=dut.CS > CSmax + tolAW or dut.CS < CSmin - tolAW)
    "AntiWindup: CS stays in [CSmin, CSmax]"
    annotation (Placement(transformation(extent={{70,40},{90,60}})));
  Tests.Utilities.Witness recovers(
      enable=AntiWindup,
      u=time > 15.02 and time < 18 and dut.CS < CSmax - tolAW)
    "AntiWindup: CS leaves CSmax within 3 s of the set-point reversal (no wind-up)"
    annotation (Placement(transformation(extent={{40,10},{60,30}})));
  Tests.Utilities.Witness exceedsMax(
      enable=not AntiWindup,
      u=dut.CS > CSmax + tolAW)
    "No anti-windup: CS goes above CSmax (the limit is not applied)"
    annotation (Placement(transformation(extent={{70,10},{90,30}})));
  Tests.Utilities.Witness exceedsMin(
      enable=not AntiWindup,
      u=dut.CS < CSmin - tolAW)
    "No anti-windup: CS goes below CSmin"
    annotation (Placement(transformation(extent={{40,-20},{60,0}})));
  Tests.Utilities.Witness satHigh(
      enable=useSAT and AntiWindup,
      u=dut.satHigh)
    "useSAT with AntiWindup: satHI occurs"
    annotation (Placement(transformation(extent={{70,-20},{90,0}})));
  Tests.Utilities.Witness satLow(
      enable=useSAT and AntiWindup,
      u=dut.satLow)
    "useSAT with AntiWindup: satLOW occurs"
    annotation (Placement(transformation(extent={{40,-50},{60,-30}})));
  Tests.Utilities.Never satNone(
      enable=useSAT and not AntiWindup,
      u=dut.satHigh or dut.satLow)
    "useSAT without AntiWindup: satHI and satLOW stay false"
    annotation (Placement(transformation(extent={{70,-50},{90,-30}})));
  Tests.Utilities.Never satBoth(
      enable=useSAT,
      u=dut.satHigh and dut.satLow)
    "satHI and satLOW never together"
    annotation (Placement(transformation(extent={{40,-80},{60,-60}})));
  Boolean passed = chkStart.passed and chkRef.passed and chkTrack.passed and limits.passed and recovers.passed and exceedsMax.passed and exceedsMin.passed and satHigh.passed and satLow.passed and satNone.passed and satBoth.passed
    "true if every enabled check of this configuration passed";
equation
  connect(ts.y, dut.TS) annotation (Line(points={{-49,80},{4,80},{4,8}}, color={255,0,255}));
  connect(tr.y, dut.TR) annotation (Line(points={{-49,50},{0,50},{0,8}}, color={0,0,127}));
  connect(bias.y, dut.BIAS) annotation (Line(points={{-49,20},{-4,20},{-4,8}}, color={0,0,127}));
  connect(sp.y, dut.SP) annotation (Line(points={{-49,-10},{-30,-10},{-30,6},{-8,6}}, color={0,0,127}));

  connect(spRef.y, ref.u) annotation (Line(points={{-49,-50},{-32,-50}}, color={0,0,127}));
  annotation (
    experiment(StopTime=40, Interval=0.01, Tolerance=1e-6),
    Diagram(coordinateSystem(extent={{-80,-90},{100,100}}, grid={1,1})),
    Documentation(info="<html>
<p>Base of the MC/DC tests of <a href=\"modelica://IndustrialControlSystems.Controllers.D\">IndustrialControlSystems.Controllers.D</a>: the class
under test <code>dut</code> with every option off, its stimuli, a continuous ideal
<code>ref</code> built from <code>Modelica.Blocks</code>, and the checks. The variants in this
package extend it and change one option (or the pair an MC/DC independence pair needs); a
source that only an option needs is instantiated only with it.</p>
<p>Open loop, PV = 0: the set point is 0, steps to 1 at t = 1.02 s, to -1.5 at 15.02 s and
back to 0 at 30.02 s, so the output of every class leaves [CSmin, CSmax] = [0, 1] upwards and
downwards when nothing limits it. Event times are off the sampling grid of the sampled
variants. Tracking (<code>useTS</code>): TS is true on [6.02, 8.02] (TR = 0.5, inside the
limits) and [20.02, 23.02] (TR = 1.5, above CSmax). Bias (<code>useBIAS</code>): 0.3 from
3.02 s.</p>
<p>Checks (each enabled only where it applies; <code>passed</code> is their conjunction):</p>
<ul><li><code>chkStart</code>: Output before the first set-point step: CS_start = 0 (FBstart for initFromFBstart)</li><li><code>chkRef</code>: Without limits and tracking: output = continuous ideal + bias; sampled: within 0.05 + 5 %, except in the 2 s after a set-point step (the discretised derivative filter decays differently)</li><li><code>chkTrack</code>: Tracking: CS = TR (limited if AntiWindup), 1 s after TS rises</li><li><code>limits</code>: AntiWindup: CS stays in [CSmin, CSmax]</li><li><code>recovers</code>: AntiWindup: CS leaves CSmax within 3 s of the set-point reversal (no wind-up)</li><li><code>exceedsMax</code>: No anti-windup: CS goes above CSmax (the limit is not applied)</li><li><code>exceedsMin</code>: No anti-windup: CS goes below CSmin</li><li><code>satHigh</code>: useSAT with AntiWindup: satHI occurs</li><li><code>satLow</code>: useSAT with AntiWindup: satLOW occurs</li><li><code>satNone</code>: useSAT without AntiWindup: satHI and satLOW stay false</li><li><code>satBoth</code>: satHI and satLOW never together</li></ul>
<p>Limit checks use the tolerance <code>tolAW</code> = 0.1 (anti-windup acts only once a limit
has been passed). Sampled variants (<code>Ts</code> = 0.05) are compared with the continuous
ideal within 0.05 + 5 %.</p>
</html>"));
end Base;
