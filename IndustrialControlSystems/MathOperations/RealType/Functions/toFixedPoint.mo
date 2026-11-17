within IndustrialControlSystems.MathOperations.RealType.Functions;
function toFixedPoint
  "Converts a real value to a saturated fixed-point integer"
  input Real u;
  input Real scaleFactor;
  input Integer MAX;
  input Integer MIN;
  output Integer y;
algorithm
  if u >= 0 then
    y := integer(floor(max(MIN, min(MAX, u*scaleFactor)) + 0.5));
  else
    y := integer(floor(max(MIN, min(MAX, u*scaleFactor)) - 0.5));
  end if;
  annotation (Documentation(info="
  <HTML>
  <h4>Description</h4>
  <p>
  This function converts a real-valued signal to a saturated fixed-point integer
  representation. It is used internally by the real-type arithmetic operation blocks
  when fixed-point mode is enabled (<code>FixedPoint=true</code>).
  </p>
  <p>
  <b>Inputs:</b>
  </p>
  <ul>
    <li><b>u</b> — the real input value to be converted.</li>
    <li><b>scaleFactor</b> — the fixed-point scale factor. The real value is multiplied
        by this factor before rounding to an integer.</li>
    <li><b>MAX</b> — upper saturation limit (maximum representable integer value).</li>
    <li><b>MIN</b> — lower saturation limit (minimum representable integer value).</li>
  </ul>
  <p>
  <b>Output:</b>
  </p>
  <ul>
    <li><b>y</b> — the resulting fixed-point integer, clamped to [MIN, MAX].</li>
  </ul>
  <p>
  <b>Algorithm:</b> the real value is multiplied by <code>scaleFactor</code>, clamped to the
  interval [MIN, MAX], and then rounded to the nearest integer using <code>floor(...+0.5)</code>
  for non-negative values and <code>floor(...-0.5)</code> for negative values (round
  half-away-from-zero).
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
end toFixedPoint;
