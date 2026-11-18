within Tests.LinearSystems.MCDC.DiscreteTransferFunction;
model Base "MC/DC base: IndustrialControlSystems.LinearSystems.Discrete.TransferFunction, strictly proper first order, no initialisation"
  extends Modelica.Icons.Example;
  parameter Real Ts = 0.01 "Sampling time";
  parameter IndustrialControlSystems.LinearSystems.Discrete.Types.discrMethod method=
    IndustrialControlSystems.LinearSystems.Discrete.Types.discrMethod.BE "Discretisation method"
    annotation(Evaluate=true);
  parameter Real num[:] = {1} "Numerator" annotation(Evaluate=true);
  parameter Real den[:] = {2, 1} "Denominator" annotation(Evaluate=true);
  parameter Boolean initOutput = false annotation(Evaluate=true);
  parameter Boolean initSteadyState = false annotation(Evaluate=true);
  parameter Boolean initSteadyOutput = false annotation(Evaluate=true);
  parameter Real y_start = 0.5 "Initial output with initOutput";
  final parameter Real y0 = if initOutput then y_start elseif initSteadyState or initSteadyOutput then num[end]/den[end] else (if size(num, 1) == size(den, 1) then num[1]/den[1] else 0)
    "Expected output at t = 0 (u = 1)";
  Modelica.Blocks.Sources.TimeTable u(table=[0,1; 5.02,1; 5.02,2; 10,2]) "Input: 1, step to 2 at 5.02 s"
    annotation (Placement(transformation(extent={{-50,-10},{-30,10}})));
  IndustrialControlSystems.LinearSystems.Discrete.TransferFunction dut(Ts=Ts, method=method, num=num, den=den, initOutput=initOutput,
    initSteadyState=initSteadyState, initSteadyOutput=initSteadyOutput, y_start=y_start) "Transfer function under test"
    annotation (Placement(transformation(extent={{-10,-10},{10,10}})));
  Modelica.Blocks.Sources.TimeTable uRef(table=[0,1; 5.02,1; 5.02,2; 10,2]) "Input of the reference"
    annotation (Placement(transformation(extent={{-50,-40},{-30,-20}})));
  Modelica.Blocks.Continuous.TransferFunction ref(b=num, a=den,
    initType=if initOutput then Modelica.Blocks.Types.Init.InitialOutput elseif initSteadyState or initSteadyOutput then
      Modelica.Blocks.Types.Init.SteadyState else Modelica.Blocks.Types.Init.InitialState, y_start=y_start)
    "Continuous reference with the same initialisation"
    annotation (Placement(transformation(extent={{-10,-40},{10,-20}})));
  Tests.Utilities.CheckRealWhile chkY(
      actual=dut.y,
      expected=ref.y,
      active=time > 0.05 and abs(time - 5.02) > 0.1,
      absTol=0.02,
      relTol=0.02,
      tStart=0.01,
      dt=0.05)
    "y = the Modelica.Blocks.Continuous.TransferFunction with the corresponding initialisation (sampled: within 0.02 + 2 %, away from t = 0 and the input step)"
    annotation (Placement(transformation(extent={{30,-10},{50,10}})));
  Tests.Utilities.CheckRealWhile chkStart(
      actual=dut.y,
      expected=y0,
      active=time < 0.0015,
      absTol=0.02,
      tStart=0,
      dt=0.001)
    "start value: 0 without initialisation (state 0), y_start = 0.5 with initOutput, 1 (= steady state for u = 1) with initSteadyState or initSteadyOutput; biproper without initialisation: 1.5"
    annotation (Placement(transformation(extent={{60,-10},{80,10}})));
  Boolean passed = chkY.passed and chkStart.passed
    "true if every enabled check of this configuration passed";
equation
  connect(u.y, dut.u) annotation (Line(points={{-29,0},{-8,0}}, color={0,0,127}));
  connect(uRef.y, ref.u) annotation (Line(points={{-29,-30},{-12,-30}}, color={0,0,127}));
  annotation (
    experiment(StopTime=10, Interval=0.005, Tolerance=1e-8),
    Diagram(coordinateSystem(extent={{-60,-50},{90,20}}, grid={1,1})),
    Documentation(info="<html>
<p>Base of the MC/DC tests of <a href=\"modelica://IndustrialControlSystems.LinearSystems.Discrete.TransferFunction\">LinearSystems.Discrete.TransferFunction</a> on the first-order system 1/(2s + 1) (one state, so each initialisation flag fixes the start completely), input 1 stepping to 2 at t = 5.02 s, against <code>Modelica.Blocks.Continuous.TransferFunction</code> (the sampled block with Ts = 0.01 within the discretisation error).</p>
<p>Checks (each enabled only where it applies; <code>passed</code> is their conjunction):</p>
<ul><li><code>chkY</code>: y = the Modelica.Blocks.Continuous.TransferFunction with the corresponding initialisation (sampled: within 0.02 + 2 %, away from t = 0 and the input step)</li><li><code>chkStart</code>: start value: 0 without initialisation (state 0), y_start = 0.5 with initOutput, 1 (= steady state for u = 1) with initSteadyState or initSteadyOutput; biproper without initialisation: 1.5</li></ul>
</html>"));
end Base;
