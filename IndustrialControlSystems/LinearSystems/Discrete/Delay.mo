within IndustrialControlSystems.LinearSystems.Discrete;
model Delay "Unitary time delay"
  extends LinearSystems.Interfaces.DiscreteBaseBlock;
  parameter Real y_start = 0 "Output initial value"
    annotation(Dialog(group = "Initial conditions"));
protected
  discrete Real u_s "Input at the last sampling instant";
initial equation
  y = y_start;
  pre(u_s) = y_start;
equation
  when sample(0,Ts) then
    y = pre(u_s);
    u_s = u;
  end when;

  annotation (Icon(graphics={Text(
          extent={{-48,48},{30,-24}},
          lineColor={0,0,0},
          textString="e"), Text(
          extent={{4,50},{44,22}},
          lineColor={0,0,0},
          textString="-sTs")}),  Documentation(info="
  <HTML>
  <h4>Description</h4>
  <p>
  Discrete-time single-step delay block.  At each sampling instant the block
  outputs the value of its input from the previous sampling period, i.e. it
  introduces a delay of exactly one sampling time Ts.  In the z-domain:
  <pre>
   Y(z) = z^(-1) * U(z)
  </pre>
  which corresponds to a continuous-domain delay of:
  <pre>
   Y(s) = e^(-s*Ts) * U(s)
  </pre>
  At each instant of <code>sample(0, Ts)</code> the block stores the input in a
  discrete variable and outputs the value stored at the previous instant, so the
  delay is one sampling period whether the input is continuous-time or already
  sampled.  The output is <code>y_start</code> during the first sampling period.
  </p>
  <h4>Parameters</h4>
  <table border=\"1\" cellspacing=\"0\" cellpadding=\"2\">
    <tr><th>Name</th><th>Default</th><th>Description</th></tr>
    <tr><td>Ts</td><td>(from DiscreteBaseBlock)</td><td>Sampling time [s]</td></tr>
    <tr><td>y_start</td><td>0</td><td>Initial value of the output y</td></tr>
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
end Delay;
