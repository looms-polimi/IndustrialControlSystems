within Tests.Controllers.MCDC.Logic.RelayHysteresis;
model Base "MC/DC base: IndustrialControlSystems.Controllers.Logic.RelayHysteresis, continuous, every option off"
  extends Modelica.Icons.Example;
  parameter Real Ts = 0 "Sampling time (0: continuous)" annotation(Evaluate=true);
  parameter Real Ymin = 0 "Output when off";
  parameter Real Ymax = 1 "Output when on";
  parameter Boolean initState = false "Initial state of the relay" annotation(Evaluate=true);
  parameter Real ThL = -0.3 "Low threshold";
  parameter Real ThH = 0.3 "High threshold";
  discrete Boolean hi(start=initState, fixed=true) "Expected state";
  Modelica.Blocks.Sources.Sine u(amplitude=1, f=0.2) "Input"
    annotation (Placement(transformation(extent={{-50,-10},{-30,10}})));
  IndustrialControlSystems.Controllers.Logic.RelayHysteresis dut(Ts=Ts, Ymin=Ymin, Ymax=Ymax, ThL=ThL, ThH=ThH, initState=initState) "Relay under test"
    annotation (Placement(transformation(extent={{-10,-10},{10,10}})));
  Tests.Utilities.CheckRealWhile chkRelay(
      actual=dut.y,
      expected=if hi then Ymax else Ymin,
      active=abs(u.y - ThH) > (if Ts > 0 then 0.2 else 0.01) and abs(u.y - ThL) > (if Ts > 0 then 0.2 else 0.01),
      absTol=1e-9,
      tStart=0.01,
      dt=0.02)
    "y = Ymax after u reached ThH, Ymin after u reached ThL, the initial state before either (away from the thresholds by more than the input moves in one sample)"
    annotation (Placement(transformation(extent={{30,-10},{50,10}})));
  Boolean passed = chkRelay.passed
    "true if every enabled check of this configuration passed";
equation
  connect(u.y, dut.u) annotation (Line(points={{-29,0},{-8,0}}, color={0,0,127}));
  when u.y >= ThH then
    hi = true;
  elsewhen u.y <= ThL then
    hi = false;
  end when;
  annotation (
    experiment(StopTime=12, Interval=0.005, Tolerance=1e-6),
    Diagram(coordinateSystem(extent={{-60,-20},{60,20}}, grid={1,1})),
    Documentation(info="<html>
<p>Base of the MC/DC tests of <a href=\"modelica://IndustrialControlSystems.Controllers.Logic.RelayHysteresis\">IndustrialControlSystems.Controllers.Logic.RelayHysteresis</a>:
a sine of amplitude 1 and 0.2 Hz between the thresholds -0.3 and 0.3.
The expected output is stated independently by a state that switches on at ThH and off at ThL;
<code>chkRelay</code>: y = Ymax after u reached ThH, Ymin after u reached ThL, the initial state before either.</p>
</html>"));
end Base;
