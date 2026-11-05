within IndustrialControlSystems.Controllers.Examples;
model TestPD_proportional "Regression test: PD controller has proportional action and starts at CS_start"
  extends Modelica.Icons.Example;
  Modelica.Blocks.Sources.Step SPstep(height=1, startTime=2)
    annotation (Placement(transformation(extent={{-160,110},{-140,130}})));
  Modelica.Blocks.Sources.Constant SP1(k=1)
    annotation (Placement(transformation(extent={{-160,80},{-140,100}})));
  Modelica.Blocks.Sources.Constant PV(k=0)
    annotation (Placement(transformation(extent={{-160,50},{-140,70}})));
  IndustrialControlSystems.Controllers.PD PDc(Kp=2, Td=1, N=10)
    annotation (Placement(transformation(extent={{-50,-20},{-10,20}})));
  IndustrialControlSystems.Controllers.PD PDd(Kp=2, Td=1, N=10, Ts=0.01)
    annotation (Placement(transformation(extent={{-50,-100},{-10,-60}})));
  IndustrialControlSystems.Controllers.PD PDc_start(Kp=2, Td=1, N=10, CS_start=0.3)
    annotation (Placement(transformation(extent={{-50,-180},{-10,-140}})));
equation
  connect(SPstep.y, PDc.SP)
    annotation (Line(points={{-139,120},{-110,120},{-110,12},{-46,12}}, color={0,0,127}));
  connect(PV.y, PDc.PV)
    annotation (Line(points={{-139,60},{-130,60},{-130,-2},{-46,-2}}, color={0,0,127}));
  connect(SPstep.y, PDd.SP)
    annotation (Line(points={{-139,120},{-110,120},{-110,-68},{-46,-68}}, color={0,0,127}));
  connect(PV.y, PDd.PV)
    annotation (Line(points={{-139,60},{-130,60},{-130,-82},{-46,-82}}, color={0,0,127}));
  connect(SP1.y, PDc_start.SP)
    annotation (Line(points={{-139,90},{-120,90},{-120,-148},{-46,-148}}, color={0,0,127}));
  connect(PV.y, PDc_start.PV)
    annotation (Line(points={{-139,60},{-130,60},{-130,-162},{-46,-162}}, color={0,0,127}));
  annotation (
    Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-170,-200},{10,140}})),
    experiment(StopTime=10, Tolerance=1e-6),
    Documentation(info="<html>
<p>Regression test for the <a href=\"modelica://IndustrialControlSystems.Controllers.PD\">PD</a> controller: it must implement <code>CS = Kp*[(SP-PV) + sTd/(1+sTd/N)*(SP-PV)] + bias</code> and start at <code>CS_start</code>. Open loop, PV = 0, Kp = 2, Td = 1, N = 10.</p>
<p>Before the fix, the proportional action was missing (CS returned to 0 for a constant error) and CS_start initialised the filter state instead of the output.</p>
<h4>Expected results</h4>
<table border=\"1\" cellspacing=\"0\" cellpadding=\"2\">
<tr><th>Instance</th><th>Input</th><th>CS</th></tr>
<tr><td>PDc</td><td>SP step 0 &rarr; 1 at t = 2 s</td><td>0 before the step; kick Kp&middot;(1+N) = 22 at t = 2 s; then decays to Kp&middot;e = 2</td></tr>
<tr><td>PDd (Ts = 0.01)</td><td>SP step 0 &rarr; 1 at t = 2 s</td><td>0 before the step; kick about 20.2 (one filter step); then decays to 2</td></tr>
<tr><td>PDc_start (CS_start = 0.3)</td><td>SP = 1 constant</td><td>CS(0) = 0.3; then rises to 2</td></tr>
</table>
</html>", revisions="<html>
<ul>
<li>November 2026: added as a regression test for the 2.0.1 controller fixes (Hubertus Tummescheit).</li>
</ul>
</html>"));
end TestPD_proportional;
