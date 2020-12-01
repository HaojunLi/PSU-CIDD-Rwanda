function pfpr_plot(Calibrate_pfpr, referenced_pfpr,repeat)
    Calibrate = readtable(Calibrate_pfpr);
    Referenced = readtable(referenced_pfpr);
    Calibrate = table2array(Calibrate);
    Referenced = table2array(Referenced);
    for index = 1:length(Calibrate)
        pfprCalibrate(index,1) = Calibrate(index,2);
        pfprCalibrate(index,2) = Calibrate(index,6);
    end
    for index = 1:repeat
        pfprCalibrateRepeat(index) = pfprCalibrate(index,2);
        pfprReferencedRepeat(index) = Referenced(index, 2);
    end
    pfprReferencedRepeat
    plot(pfprReferencedRepeat,pfprCalibrateRepeat,'o');
    hold on
    plot(pfprReferencedRepeat,pfprReferencedRepeat);
    hold off
    xlabel('Reference PfPR_2_t_o_1_0');
    ylabel('Simulated PfPR_2_t_o_1_0');
end