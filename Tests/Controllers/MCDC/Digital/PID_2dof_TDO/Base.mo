within Tests.Controllers.MCDC.Digital.PID_2dof_TDO;
model Base "MC/DC base: IndustrialControlSystems.Controllers.Digital.PID_2dof_TDO, open loop, every option off"
  extends Modelica.Icons.Example;
  parameter Boolean AntiWindup = false "Output limits and anti-windup" annotation(Evaluate=true);
  parameter Boolean useTS = false "Tracking inputs TS, TR" annotation(Evaluate=true);
  parameter Boolean useBIAS = false "Bias input" annotation(Evaluate=true);
  parameter Boolean useMAN = false "Manual inputs MAN, CSinc" annotation(Evaluate=true);
  parameter Boolean useForbid = false "Forbid inputs Finc, Fdec" annotation(Evaluate=true);
  parameter Real Td = 1 "Derivative time (0 removes the derivative path)" annotation(Evaluate=true);
  parameter Real CSmin = 0 "Lower output limit";
  parameter Real CSmax = 1 "Upper output limit";
  parameter Real tolAW = 0.1 "Tolerance of the limit checks";
  Modelica.Blocks.Sources.BooleanTable ts(table={6.02, 8.02, 20.02, 23.02}, startValue=false) if useTS "Track switch"
    annotation (Placement(transformation(extent={{-70,70},{-50,90}})));
  Modelica.Blocks.Sources.TimeTable tr(table=[0,0.5; 14,0.5; 14,1.5; 40,1.5]) if useTS "Track reference"
    annotation (Placement(transformation(extent={{-70,40},{-50,60}})));
  Modelica.Blocks.Sources.Step bias(height=0.3, startTime=3.02) if useBIAS "Bias"
    annotation (Placement(transformation(extent={{-70,10},{-50,30}})));
  Modelica.Blocks.Sources.TimeTable sp(table=[0,0; 1.02,0; 1.02,1; 15.02,1; 15.02,-1.5; 30.02,-1.5; 30.02,0; 40,0]) "Set point"
    annotation (Placement(transformation(extent={{-70,-20},{-50,0}})));
  Modelica.Blocks.Sources.BooleanTable man(table={6.52, 7.52}, startValue=false) if useMAN "Manual mode"
    annotation (Placement(transformation(extent={{-70,-50},{-50,-30}})));
  Modelica.Blocks.Sources.Constant csInc(k=0.01) if useMAN "Manual increment per sample"
    annotation (Placement(transformation(extent={{-70,-80},{-50,-60}})));
  Modelica.Blocks.Sources.BooleanTable fInc(table={3.52, 7.52, 24.02, 26.02}, startValue=false) if useForbid
    "Forbid increments: while rising (and manual), then while falling"
    annotation (Placement(transformation(extent={{-70,-110},{-50,-90}})));
  Modelica.Blocks.Sources.BooleanTable fDec(table={10.02, 12.02, 17.52, 19.52}, startValue=false) if useForbid
    "Forbid decrements: while rising, then while falling"
    annotation (Placement(transformation(extent={{-70,-140},{-50,-120}})));
  IndustrialControlSystems.Controllers.Digital.PID_2dof_TDO dut(Ts=0.1, AntiWindup=AntiWindup, useTS=useTS, useBIAS=useBIAS, useMAN=useMAN,
    useForbid=useForbid, CSmin=CSmin, CSmax=CSmax, Kp=2, Ti=5, Td=Td, N=5, b=1, c=1, PV=0) "Controller under test"
    annotation (Placement(transformation(extent={{-10,-10},{10,10}})));
  Modelica.Blocks.Sources.TimeTable spRef(table=[0,0; 1.02,0; 1.02,1; 15.02,1; 15.02,-1.5; 30.02,-1.5; 30.02,0; 40,0]) "Set point of the reference"
    annotation (Placement(transformation(extent={{-70,-170},{-50,-150}})));
  Modelica.Blocks.Continuous.TransferFunction ref(
    b=if Td > 0 then 2*{5*Td*(1 + 1/5), 5 + Td/5, 1} else 2*{5, 5 + 1, 1},
    a=if Td > 0 then {5*Td/5, 5, 0} else {5, 5, 0},
    initType=Modelica.Blocks.Types.Init.InitialState)
    "Continuous ideal: Kp*(b + 1/(s*Ti) + c*s*Td/(1 + s*Td/N)), Kp = 2, Ti = 5, N = 5, b = c = 1"
    annotation (Placement(transformation(extent={{-30,-170},{-10,-150}})));
  Modelica.Blocks.Math.Mean csMean(f=1/0.1, x0=0) "Mean of CS over each sampling period"
    annotation (Placement(transformation(extent={{30,-50},{50,-30}})));
  discrete Real csPrev(start=0, fixed=true) "Control signal of the previous sampling period";
  discrete Real csLast(start=0, fixed=true) "Control signal sampled at the start of a period";
  discrete Real csMan0(start=0, fixed=true) "Control signal when manual mode starts";
  discrete Real csInc0(start=0, fixed=true) "Control signal when F_inc rises the first time";
  discrete Real csDec0(start=0, fixed=true) "Control signal when F_dec rises the second time";
  discrete Real csDec1(start=0, fixed=true) "Control signal when F_dec rises the first time";
  discrete Real csInc1(start=0, fixed=true) "Control signal when F_inc rises the second time";
  Tests.Utilities.CheckRealWhile chkStart(
      actual=dut.cs,
      expected=0,
      active=time < 1,
      absTol=1e-3,
      tStart=0.05,
      dt=0.1)
    "Output before the first set-point step: 0"
    annotation (Placement(transformation(extent={{70,70},{90,90}})));
  Tests.Utilities.CheckRealWhile chkRef(
      enable=not AntiWindup and not useTS and not useMAN and not useForbid,
      actual=dut.cs,
      expected=ref.y + dut.bias,
      absTol=0.05,
      relTol=0.05,
      active=not ((time > 1.02 and time < 3.0) or (time > 15.02 and time < 17.0) or (time > 30.02 and time < 32.0)),
      tStart=0.9,
      dt=1)
    "Automatic mode without limits: control signal = continuous ideal + bias, within 0.05 + 5 %, except in the 2 s after a set-point step (the discretised derivative filter decays differently)"
    annotation (Placement(transformation(extent={{100,70},{120,90}})));
  Tests.Utilities.CheckRealWhile chkTrack(
      enable=useTS,
      actual=dut.cs,
      expected=if AntiWindup then max(CSmin, min(CSmax, dut.tr)) else dut.tr,
      active=(time > 6.35 and time < 6.5) or (time > 7.85 and time < 8.0) or (time > 20.35 and time < 23.0),
      absTol=1e-6,
      tStart=0.05,
      dt=0.1)
    "Tracking (and not manual): control signal = TR (limited if AntiWindup), from the second sample"
    annotation (Placement(transformation(extent={{70,40},{90,60}})));
  Tests.Utilities.CheckRealWhile chkMan(
      enable=useMAN,
      actual=dut.cs,
      expected=csMan0 + 0.01/0.1*(time - 6.55),
      active=time > 6.75 and time < 7.5,
      absTol=0.02,
      tStart=0.05,
      dt=0.1)
    "Manual (MAN on [6.52, 7.52]): control signal rises by CSinc = 0.01 per sample, also while TS or F_inc"
    annotation (Placement(transformation(extent={{100,40},{120,60}})));
  Tests.Utilities.CheckRealWhile chkFrozen(
      enable=useForbid,
      actual=dut.cs,
      expected=if time < 10 then csInc0 else csDec0,
      active=(time > 3.8 and time < 6.45) or (time > 17.8 and time < 19.5),
      absTol=1e-6,
      tStart=0.05,
      dt=0.1)
    "F_inc while the signal rises, F_dec while it falls: the control signal is held"
    annotation (Placement(transformation(extent={{70,10},{90,30}})));
  Tests.Utilities.Witness incPasses(
      enable=useForbid and not useMAN,
      u=time > 10.3 and time < 12 and dut.cs > csDec1 + 0.1)
    "F_dec while the signal rises: the rise passes"
    annotation (Placement(transformation(extent={{100,10},{120,30}})));
  Tests.Utilities.Witness decPasses(
      enable=useForbid and not useMAN,
      u=time > 24.3 and time < 26 and dut.cs < csInc1 - 0.1)
    "F_inc while the signal falls: the fall passes"
    annotation (Placement(transformation(extent={{70,-20},{90,0}})));
  Tests.Utilities.Never limits(
      enable=AntiWindup,
      u=dut.cs > CSmax + tolAW or dut.cs < CSmin - tolAW)
    "AntiWindup: the control signal stays in [CSmin, CSmax]"
    annotation (Placement(transformation(extent={{100,-20},{120,0}})));
  Tests.Utilities.Witness recovers(
      enable=AntiWindup,
      u=time > 15.02 and time < 18 and dut.cs < CSmax - tolAW)
    "AntiWindup: the control signal leaves CSmax within 3 s of the set-point reversal"
    annotation (Placement(transformation(extent={{70,-50},{90,-30}})));
  Tests.Utilities.Witness exceedsMax(
      enable=not AntiWindup,
      u=dut.cs > CSmax + tolAW)
    "No anti-windup: above CSmax"
    annotation (Placement(transformation(extent={{100,-50},{120,-30}})));
  Tests.Utilities.Witness exceedsMin(
      enable=not AntiWindup,
      u=dut.cs < CSmin - tolAW)
    "No anti-windup: below CSmin"
    annotation (Placement(transformation(extent={{70,-80},{90,-60}})));
  Tests.Utilities.Witness satHigh(
      enable=AntiWindup,
      u=dut.satHI)
    "AntiWindup: satHI occurs"
    annotation (Placement(transformation(extent={{100,-80},{120,-60}})));
  Tests.Utilities.Never satNone(
      enable=not AntiWindup,
      u=dut.satHI or dut.satLOW)
    "No anti-windup: satHI, satLOW stay false"
    annotation (Placement(transformation(extent={{70,-110},{90,-90}})));
  Tests.Utilities.Never pwmLevels(
      u=dut.CS > CSmin + 1e-9 and dut.CS < CSmax - 1e-9)
    "Time-division output: CS is always CSmin or CSmax"
    annotation (Placement(transformation(extent={{100,-110},{120,-90}})));
  Tests.Utilities.CheckRealWhile pwmMean(
      actual=csMean.y,
      expected=max(CSmin, min(CSmax, csPrev)),
      absTol=0.02,
      tStart=0.1*1.5,
      dt=0.1)
    "Time-division output: its mean over each period = the control signal of that period, limited"
    annotation (Placement(transformation(extent={{70,-140},{90,-120}})));
  Boolean passed = chkStart.passed and chkRef.passed and chkTrack.passed and chkMan.passed and chkFrozen.passed and incPasses.passed and decPasses.passed and limits.passed and recovers.passed and exceedsMax.passed and exceedsMin.passed and satHigh.passed and satNone.passed and pwmLevels.passed and pwmMean.passed
    "true if every enabled check of this configuration passed";
