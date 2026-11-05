within IndustrialControlSystems.MathOperations.RealType.Functions;
partial function GeneralReScalingFunction
  input Real u[:] "input of the function";
  input Real Y "computed output";
  input Real scaleFactor "scale factor";
  output Real y "re-scaled output";
  annotation (Documentation(info="
  <HTML>
  <h4>Description</h4>
  <p>
  This partial function defines the interface for fixed-point rescaling functions used by the
  real-type <code>Expression</code> block when <code>FixedPoint=true</code>. After the main
  mathematical function computes a raw real result, this rescaling function is called to
  convert that result back to the intended physical value.
  </p>
  <p>
  <b>Interface:</b>
  </p>
  <ul>
    <li><b>u[:]</b> — the original real input vector passed to the main function (available
        for context if the rescaling depends on the inputs).</li>
    <li><b>Y</b> — the raw output computed by the main mathematical function before
        rescaling.</li>
    <li><b>scaleFactor</b> — the scale factor used in the fixed-point representation.</li>
    <li><b>y</b> — the rescaled real output value.</li>
  </ul>
  <p>
  Concrete rescaling functions such as <code>reScale</code> extend this partial function and
  implement the rescaling algorithm (typically <code>y := Y / scaleFactor</code>).
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
end GeneralReScalingFunction;
