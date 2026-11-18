within Tests.Controllers.MCDC.Blocks.LeadLAG;
model Tracking "Blocks.LeadLAG: tracking inputs on"
  extends Base(useTS=true);
  annotation (experiment(StopTime=40, Interval=0.01, Tolerance=1e-6), Documentation(info="<html>
<p>Blocks.LeadLAG: tracking inputs on. Configuration: <code>useTS=true</code>.</p>
<p>MC/DC role: pairs with Base for useTS, and gives TS both values within the run.</p>
</html>"));
end Tracking;
