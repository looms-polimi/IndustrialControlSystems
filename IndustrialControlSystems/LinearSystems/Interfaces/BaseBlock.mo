within IndustrialControlSystems.LinearSystems.Interfaces;
partial model BaseBlock "Partial continuous time block interfaces"

  Modelica.Blocks.Interfaces.RealInput u "input"
    annotation (Placement(transformation(extent={{-100,-20},{-60,20}},
          rotation=0)));
  Modelica.Blocks.Interfaces.RealOutput y "output"
    annotation (Placement(transformation(extent={{80,-10},{100,10}},
          rotation=0)));
  annotation (Diagram(graphics),
                       Icon(graphics={Rectangle(
          extent={{-100,100},{100,-100}},
          lineColor={0,0,0},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid), Text(
          extent={{-100,-106},{100,-132}},
          lineColor={0,0,0},
          fillColor={85,85,255},
          fillPattern=FillPattern.Solid,
          textString=
               "%name")}),Documentation(info="
  <HTML>
  <h4>Description</h4>
  <p>
  Partial base interface for continuous-time linear system blocks.
  All concrete blocks in the <code>LinearSystems.Continuous</code> package
  extend this partial model to obtain a consistent connector layout and
  icon style.
  </p>
  <p>
  The interface declares one scalar Real input and one scalar Real output,
  making every derived block a single-input single-output (SISO) element:
  </p>
  <table border=\"1\" cellspacing=\"0\" cellpadding=\"2\">
    <tr><th>Connector</th><th>Type</th><th>Description</th></tr>
    <tr><td>u</td><td>RealInput</td><td>Input signal</td></tr>
    <tr><td>y</td><td>RealOutput</td><td>Output signal</td></tr>
  </table>
  <p>
  The icon displays a white rectangle with the instance name shown below.
  Derived blocks add their own graphical elements (text labels, lines) on
  top of this base icon to indicate the transfer function implemented.
  </p>
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
end BaseBlock;
