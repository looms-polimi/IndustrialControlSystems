within IndustrialControlSystems.Logical.Timers.Examples;
model testT_On
  "Test of the T_on-delay timer block"
  extends Modelica.Icons.Example;

  IndustrialControlSystems.Logical.Timers.Timer_On timer
    annotation (Placement(transformation(extent={{0,60},{20,80}})));
  Modelica.Blocks.Sources.BooleanTable SetSignal(table={0.5,4,6.5})
    annotation (Placement(transformation(extent={{-98,72},{-78,92}})));
  Modelica.Blocks.Sources.BooleanTable ResetSignal(table={5,6.5})
    annotation (Placement(transformation(extent={{-100,40},{-80,60}})));
  Modelica.Blocks.Sources.Constant timerVALUE(k=30) annotation (
      Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={-30,30})));
equation
  connect(SetSignal.y, timer.S)   annotation (Line(
      points={{-77,82},{-60,82},{-60,74},{2,74}},
      color={255,0,255},
      smooth=Smooth.None));
  connect(ResetSignal.y, timer.R)
                               annotation (Line(
      points={{-79,50},{-60,50},{-60,66},{2,66}},
      color={255,0,255},
      smooth=Smooth.None));
  connect(timerVALUE.y, timer.PV)   annotation (Line(
      points={{-19,30},{-8,30},{-8,54},{6,54},{6,62}},
      color={0,0,127},
      smooth=Smooth.None));
  annotation (Diagram(graphics),
    experiment(StopTime=50),
    experimentSetupOutput,
    Documentation(info="
  <HTML>
  <h4>Description</h4>
  <p>
  This example demonstrates the basic operation of the <em>Timer_On</em> block. The timer is
  configured with a programmed value of 30 s. A Boolean table drives the Set signal with
  transitions at t = 0.5, 4, and 6.5 s, and another table drives the Reset signal at t = 5
  and 6.5 s. The simulation runs for 50 s. The example shows that the timer output Q is active
  while the Set signal is high and the elapsed time has not yet exceeded the programmed value,
  and is immediately cleared by the Reset signal regardless of the elapsed time.
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
end testT_On;
