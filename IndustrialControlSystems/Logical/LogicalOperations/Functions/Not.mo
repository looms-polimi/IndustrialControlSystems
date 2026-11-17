within IndustrialControlSystems.Logical.LogicalOperations.Functions;
function Not "Function NOT"
  input Boolean u[:];
  input Integer nOutput = 1;
  output Boolean y[nOutput];
algorithm
  for i in 1:size(u,1) loop
    y[i] := not u[i];
  end for;
  annotation (Documentation(info="
  <HTML>
  <h4>Description</h4>
  <p>
  This function applies logical NOT element-wise to the Boolean input array <em>u</em> and
  returns the result in the output array <em>y</em>, which has the same length as <em>u</em>
  (given by <em>nOutput</em>). Each output element <em>y[i]</em> is the logical complement of
  the corresponding input <em>u[i]</em>.
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
end Not;
