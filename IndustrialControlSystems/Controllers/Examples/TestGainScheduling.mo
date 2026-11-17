within IndustrialControlSystems.Controllers.Examples;
model TestGainScheduling "Regression test: gain-scheduled P, PI and I, continuous and sampled"
  extends Modelica.Icons.Example;
  Modelica.Blocks.Sources.Constant SP(k=1)
    annotation (Placement(transformation(extent={{-160,140},{-140,160}})));
  Modelica.Blocks.Sources.Constant PV(k=0)
    annotation (Placement(transformation(extent={{-160,110},{-140,130}})));
  Modelica.Blocks.Sources.Constant Kp_sched(k=2)
    annotation (Placement(transformation(extent={{-160,80},{-140,100}})));
  Modelica.Blocks.Sources.Constant Ti_sched(k=4)
    annotation (Placement(transformation(extent={{-160,50},{-140,70}})));
  IndustrialControlSystems.Controllers.P Pc(useGS=true, Kp=5)
    annotation (Placement(transformation(extent={{-50,-20},{-10,20}})));
  IndustrialControlSystems.Controllers.P Pd(useGS=true, Kp=5, Ts=0.1)
    annotation (Placement(transformation(extent={{-50,-100},{-10,-60}})));
  IndustrialControlSystems.Controllers.PI PIc(useGS=true, Kp=5, Ti=1)
    annotation (Placement(transformation(extent={{-50,-180},{-10,-140}})));
  IndustrialControlSystems.Controllers.PI PId(useGS=true, Kp=5, Ti=1, Ts=0.1)
    annotation (Placement(transformation(extent={{-50,-260},{-10,-220}})));
  IndustrialControlSystems.Controllers.I Ic(useGS=true, T=1)
    annotation (Placement(transformation(extent={{-50,-340},{-10,-300}})));
  IndustrialControlSystems.Controllers.I Id(useGS=true, T=1, Ts=0.1)
    annotation (Placement(transformation(extent={{-50,-420},{-10,-380}})));
equation
  connect(SP.y, Pc.SP)
    annotation (Line(points={{-139,150},{-100,150},{-100,12},{-46,12}}, color={0,0,127}));
  connect(PV.y, Pc.PV)
    annotation (Line(points={{-139,120},{-110,120},{-110,-2},{-46,-2}}, color={0,0,127}));
  connect(Kp_sched.y, Pc.Kp_GS)
    annotation (Line(points={{-139,90},{-120,90},{-120,-28},{-30,-28},{-30,-18.4}}, color={0,0,127}));
  connect(SP.y, Pd.SP)
    annotation (Line(points={{-139,150},{-100,150},{-100,-68},{-46,-68}}, color={0,0,127}));
  connect(PV.y, Pd.PV)
    annotation (Line(points={{-139,120},{-110,120},{-110,-82},{-46,-82}}, color={0,0,127}));
  connect(Kp_sched.y, Pd.Kp_GS)
    annotation (Line(points={{-139,90},{-120,90},{-120,-108},{-30,-108},{-30,-98.4}}, color={0,0,127}));
  connect(SP.y, PIc.SP)
    annotation (Line(points={{-139,150},{-100,150},{-100,-148},{-46,-148}}, color={0,0,127}));
  connect(PV.y, PIc.PV)
    annotation (Line(points={{-139,120},{-110,120},{-110,-162},{-46,-162}}, color={0,0,127}));
  connect(Kp_sched.y, PIc.Kp_GS)
    annotation (Line(points={{-139,90},{-120,90},{-120,-188},{-34,-188},{-34,-176}}, color={0,0,127}));
  connect(Ti_sched.y, PIc.Ti_GS)
    annotation (Line(points={{-139,60},{-130,60},{-130,-192},{-21.6,-192},{-21.6,-176}}, color={0,0,127}));
  connect(SP.y, PId.SP)
    annotation (Line(points={{-139,150},{-100,150},{-100,-228},{-46,-228}}, color={0,0,127}));
  connect(PV.y, PId.PV)
    annotation (Line(points={{-139,120},{-110,120},{-110,-242},{-46,-242}}, color={0,0,127}));
  connect(Kp_sched.y, PId.Kp_GS)
    annotation (Line(points={{-139,90},{-120,90},{-120,-268},{-34,-268},{-34,-256}}, color={0,0,127}));
  connect(Ti_sched.y, PId.Ti_GS)
    annotation (Line(points={{-139,60},{-130,60},{-130,-272},{-21.6,-272},{-21.6,-256}}, color={0,0,127}));
  connect(SP.y, Ic.SP)
    annotation (Line(points={{-139,150},{-100,150},{-100,-308},{-46,-308}}, color={0,0,127}));
  connect(PV.y, Ic.PV)
    annotation (Line(points={{-139,120},{-110,120},{-110,-322},{-46,-322}}, color={0,0,127}));
  connect(Ti_sched.y, Ic.T_GS)
    annotation (Line(points={{-139,60},{-130,60},{-130,-348},{-30,-348},{-30,-338.4}}, color={0,0,127}));
  connect(SP.y, Id.SP)
    annotation (Line(points={{-139,150},{-100,150},{-100,-388},{-46,-388}}, color={0,0,127}));
  connect(PV.y, Id.PV)
    annotation (Line(points={{-139,120},{-110,120},{-110,-402},{-46,-402}}, color={0,0,127}));
  connect(Ti_sched.y, Id.T_GS)
    annotation (Line(points={{-139,60},{-130,60},{-130,-428},{-30,-428},{-30,-418.4}}, color={0,0,127}));
  annotation (
    Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-170,-440},{10,170}})),
    experiment(StopTime=2, Tolerance=1e-6),
    Documentation(info="<html>
<p>Regression test for gain scheduling (<code>useGS = true</code>) in <a href=\"modelica://IndustrialControlSystems.Controllers.P\">P</a>, <a href=\"modelica://IndustrialControlSystems.Controllers.PI\">PI</a> and <a href=\"modelica://IndustrialControlSystems.Controllers.I\">I</a>, continuous and sampled (Ts = 0.1). The parameters are Kp = 5, Ti = T = 1; the scheduled values are Kp = 2, Ti = T = 4. Open loop, SP = 1, PV = 0, CS_start = 0.</p>
<p>Before the fix, the sampled branches ignored the scheduled values, and the continuous PI did not start at CS_start (it started at -3).</p>
<h4>Expected results at t = 2 s</h4>
<table border=\"1\" cellspacing=\"0\" cellpadding=\"2\">
<tr><th>Instance</th><th>CS(0)</th><th>CS(2 s)</th></tr>
<tr><td>Pc, Pd</td><td>2</td><td>2 (= scheduled Kp &middot; e)</td></tr>
<tr><td>PIc</td><td>0</td><td>1.0</td></tr>
<tr><td>PId</td><td>0</td><td>0.976 (backward Euler)</td></tr>
<tr><td>Ic</td><td>0</td><td>0.5</td></tr>
<tr><td>Id</td><td>0.025</td><td>0.525 (backward Euler)</td></tr>
</table>
</html>", revisions="<html>
<ul>
<li>November 2026: added as a regression test for the 2.0.1 controller fixes (Hubertus Tummescheit).</li>
</ul>
</html>"));
end TestGainScheduling;
