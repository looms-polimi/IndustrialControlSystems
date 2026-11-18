within Tests.Controllers.MCDC.PD;
model SampledForwardEuler "PD: sampled, Forward Euler"
  extends Base(Ts=0.05, method=IndustrialControlSystems.LinearSystems.Discrete.Types.discrMethod.FE);
  annotation (experiment(StopTime=40, Interval=0.01, Tolerance=1e-6), Documentation(info="<html>
<p>PD: sampled, Forward Euler. Configuration: <code>Ts=0.05, method=IndustrialControlSystems.LinearSystems.Discrete.Types.discrMethod.FE</code>.</p>
<p>MC/DC role: covers method = FE in the discretisation decision.</p>
</html>"));
end SampledForwardEuler;
