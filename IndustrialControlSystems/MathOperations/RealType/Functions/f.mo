within IndustrialControlSystems.MathOperations.RealType.Functions;
function f
  "Smooth step transition between two values, controlled by up/down signals"
  input Boolean up;
  input Boolean down;
  input Real t;
  input Real ts;
  input Real td;
  input Real alfa;
  input Real m;
  input Real yin;
  input Real yfin;
  output Real x;
algorithm
  if
    (up == true and down==false) then
    x := fSmoothStep(t,ts,alfa,m,yin,yfin);
  elseif
        (up==true) then
    x := fSmoothStep(t,td,alfa,m,yfin,yin);
  else
    x := yin;
  end if;
  annotation (Documentation(info="
  <HTML>
  <h4>Description</h4>
  <p>
  This function implements a smooth step transition between two real values, controlled by
  Boolean rise and fall signals. It is the core logic used by the triggered smooth-step
  signal generators in <code>RealType.Signals</code>.
  </p>
  <p>
  <b>Inputs:</b>
  </p>
  <ul>
    <li><b>up</b> — Boolean flag: when true the signal moves from <code>yin</code> toward
        <code>yfin</code>.</li>
    <li><b>down</b> — Boolean flag: when true together with <code>up</code>, the signal
        moves in the reverse direction (from <code>yfin</code> toward <code>yin</code>).</li>
    <li><b>t</b> — current simulation time.</li>
    <li><b>ts</b> — time stamp at which the rising transition was triggered.</li>
    <li><b>td</b> — time stamp at which the falling transition was triggered.</li>
    <li><b>alfa</b> — parabolic blending coefficient for the transition shape.</li>
    <li><b>m</b> — maximum rate of change (slope) of the transition.</li>
    <li><b>yin</b> — initial (start) value of the signal.</li>
    <li><b>yfin</b> — final (end) value of the signal.</li>
  </ul>
  <p>
  <b>Output:</b>
  </p>
  <ul>
    <li><b>x</b> — the current signal value computed by the smooth-step profile.</li>
  </ul>
  <p>
  <b>Algorithm:</b> when <code>up=true</code> and <code>down=false</code>, the function
  delegates to <code>fSmoothStep(t, ts, alfa, m, yin, yfin)</code> for a rising transition.
  When both <code>up=true</code> and <code>down=true</code>, it calls
  <code>fSmoothStep(t, td, alfa, m, yfin, yin)</code> for a falling transition.
  Otherwise the output holds the initial value <code>yin</code>.
  </p>
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
end f;
