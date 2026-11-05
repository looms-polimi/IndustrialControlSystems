within ;
package IndustrialControlSystems "Modelica Industrial Control Systems Library"
  extends Modelica.Icons.Package;
  annotation (Icon(coordinateSystem(extent={{-100.0,-100.0},{100.0,100.0}},
          preserveAspectRatio=true), graphics={
        Rectangle(
          origin={0.0,35.1488},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid,
          extent={{-30.0,-20.1488},{30.0,20.1488}}),
        Rectangle(
          origin={0.0,-34.8512},
          fillColor={128,128,128},
          fillPattern=FillPattern.Solid,
          extent={{-30.0,-20.1488},{30.0,20.1488}}),
        Line(origin={-51.25,0.0}, points={{21.25,-35.0},{-13.75,-35.0},{-13.75,
              35.0},{6.25,35.0}}),
        Polygon(
          origin={-40.0,35.0},
          pattern=LinePattern.None,
          fillPattern=FillPattern.Solid,
          points={{10.0,0.0},{-5.0,5.0},{-5.0,-5.0}}),
        Line(origin={51.25,0.0}, points={{-21.25,35.0},{13.75,35.0},{13.75,-35.0},
              {-6.25,-35.0}}),
        Polygon(
          origin={40.0,-35.0},
          pattern=LinePattern.None,
          fillPattern=FillPattern.Solid,
          points={{-10.0,0.0},{5.0,5.0},{5.0,-5.0}})}), Documentation(info="<html>
<p><br/>Package <b>Industrial Control Systems</b> is a library that is developed with the Modelica language <a href=\"http://www.Modelica.org\">http://www.Modelica.org</a> and provides a set of continuous and discrete control systems. This library can be used to set up or replicate the majority of industrial controllers. 
<br>
<img src=\"modelica://IndustrialControlSystems/Resources/Images/Applications/ControlProblems/LevelControl_Scheme.png\"/><br>

</p>
</html>"),
    uses(Modelica(version="4.1.0")),
    version="2.0.1",
    conversion(from(
	  version={"1.2.0","1.1.0"},
	  script="modelica://IndustrialControlSystems/Resources/Scripts/Conversion/ConvertFromIndustrialControlSystems_1.2.0.mos"),
	  noneFromVersion="2.0.0"));
end IndustrialControlSystems;
