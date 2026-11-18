within Tests.LinearSystems;
model DiscreteDelay
  "Discrete.Delay and MultiStepsDelay: delay of a sampled and a continuous ramp"
  extends Modelica.Icons.Example;
  parameter Real Ts = 0.1 "Sampling time";
  Modelica.Blocks.Sources.Ramp ramp(height=2, duration=2) "Continuous ramp u = t"
    annotation (Placement(transformation(extent={{-160,10},{-140,30}})));
  Modelica.Blocks.Discrete.ZeroOrderHold zoh(samplePeriod=Ts, startTime=Ts/2) "Ramp sampled every Ts, half a period before the delay samples"
    annotation (Placement(transformation(extent={{-160,-20},{-140,0}})));
  IndustrialControlSystems.LinearSystems.Discrete.Delay delay_disc(Ts=Ts) "Sampled input"
    annotation (Placement(transformation(extent={{-110,-10},{-90,10}})));
  Modelica.Blocks.Sources.RealExpression expected_disc(y=noEvent(if time < 2*Ts then 0 else Ts*(floor(time/Ts) - 1.5))) "Held value read one sample earlier: (k-1.5)*Ts on [k*Ts, (k+1)*Ts)"
    annotation (Placement(transformation(extent={{-110,-40},{-90,-20}})));
  Utilities.CheckReal chk_disc(absTol=1e-9, tStart=1.5*Ts, dt=Ts)
    annotation (Placement(transformation(extent={{-50,-30},{-30,-10}})));
  IndustrialControlSystems.LinearSystems.Discrete.Delay delay_cont(Ts=Ts) "Continuous input"
    annotation (Placement(transformation(extent={{-110,-70},{-90,-50}})));
  Modelica.Blocks.Sources.RealExpression expected_cont(y=noEvent(if time < Ts then 0 else Ts*(floor(time/Ts) - 1))) "u one sample earlier: (k-1)*Ts on [k*Ts, (k+1)*Ts)"
    annotation (Placement(transformation(extent={{-110,-100},{-90,-80}})));
  Utilities.CheckReal chk_cont(absTol=1e-9, tStart=1.5*Ts, dt=Ts)
    annotation (Placement(transformation(extent={{-50,-90},{-30,-70}})));
  IndustrialControlSystems.LinearSystems.Discrete.MultiStepsDelay delay_multi(Ts=Ts, N=3) "Continuous input, three samples"
    annotation (Placement(transformation(extent={{-110,-130},{-90,-110}})));
  Modelica.Blocks.Sources.RealExpression expected_multi(y=noEvent(if time < 3*Ts then 0 else Ts*(floor(time/Ts) - 3))) "u three samples earlier: (k-3)*Ts on [k*Ts, (k+1)*Ts)"
    annotation (Placement(transformation(extent={{-110,-160},{-90,-140}})));
  Utilities.CheckReal chk_multi(absTol=1e-9, tStart=1.5*Ts, dt=Ts)
    annotation (Placement(transformation(extent={{-50,-150},{-30,-130}})));
  Boolean passed = chk_cont.passed and chk_disc.passed and chk_multi.passed "true if every check in this test passed";
equation
  connect(zoh.y, delay_disc.u) annotation (Line(points={{-139,-10},{-130,-10},{-130,0},{-108,0}}, color={0,0,127}));
  connect(delay_disc.y, chk_disc.actual) annotation (Line(points={{-91,0},{-70,0},{-70,-14},{-52,-14}}, color={0,0,127}));
  connect(expected_disc.y, chk_disc.expected) annotation (Line(points={{-89,-30},{-60,-30},{-60,-26},{-52,-26}}, color={0,0,127}));
  connect(ramp.y, delay_cont.u) annotation (Line(points={{-139,20},{-120,20},{-120,-60},{-108,-60}}, color={0,0,127}));
  connect(delay_cont.y, chk_cont.actual) annotation (Line(points={{-91,-60},{-70,-60},{-70,-74},{-52,-74}}, color={0,0,127}));
  connect(expected_cont.y, chk_cont.expected) annotation (Line(points={{-89,-90},{-60,-90},{-60,-86},{-52,-86}}, color={0,0,127}));
  connect(ramp.y, delay_multi.u) annotation (Line(points={{-139,20},{-120,20},{-120,-120},{-108,-120}}, color={0,0,127}));
  connect(delay_multi.y, chk_multi.actual) annotation (Line(points={{-91,-120},{-70,-120},{-70,-134},{-52,-134}}, color={0,0,127}));
  connect(expected_multi.y, chk_multi.expected) annotation (Line(points={{-89,-150},{-60,-150},{-60,-146},{-52,-146}}, color={0,0,127}));
  connect(ramp.y, zoh.u) annotation (Line(points={{-139,20},{-135,20},{-135,5},{-170,5},{-170,-10},{-162,-10}}, color={0,0,127}));
  annotation (
    experiment(StopTime=2, Interval=0.005),
    Diagram(coordinateSystem(extent={{-180,-170},{-20,40}}, grid={1,1})),
    Documentation(info="<html>
<p>Checks that <a href=\"modelica://IndustrialControlSystems.LinearSystems.Discrete.Delay\">Discrete.Delay</a>
delays its input by one sampling period, as documented: Y(z) = z<sup>-1</sup>U(z). The input is the ramp
u = t (for t &lt; 2 s), so on [kTs, (k+1)Ts) the output should be (k-1)Ts. Checks are in the middle of
each sampling interval.</p>
<ul><li><code>delay_disc</code>: the ramp sampled by a zero-order hold with the same period, offset by
half a period. At instant kTs the delay reads the held value (k-0.5)Ts, so its output on
[kTs, (k+1)Ts) should be (k-1.5)Ts. The offset avoids sampling at the instants where the hold
changes: <code>Modelica.Blocks.Discrete.ZeroOrderHold</code> outputs <code>pre(ySample)</code>, so a
block sampling at the same instants reads the previous held value.</li>
<li><code>delay_cont</code>: the continuous ramp connected directly, as one would connect a
continuous plant output.</li>
<li><code>delay_multi</code>: <a href=\"modelica://IndustrialControlSystems.LinearSystems.Discrete.MultiStepsDelay\">Discrete.MultiStepsDelay</a>
with N = 3 and the continuous ramp: Y(z) = z<sup>-3</sup>U(z), so the output should be (k-3)Ts.</li></ul>
<p>The verdict is <code>passed</code>.</p>
</html>"));
end DiscreteDelay;
