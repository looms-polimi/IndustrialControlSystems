within Tests.Controllers.MCDC.Digital.PID_2dof_TDO;
model AntiWindup "Digital.PID_2dof_TDO: anti-windup on"
  extends Base(AntiWindup=true);
  annotation (experiment(StopTime=40, Interval=0.01, Tolerance=1e-6), Documentation(info="<html>
<p>Digital.PID_2dof_TDO: anti-windup on. Configuration: <code>AntiWindup=true</code>.</p>
<p>MC/DC role: pairs with Base for AntiWindup in `cs > CSmax and AntiWindup` and `cs < CSmin and AntiWindup`.</p>
</html>"));
end AntiWindup;
