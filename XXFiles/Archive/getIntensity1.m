function [IntensityBeforeCoating,IntensityAfterCoating] =  ...
         getIntensity(RayTraceResult,surfIndex)
     % getIntensity: Returns intensity parameters of the ray before
     % and after the coating of a surf
     IntensityBeforeCoating = computeIntensity...
         ( RayTraceResult.PolarizationVectorBeforeCoating(surfIndex,:));
     IntensityAfterCoating = computeIntensity...
         (RayTraceResult.PolarizationVectorAfterCoating(surfIndex,:));
end
