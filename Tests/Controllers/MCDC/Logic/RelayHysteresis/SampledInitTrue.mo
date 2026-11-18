within Tests.Controllers.MCDC.Logic.RelayHysteresis;
model SampledInitTrue "Logic.RelayHysteresis: sampled, initial state on"
  extends Base(Ts=0.1, initState=true);
  annotation (experiment(StopTime=12, Interval=0.005, Tolerance=1e-6), Documentation(info="<html>
<p>Logic.RelayHysteresis: sampled, initial state on. Configuration: <code>Ts=0.1, initState=true</code>.</p>
<p>MC/DC role: pairs with Sampled for initState.</p>
</html>"));
end SampledInitTrue;
