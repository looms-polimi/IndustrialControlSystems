within IndustrialControlSystems.MathOperations.Examples;
function reScale
  "this function rescale the operation result (for Fuxed Point numbers)"
  extends RealType.Functions.GeneralReScalingFunction;
algorithm
  y := Y/scaleFactor;
  annotation (Documentation(info="
  <HTML>
  <h4>Description</h4>
  <p>
  This function applies a fixed-point rescaling correction to the raw output of a mathematical
  operation. It extends <code>RealType.Functions.GeneralReScalingFunction</code> and therefore
  has the following interface:
  </p>
  <ul>
    <li><b>u[:]</b> — real input vector (the original operands, passed through for context).</li>
    <li><b>Y</b> — the raw computed output value before rescaling.</li>
    <li><b>scaleFactor</b> — the scale factor used in the fixed-point representation.</li>
    <li><b>y</b> — the rescaled real output.</li>
  </ul>
  <p>
  <b>Algorithm:</b>
  </p>
  <pre>
    y := Y / scaleFactor;
  </pre>
  <p>
  Dividing by <code>scaleFactor</code> converts a fixed-point integer result back to the
  corresponding real-world value. This function is used as a plug-in for the
  <code>Expression</code> block when <code>FixedPoint=true</code>.
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
end reScale;
