within IndustrialControlSystems.Logical.Timers.Examples;
model testT_OffDelay
  "Test of the T_off-delay timer block"
  extends Modelica.Icons.Example;

  IndustrialControlSystems.Logical.Timers.Timer_OffDelay timer
    annotation (Placement(transformation(extent={{0,60},{20,80}})));
  Modelica.Blocks.Sources.Constant timerVALUE(k=10) annotation (
      Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={-30,30})));
  Modelica.Blocks.Sources.BooleanTable SetSignal(table={0.5,4,6.5})
    annotation (Placement(transformation(extent={{-100,78},{-80,98}})));
  Modelica.Blocks.Sources.BooleanTable ResetSignal(table={5,6.5})
    annotation (Placement(transformation(extent={{-100,46},{-80,66}})));
equation
  connect(timerVALUE.y, timer.PV)   annotation (Line(
      points={{-19,30},{6,30},{6,62}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(SetSignal.y, timer.S) annotation (Line(
      points={{-79,88},{-40,88},{-40,74},{2,74}},
      color={255,0,255},
      smooth=Smooth.None));
  connect(ResetSignal.y, timer.R) annotation (Line(
      points={{-79,56},{-40,56},{-40,66},{2,66}},
      color={255,0,255},
      smooth=Smooth.None));
  annotation (Diagram(graphics),
    experiment(StopTime=50),
    experimentSetupOutput,
    Documentation(info="
  <HTML>
  <h4>Description</h4>
  <p>
  This example demonstrates the basic operation of the <em>Timer_OffDelay</em> block. The timer
  is configured with a programmed value of 10 seconds. A Boolean table drives the Set signal
  with transitions at t = 0.5, 4, and 6.5 s, and another table drives the Reset signal at
  t = 5 and 6.5 s. The simulation runs for 50 s, allowing observation of the timer output Q
  activating after the configured off-delay has elapsed from the start of the Set condition
  and being cleared immediately by the Reset signal.
  </p>
  </HTML>", revisions="<html>
<dl><dt>First release of the Industrial Control Systems: April-May 2012</dt>
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
<dd><i>The IndustrialControlSystems package is <b>free</b> software; it can be redistributed and/or modified under the terms of the <b>Modelica license</b>, see the license conditions and the accompanying <b>disclaimer</b> in the documentation of package Modelica in file &quot;Modelica/package.mo&quot;.</i><br/></dd>
</dl></html>"));
end testT_OffDelay;
