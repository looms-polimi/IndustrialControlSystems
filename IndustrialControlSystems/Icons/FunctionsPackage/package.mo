within IndustrialControlSystems.Icons;
partial package FunctionsPackage "Function package icon"
  annotation (Icon(graphics={Ellipse(
        extent={{-100,100},{100,-100}},
        lineColor={255,255,255},
        fillColor={255,170,85},
        fillPattern=FillPattern.Solid), Text(
        extent={{-40,100},{40,-100}},
        lineColor={255,255,255},
        fillColor={255,170,85},
        fillPattern=FillPattern.Solid,
        textString="f")}),                  Documentation(info="
  <HTML>
  <h4>Description</h4>
  <p>
  This partial package defines the icon used to identify function packages throughout the
  IndustrialControlSystems library. Any package that groups Modelica functions should extend
  this class to inherit the standard functions-package graphical appearance: an orange circle
  with the letter <b>f</b> displayed in white. This makes function packages immediately
  distinguishable from model and example packages in the tool's package browser.
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

end FunctionsPackage;
