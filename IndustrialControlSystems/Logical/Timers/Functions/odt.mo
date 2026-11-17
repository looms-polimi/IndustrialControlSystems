within IndustrialControlSystems.Logical.Timers.Functions;
function odt "This logical function represents the Off-Delay timer behaviour."
  input Boolean S;
  input Boolean R;
  input Real durata;
  input Real t;
  input Real inizio;
  output Boolean run;
  output Boolean Q;
algorithm
  if (S==true and R==false and t >= inizio + durata) then
    Q := true;
  else
    Q := false;
  end if;
  run := Q;
    annotation (Documentation(info="
  <HTML>
  <h4>Description</h4>
  <p>
  This function computes the Boolean output of an off-delay timer. Given the Set signal <em>S</em>,
  the Reset signal <em>R</em>, the programmed delay duration <em>durata</em>, the current
  simulation time <em>t</em>, and the timer start time <em>inizio</em>, the outputs are:
  </p>
  <ul>
  <li><em>Q</em> &mdash; true when <em>S</em> is active, Reset is not asserted, and the elapsed
  time since <em>inizio</em> has reached or exceeded <em>durata</em>
  (<em>t</em> &ge; <em>inizio</em> + <em>durata</em>); false otherwise.</li>
  <li><em>run</em> &mdash; assigned the same value as <em>Q</em>.</li>
  </ul>
  <p>
  This function is used by Timer_OffDelay blocks that activate their output after a configurable
  delay from the start of the Set signal.
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
end odt;
