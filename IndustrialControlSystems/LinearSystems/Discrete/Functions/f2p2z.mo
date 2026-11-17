within IndustrialControlSystems.LinearSystems.Discrete.Functions;
function f2p2z
  "Function of a process with oneintegrator, one pole and two zeroes: k(1+sT1)(1+sT2)/(1+sT3)s"
  input Real alpha "Parametro di discretizzazione";
  input Real T1 "Zero";
  input Real T2 "Zero";
  input Real T3 "Polo";
  input Real u "Current input";
  input Real u_pre1 "Previous input";
  input Real u_pre2 "two steps ago input";
  input Real y_pre1 "Previous output";
  input Real y_pre2 "two steps ago output";
  input Real Ts "Sampling time [s]";
  input Real mu "Gain";
  output Real y "Output";
algorithm
  y := 1/(alpha*Ts + T3)*(
          + T3*y_pre1
          - (-T3-alpha*Ts+Ts)*y_pre1
          + alpha*Ts*y_pre1
          - (T3+alpha*Ts-Ts)*y_pre2
          + mu*T1*T2*u
          + alpha^2*mu*Ts^2*u
          + alpha*mu*Ts*T2*u
          + alpha*mu*Ts*T1*u
          + mu*(-T1-alpha*Ts+Ts)*T2*u_pre1
          + mu*T1*(-T2-alpha*Ts+Ts)*u_pre1
          + alpha*mu*Ts*(-T2-alpha*Ts+Ts)*u_pre1
          + alpha*mu*Ts*(-T1-alpha*Ts+Ts)*u_pre1
          + mu*(-T1-alpha*Ts+Ts)*(-T2-alpha*Ts+Ts)*u_pre2);

  annotation (Documentation(info="
  <HTML>
  <h4>Description</h4>
  <p>
  Discrete-time function implementing a transfer function with one integrator,
  one real pole (time constant T3) and two real zeros (time constants T1 and T2),
  with gain mu:
  <pre>
   Y(s)     (1+s*T1)*(1+s*T2)
   ----  = mu -----------------
   U(s)       s*(1+s*T3)
  </pre>
  The continuous-time transfer function is discretised using the generalised
  integration rule with parameter <code>alpha</code> (0 = Forward Euler,
  1 = Backward Euler, 0.5 = Tustin).  The function requires two past input
  samples (u_pre1, u_pre2) and two past output samples (y_pre1, y_pre2),
  giving the third-order recurrence equation computed in the algorithm section.
  </p>
  <h4>Inputs</h4>
  <table border=\"1\" cellspacing=\"0\" cellpadding=\"2\">
    <tr><th>Name</th><th>Description</th></tr>
    <tr><td>alpha</td><td>Discretisation parameter (0=FE, 1=BE, 0.5=Tustin)</td></tr>
    <tr><td>T1</td><td>First zero time constant [s]</td></tr>
    <tr><td>T2</td><td>Second zero time constant [s]</td></tr>
    <tr><td>T3</td><td>Pole time constant [s]</td></tr>
    <tr><td>u</td><td>Current input sample u[n]</td></tr>
    <tr><td>u_pre1</td><td>Previous input sample u[n-1]</td></tr>
    <tr><td>u_pre2</td><td>Input sample two steps ago u[n-2]</td></tr>
    <tr><td>y_pre1</td><td>Previous output sample y[n-1]</td></tr>
    <tr><td>y_pre2</td><td>Output sample two steps ago y[n-2]</td></tr>
    <tr><td>Ts</td><td>Sampling time [s]</td></tr>
    <tr><td>mu</td><td>Static gain</td></tr>
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
end f2p2z;
