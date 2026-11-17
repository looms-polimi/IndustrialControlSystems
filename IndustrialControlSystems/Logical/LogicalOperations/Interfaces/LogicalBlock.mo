within IndustrialControlSystems.Logical.LogicalOperations.Interfaces;
partial model LogicalBlock
  "Partial interface of a generic nInput nOutput logical block"
  parameter Real Ts = 0.1 "sampling time";
  parameter Integer nInput = 1 "number of inputs";
  parameter Integer nOutput = 1 "number of outputs";
  Modelica.Blocks.Interfaces.BooleanInput u[nInput] "input vector"
    annotation (Placement(transformation(extent={{-100,-20},{-60,20}},
          rotation=0)));
  Modelica.Blocks.Interfaces.BooleanOutput y[nOutput] "output vector"
    annotation (Placement(transformation(extent={{80,-10},{100,10}},
          rotation=0)));
  annotation (Diagram(graphics),
                       Icon(graphics={Rectangle(
          extent={{-100,100},{100,-100}},
          lineColor={0,0,0},
          fillColor={255,170,255},
          fillPattern=FillPattern.Solid), Text(
          extent={{-56,14},{76,-14}},
          lineColor={0,0,0},
          textString="%nInput x %nOutput ")}),
    Documentation(info="
  <HTML>
  <h4>Description</h4>
  <p>
  This partial model defines the common interface for generic n-input m-output Boolean blocks.
  It declares a Boolean input vector <em>u</em> of length <em>nInput</em>, a Boolean output
  vector <em>y</em> of length <em>nOutput</em>, and a sampling time parameter <em>Ts</em>.
  When <em>Ts</em> is set to zero the block operates in continuous time; a positive value
  introduces a sampling delay equal to one period. Concrete logical blocks (AND, OR, NOT, XOR)
  extend this interface and implement their operation in a when-clause sampled at rate
  <em>1/Ts</em>.
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
end LogicalBlock;
