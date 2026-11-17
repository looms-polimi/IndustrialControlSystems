within IndustrialControlSystems.Controllers.Examples;
model TestI_biasNoDrift "Regression test: integral controller with bias must not drift (open loop, zero error)"
  extends Modelica.Icons.Example;
  Modelica.Blocks.Sources.Constant SP(k=0)
    annotation (Placement(transformation(extent={{-160,110},{-140,130}})));
  Modelica.Blocks.Sources.Constant PV(k=0)
    annotation (Placement(transformation(extent={{-160,80},{-140,100}})));
  Modelica.Blocks.Sources.Constant BIAS(k=1)
    annotation (Placement(transformation(extent={{-160,50},{-140,70}})));
  IndustrialControlSystems.Controllers.I Ic(useBIAS=true, T=1, CS_start=0)
    annotation (Placement(transformation(extent={{-50,-20},{-10,20}})));
  IndustrialControlSystems.Controllers.I Ic_AW(useBIAS=true, T=1, CS_start=0, AntiWindup=true, CSmin=-2, CSmax=2)
    annotation (Placement(transformation(extent={{-50,-100},{-10,-60}})));
  IndustrialControlSystems.Controllers.I Id(useBIAS=true, T=1, CS_start=0, Ts=0.1)
    annotation (Placement(transformation(extent={{-50,-180},{-10,-140}})));
equation
  connect(SP.y, Ic.SP)
    annotation (Line(points={{-139,120},{-110,120},{-110,12},{-46,12}}, color={0,0,127}));
  connect(PV.y, Ic.PV)
    annotation (Line(points={{-139,90},{-120,90},{-120,-2},{-46,-2}}, color={0,0,127}));
  connect(BIAS.y, Ic.BIAS)
    annotation (Line(points={{-139,60},{-130,60},{-130,28},{-38,28},{-38,16}}, color={0,0,127}));
  connect(SP.y, Ic_AW.SP)
    annotation (Line(points={{-139,120},{-110,120},{-110,-68},{-46,-68}}, color={0,0,127}));
  connect(PV.y, Ic_AW.PV)
    annotation (Line(points={{-139,90},{-120,90},{-120,-82},{-46,-82}}, color={0,0,127}));
  connect(BIAS.y, Ic_AW.BIAS)
    annotation (Line(points={{-139,60},{-130,60},{-130,-52},{-38,-52},{-38,-64}}, color={0,0,127}));
  connect(SP.y, Id.SP)
    annotation (Line(points={{-139,120},{-110,120},{-110,-148},{-46,-148}}, color={0,0,127}));
  connect(PV.y, Id.PV)
    annotation (Line(points={{-139,90},{-120,90},{-120,-162},{-46,-162}}, color={0,0,127}));
  connect(BIAS.y, Id.BIAS)
    annotation (Line(points={{-139,60},{-130,60},{-130,-132},{-38,-132},{-38,-144}}, color={0,0,127}));
  annotation (
    Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-170,-200},{10,140}})),
    experiment(StopTime=10, Tolerance=1e-6),
    Documentation(info="<html>
<p>Regression test for the anti-windup term of the continuous <a href=\"modelica://IndustrialControlSystems.Controllers.I\">I</a> controller with a bias input. Open loop: SP = PV = 0, BIAS = 1, so the error is zero and the output must stay constant.</p>
<p>Before the fix, the continuous controller's pull-back term was <code>bias/eps</code> whenever the output was not saturated, so CS ramped at 10/s (with the default eps = 0.1).</p>
<h4>Expected results</h4>
<table border=\"1\" cellspacing=\"0\" cellpadding=\"2\">
<tr><th>Instance</th><th>Configuration</th><th>CS for 0 &le; t &le; 10 s</th></tr>
<tr><td>Ic</td><td>continuous</td><td>0, constant</td></tr>
<tr><td>Ic_AW</td><td>continuous, AntiWindup, CSmin = -2, CSmax = 2</td><td>0, constant (until the CS_start fix, #15, it was 1: with AntiWindup the state started at CS_start, so CS = CS_start + bias)</td></tr>
<tr><td>Id</td><td>sampled, Ts = 0.1</td><td>0, constant (the sampled branch was already correct)</td></tr>
</table>
</html>", revisions="<html>
<ul>
<li>November 2026: added as a regression test for the 2.0.1 controller fixes (Hubertus Tummescheit).</li>
</ul>
</html>"));
end TestI_biasNoDrift;
