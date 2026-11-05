within IndustrialControlSystems.Controllers.Examples;
model TestTracking_bias "Regression test: in tracking mode CS = TR, the bias is not added (PI, I, PID)"
  extends Modelica.Icons.Example;
  Modelica.Blocks.Sources.Constant SP(k=0)
    annotation (Placement(transformation(extent={{-160,170},{-140,190}})));
  Modelica.Blocks.Sources.Constant PV(k=0)
    annotation (Placement(transformation(extent={{-160,140},{-140,160}})));
  Modelica.Blocks.Sources.Constant TR(k=0.3)
    annotation (Placement(transformation(extent={{-160,110},{-140,130}})));
  Modelica.Blocks.Sources.Constant BIAS(k=0.2)
    annotation (Placement(transformation(extent={{-160,80},{-140,100}})));
  Modelica.Blocks.Sources.BooleanStep TS(startTime=3, startValue=true)
    annotation (Placement(transformation(extent={{-160,50},{-140,70}})));
  IndustrialControlSystems.Controllers.PI PIc(useTS=true, useBIAS=true)
    annotation (Placement(transformation(extent={{-50,-20},{-10,20}})));
  IndustrialControlSystems.Controllers.PI PId(useTS=true, useBIAS=true, Ts=0.1)
    annotation (Placement(transformation(extent={{-50,-100},{-10,-60}})));
  IndustrialControlSystems.Controllers.I Ic(useTS=true, useBIAS=true)
    annotation (Placement(transformation(extent={{-50,-180},{-10,-140}})));
  IndustrialControlSystems.Controllers.I Id(useTS=true, useBIAS=true, Ts=0.1)
    annotation (Placement(transformation(extent={{-50,-260},{-10,-220}})));
  IndustrialControlSystems.Controllers.PID PIDc(useTS=true, useBIAS=true)
    annotation (Placement(transformation(extent={{-50,-340},{-10,-300}})));
  IndustrialControlSystems.Controllers.PID PIDd(useTS=true, useBIAS=true, Ts=0.1)
    annotation (Placement(transformation(extent={{-50,-420},{-10,-380}})));
