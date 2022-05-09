t = timer();
t.TimerFcn = @fun();
t.Period=1;
t.start()



function fun
    print('Dio Boia')
end