within Tests.Controllers;
model TestInit_CSstart "Regression test: I, PI and D start at CS_start, with and without AntiWindup"
  extends Modelica.Icons.Example;
  Modelica.Blocks.Sources.Constant SP(k=0.1)
    annotation (Placement(transformation(extent={{-160,110},{-140,130}})));
  Modelica.Blocks.Sources.Constant PV(k=0)
    annotation (Placement(transformation(extent={{-160,80},{-140,100}})));
  Modelica.Blocks.Sources.Constant BIAS(k=0.2)
    annotation (Placement(transformation(extent={{-160,50},{-140,70}})));
  IndustrialControlSystems.Controllers.I Ic_AW(useBIAS=true, CS_start=0.3, CSmin=-2, CSmax=2, AntiWindup=true)
    annotation (Placement(transformation(extent={{-50,-20},{-10,20}})));
  IndustrialControlSystems.Controllers.I Id(useBIAS=true, CS_start=0.3, CSmin=-2, CSmax=2, Ts=0.1)
    annotation (Placement(transformation(extent={{-50,-100},{-10,-60}})));
  IndustrialControlSystems.Controllers.PI PIc_AW(useBIAS=true, CS_start=0.3, CSmin=-2, CSmax=2, AntiWindup=true)
    annotation (Placement(transformation(extent={{-50,-180},{-10,-140}})));
  IndustrialControlSystems.Controllers.PI PId_AW(useBIAS=true, CS_start=0.3, CSmin=-2, CSmax=2, AntiWindup=true, Ts=0.1)
    annotation (Placement(transformation(extent={{-50,-260},{-10,-220}})));
  IndustrialControlSystems.Controllers.D Dc(useBIAS=true, CS_start=0.3, CSmin=-2, CSmax=2)
    annotation (Placement(transformation(extent={{-50,-340},{-10,-300}})));
  IndustrialControlSystems.Controllers.D Dd_AW(useBIAS=true, CS_start=0.3, CSmin=-2, CSmax=2, AntiWindup=true, Ts=0.1)
    annotation (Placement(transformation(extent={{-50,-420},{-10,-380}})));
  Tests.Utilities.CheckRealWhile chkIcAW(actual=Ic_AW.CS, expected=0.3 + 0.1*time, active=true, absTol=1e-4, tStart=0.01, dt=0.02)
    "Ic_AW: CS = 0.3 + 0.1 t"
    annotation (Placement(transformation(extent={{20,120},{40,140}})));
  Tests.Utilities.CheckRealWhile chkId(actual=Id.CS, expected=0.31 + 0.01*floor(time/0.1), active=true, absTol=1e-4, tStart=0.05, dt=0.1)
    "Id: CS = 0.31, + 0.01 per sample"
    annotation (Placement(transformation(extent={{50,120},{70,140}})));
  Tests.Utilities.CheckRealWhile chkPIcAW(actual=PIc_AW.CS, expected=0.3 + 0.5*time, active=true, absTol=1e-4, tStart=0.01, dt=0.02)
    "PIc_AW: CS = 0.3 + 0.5 t"
    annotation (Placement(transformation(extent={{20,90},{40,110}})));
  Tests.Utilities.CheckRealWhile chkPIdAW(actual=PId_AW.CS, expected=if time < 0.5 then 0.3 else 0.7545, active=time < 0.05 or time > 1.0, absTol=1e-4, tStart=0.01, dt=0.02)
    "PId_AW: CS = 0.3 before the first sample, 0.7545 after the sample at t = 1 s"
    annotation (Placement(transformation(extent={{50,90},{70,110}})));
  Tests.Utilities.CheckRealWhile chkDc(actual=Dc.CS, expected=0.2 + 0.1*exp(-10*time), active=true, absTol=1e-3, tStart=0.01, dt=0.02)
    "Dc: CS = 0.3 at t = 0, decays to the bias 0.2 with Td/N = 0.1 s"
    annotation (Placement(transformation(extent={{20,60},{40,80}})));
  Tests.Utilities.CheckRealWhile chkDdAW(actual=Dd_AW.CS, expected=if time < 0.5 then 0.25 else 0.2, active=time < 0.05 or time > 0.95, absTol=1e-3, tStart=0.01, dt=0.02)
    "Dd_AW: CS = 0.25 before the first sample, 0.2 at t = 1 s"
    annotation (Placement(transformation(extent={{50,60},{70,80}})));
  Boolean passed = chkIcAW.passed and chkId.passed and chkPIcAW.passed and chkPIdAW.passed and chkDc.passed and chkDdAW.passed
    "true if every check passed";
