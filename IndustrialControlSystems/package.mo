within ;
package IndustrialControlSystems "Modelica Industrial Control Systems Library"
  extends Modelica.Icons.Package;
  annotation (Documentation(info="<html>
<p><br/>Package <b>Industrial Control Systems</b> is a library that is developed with the Modelica language <a href=\"http://www.Modelica.org\">http://www.Modelica.org</a> and provides a set of continuous and discrete control systems. This library can be used to set up or replicate the majority of industrial controllers. 
<br>
<img src=\"modelica://IndustrialControlSystems/help/images/Applications/ControlProblems/LevelControl_Scheme.png\"/><br>

</p>
</html>"),
    uses(Modelica(version="4.0.0")),
    version="2.0.0",
    conversion(from(
	  version={"1.2.0","1.1.0"},
	  script="modelica://IndustrialControlSystems/Resources/Conversion/ConvertFromIndustrialControlSystems_1.2.0.mos")));
end IndustrialControlSystems;
