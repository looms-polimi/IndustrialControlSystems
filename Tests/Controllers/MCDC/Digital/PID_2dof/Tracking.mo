within Tests.Controllers.MCDC.Digital.PID_2dof;
model Tracking "Digital.PID_2dof: tracking inputs on"
  extends Base(useTS=true);
  annotation (experiment(StopTime=40, Interval=0.01, Tolerance=1e-6), Documentation(info="<html>
<p>Digital.PID_2dof: tracking inputs on. Configuration: <code>useTS=true</code>.</p>
<p>MC/DC role: pairs with Base for useTS (`not ts` in the mode decision).</p>
</html>"));
end Tracking;
