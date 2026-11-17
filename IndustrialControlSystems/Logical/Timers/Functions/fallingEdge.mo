within IndustrialControlSystems.Logical.Timers.Functions;
function fallingEdge
  "logical function that senses a falling edge of set signal"
  input Boolean S_old;
  input Boolean S;
  input Boolean R;
  input Real s_time;
  input Real t;
  input Boolean Run_old;
  output Real st_time;
  output Boolean Run;
algorithm
  Run     := if ((S_old==true and S==false and R==false) or (Run_old==true and R==false)) then true else false;
  st_time := if (S_old==true and S==false and R==false) then t else 0.0;
  st_time := max(s_time,st_time);
    annotation (Documentation(info="
  <HTML>
  <h4>Description</h4>
  <p>
  This function detects a falling edge (1-to-0 transition) of the Set signal <em>S</em> and
  uses it to start a timer. It takes the previous and current values of <em>S</em>, the Reset
  signal <em>R</em>, the previously recorded start time <em>s_time</em>, the current simulation
  time <em>t</em>, and the previous Run flag <em>Run_old</em>. It returns:
  </p>
  <ul>
  <li><em>Run</em> &mdash; true if a falling edge was just detected or if <em>Run_old</em> was
  true and Reset has not been asserted; false otherwise.</li>
  <li><em>st_time</em> &mdash; the start time of the current timing interval, recorded at the
  moment the falling edge is detected and preserved thereafter via a max operation.</li>
  </ul>
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
end fallingEdge;
