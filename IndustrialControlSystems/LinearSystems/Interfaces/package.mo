within IndustrialControlSystems.LinearSystems;
package Interfaces "Interfaces"
  extends IndustrialControlSystems.Icons.InterfacesPackage;


annotation (Documentation(info="
  <HTML>
  <h4>Description</h4>
  <p>
  This package contains the partial (base) model interfaces shared by all
  linear system blocks in the LinearSystems library.  Extending these
  interfaces ensures a consistent connector layout and icon style across
  all continuous-time and discrete-time blocks.
  </p>
  <p>
  Available interfaces:
  <ul>
    <li><b>BaseBlock</b> &mdash; partial SISO block for continuous-time models,
        providing a single Real input <code>u</code> and a single Real output
        <code>y</code>.</li>
    <li><b>DiscreteBaseBlock</b> &mdash; partial SISO block for discrete-time
        models, adding a sampling time parameter <code>Ts</code>.</li>
  </ul>
  </p>
  </HTML>", revisions="<html>
</html>"));
end Interfaces;
