within Tests.Controllers.MCDC.Logic.RelayHysteresis;
model InitTrue "Logic.RelayHysteresis: initial state on"
  extends Base(initState=true);
  annotation (experiment(StopTime=12, Interval=0.005, Tolerance=1e-6), Documentation(info="<html>
<p>Logic.RelayHysteresis: initial state on. Configuration: <code>initState=true</code>.</p>
<p>MC/DC role: pairs with Base for initState (the first half-wave starts between the thresholds).</p>
</html>"));
end InitTrue;
