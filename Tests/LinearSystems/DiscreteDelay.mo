within Tests.LinearSystems;
model DiscreteDelay
  "Discrete.Delay: one-sample delay of a sampled and a continuous ramp"
  extends Modelica.Icons.Example;
  parameter Real Ts = 0.1 "Sampling time";
  Modelica.Blocks.Sources.Ramp ramp(height=2, duration=2) "Continuous ramp u = t"
    annotation (Placement(transformation(extent={{-100,82},{-84,98}})));
  Modelica.Blocks.Discrete.ZeroOrderHold zoh(samplePeriod=Ts) "Ramp sampled every Ts"
    annotation (Placement(transformation(extent={{-100,57},{-84,73}})));
  Modelica.Blocks.Sources.RealExpression expected(y=noEvent(if time < Ts then 0 else Ts*(floor(time/Ts) - 1))) "u one sample earlier: (k-1)*Ts on [k*Ts, (k+1)*Ts)"
    annotation (Placement(transformation(extent={{-50,82},{-34,98}})));
  IndustrialControlSystems.LinearSystems.Discrete.Delay delay_cont(Ts=Ts) "Continuous input"
    annotation (Placement(transformation(extent={{0,82},{16,98}})));
  IndustrialControlSystems.LinearSystems.Discrete.Delay delay_disc(Ts=Ts) "Sampled input"
    annotation (Placement(transformation(extent={{0,57},{16,73}})));
  Utilities.CheckReal chk_cont(absTol=1e-9, tStart=1.5*Ts, dt=Ts)
    annotation (Placement(transformation(extent={{50,82},{66,98}})));
  Utilities.CheckReal chk_disc(absTol=1e-9, tStart=1.5*Ts, dt=Ts)
    annotation (Placement(transformation(extent={{50,57},{66,73}})));
  Boolean passed = chk_cont.passed and chk_disc.passed "true if every check in this test passed";
equation
  connect(ramp.y, zoh.u);
  connect(ramp.y, delay_cont.u);
  connect(zoh.y, delay_disc.u);
  connect(delay_cont.y, chk_cont.actual);
  connect(delay_disc.y, chk_disc.actual);
  connect(expected.y, chk_cont.expected);
  connect(expected.y, chk_disc.expected);
  annotation (
    experiment(StopTime=2, Interval=0.005),
    Diagram(coordinateSystem(extent={{-110,47},{76,100}})),
    Documentation(info="<html>
<p>Checks that <a href=\"modelica://IndustrialControlSystems.LinearSystems.Discrete.Delay\">Discrete.Delay</a>
delays its input by one sampling period, as documented: Y(z) = z<sup>-1</sup>U(z). The input is the ramp
u = t (for t &lt; 2 s), so on [kTs, (k+1)Ts) the output should be (k-1)Ts. Checks are in the middle of
each sampling interval.</p>
<ul><li><code>delay_disc</code>: the ramp sampled by a zero-order hold with the same period.</li>
<li><code>delay_cont</code>: the continuous ramp connected directly, as one would connect a
continuous plant output.</li></ul>
<p>The verdict is <code>passed</code>.</p>
</html>"));
end DiscreteDelay;
