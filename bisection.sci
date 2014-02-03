ax = "cos(5+x/15)";

function[root, err, iter, exectime] = bisect(fx, xu, xl, tol)
    tic();    
    err = 100; //initial error
    for iter = 1: 1 : 10000
        if err > tol
            xr = (xl + xu)/2;
            x = xu;
            utmp = evstr(fx);
            x = xl;
            ltmp = evstr(fx);
            tmp = utmp * ltmp;
            if tmp < 0 
                xu = xr;
            elseif tmp > 0
                xl = xr;
            else
                root = xr;
                err = 0;
                break;
            end
            if(iter > 2)
                err = abs((xr - root)/xr)*100;
            end
            root = xr;
        else
            break;
        end
    end
    exectime = toc();
endfunction


function [root, err, iter, exectime] = falseposition(fx, xu, xl, tol)
    tic();
    err = 100; //initial error
    for iter = 1: 1 : 10000
        if err > tol
            x = xu;
            utmp = evstr(fx);
            x = xl;
            ltmp = evstr(fx);
            xr = xu - ((utmp * (xl - xu))/(ltmp * utmp));
            tmp = utmp * ltmp;
            if tmp < 0 
                xu = xr;
            elseif tmp > 0
                xl = xr;
            else
                root = xr;
                err = 0;
                break;
            end
            if(iter > 2)
                err = abs((xr - root)/xr)*100;
            end
            root = xr;
        else
            break;
        end
    end
    
    exectime = toc();
endfunction




function [root, err, iter, exectime] = modfalseposition(fx, xu, xl, tol)
    tic();
    il = 0;
    iu = 0;
    err = 100; //initial error
    for iter = 1: 1 : 10000
        if err > tol
            x = xu;
            utmp = evstr(fx);
            x = xl;
            ltmp = evstr(fx);
            xr = xu - ((utmp * (xl - xu))/(ltmp * utmp));
            tmp = utmp * ltmp;
            x = xr;
            xrtmp = evstr(fx);
            if tmp < 0 
                xu = xr;
                x = xu;
                utmp = evstr(fx);
                iu = 0;
                il = il + 1;
                if il >= 2
                    ltmp = ltmp/2;
                end
            elseif tmp > 0
                xl = xr;
                x = xl;
                ltmp = evstr(fx);
                il = 0;
                iu = iu + 1;
                if iu >= 2
                    utmp = utmp/2;
                end
            else
                root = xr;
                err = 0;
                break;
            end
            if(iter > 2)
                err = abs((xr - root)/xr)*100;
            end
            root = xr;
        else
            break;
        end
    end
    
    exectime = toc();
endfunction

function [root, err, iter, exectime] = secant(fx, xu, xl, tol)
    tic();
    err = 100; //initial error
    for iter = 1 : 10000
        
    end
    exectime = toc();
endfunction

/*
FUNCTION Fixpt(x0, es, imax, iter, ea)
xr  x0
iter  0
DO
xrold  xr
xr  g(xrold)
iter iter 1
IF xr  O THEN
ea   100
END IF
IF ea  es OR iter  imax EXIT
END DO
Fixpt  xr
END Fixpt
*/
