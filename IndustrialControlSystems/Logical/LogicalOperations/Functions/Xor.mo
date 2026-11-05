within IndustrialControlSystems.Logical.LogicalOperations.Functions;
function Xor "Function XOR"
  input Boolean u[:];
  input Integer nInput = 2;
  output Boolean y;
algorithm

  y := (u[1] and (not u[2])) or ((not u[1]) and u[2]);

  for i in 3:size(u,1) loop
    y := (u[i] and (not y)) or ((not u[i]) and y);
  end for;

  annotation (Documentation(info="
  <HTML>
  <h4>Description</h4>
  <p>
  This function computes the logical XOR of all elements in the Boolean input array <em>u</em>.
  The result is obtained by chaining pairwise XOR operations: <em>y</em> is initialised to
  <code>(u[1] and not u[2]) or (not u[1] and u[2])</code>, and then each subsequent element
  <em>u[i]</em> is XOR-combined with the running result. The final output <em>y</em> is true if
  and only if an odd number of elements in <em>u</em> are true.
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
end Xor;