equation
  connect(ts.y, dut.TS) annotation (Line(points={{-49,80},{4,80},{4,8}}, color={255,0,255}));
  connect(tr.y, dut.TR) annotation (Line(points={{-49,50},{0,50},{0,8}}, color={0,0,127}));
  connect(bias.y, dut.BIAS) annotation (Line(points={{-49,20},{-4,20},{-4,8}}, color={0,0,127}));
  connect(sp.y, dut.SP) annotation (Line(points={{-49,-10},{-30,-10},{-30,8},{-8,8}}, color={0,0,127}));
  connect(man.y, dut.MAN) annotation (Line(points={{-49,-40},{-20,-40},{-20,0},{-8,0}}, color={255,0,255}));
  connect(csInc.y, dut.CSinc) annotation (Line(points={{-49,-70},{-14,-70},{-14,-4},{-8,-4}}, color={0,0,127}));
  connect(fInc.y, dut.Finc) annotation (Line(points={{-49,-100},{-4,-100},{-4,-8}}, color={255,0,255}));
  connect(fDec.y, dut.Fdec) annotation (Line(points={{-49,-130},{2,-130},{2,-8}}, color={255,0,255}));
  connect(spRef.y, ref.u) annotation (Line(points={{-49,-160},{-32,-160}}, color={0,0,127}));
  connect(dut.CS, csMean.u) annotation (Line(points={{9,0},{20,0},{20,-40},{28,-40}}, color={0,0,127}));
  when sample(0.1, 0.1) then
    csPrev = pre(csLast);
    csLast = dut.cs;
  end when;
  when time >= 6.52 then
    csMan0 = dut.cs;
  end when;
  when time >= 3.52 then
    csInc0 = dut.cs;
  end when;
  when time >= 24.02 then
    csInc1 = dut.cs;
  end when;
  when time >= 10.02 then
    csDec1 = dut.cs;
  end when;
  when time >= 17.52 then
    csDec0 = dut.cs;
  end when;
  annotation (
    experiment(StopTime=40, Interval=0.01, Tolerance=1e-6),
    Diagram(coordinateSystem(extent={{-80,-180},{130,100}}, grid={1,1})),
    Documentation(info="<html>
<p>Base of the MC/DC tests of <a href=\"modelica://IndustrialControlSystems.Controllers.Digital.PID_2dof_TDO\">IndustrialControlSystems.Controllers.Digital.PID_2dof_TDO</a>
(Ts = 0.1, Kp = 2, Ti = 5, Td = 1, N = 5, b = c = 1): <code>dut</code> with every option off, its
stimuli, a continuous ideal <code>ref</code>, and the checks. The variants extend it and change one
option or an MC/DC pair; a source that only an option needs is instantiated only with it.</p>
<p>Open loop, PV = 0: the set point is 0, steps to 1 at t = 1.02 s, to -1.5 at 15.02 s and
back to 0 at 30.02 s, so the output of every class leaves [CSmin, CSmax] = [0, 1] upwards and
downwards when nothing limits it. Event times are off the sampling grid of the sampled
variants. Tracking (<code>useTS</code>): TS is true on [6.02, 8.02] (TR = 0.5, inside the
limits) and [20.02, 23.02] (TR = 1.5, above CSmax). Bias (<code>useBIAS</code>): 0.3 from
3.02 s.</p>
<p>Manual (<code>useMAN</code>): MAN on [6.52, 7.52] (inside the first tracking window and the first
F_inc window), CSinc = 0.01. Forbid (<code>useForbid</code>): F_inc on [3.52, 7.52] (signal rising)
and [24.02, 26.02] (falling); F_dec on [10.02, 12.02] (rising) and [17.52, 19.52] (falling, after the derivative kick of the set-point reversal has decayed).</p>
<p>The output is time-division (PWM) between CSmin and CSmax, so the checks of the control law use the public internal signal <code>dut.cs</code>; <code>pwmLevels</code> and <code>pwmMean</code> check the output itself.</p>
<p>Checks (each enabled only where it applies; <code>passed</code> is their conjunction):</p>
<ul><li><code>chkStart</code>: Output before the first set-point step: 0</li><li><code>chkRef</code>: Automatic mode without limits: control signal = continuous ideal + bias, within 0.05 + 5 %, except in the 2 s after a set-point step (the discretised derivative filter decays differently)</li><li><code>chkTrack</code>: Tracking (and not manual): control signal = TR (limited if AntiWindup), from the second sample</li><li><code>chkMan</code>: Manual (MAN on [6.52, 7.52]): control signal rises by CSinc = 0.01 per sample, also while TS or F_inc</li><li><code>chkFrozen</code>: F_inc while the signal rises, F_dec while it falls: the control signal is held</li><li><code>incPasses</code>: F_dec while the signal rises: the rise passes</li><li><code>decPasses</code>: F_inc while the signal falls: the fall passes</li><li><code>limits</code>: AntiWindup: the control signal stays in [CSmin, CSmax]</li><li><code>recovers</code>: AntiWindup: the control signal leaves CSmax within 3 s of the set-point reversal</li><li><code>exceedsMax</code>: No anti-windup: above CSmax</li><li><code>exceedsMin</code>: No anti-windup: below CSmin</li><li><code>satHigh</code>: AntiWindup: satHI occurs</li><li><code>satNone</code>: No anti-windup: satHI, satLOW stay false</li><li><code>pwmLevels</code>: Time-division output: CS is always CSmin or CSmax</li><li><code>pwmMean</code>: Time-division output: its mean over each period = the control signal of that period, limited</li></ul>
</html>"));
end Base;
