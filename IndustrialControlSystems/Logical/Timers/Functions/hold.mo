within IndustrialControlSystems.Logical.Timers.Functions;
function hold
  "this function keeps high the set value after a rising edge, until an high value of the reset signal"
  input Boolean S_old;
  input Boolean S;
  input Boolean R;
  input Boolean S_hold;
  output Boolean Y;
algorithm
  if (S_old==false and S==true and R==false) then
    Y := true;
  elseif (S_old==true and S==false and R==false) then
    Y := true;
  elseif (S==true and R==false) then
    Y := true;
  elseif (S_hold==true and R==false) then
    Y := true;
  else
    Y := false;
  end if;
    annotation (Documentation(info="
  <HTML>
  <h4>Description</h4>
  <p>
  This function implements a signal-hold logic used by timer blocks to sustain the Set condition
  across clock steps. Given the previous Set value <em>S_old</em>, the current Set value
  <em>S</em>, the Reset signal <em>R</em>, and the previous hold output <em>S_hold</em>, the
  function returns the output <em>Y</em> which is true in any of the following conditions:
  </p>
  <ul>
  <li>A rising edge of <em>S</em> is detected (<em>S_old</em>=false, <em>S</em>=true) and Reset
  is not active.</li>
  <li>A falling edge of <em>S</em> is detected (<em>S_old</em>=true, <em>S</em>=false) and
  Reset is not active.</li>
  <li><em>S</em> is currently high and Reset is not active.</li>
  <li>The previous hold output <em>S_hold</em> was true and Reset is not active.</li>
  </ul>
  <p>
  The output <em>Y</em> is false only when Reset is asserted, which clears the held state.
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
end hold;
