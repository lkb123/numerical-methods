ax = "(x^9)-2";
bx = "cos(5+x/15)";
cx = "3*sin(x)-exp(1/x)";
dx = "0.1*x^2+(22/22.5)*x-0.12";
ex = "x^3*x^2+70*x-70";

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

function [root, err, iter, exectime] = secant(fx, x0, x1, tol)
    tic();
    err = 100; //initial error

    for iter = 1 : 10000
        if err > tol
            x = x0;
            fx0 = evstr(fx);    //evaluate x0
            x = x1;
            fx1 = evstr(fx);    //evaluate x1
            xiplus1 = x1 - ((fx1 - (x1 - x0))/(fx1 - fx0));
            
            
            if(iter > 2)
               err = abs((xiplus1 - x1)/xiplus1) * 100;
            end
            x0 = x1;
            x1 = xiplus1;
        else 
           break;
        end
    end
    root = x1;
    exectime = toc();
endfunction 

