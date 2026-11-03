within IndustrialControlSystems.Controllers.Examples;
model TestTracking_bumpless "Regression test: bumpless return from tracking to automatic mode (PI, PID, PI autotuners)"
  extends Modelica.Icons.Example;
  Modelica.Blocks.Sources.Constant SP(k=1)
    annotation (Placement(transformation(extent={{-160,200},{-140,220}})));
  Modelica.Blocks.Sources.Constant PV(k=0.5)
    annotation (Placement(transformation(extent={{-160,170},{-140,190}})));
  Modelica.Blocks.Sources.Constant TR(k=0.3)
    annotation (Placement(transformation(extent={{-160,140},{-140,160}})));
  Modelica.Blocks.Sources.Constant BIAS(k=0.2)
    annotation (Placement(transformation(extent={{-160,110},{-140,130}})));
  Modelica.Blocks.Sources.BooleanStep TS(startTime=3, startValue=true)
    annotation (Placement(transformation(extent={{-160,80},{-140,100}})));
  Modelica.Blocks.Sources.BooleanConstant noAT(k=false)
    annotation (Placement(transformation(extent={{-160,50},{-140,70}})));
  IndustrialControlSystems.Controllers.PI PIc(useTS=true, useBIAS=true, Kp=2, Ti=1)
    annotation (Placement(transformation(extent={{-50,-20},{-10,20}})));
  IndustrialControlSystems.Controllers.PI PId(useTS=true, useBIAS=true, Kp=2, Ti=1, Ts=0.1)
    annotation (Placement(transformation(extent={{-50,-100},{-10,-60}})));
  IndustrialControlSystems.Controllers.PID PIDc(useTS=true, useBIAS=true, Kp=2, Ti=1, Td=0.5)
    annotation (Placement(transformation(extent={{-50,-180},{-10,-140}})));
  IndustrialControlSystems.Controllers.PID PIDd(useTS=true, useBIAS=true, Kp=2, Ti=1, Td=0.5, Ts=0.1)
    annotation (Placement(transformation(extent={{-50,-260},{-10,-220}})));
  IndustrialControlSystems.Controllers.AutoTuning.ATPIrelayNCdigital ATdigital(useTS=true, useBIAS=true, Kp=2, Ti=1, Ts=0.1)
    annotation (Placement(transformation(extent={{-50,-340},{-10,-300}})));
  IndustrialControlSystems.Controllers.AutoTuning.ATPIrelayNCmixedMode ATmixed(useTS=true, useBIAS=true, Kp=2, Ti=1, Ts=0.1)
    annotation (Placement(transformation(extent={{-50,-420},{-10,-380}})));
