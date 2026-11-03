within IndustrialControlSystems.MathOperations.Examples;
model SetPointGeneration
  "various examples of set point generators and noise signal"
  extends Modelica.Icons.Example;

  RealType.Signals.SmoothStep smoothStep(
    alfa=0.3,
    yfin=3,
    m=0.2) annotation (Placement(transformation(extent={{-80,60},{-60,80}})));
  IndustrialControlSystems.MathOperations.RealType.Signals.SmoothTooth smoothTooth_alpha_01
    annotation (Placement(transformation(extent={{-40,60},{-20,80}})));
  RealType.Signals.SmoothStepSignal smoothStepSignal(
    alfa=0.3,
    yfin=3,
    m=0.2,
    delay=1.5)
           annotation (Placement(transformation(extent={{-40,20},{-20,40}})));
  Modelica.Blocks.Sources.BooleanStep startRise(startTime=15)
    annotation (Placement(transformation(extent={{-100,26},{-80,46}})));
  RealType.Signals.SmoothToothSignal smoothToothSignal
    annotation (Placement(transformation(extent={{0,-40},{20,-20}})));
  Modelica.Blocks.Sources.BooleanTable enRise(table={5,6})
    annotation (Placement(transformation(extent={{-40,-20},{-20,0}})));
  Modelica.Blocks.Sources.BooleanTable enFall(table={26,27})
    annotation (Placement(transformation(extent={{-40,-60},{-20,-40}})));
  Modelica.Blocks.Sources.Constant Ystart(k=0)
    annotation (Placement(transformation(extent={{-100,-58},{-80,-38}})));
  Modelica.Blocks.Sources.Constant Yend(k=1)
    annotation (Placement(transformation(extent={{-100,-20},{-80,0}})));
  RealType.Signals.noiseGen noiseGen
    annotation (Placement(transformation(extent={{0,60},{20,80}})));
  IndustrialControlSystems.MathOperations.RealType.Signals.SmoothTooth smoothTooth_alpha_04(alfa=0.4)
    annotation (Placement(transformation(extent={{40,60},{60,80}})));
equation
  connect(startRise.y, smoothStepSignal.ENup)   annotation (Line(
      points={{-79,36},{-38,36}},
      color={255,0,255},
      smooth=Smooth.None));
  connect(enRise.y, smoothToothSignal.ENup)       annotation (Line(
      points={{-19,-10},{-10,-10},{-10,-24},{2,-24}},
      color={255,0,255},
      smooth=Smooth.None));
  connect(enFall.y, smoothToothSignal.ENdown)       annotation (Line(
      points={{-19,-50},{-10,-50},{-10,-36},{2,-36}},
      color={255,0,255},
      smooth=Smooth.None));
  connect(Yend.y, smoothToothSignal.u[2]) annotation (Line(
      points={{-79,-10},{-60,-10},{-60,-29},{2,-29}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(Ystart.y, smoothToothSignal.u[1]) annotation (Line(
      points={{-79,-48},{-60,-48},{-60,-31},{2,-31}},
      color={0,0,127},
      smooth=Smooth.None));
  annotation (
    experiment(StopTime=50),
    experimentSetupOutput,
    Diagram(graphics),
    Documentation(info="
  <HTML>
  <h4>Description</h4>
  <p>
  This example model demonstrates the set-point signal generators and noise source available
  in <code>MathOperations.RealType.Signals</code>. The simulation runs for 50 seconds and
  exercises the following blocks in parallel:
  </p>
  <ul>
    <li>
      <b>smoothStep</b> — a free-running smooth step from the initial value to
      <code>yfin=3</code>, with slope parameter <code>m=0.2</code> and parabolic blending
      coefficient <code>alfa=0.3</code>.
    </li>
    <li>
      <b>smoothTooth_alpha_01</b> — a smooth tooth-wave signal with default parameters
      (<code>alfa=0.1</code>).
    </li>
    <li>
      <b>smoothTooth_alpha_04</b> — a smooth tooth-wave signal with increased blending
      (<code>alfa=0.4</code>), illustrating the effect of a larger alpha value.
    </li>
    <li>
      <b>smoothStepSignal</b> — a triggered smooth step that rises when the Boolean input
      <code>ENup</code> goes true (at t=15 s via a BooleanStep source), with a delay of
      1.5 s before the transition begins.
    </li>
    <li>
      <b>smoothToothSignal</b> — a triggered tooth signal that rises when <code>ENup</code>
      is asserted (BooleanTable: t=5 s and t=6 s) and falls when <code>ENdown</code> is
      asserted (BooleanTable: t=26 s and t=27 s). Start and end levels are supplied by
      Constant sources (<code>Ystart=0</code>, <code>Yend=1</code>).
    </li>
    <li>
      <b>noiseGen</b> — a noise signal generator producing a pseudo-random disturbance
      signal with default parameters.
    </li>
  </ul>
  </HTML>", revisions="<html>
<dl><dt>Industrial Control Systems (v 1.0.0) : April-May 2012</dt>
<dl><dt>List of revisions:</dt>
<p><ul>
<li>11 May 2012 (author: Marco Bonvini)</li>
</ul></p>
<dl><dt><b>Main Authors:</b> <br/></dt>
<dd>Marco Bonvini; &lt;<a href=\"mailto:bonvini@elet.polimi.it\">bonvini@elet.polimi.it</a>&gt;</dd>
<dd>Alberto Leva &lt;<a href=\"mailto:leva@elet.polimi.it\">leva@elet.polimi.it</a>&gt;<br/></dd>
<dd>Politecnico di Milano</dd>
<dd>Dipartimento di Elettronica e Informazione</dd>
<dd>Via Ponzio 34/5</dd>
<dd>20133 Milano - ITALIA -<br/></dd>
<dt><b>Copyright:</b> </dt>
<dd>Copyright &copy; 2010-2012, Marco Bonvini and Alberto Leva.<br/></dd>
<dd><i>The IndustrialControlSystems package is <b>free</b> software; it can be redistributed and/or modified under the terms of the <b>Modelica license</b>.</i><br/></dd>
</dl></html>"));
end SetPointGeneration;
