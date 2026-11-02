within IndustrialControlSystems.Logical.Timers.Functions;
function positiveEdge
  "The positive Edge Detection function detects a change from 0 to 1"
  input Boolean S_old;
  input Boolean S;
  input Boolean R;
  input Real s_time;
  input Real t;
  output Real st_time;
algorithm
  st_time := if (S_old==false and S==true and R==false) then t else 0.0;
  st_time := max(s_time,st_time);
    annotation (Documentation(info="
  <HTML>
  <h4>Description</h4>
  <p>
  This function detects a rising edge (0-to-1 transition) of the Set signal <em>S</em> and
  records the simulation time at which the edge occurred. Given the previous and current values
  of <em>S</em>, the Reset signal <em>R</em>, the previously recorded start time <em>s_time</em>,
  and the current time <em>t</em>, it returns:
  </p>
  <ul>
  <li><em>st_time</em> &mdash; set to <em>t</em> when a rising edge is detected and Reset is not
  active; otherwise 0.0. A max operation with <em>s_time</em> ensures the recorded start time is
  never decreased.</li>
  </ul>
  <p>
  Unlike <em>risingEdge</em>, this function does not maintain a Run flag; it is used to capture
  only the timestamp of the positive transition.
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
end positiveEdge;
