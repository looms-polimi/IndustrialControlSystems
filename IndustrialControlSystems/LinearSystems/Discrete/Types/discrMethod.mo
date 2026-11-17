within IndustrialControlSystems.LinearSystems.Discrete.Types;
type discrMethod = enumeration(
    FE,
    BE,
    TU)
  "Definition of the suitable discretisation methods: Forward Euler, Backward and Tustin"
  annotation (Documentation(info="
  <HTML>
  <h4>Description</h4>
  <p>
  Enumeration type defining the numerical discretisation method used when
  converting a continuous-time transfer function into a discrete-time
  recurrence equation.  The three supported methods correspond to different
  values of the generalised integration parameter <code>alfa</code>:
  </p>
  <table border=\"1\" cellspacing=\"0\" cellpadding=\"2\">
    <tr><th>Enumerator</th><th>Method</th><th>alfa value</th></tr>
    <tr><td>FE</td><td>Forward Euler (explicit)</td><td>0</td></tr>
    <tr><td>BE</td><td>Backward Euler (implicit)</td><td>1</td></tr>
    <tr><td>TU</td><td>Tustin / bilinear (trapezoidal)</td><td>0.5</td></tr>
  </table>
  <p>
  Forward Euler is conditionally stable and requires a sufficiently small
  sampling time.  Backward Euler is unconditionally stable.  Tustin provides
  the best frequency-domain match between the continuous and discrete
  transfer functions and is the recommended choice for most applications.
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
