within IndustrialControlSystems.Controllers.Examples;
model TestPID_initCSstart "Regression test: PID starts at CS_start without a derivative kick"
  extends Modelica.Icons.Example;
  Modelica.Blocks.Sources.Constant SP(k=0.1)
    annotation (Placement(transformation(extent={{-160,110},{-140,130}})));
  Modelica.Blocks.Sources.Constant PV(k=0)
    annotation (Placement(transformation(extent={{-160,80},{-140,100}})));
  Modelica.Blocks.Sources.Constant BIAS(k=0.2)
    annotation (Placement(transformation(extent={{-160,50},{-140,70}})));
  IndustrialControlSystems.Controllers.PID PIDc(useBIAS=true, CS_start=0.3, CSmin=-2, CSmax=2)
    annotation (Placement(transformation(extent={{-50,-20},{-10,20}})));
  IndustrialControlSystems.Controllers.PID PIDd_AW(useBIAS=true, CS_start=0.3, CSmin=-2, CSmax=2, AntiWindup=true, Ts=0.1)
    annotation (Placement(transformation(extent={{-50,-100},{-10,-60}})));
  IndustrialControlSystems.Controllers.PID PIDc_Td0(useBIAS=true, CS_start=0.3, CSmin=-2, CSmax=2, Td=0)
    annotation (Placement(transformation(extent={{-50,-180},{-10,-140}})));
equation
  connect(SP.y, PIDc.SP)
    annotation (Line(points={{-139,120},{-110,120},{-110,12},{-46,12}}, color={0,0,127}));
  connect(PV.y, PIDc.PV)
    annotation (Line(points={{-139,90},{-120,90},{-120,-2},{-46,-2}}, color={0,0,127}));
  connect(BIAS.y, PIDc.BIAS)
    annotation (Line(points={{-139,60},{-130,60},{-130,28},{-38,28},{-38,16}}, color={0,0,127}));
  connect(SP.y, PIDd_AW.SP)
    annotation (Line(points={{-139,120},{-110,120},{-110,-68},{-46,-68}}, color={0,0,127}));
  connect(PV.y, PIDd_AW.PV)
    annotation (Line(points={{-139,90},{-120,90},{-120,-82},{-46,-82}}, color={0,0,127}));
  connect(BIAS.y, PIDd_AW.BIAS)
    annotation (Line(points={{-139,60},{-130,60},{-130,-52},{-38,-52},{-38,-64}}, color={0,0,127}));
  connect(SP.y, PIDc_Td0.SP)
    annotation (Line(points={{-139,120},{-110,120},{-110,-148},{-46,-148}}, color={0,0,127}));
  connect(PV.y, PIDc_Td0.PV)
    annotation (Line(points={{-139,90},{-120,90},{-120,-162},{-46,-162}}, color={0,0,127}));
  connect(BIAS.y, PIDc_Td0.BIAS)
    annotation (Line(points={{-139,60},{-130,60},{-130,-132},{-38,-132},{-38,-144}}, color={0,0,127}));
  annotation (
    Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-170,-200},{10,140}})),
    experiment(StopTime=1, Tolerance=1e-6),
    Documentation(info="<html>
<p>Regression test for the initialisation of <a href=\"modelica://IndustrialControlSystems.Controllers.PID\">PID</a>:
the output must start at <code>CS_start</code> without a derivative kick, with and without AntiWindup and for Td = 0.
Open loop: SP = 0.1, PV = 0, BIAS = 0.2, CS_start = 0.3, CSmin = -2, CSmax = 2 (no saturation),
default gains (Kp = 5, Ti = Td = 1, N = 10, b = c = 1).
<a href=\"modelica://IndustrialControlSystems.Controllers.Examples.TestInit_CSstart\">TestInit_CSstart</a> checks the same for I, PI and D.</p>
<p>Before the fix, PID ignored CS_start and started its integral and derivative filter states at zero. It therefore started at
Kp*(SP - PV) + BIAS plus a derivative kick of Kp*N*(SP - PV): CS(0) = 5.7 continuous, 2.0 (= CSmax) sampled with AntiWindup,
and 0.7 with Td = 0.</p>
<p>The sampled controller sets its states one sample before t = 0, so at t = 0 its output has already moved by one integration step.</p>
<h4>Expected results</h4>
<table border=\"1\" cellspacing=\"0\" cellpadding=\"2\">
<tr><th>Instance</th><th>Configuration</th><th>CS(0)</th><th>CS(1)</th></tr>
<tr><td>PIDc</td><td>continuous</td><td>0.3 (no derivative kick)</td><td>0.8</td></tr>
<tr><td>PIDd_AW</td><td>sampled, Ts = 0.1, AntiWindup</td><td>0.35 (one integration step of Kp*(SP - PV)*Ts/Ti = 0.05)</td><td>0.85</td></tr>
<tr><td>PIDc_Td0</td><td>continuous, Td = 0</td><td>0.3</td><td>0.8</td></tr>
</table>
</html>", revisions="<html>
<ul>
<li>November 2026: added as a regression test for the PID CS_start initialisation (#17) (Hubertus Tummescheit).</li>
</ul>
</html>"));
end TestPID_initCSstart;
