within Tests.Controllers.MCDC.AutoTuning.ATPIrelayNCdigital;
model Base "MC/DC base: IndustrialControlSystems.Controllers.AutoTuning.ATPIrelayNCdigital, closed loop, every option off"
  extends Modelica.Icons.Example;
  parameter Boolean AntiWindup = false "Output limits and anti-windup in PI mode" annotation(Evaluate=true);
  parameter Boolean useTS = false "Tracking inputs TS, TR" annotation(Evaluate=true);
  parameter Boolean useBIAS = false "Bias input" annotation(Evaluate=true);
  parameter Real CSmin = 0 "Lower output limit";
  parameter Real CSmax = 1 "Upper output limit";
  parameter Real tolAW = 0.1 "Tolerance of the limit checks";
  parameter Real Kp0 = 0.2 "Initial gain";
  parameter Real pm = 45 "Required phase margin [deg]";
  final parameter Real wox = tan(Modelica.Constants.pi/6) "Plant 1/(s+1)^3 has -90 degrees at tan(30 deg) rad/s";
  final parameter Real Pox = 1/(1 + wox^2)^1.5 "Plant gain at wox";
  final parameter Real TIexp = tan(pm*Modelica.Constants.pi/180)/wox "Integral time the method gives for the exact point";
  final parameter Real Kexp = wox*TIexp/Pox/sqrt(1 + (wox*TIexp)^2) "Gain the method gives for the exact point";
  discrete Real cs0(start=0, fixed=true) "CS just before the bias step";
  Modelica.Blocks.Sources.BooleanTable ts(table={140, 150, 240, 250}, startValue=false) if useTS "Track switch"
    annotation (Placement(transformation(extent={{-90,70},{-70,90}})));
  Modelica.Blocks.Sources.TimeTable tr(table=[0,0.3; 200,0.3; 200,1.5; 260,1.5]) if useTS "Track reference"
    annotation (Placement(transformation(extent={{-90,40},{-70,60}})));
  Modelica.Blocks.Sources.Step bias(height=0.2, startTime=160.02) if useBIAS "Bias"
    annotation (Placement(transformation(extent={{-90,10},{-70,30}})));
  Modelica.Blocks.Sources.Step sp(offset=0.5, height=0.3, startTime=120.02) "Set point"
    annotation (Placement(transformation(extent={{-90,-20},{-70,0}})));
  Modelica.Blocks.Sources.BooleanTable atReq(table={60, 60.1}, startValue=false) "Autotuning request"
    annotation (Placement(transformation(extent={{-40,-50},{-20,-30}})));
  IndustrialControlSystems.Controllers.AutoTuning.ATPIrelayNCdigital dut(Ts=0.1, AntiWindup=AntiWindup, useTS=useTS, useBIAS=useBIAS,
    CSmin=CSmin, CSmax=CSmax, Kp=Kp0, Ti=2, slope=0.02, pm=pm) "Controller under test"
    annotation (Placement(transformation(extent={{-10,-10},{10,10}})));
  Modelica.Blocks.Math.Add add "Control signal + load"
    annotation (Placement(transformation(extent={{30,-10},{50,10}})));
  Modelica.Blocks.Sources.TimeTable load(table=[0,0; 180,0; 180,-0.8; 230,-0.8; 230,0; 260,0])
    "Load that needs CS = 1.6 from t = 180 s to 230 s"
    annotation (Placement(transformation(extent={{0,-40},{20,-20}})));
  IndustrialControlSystems.LinearSystems.Continuous.TransferFunction plant(num={1}, den={1, 3, 3, 1},
    initSteadyState=true) "Plant 1/(s+1)^3"
    annotation (Placement(transformation(extent={{70,-10},{90,10}})));
  Tests.Utilities.Witness tuned(
      u=time > 61 and dut.iMode == 0 and abs(dut.K - Kp0) > 1e-3)
    "The autotuning started at t = 60 s ends and changes the gain"
    annotation (Placement(transformation(extent={{130,70},{150,90}})));
  Tests.Utilities.CheckRealWhile chkK(
      actual=dut.K,
      expected=Kexp,
      relTol=0.2,
      active=time > 130,
      tStart=0.5,
      dt=10)
    "Tuned gain within 20 % of the value for the exact -90 degree point of the plant"
    annotation (Placement(transformation(extent={{160,70},{180,90}})));
  Tests.Utilities.CheckRealWhile chkTI(
      actual=dut.TI,
      expected=TIexp,
      relTol=0.2,
      active=time > 130,
      tStart=0.5,
      dt=10)
    "Tuned integral time within 20 % of the exact value"
    annotation (Placement(transformation(extent={{130,40},{150,60}})));
  Tests.Utilities.CheckRealWhile chkTrack(
      enable=useTS,
      actual=dut.CS,
      expected=if AntiWindup then max(CSmin, min(CSmax, dut.tr)) else dut.tr,
      active=(time > 141 and time < 150) or (time > 241 and time < 250),
      absTol=0.01,
      tStart=0.05,
      dt=0.1)
    "Tracking (TS on [140, 150] with TR = 0.3 and [240, 250] with TR = 1.5): CS = TR, limited if AntiWindup"
    annotation (Placement(transformation(extent={{160,40},{180,60}})));
  Tests.Utilities.Witness biasStep(
      enable=useBIAS,
      u=time > 160.05 and time < 160.3 and abs(dut.CS - cs0 - 0.2) < 0.03)
    "The bias step of 0.2 at t = 160.02 s appears in CS"
    annotation (Placement(transformation(extent={{130,10},{150,30}})));
  Tests.Utilities.Never limits(
      enable=AntiWindup,
      u=dut.iMode == 0 and (dut.CS > CSmax + tolAW or dut.CS < CSmin - tolAW))
    "AntiWindup: in PI mode CS stays in [CSmin, CSmax] (the relay test is not limited)"
    annotation (Placement(transformation(extent={{160,10},{180,30}})));
  Tests.Utilities.Witness recovers(
      enable=AntiWindup,
      u=time > 230.02 and time < 236 and dut.CS < CSmax - tolAW)
    "AntiWindup: CS leaves CSmax soon after the load returns at t = 230 s"
    annotation (Placement(transformation(extent={{130,-20},{150,0}})));
  Tests.Utilities.Witness exceedsMax(
      enable=not AntiWindup,
      u=time > 180 and dut.CS > CSmax + tolAW)
    "No anti-windup: the load from t = 180 s drives CS above CSmax"
    annotation (Placement(transformation(extent={{160,-20},{180,0}})));
  Boolean passed = tuned.passed and chkK.passed and chkTI.passed and chkTrack.passed and biasStep.passed and limits.passed and recovers.passed and exceedsMax.passed
    "true if every enabled check of this configuration passed";
