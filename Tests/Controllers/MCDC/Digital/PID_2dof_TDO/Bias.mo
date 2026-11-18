within Tests.Controllers.MCDC.Digital.PID_2dof_TDO;
model Bias "Digital.PID_2dof_TDO: bias input on"
  extends Base(useBIAS=true);
  annotation (experiment(StopTime=40, Interval=0.01, Tolerance=1e-6), Documentation(info="<html>
<p>Digital.PID_2dof_TDO: bias input on. Configuration: <code>useBIAS=true</code>.</p>
<p>MC/DC role: pairs with Base for useBIAS.</p>
</html>"));
end Bias;
