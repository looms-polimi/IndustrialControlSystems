within IndustrialControlSystems.MathOperations.Examples;
function SumSquare "This function compute the sum square of a vector"
  extends IntegerType.Functions.GeneralFunction;
protected
  Integer n "Length of input vector";
algorithm
  n :=size(u,1);

  y := sum(u[i]*u[i] for i in 1:n);

  annotation (Documentation(info="
  <HTML>
  <h4>Description</h4>
  <p>
  This function computes the sum of squares of an integer input vector.
  It extends <code>IntegerType.Functions.GeneralFunction</code> and therefore accepts a
  variable-length integer input vector <code>u[:]</code> and returns a single integer
  output <code>y</code>.
  </p>
  <p>
  <b>Algorithm:</b> the length <code>n</code> of the input vector is determined at run time,
  and the output is computed as
  </p>
  <pre>
    y := sum(u[i] * u[i] for i in 1:n);
  </pre>
  <p>
  This function is used as a plug-in for the integer-type <code>Expression</code> block in the
  <code>CustomMathOperation</code> example, where it receives inputs [2, 4, -4, 5] and
  produces the result 2&sup2; + 4&sup2; + 4&sup2; + 5&sup2; = 61.
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
end SumSquare;
