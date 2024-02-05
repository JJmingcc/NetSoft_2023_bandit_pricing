function qM = klIC(p, d)
    lM = p; 
    uM = min(1,p+sqrt(d/2)); % ones(size(p));
    for j = 1:32
        qM = (uM+lM)/2;
        down = DivKL(p,qM) > d;
        uM(down) = qM(down);
        lM(~down) = qM(~down);
    end
    qM = uM;
end