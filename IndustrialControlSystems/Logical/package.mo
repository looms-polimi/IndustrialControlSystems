within IndustrialControlSystems;
package Logical "Binary and logic operations"
  extends Modelica.Icons.Package;


  annotation (Icon(graphics={Line(
          points={{-86,-22},{-50,-22},{-50,22},{48,22},{48,-22},{88,-24}},
          color={255,0,255})}), Documentation(
info="
  <HTML>
  <h4>Description</h4>
  <p>
  This package groups all sampled-data Boolean and logic components of the Industrial Control
  Systems library. It is organised into the following sub-packages:
  </p>
  <ul>
  <li><b>Comparisons</b> &mdash; relational operator blocks (==, !=, &gt;, &lt;, &gt;=, &lt;=)
  for both integer and real-valued signals.</li>
  <li><b>LogicalOperations</b> &mdash; configurable Boolean logic blocks (AND, OR, NOT, XOR)
  and an SR flip-flop.</li>
  <li><b>Timers</b> &mdash; on-delay and off-delay timer blocks, including edge-triggered
  variants and residual-time outputs.</li>
  <li><b>Counter</b> &mdash; modular up/down counter blocks with Set, Reset, Count-Up, and
  Count-Down inputs.</li>
  </ul>
  <p>
  All blocks operate in discrete time with a configurable sampling period <em>Ts</em>.
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
end Logical;
