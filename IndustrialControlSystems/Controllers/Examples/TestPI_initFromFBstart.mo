within IndustrialControlSystems.Controllers.Examples;
model TestPI_initFromFBstart "Regression test: PI reset state initialised from FBstart"
  extends Modelica.Icons.Example;
  Modelica.Blocks.Sources.Constant SP(k=0)
    annotation (Placement(transformation(extent={{-160,80},{-140,100}})));
  Modelica.Blocks.Sources.Constant PV(k=0)
    annotation (Placement(transformation(extent={{-160,50},{-140,70}})));
  IndustrialControlSystems.Controllers.PI PIc(initFromFBstart=true, FBstart=0.5)
    annotation (Placement(transformation(extent={{-50,-20},{-10,20}})));
  IndustrialControlSystems.Controllers.PI PId(initFromFBstart=true, FBstart=0.5, Ts=0.1)
    annotation (Placement(transformation(extent={{-50,-100},{-10,-60}})));
  IndustrialControlSystems.Controllers.PI PIc_default(FBstart=0.5)
    annotation (Placement(transformation(extent={{-50,-180},{-10,-140}})));
equation
  connect(SP.y, PIc.SP)
    annotation (Line(points={{-139,90},{-120,90},{-120,12},{-46,12}}, color={0,0,127}));
  connect(PV.y, PIc.PV)
    annotation (Line(points={{-139,60},{-130,60},{-130,-2},{-46,-2}}, color={0,0,127}));
  connect(SP.y, PId.SP)
    annotation (Line(points={{-139,90},{-120,90},{-120,-68},{-46,-68}}, color={0,0,127}));
  connect(PV.y, PId.PV)
    annotation (Line(points={{-139,60},{-130,60},{-130,-82},{-46,-82}}, color={0,0,127}));
  connect(SP.y, PIc_default.SP)
    annotation (Line(points={{-139,90},{-120,90},{-120,-148},{-46,-148}}, color={0,0,127}));
  connect(PV.y, PIc_default.PV)
    annotation (Line(points={{-139,60},{-130,60},{-130,-162},{-46,-162}}, color={0,0,127}));
  annotation (
    Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-170,-200},{10,110}})),
    experiment(StopTime=5, Tolerance=1e-6),
    Documentation(info="<html>
<p>Regression test for the option <code>initFromFBstart</code> of <a href=\"modelica://IndustrialControlSystems.Controllers.PI\">PI</a>: with <code>initFromFBstart = true</code> the reset state FBout starts at FBstart instead of being computed from CS_start. Open loop, SP = PV = 0, so the output stays at its initial value.</p>
<h4>Expected results</h4>
<table border=\"1\" cellspacing=\"0\" cellpadding=\"2\">
<tr><th>Instance</th><th>Configuration</th><th>CS for 0 &le; t &le; 5 s</th></tr>
<tr><td>PIc</td><td>continuous, initFromFBstart = true, FBstart = 0.5</td><td>0.5, constant</td></tr>
<tr><td>PId</td><td>sampled (Ts = 0.1), initFromFBstart = true, FBstart = 0.5</td><td>0.5, constant</td></tr>
<tr><td>PIc_default</td><td>continuous, FBstart = 0.5, initFromFBstart = false (default)</td><td>0 (= CS_start; FBstart is ignored)</td></tr>
</table>
</html>", revisions="<html>
<ul>
<li>November 2026: added as a regression test for the 2.0.1 controller fixes (Hubertus Tummescheit).</li>
</ul>
</html>"));
end TestPI_initFromFBstart;
