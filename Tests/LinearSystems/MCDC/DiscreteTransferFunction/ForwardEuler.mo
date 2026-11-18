within Tests.LinearSystems.MCDC.DiscreteTransferFunction;
model ForwardEuler "DiscreteTransferFunction: Forward Euler"
  extends Base(method=IndustrialControlSystems.LinearSystems.Discrete.Types.discrMethod.FE);
  annotation (experiment(StopTime=10, Interval=0.005, Tolerance=1e-8), Documentation(info="<html>
<p>DiscreteTransferFunction: Forward Euler. Configuration: <code>method=IndustrialControlSystems.LinearSystems.Discrete.Types.discrMethod.FE</code>.</p>
<p>MC/DC role: covers method = FE.</p>
</html>"));
end ForwardEuler;
