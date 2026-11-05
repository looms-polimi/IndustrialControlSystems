within IndustrialControlSystems.LinearSystems.Discrete.Functions;
function fDerivator "Function derivator"
  input Real alpha "discretisation parameter";
  input Real u "Current input";
  input Real u_pre "Previous input";
  input Real y_pre "Previous output";
  input Real Ts "Sampling time [s]";
  input Real k "Gain";
  output Real y "Output";
algorithm
  y := (u - u_pre + (alpha-1)*Ts*y_pre)/(alpha*Ts);
  annotation (Documentation(info="
  <HTML>
  <h4>Description</h4>
  <p>
  Discrete-time function implementing a pure derivative (differentiator).
  The continuous-time transfer function is:
  <pre>
   Y(s)
   ----  = k * s
   U(s)
  </pre>
  The derivative is approximated using the generalised integration rule with
  parameter <code>alpha</code> (0 = Forward Euler, 1 = Backward Euler,
  0.5 = Tustin).  The recurrence equation is:
  <pre>
   y[n] = ( u[n] - u[n-1] + (alpha-1)*Ts*y[n-1] ) / (alpha*Ts)
  </pre>
  Note: the gain k is declared as an input but is not used in the algorithm;
  the gain must be applied externally if required.
  </p>
  <h4>Inputs</h4>
  <table border=\"1\" cellspacing=\"0\" cellpadding=\"2\">
    <tr><th>Name</th><th>Description</th></tr>
    <tr><td>alpha</td><td>Discretisation parameter (0=FE, 1=BE, 0.5=Tustin)</td></tr>
    <tr><td>u</td><td>Current input sample u[n]</td></tr>
    <tr><td>u_pre</td><td>Previous input sample u[n-1]</td></tr>
    <tr><td>y_pre</td><td>Previous output sample y[n-1]</td></tr>
    <tr><td>Ts</td><td>Sampling time [s]</td></tr>
    <tr><td>k</td><td>Gain (declared but not used in algorithm)</td></tr>
  </table>
  <h4>Output</h4>
  <table border=\"1\" cellspacing=\"0\" cellpadding=\"2\">
    <tr><th>Name</th><th>Description</th></tr>
    <tr><td>y</td><td>Current output sample y[n]</td></tr>
  </table>
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
end fDerivator;
