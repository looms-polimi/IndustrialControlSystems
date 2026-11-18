within Tests.Controllers.MCDC.Digital.PID_2dof;
model NoDerivative "Digital.PID_2dof: derivative path removed (Td = 0)"
  extends Base(Td=0);
  annotation (experiment(StopTime=40, Interval=0.01, Tolerance=1e-6), Documentation(info="<html>
<p>Digital.PID_2dof: derivative path removed (Td = 0). Configuration: <code>Td=0</code>.</p>
<p>MC/DC role: pairs with Base for `Td > 0`.</p>
</html>"));
end NoDerivative;
