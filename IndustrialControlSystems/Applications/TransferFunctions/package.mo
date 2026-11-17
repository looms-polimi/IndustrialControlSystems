within IndustrialControlSystems.Applications;
package TransferFunctions "Typical transfer functions"
  extends Modelica.Icons.Package;


  annotation (Icon(
          coordinateSystem(preserveAspectRatio=true,
            extent={{-100.0,-100.0},{100.0,100.0}}),
            graphics={
          Line(points={{-80.0,0.0},{80.0,0.0}},
            color={0,0,127}),
        Text(textColor={0,0,127},
          extent={{-90.0,10.0},{90.0,90.0}},
          textString="b(s)"),
        Text(textColor={0,0,127},
          extent={{-90.0,-90.0},{90.0,-10.0}},
          textString="a(s)")}), Documentation(
info="
  <HTML>
  <h4>Description</h4>
  <p>
  This sub-package contain a list of trasfer functions that represent a variety of industrial processes.<br>
  </p>
  </HTML>"));
end TransferFunctions;
