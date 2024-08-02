% Mutation of 2 chromes,
% Input to the function = 2 chromes , Percentage at which user want to mutate them, if u want to mutate them at 20%, input = 0.2
% Output of Function = 2 chromes after mutation
% 2 chromes --> process --> 2 chromes (mutated)

function [c1,c2] = mutation2(c1,c2,mutation_percent)
Length_chrome = length(c1);
bits = floor(mutation_percent .* length(c1));
a = c1(1:bits);
A = ones(1,bits);
A = bitxor(a,A);
A(bits+1:Length_chrome) = c1(bits+1:Length_chrome);
c1 = A;
a = c2(1:bits);
A = ones(1,bits);
A = bitxor(a,A);
A(bits+1:Length_chrome) = c2(bits+1:Length_chrome);
c2 = A;
end

