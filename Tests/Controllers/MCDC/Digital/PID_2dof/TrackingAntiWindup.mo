within Tests.Controllers.MCDC.Digital.PID_2dof;
model TrackingAntiWindup "Digital.PID_2dof: tracking and anti-windup on"
  extends Base(useTS=true, AntiWindup=true);
  annotation (experiment(StopTime=40, Interval=0.01, Tolerance=1e-6), Documentation(info="<html>
<p>Digital.PID_2dof: tracking and anti-windup on. Configuration: <code>useTS=true, AntiWindup=true</code>.</p>
<p>MC/DC role: pairs with Tracking for AntiWindup (TR = 1.5 limited to CSmax).</p>
</html>"));
end TrackingAntiWindup;
