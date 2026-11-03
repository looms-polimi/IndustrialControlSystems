within IndustrialControlSystems.MathOperations.IntegerType.Interfaces;
partial model IntNinOperation
  "Partial interface of a generic n-input integer math operation"
  parameter Real Ts = 0.1 "sampling time" annotation(Evaluate=true);
  parameter Integer nInput = 1 "number of inputs" annotation(Evaluate=true);
  Modelica.Blocks.Interfaces.IntegerInput u[nInput] "input vector"
    annotation (Placement(transformation(extent={{-100,-20},{-60,20}},
          rotation=0), iconTransformation(extent={{-100,-20},{-60,20}})));
  Modelica.Blocks.Interfaces.IntegerOutput y "output"
    annotation (Placement(transformation(extent={{80,-10},{100,10}},
          rotation=0), iconTransformation(extent={{80,-10},{100,10}})));
  annotation (Diagram(graphics),
                       Icon(graphics={Rectangle(
          extent={{-100,100},{100,-100}},
          lineColor={0,0,0},
          fillColor={255,170,85},
          fillPattern=FillPattern.Solid)}),
    Documentation(info="
  <HTML>
  <h4>Description</h4>
  <p>
  This partial model defines the interface for a generic integer mathematical operation block
  that accepts a configurable number of integer inputs and produces a single integer output.
  It serves as the base class for all N-input integer operation blocks in the library.
  </p>
  <p>
  <b>Parameters:</b>
  </p>
  <ul>
    <li><b>Ts</b> — sampling time [s] (default 0.1). Governs how frequently the output is
        updated in discrete-time implementations.</li>
    <li><b>nInput</b> — number of integer input signals (default 1). Sets the size of the
        input port vector.</li>
  </ul>
  <p>
  <b>Ports:</b>
  </p>
  <ul>
    <li><b>u[nInput]</b> — vector of integer input signals.</li>
    <li><b>y</b> — single integer output signal.</li>
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
end IntNinOperation;