equation
  connect(ts.y, dut.TS) annotation (Line(points={{-69,80},{4,80},{4,8}}, color={255,0,255}));
  connect(tr.y, dut.TR) annotation (Line(points={{-69,50},{0,50},{0,8}}, color={0,0,127}));
  connect(bias.y, dut.BIAS) annotation (Line(points={{-69,20},{-4,20},{-4,8}}, color={0,0,127}));
  connect(sp.y, dut.SP) annotation (Line(points={{-69,-10},{-60,-10},{-60,6},{-8,6}}, color={0,0,127}));
  connect(atReq.y, dut.ATreq) annotation (Line(points={{-19,-40},{-8,-40},{-8,-8}}, color={255,0,255}));
  connect(dut.CS, add.u1) annotation (Line(points={{9,0},{20,0},{20,6},{28,6}}, color={0,0,127}));
  connect(load.y, add.u2) annotation (Line(points={{21,-30},{24,-30},{24,-6},{28,-6}}, color={0,0,127}));
  connect(add.y, plant.u) annotation (Line(points={{51,0},{68,0}}, color={0,0,127}));
  connect(plant.y, dut.PV) annotation (Line(points={{91,0},{100,0},{100,-60},{-50,-60},{-50,-1},{-8,-1}}, color={0,0,127}));
  when time >= 159.95 then
    cs0 = dut.CS;
  end when;
  annotation (
    experiment(StopTime=260, Interval=0.05, Tolerance=1e-6),
    Diagram(coordinateSystem(extent={{-100,-70},{190,100}}, grid={1,1})),
    Documentation(info="<html>
<p>Base of the MC/DC tests of <a href=\"modelica://IndustrialControlSystems.Controllers.AutoTuning.ATPIrelayNCdigital\">IndustrialControlSystems.Controllers.AutoTuning.ATPIrelayNCdigital</a>
on the plant 1/(s+1)^3 (as in <code>Tests.Controllers.AutoTuning</code>): initial PI Kp = 0.2,
Ti = 2; autotuning requested at t = 60 s (relay slope 0.02, pm = 45 deg); set point 0.5, 0.8 from
120 s; a load of -0.8 on [180, 230] s needs CS = 1.6, above CSmax = 1. The variants extend it and
change one option or an MC/DC pair.</p>
<p>The expected tuning uses the exact -90 degree point of the plant (w = tan 30 deg,
|P| = 0.65); the method estimates it from the relay oscillation by a describing function, hence
the 20 % tolerance.</p>
<p>Checks (each enabled only where it applies; <code>passed</code> is their conjunction):</p>
<ul><li><code>tuned</code>: The autotuning started at t = 60 s ends and changes the gain</li><li><code>chkK</code>: Tuned gain within 20 % of the value for the exact -90 degree point of the plant</li><li><code>chkTI</code>: Tuned integral time within 20 % of the exact value</li><li><code>chkTrack</code>: Tracking (TS on [140, 150] with TR = 0.3 and [240, 250] with TR = 1.5): CS = TR, limited if AntiWindup</li><li><code>biasStep</code>: The bias step of 0.2 at t = 160.02 s appears in CS</li><li><code>limits</code>: AntiWindup: in PI mode CS stays in [CSmin, CSmax] (the relay test is not limited)</li><li><code>recovers</code>: AntiWindup: CS leaves CSmax soon after the load returns at t = 230 s</li><li><code>exceedsMax</code>: No anti-windup: the load from t = 180 s drives CS above CSmax</li></ul>
</html>"));
end Base;
