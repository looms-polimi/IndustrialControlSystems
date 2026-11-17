within IndustrialControlSystems.Logical.Timers.Functions;
function odts
  "This function represents the Off-Delay timer (active on a rising edge) behaviour."
  input Boolean R;
  input Real durata;
  input Real t;
  input Real inizio;
  input Boolean run;
  output Boolean Q;
algorithm
  if (R==false and t >= inizio + durata and run==true) then
    Q := true;
  else
    Q := false;
  end if;
    annotation (Documentation(info="
  <HTML>
  <h4>Description</h4>
  <p>
  This function computes the Boolean output of an off-delay timer variant used by edge-triggered
  timer blocks. Given the Reset signal <em>R</em>, the programmed duration <em>durata</em>, the
  current simulation time <em>t</em>, the timer start time <em>inizio</em>, and the Run flag
  <em>run</em>, the output <em>Q</em> is set to true when all of the following hold:
  </p>
  <ul>
  <li>Reset is not asserted (<em>R</em>=false).</li>
  <li>The elapsed time since <em>inizio</em> has reached or exceeded <em>durata</em>
  (<em>t</em> &ge; <em>inizio</em> + <em>durata</em>).</li>
  <li>The Run flag is active (<em>run</em>=true), indicating an edge was previously detected.</li>
  </ul>
  <p>
  Otherwise <em>Q</em> is false.
  </p>
  </HTML>", revisions="<html>
<dl><dt>First release of the Industrial Control Systems: April-May 2012</dt>
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
<dd><i>The IndustrialControlSystems package is <b>free</b> software; it can be redistributed and/or modified under the terms of the <b>Modelica license</b>, see the license conditions and the accompanying <b>disclaimer</b> in the documentation of package Modelica in file &quot;Modelica/package.mo&quot;.</i><br/></dd>
</dl></html>"));
end odts;