equation
  connect(SP.y, PIc.SP)
    annotation (Line(points={{-139,180},{-90,180},{-90,12},{-46,12}}, color={0,0,127}));
  connect(PV.y, PIc.PV)
    annotation (Line(points={{-139,150},{-100,150},{-100,-2},{-46,-2}}, color={0,0,127}));
  connect(TR.y, PIc.TR)
    annotation (Line(points={{-139,120},{-110,120},{-110,32},{-30,32},{-30,16}}, color={0,0,127}));
  connect(TS.y, PIc.TS)
    annotation (Line(points={{-139,60},{-130,60},{-130,36},{-22,36},{-22,16}}, color={255,0,255}));
  connect(BIAS.y, PIc.BIAS)
    annotation (Line(points={{-139,90},{-120,90},{-120,28},{-38,28},{-38,16}}, color={0,0,127}));
  connect(SP.y, PId.SP)
    annotation (Line(points={{-139,180},{-90,180},{-90,-68},{-46,-68}}, color={0,0,127}));
  connect(PV.y, PId.PV)
    annotation (Line(points={{-139,150},{-100,150},{-100,-82},{-46,-82}}, color={0,0,127}));
  connect(TR.y, PId.TR)
    annotation (Line(points={{-139,120},{-110,120},{-110,-48},{-30,-48},{-30,-64}}, color={0,0,127}));
  connect(TS.y, PId.TS)
    annotation (Line(points={{-139,60},{-130,60},{-130,-44},{-22,-44},{-22,-64}}, color={255,0,255}));
  connect(BIAS.y, PId.BIAS)
    annotation (Line(points={{-139,90},{-120,90},{-120,-52},{-38,-52},{-38,-64}}, color={0,0,127}));
  connect(SP.y, Ic.SP)
    annotation (Line(points={{-139,180},{-90,180},{-90,-148},{-46,-148}}, color={0,0,127}));
  connect(PV.y, Ic.PV)
    annotation (Line(points={{-139,150},{-100,150},{-100,-162},{-46,-162}}, color={0,0,127}));
  connect(TR.y, Ic.TR)
    annotation (Line(points={{-139,120},{-110,120},{-110,-128},{-30,-128},{-30,-144}}, color={0,0,127}));
  connect(TS.y, Ic.TS)
    annotation (Line(points={{-139,60},{-130,60},{-130,-124},{-22,-124},{-22,-144}}, color={255,0,255}));
  connect(BIAS.y, Ic.BIAS)
    annotation (Line(points={{-139,90},{-120,90},{-120,-132},{-38,-132},{-38,-144}}, color={0,0,127}));
  connect(SP.y, Id.SP)
    annotation (Line(points={{-139,180},{-90,180},{-90,-228},{-46,-228}}, color={0,0,127}));
  connect(PV.y, Id.PV)
    annotation (Line(points={{-139,150},{-100,150},{-100,-242},{-46,-242}}, color={0,0,127}));
  connect(TR.y, Id.TR)
    annotation (Line(points={{-139,120},{-110,120},{-110,-208},{-30,-208},{-30,-224}}, color={0,0,127}));
  connect(TS.y, Id.TS)
    annotation (Line(points={{-139,60},{-130,60},{-130,-204},{-22,-204},{-22,-224}}, color={255,0,255}));
  connect(BIAS.y, Id.BIAS)
    annotation (Line(points={{-139,90},{-120,90},{-120,-212},{-38,-212},{-38,-224}}, color={0,0,127}));
  connect(SP.y, PIDc.SP)
    annotation (Line(points={{-139,180},{-90,180},{-90,-308},{-46,-308}}, color={0,0,127}));
  connect(PV.y, PIDc.PV)
    annotation (Line(points={{-139,150},{-100,150},{-100,-322},{-46,-322}}, color={0,0,127}));
  connect(TR.y, PIDc.TR)
    annotation (Line(points={{-139,120},{-110,120},{-110,-288},{-30,-288},{-30,-304}}, color={0,0,127}));
  connect(TS.y, PIDc.TS)
    annotation (Line(points={{-139,60},{-130,60},{-130,-284},{-22,-284},{-22,-304}}, color={255,0,255}));
  connect(BIAS.y, PIDc.BIAS)
    annotation (Line(points={{-139,90},{-120,90},{-120,-292},{-38,-292},{-38,-304}}, color={0,0,127}));
  connect(SP.y, PIDd.SP)
    annotation (Line(points={{-139,180},{-90,180},{-90,-388},{-46,-388}}, color={0,0,127}));
  connect(PV.y, PIDd.PV)
    annotation (Line(points={{-139,150},{-100,150},{-100,-402},{-46,-402}}, color={0,0,127}));
  connect(TR.y, PIDd.TR)
    annotation (Line(points={{-139,120},{-110,120},{-110,-368},{-30,-368},{-30,-384}}, color={0,0,127}));
  connect(TS.y, PIDd.TS)
    annotation (Line(points={{-139,60},{-130,60},{-130,-364},{-22,-364},{-22,-384}}, color={255,0,255}));
  connect(BIAS.y, PIDd.BIAS)
    annotation (Line(points={{-139,90},{-120,90},{-120,-372},{-38,-372},{-38,-384}}, color={0,0,127}));
  annotation (
    Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-170,-440},{10,200}})),
    experiment(StopTime=6, Tolerance=1e-6),
    Documentation(info="<html>
<p>Regression test for tracking mode with a bias: while TS = true the output must equal TR; the bias is not added. Open loop: SP = PV = 0, TR = 0.3, BIAS = 0.2, tracking until t = 3 s. PI, I and PID, continuous and sampled (Ts = 0.1), default gains.</p>
<p>Before the fixes, the continuous PI and both PID branches gave TR + bias = 0.5 while tracking, and I without AntiWindup also added the bias.</p>
<h4>Expected results</h4>
<table border=\"1\" cellspacing=\"0\" cellpadding=\"2\">
<tr><th>Instance</th><th>CS while tracking</th><th>CS after release (e = 0)</th></tr>
<tr><td>PIc, PId, Id, PIDc, PIDd</td><td>0.3 from t = 0</td><td>0.3 (bumpless)</td></tr>
<tr><td>Ic</td><td>starts at CS_start = 0, follows TR with time constant eps = 0.1, 0.3 after about 1 s</td><td>0.3 (bumpless)</td></tr>
</table>
</html>", revisions="<html>
<ul>
<li>November 2026: added as a regression test for the 2.0.1 controller fixes (Hubertus Tummescheit).</li>
</ul>
</html>"));
end TestTracking_bias;
