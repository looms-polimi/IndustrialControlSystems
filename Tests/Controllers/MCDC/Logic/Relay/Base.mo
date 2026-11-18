within Tests.Controllers.MCDC.Logic.Relay;
model Base "MC/DC base: IndustrialControlSystems.Controllers.Logic.Relay, continuous, every option off"
  extends Modelica.Icons.Example;
  parameter Real Ts = 0 "Sampling time (0: continuous)" annotation(Evaluate=true);
  parameter Real Ymin = 0 "Output when off";
  parameter Real Ymax = 1 "Output when on";
  parameter Real Th = 0.3 "Threshold";
  Modelica.Blocks.Sources.Sine u(amplitude=1, f=0.2) "Input"
    annotation (Placement(transformation(extent={{-50,-10},{-30,10}})));
  IndustrialControlSystems.Controllers.Logic.Relay dut(Ts=Ts, Ymin=Ymin, Ymax=Ymax, Th=Th) "Relay under test"
    annotation (Placement(transformation(extent={{-10,-10},{10,10}})));
  Tests.Utilities.CheckRealWhile chkRelay(
      actual=dut.y,
      expected=if u.y >= Th then Ymax else Ymin,
      active=abs(u.y - Th) > (if Ts > 0 then 0.2 else 0.01),
      absTol=1e-9,
      tStart=0.01,
      dt=0.02)
    "y = Ymax where u >= Th, Ymin elsewhere (away from the thresholds by more than the input moves in one sample)"
    annotation (Placement(transformation(extent={{30,-10},{50,10}})));
  Boolean passed = chkRelay.passed
    "true if every enabled check of this configuration passed";
equation
  connect(u.y, dut.u) annotation (Line(points={{-29,0},{-8,0}}, color={0,0,127}));
  annotation (
    experiment(StopTime=12, Interval=0.005, Tolerance=1e-6),
    Diagram(coordinateSystem(extent={{-60,-20},{60,20}}, grid={1,1})),
    Documentation(info="<html>
<p>Base of the MC/DC tests of <a href=\"modelica://IndustrialControlSystems.Controllers.Logic.Relay\">IndustrialControlSystems.Controllers.Logic.Relay</a>:
a sine of amplitude 1 and 0.2 Hz against the threshold 0.3.
The expected output is stated independently;
<code>chkRelay</code>: y = Ymax where u >= Th, Ymin elsewhere.</p>
</html>"));
end Base;
