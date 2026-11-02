within IndustrialControlSystems.LinearSystems.Discrete;
model MultiStepsDelay "Multistep time delay"
  extends LinearSystems.Interfaces.DiscreteBaseBlock;
  parameter Integer N = 1 "Fixed multi-step dalay";
  parameter Real y_start = 0 "Initial output value";
protected
  discrete Real buffer[N](each start = y_start);
algorithm
  assert(N>1,"The number of N steps delay must be positive");

  when sample(0,Ts) then

    for i in 2:N loop
      buffer[i] := pre(buffer[i-1]);
    end for;

    buffer[1] := u;

    y := buffer[N];

  end when;
  annotation (Icon(graphics={Text(
          extent={{-48,48},{30,-24}},
          lineColor={0,0,0},
          textString="e"), Text(
          extent={{4,50},{44,22}},
          lineColor={0,0,0},
          textString="-sNTs")}),  Documentation(info="
  <HTML>
  <h4>Description</h4>
  <p>
  Discrete-time multi-step delay block.  The block introduces a delay of
  exactly N sampling periods by passing the input signal through a shift
  register of length N.  In the z-domain:
  <pre>
   Y(z) = z^(-N) * U(z)
  </pre>
  which corresponds to a continuous-domain delay of:
  <pre>
   Y(s) = e^(-s*N*Ts) * U(s)
  </pre>
  The implementation maintains an internal buffer array of size N.  At each
  sampling instant the buffer is shifted and the oldest value is presented
  at the output.  N must be strictly greater than 1; for a single-step delay
  use the <code>Delay</code> block instead.  All buffer elements are
  initialised to <code>y_start</code>.
  </p>
  <h4>Parameters</h4>
  <table border=\"1\" cellspacing=\"0\" cellpadding=\"2\">
    <tr><th>Name</th><th>Default</th><th>Description</th></tr>
    <tr><td>Ts</td><td>(from DiscreteBaseBlock)</td><td>Sampling time [s]</td></tr>
    <tr><td>N</td><td>1</td><td>Number of delay steps (must be &gt; 1)</td></tr>
    <tr><td>y_start</td><td>0</td><td>Initial value for all buffer elements and output</td></tr>
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
end MultiStepsDelay;
