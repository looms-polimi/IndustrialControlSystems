within IndustrialControlSystems.LinearSystems.Discrete.Functions;
function f1p1z "Function lead lag process: k(1+sT1)/(1+sT2)"
  input Real alfa "Parametro di discretizzazione";
  input Real T1 "Zero";
  input Real T2 "Polo";
  input Real u "Current input";
  input Real u_pre "Previous input";
  input Real y_pre "Previous output";
  input Real Ts "Sampling time [s]";
  input Real k "Gain";
  output Real y "Output";
protected
  Real A "Weighted time step alfa*Ts";
  Real B "Weighted time step (1-alfa)*Ts";
  Real C "Numerator coefficient A + T1";
  Real D "Numerator coefficient B - T1";
  Real E "Denominator coefficient A + T2";
  Real F "Denominator coefficient B - T2";
algorithm
  A := alfa*Ts;
  B := Ts - alfa*Ts;
  C := A + T1;
  D := B - T1;
  E := A + T2;
  F := B - T2;
  y := (C*k*u + D*k*u_pre - F*y_pre)/E;
  annotation (Documentation(info="
  <HTML>
  <h4>Description</h4>
  <p>
  Discrete-time function implementing a lead-lag (one zero, one pole) transfer function
  with static gain k:
  <pre>
   Y(s)       1 + s*T1
   ----  = k ---------
   U(s)       1 + s*T2
  </pre>
  The continuous-time transfer function is discretised using the generalised
  integration rule with parameter <code>alfa</code> (0 = Forward Euler,
  1 = Backward Euler, 0.5 = Tustin).  Defining
  <pre>
   A = alfa*Ts,  B = (1-alfa)*Ts
  </pre>
  the resulting recurrence equation is:
  <pre>
   y[n] = ( k*(A+T1)*u[n] + k*(B-T1)*u[n-1] - (B-T2)*y[n-1] ) / (A+T2)
  </pre>
  </p>
  <h4>Inputs</h4>
  <table border=\"1\" cellspacing=\"0\" cellpadding=\"2\">
    <tr><th>Name</th><th>Description</th></tr>
    <tr><td>alfa</td><td>Discretisation parameter (0=FE, 1=BE, 0.5=Tustin)</td></tr>
    <tr><td>T1</td><td>Zero time constant [s]</td></tr>
    <tr><td>T2</td><td>Pole time constant [s]</td></tr>
    <tr><td>u</td><td>Current input sample u[n]</td></tr>
    <tr><td>u_pre</td><td>Previous input sample u[n-1]</td></tr>
    <tr><td>y_pre</td><td>Previous output sample y[n-1]</td></tr>
    <tr><td>Ts</td><td>Sampling time [s]</td></tr>
    <tr><td>k</td><td>Static gain</td></tr>
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
end f1p1z;
