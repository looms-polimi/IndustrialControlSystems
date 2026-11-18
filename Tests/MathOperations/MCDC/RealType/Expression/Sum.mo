within Tests.MathOperations.MCDC.RealType.Expression;
function Sum "Sum of the inputs (for the Expression tests)"
  extends IndustrialControlSystems.MathOperations.RealType.Functions.GeneralFunction;
algorithm
  y := sum(u);
end Sum;
