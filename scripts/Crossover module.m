% Cross Over Parents......
%input = 2 chromes , Cross Over percentage( e.g for 30% , input 0.3)

function[p1,p2] = cross2(p1,p2,cross_percent)
    bits_length = length(p1);
    bits = floor(cross_percent .* bits_length);
    temp = p1(1:bits);
    bits_of_p2 = p2((bits_length-bits)+1:end);
    p1(1:bits) = bits_of_p2;
    p2((bits_length-bits)+1:end) = temp;
end