equation
  connect(SP.y, PIc.SP)
    annotation (Line(points={{-139,210},{-80,210},{-80,12},{-46,12}}, color={0,0,127}));
  connect(PV.y, PIc.PV)
    annotation (Line(points={{-139,180},{-90,180},{-90,-2},{-46,-2}}, color={0,0,127}));
  connect(TR.y, PIc.TR)
    annotation (Line(points={{-139,150},{-100,150},{-100,32},{-30,32},{-30,16}}, color={0,0,127}));
  connect(TS.y, PIc.TS)
    annotation (Line(points={{-139,90},{-120,90},{-120,36},{-22,36},{-22,16}}, color={255,0,255}));
  connect(BIAS.y, PIc.BIAS)
    annotation (Line(points={{-139,120},{-110,120},{-110,28},{-38,28},{-38,16}}, color={0,0,127}));
  connect(SP.y, PId.SP)
    annotation (Line(points={{-139,210},{-80,210},{-80,-68},{-46,-68}}, color={0,0,127}));
  connect(PV.y, PId.PV)
    annotation (Line(points={{-139,180},{-90,180},{-90,-82},{-46,-82}}, color={0,0,127}));
  connect(TR.y, PId.TR)
    annotation (Line(points={{-139,150},{-100,150},{-100,-48},{-30,-48},{-30,-64}}, color={0,0,127}));
  connect(TS.y, PId.TS)
    annotation (Line(points={{-139,90},{-120,90},{-120,-44},{-22,-44},{-22,-64}}, color={255,0,255}));
  connect(BIAS.y, PId.BIAS)
    annotation (Line(points={{-139,120},{-110,120},{-110,-52},{-38,-52},{-38,-64}}, color={0,0,127}));
  connect(SP.y, PIDc.SP)
    annotation (Line(points={{-139,210},{-80,210},{-80,-148},{-46,-148}}, color={0,0,127}));
  connect(PV.y, PIDc.PV)
    annotation (Line(points={{-139,180},{-90,180},{-90,-162},{-46,-162}}, color={0,0,127}));
  connect(TR.y, PIDc.TR)
    annotation (Line(points={{-139,150},{-100,150},{-100,-128},{-30,-128},{-30,-144}}, color={0,0,127}));
  connect(TS.y, PIDc.TS)
    annotation (Line(points={{-139,90},{-120,90},{-120,-124},{-22,-124},{-22,-144}}, color={255,0,255}));
  connect(BIAS.y, PIDc.BIAS)
    annotation (Line(points={{-139,120},{-110,120},{-110,-132},{-38,-132},{-38,-144}}, color={0,0,127}));
  connect(SP.y, PIDd.SP)
    annotation (Line(points={{-139,210},{-80,210},{-80,-228},{-46,-228}}, color={0,0,127}));
  connect(PV.y, PIDd.PV)
    annotation (Line(points={{-139,180},{-90,180},{-90,-242},{-46,-242}}, color={0,0,127}));
  connect(TR.y, PIDd.TR)
    annotation (Line(points={{-139,150},{-100,150},{-100,-208},{-30,-208},{-30,-224}}, color={0,0,127}));
  connect(TS.y, PIDd.TS)
    annotation (Line(points={{-139,90},{-120,90},{-120,-204},{-22,-204},{-22,-224}}, color={255,0,255}));
  connect(BIAS.y, PIDd.BIAS)
    annotation (Line(points={{-139,120},{-110,120},{-110,-212},{-38,-212},{-38,-224}}, color={0,0,127}));
  connect(SP.y, ATdigital.SP)
    annotation (Line(points={{-139,210},{-80,210},{-80,-308},{-46,-308}}, color={0,0,127}));
  connect(PV.y, ATdigital.PV)
    annotation (Line(points={{-139,180},{-90,180},{-90,-322},{-46,-322}}, color={0,0,127}));
  connect(TR.y, ATdigital.TR)
    annotation (Line(points={{-139,150},{-100,150},{-100,-288},{-30,-288},{-30,-304}}, color={0,0,127}));
  connect(TS.y, ATdigital.TS)
    annotation (Line(points={{-139,90},{-120,90},{-120,-284},{-22,-284},{-22,-304}}, color={255,0,255}));
  connect(BIAS.y, ATdigital.BIAS)
    annotation (Line(points={{-139,120},{-110,120},{-110,-292},{-38,-292},{-38,-304}}, color={0,0,127}));
  connect(noAT.y, ATdigital.ATreq)
    annotation (Line(points={{-139,60},{-130,60},{-130,-336},{-46,-336}}, color={255,0,255}));
  connect(SP.y, ATmixed.SP)
    annotation (Line(points={{-139,210},{-80,210},{-80,-388},{-46,-388}}, color={0,0,127}));
  connect(PV.y, ATmixed.PV)
    annotation (Line(points={{-139,180},{-90,180},{-90,-402},{-46,-402}}, color={0,0,127}));
  connect(TR.y, ATmixed.TR)
    annotation (Line(points={{-139,150},{-100,150},{-100,-368},{-30,-368},{-30,-384}}, color={0,0,127}));
  connect(TS.y, ATmixed.TS)
    annotation (Line(points={{-139,90},{-120,90},{-120,-364},{-22,-364},{-22,-384}}, color={255,0,255}));
  connect(BIAS.y, ATmixed.BIAS)
    annotation (Line(points={{-139,120},{-110,120},{-110,-372},{-38,-372},{-38,-384}}, color={0,0,127}));
  connect(noAT.y, ATmixed.ATreq)
    annotation (Line(points={{-139,60},{-130,60},{-130,-416},{-46,-416}}, color={255,0,255}));
  annotation (
    Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-170,-440},{10,230}})),
    experiment(StopTime=5, Tolerance=1e-6),
    Documentation(info="<html>
<p>Regression test for the bumpless return from tracking to automatic mode. While tracking, the integral (reset) state follows the value for which the automatic control law gives CS = TR. Open loop: SP = 1, PV = 0.5 (e = 0.5), TR = 0.3, BIAS = 0.2, Kp = 2, Ti = 1 (Td = 0.5 for PID), tracking released at t = 3 s. The autotuners get ATreq = false, so they do not tune.</p>
<p>Before the fix, the output jumped at release from TR to TR + P (+ D) + bias, here to about 1.5.</p>
<h4>Expected results</h4>
<table border=\"1\" cellspacing=\"0\" cellpadding=\"2\">
<tr><th>Instance</th><th>CS until release</th><th>CS after release</th></tr>
<tr><td>PIc, PIDc</td><td>0.3</td><td>continues from 0.3, ramps at Kp&middot;e/Ti = 1/s (2.3 at t = 5 s)</td></tr>
<tr><td>PId (Ts = 0.1)</td><td>0.3</td><td>0.3, then +0.091 per sample (2.118 at t = 5 s)</td></tr>
<tr><td>PIDd (Ts = 0.1)</td><td>0.3</td><td>+0.1 per sample from the sample at t = 3 s (0.4 at t = 3 s, 2.4 at t = 5 s)</td></tr>
<tr><td>ATdigital (Ts = 0.1)</td><td>0.3</td><td>+0.1 per sample from t = 3 s, limited by CSmax = 1</td></tr>
<tr><td>ATmixed</td><td>0.3</td><td>continues from 0.3, ramps at 1/s (2.3 at t = 5 s)</td></tr>
</table>
</html>", revisions="<html>
<ul>
<li>November 2026: added as a regression test for the 2.0.1 controller fixes (Hubertus Tummescheit).</li>
</ul>
</html>"));
end TestTracking_bumpless;
