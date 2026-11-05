within IndustrialControlSystems.Logical.Comparisons.RealType.Interfaces;
partial model RealComparison "Partial interface for Real comparisons"
  parameter Real Ts = 0.1 "sampling time";
  parameter Real eps = Modelica.Constants.eps*100
    "tolerance for the comparison";
  Modelica.Blocks.Interfaces.RealInput u1 "input"
    annotation (Placement(transformation(extent={{-100,30},{-60,70}},
          rotation=0), iconTransformation(extent={{-100,30},{-60,70}})));

  Modelica.Blocks.Interfaces.RealInput u2 "input"
    annotation (Placement(transformation(extent={{-100,-70},{-60,-30}},
          rotation=0), iconTransformation(extent={{-100,-70},{-60,-30}})));
  Modelica.Blocks.Interfaces.BooleanOutput y "output"
    annotation (Placement(transformation(extent={{80,-10},{100,10}},
          rotation=0), iconTransformation(extent={{80,-10},{100,10}})));
  annotation (Diagram(graphics),
                       Icon(graphics={Rectangle(
          extent={{-100,100},{100,-100}},
          lineColor={0,0,0},
          fillColor={170,213,255},
          fillPattern=FillPattern.Solid)}),
    Documentation(info="
  <HTML>
  <h4>Description</h4>
  <p>
  This partial model defines the common interface for all real-valued comparison blocks. It
  declares two real inputs <em>u1</em> and <em>u2</em>, a Boolean output <em>y</em>, a sampling
  time parameter <em>Ts</em>, and a numerical tolerance parameter <em>eps</em> (defaulting to
  100 times the machine epsilon). Concrete comparison models (==, !=, &gt;, &lt;, &gt;=, &lt;=)
  extend this interface and implement their comparison logic using <em>eps</em> to handle the
  limited precision of floating-point arithmetic, particularly for equality and inequality tests.
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
end RealComparison;