equation
  connect(SP.y, Ic_AW.SP)
    annotation (Line(points={{-139,120},{-110,120},{-110,12},{-46,12}}, color={0,0,127}));
  connect(PV.y, Ic_AW.PV)
    annotation (Line(points={{-139,90},{-120,90},{-120,-2},{-46,-2}}, color={0,0,127}));
  connect(BIAS.y, Ic_AW.BIAS)
    annotation (Line(points={{-139,60},{-130,60},{-130,28},{-38,28},{-38,16}}, color={0,0,127}));
  connect(SP.y, Id.SP)
    annotation (Line(points={{-139,120},{-110,120},{-110,-68},{-46,-68}}, color={0,0,127}));
  connect(PV.y, Id.PV)
    annotation (Line(points={{-139,90},{-120,90},{-120,-82},{-46,-82}}, color={0,0,127}));
  connect(BIAS.y, Id.BIAS)
    annotation (Line(points={{-139,60},{-130,60},{-130,-52},{-38,-52},{-38,-64}}, color={0,0,127}));
  connect(SP.y, PIc_AW.SP)
    annotation (Line(points={{-139,120},{-110,120},{-110,-148},{-46,-148}}, color={0,0,127}));
  connect(PV.y, PIc_AW.PV)
    annotation (Line(points={{-139,90},{-120,90},{-120,-162},{-46,-162}}, color={0,0,127}));
  connect(BIAS.y, PIc_AW.BIAS)
    annotation (Line(points={{-139,60},{-130,60},{-130,-132},{-38,-132},{-38,-144}}, color={0,0,127}));
  connect(SP.y, PId_AW.SP)
    annotation (Line(points={{-139,120},{-110,120},{-110,-228},{-46,-228}}, color={0,0,127}));
  connect(PV.y, PId_AW.PV)
    annotation (Line(points={{-139,90},{-120,90},{-120,-242},{-46,-242}}, color={0,0,127}));
  connect(BIAS.y, PId_AW.BIAS)
    annotation (Line(points={{-139,60},{-130,60},{-130,-212},{-38,-212},{-38,-224}}, color={0,0,127}));
  connect(SP.y, Dc.SP)
    annotation (Line(points={{-139,120},{-110,120},{-110,-308},{-46,-308}}, color={0,0,127}));
  connect(PV.y, Dc.PV)
    annotation (Line(points={{-139,90},{-120,90},{-120,-322},{-46,-322}}, color={0,0,127}));
  connect(BIAS.y, Dc.BIAS)
    annotation (Line(points={{-139,60},{-130,60},{-130,-292},{-38,-292},{-38,-304}}, color={0,0,127}));
  connect(SP.y, Dd_AW.SP)
    annotation (Line(points={{-139,120},{-110,120},{-110,-388},{-46,-388}}, color={0,0,127}));
  connect(PV.y, Dd_AW.PV)
    annotation (Line(points={{-139,90},{-120,90},{-120,-402},{-46,-402}}, color={0,0,127}));
  connect(BIAS.y, Dd_AW.BIAS)
    annotation (Line(points={{-139,60},{-130,60},{-130,-372},{-38,-372},{-38,-384}}, color={0,0,127}));
  annotation (
    Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-170,-440},{80,150}})),
    experiment(StopTime=1.05, Tolerance=1e-6),
    Documentation(info="<html>
<p>Regression test for the initialisation of <a href=\"modelica://IndustrialControlSystems.Controllers.I\">I</a>,
<a href=\"modelica://IndustrialControlSystems.Controllers.PI\">PI</a> and
<a href=\"modelica://IndustrialControlSystems.Controllers.D\">D</a>: the output must start at <code>CS_start</code>,
with and without AntiWindup. Open loop: SP = 0.1, PV = 0, BIAS = 0.2, CS_start = 0.3, CSmin = -2, CSmax = 2 (no saturation),
default gains (T = Ti = Td = 1, Kp = 5, N = 10).</p>
<p>Before the fix: with AntiWindup the I state was not reduced by the bias (CS(0) = 0.5); the sampled I ignored CS_start (CS(0) = 0.01);
with AntiWindup the PI state was not reduced by the bias and the P action (CS(0) = 1.0); D initialised its filtered error with CS_start - bias
(CS(0) = -1.8 continuous and -0.8 sampled with AntiWindup).</p>
<p>The sampled controllers set the state one sample before t = 0, so at t = 0 their output has already moved by one integration or filter step.</p>
<h4>Expected results</h4>
<table border=\"1\" cellspacing=\"0\" cellpadding=\"2\">
<tr><th>Instance</th><th>Configuration</th><th>CS(0)</th><th>CS(1)</th></tr>
<tr><td>Ic_AW</td><td>I, continuous, AntiWindup</td><td>0.3</td><td>0.4</td></tr>
<tr><td>Id</td><td>I, sampled, Ts = 0.1</td><td>0.31 (one step of 0.01)</td><td>0.41</td></tr>
<tr><td>PIc_AW</td><td>PI, continuous, AntiWindup</td><td>0.3</td><td>0.8</td></tr>
<tr><td>PId_AW</td><td>PI, sampled, Ts = 0.1, AntiWindup</td><td>0.3</td><td>0.7545</td></tr>
<tr><td>Dc</td><td>D, continuous</td><td>0.3</td><td>0.2 (decays to the bias)</td></tr>
<tr><td>Dd_AW</td><td>D, sampled, Ts = 0.1, AntiWindup</td><td>0.25 (one filter step)</td><td>0.2</td></tr>
</table>
<h4>Verdict</h4>
<p><code>passed</code> is true when every check passed. The run ends at 1.05 s, just after the sample at the end time of the table, so the sampled value can be checked.</p>
<ul><li><code>chkIcAW</code>: Ic_AW: CS = 0.3 + 0.1 t</li><li><code>chkId</code>: Id: CS = 0.31, + 0.01 per sample</li><li><code>chkPIcAW</code>: PIc_AW: CS = 0.3 + 0.5 t</li><li><code>chkPIdAW</code>: PId_AW: CS = 0.3 before the first sample, 0.7545 after the sample at t = 1 s</li><li><code>chkDc</code>: Dc: CS = 0.3 at t = 0, decays to the bias 0.2 with Td/N = 0.1 s</li><li><code>chkDdAW</code>: Dd_AW: CS = 0.25 before the first sample, 0.2 at t = 1 s</li></ul>
</html>", revisions="<html>
<ul>
<li>November 2026: added as a regression test for the CS_start initialisation fix (#15) (Hubertus Tummescheit).</li>
</ul>
</html>"));
end TestInit_CSstart;
