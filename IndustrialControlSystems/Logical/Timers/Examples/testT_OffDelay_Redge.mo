within IndustrialControlSystems.Logical.Timers.Examples;
model testT_OffDelay_Redge
  "Test of the T_off-delay timer triggered on a rising edge"
  extends Modelica.Icons.Example;

  IndustrialControlSystems.Logical.Timers.Timer_OffDelay_Redge timer
    annotation (Placement(transformation(extent={{0,60},{20,80}})));
  Modelica.Blocks.Sources.BooleanTable SetSignal(table={0.5,0.6,17,17.1})
    annotation (Placement(transformation(extent={{-100,80},{-80,100}})));
  Modelica.Blocks.Sources.BooleanTable ResetSignal(table={5,5.1,30,30.1})
    annotation (Placement(transformation(extent={{-100,40},{-80,60}})));
  Modelica.Blocks.Sources.Constant timerVALUE(k=10) annotation (
      Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={-30,30})));
equation
  connect(SetSignal.y, timer.S)   annotation (Line(
      points={{-79,90},{-60,90},{-60,74},{2,74}},
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
  This example demonstrates the <em>Timer_OffDelay_Redge</em> block, which starts its delay on a
  rising edge (0-to-1 transition) of the Set signal. The programmed value is set to 10 s.
  Set signal transitions occur at t = 0.5, 0.6, 17, and 17.1 s; Reset signal transitions at
  t = 5, 5.1, 30, and 30.1 s. The simulation runs for 50 s. The example illustrates that the
  timer output Q activates after the programmed delay following each rising edge of the Set
  signal and is cleared immediately by the Reset signal.
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
end testT_OffDelay_Redge;
