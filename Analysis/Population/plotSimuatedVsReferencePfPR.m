% Generate the simuated versus reference PfPR values, which can be used as
% figure one for a manuscript.
function [] = plotSimuatedVsReferencePfPR(filename)
    % Load the reference data
    reference = csvread('../../Calibration/out/weighted_pfpr.csv');
    % Load and trim the evaluation data to post-burn-in
    dataO = csvread(filename, 0, 0);
    count = 1;
    % five years after burn-in
    for index = 1:length(dataO)
        if dataO(index,1) >= (11*365) && dataO(index,1) <= (16*365)
            data(count,:) = dataO(index, :);
            count = count + 1;
        end
    end
    districts = unique(data(:, 2));

    % Prepare the color map
    colors = colormap(parula(size(districts, 1)));
%     recorder(1,:) = ['Districts','mean(maxima)','abs(mean(minima))','expected'];
    hold on;
    i = 1;
    districtStr = string(districts);
    for district = transpose(districts)
        clear maximaSave;
        clear minimaSave;
        expected = reference(reference(:, 1) == district, 2);
        pfpr = data(data(:, 2) == district, 6); 

        % We want the seasonal maxima, filter out the local maxima, once
        % this is done we should only have ten points left (i.e., number of
        % years)
        maxima = pfpr(pfpr > mean(pfpr));
        maxima = maxima(maxima > maxima - std(maxima));
        maxima = findpeaks(maxima);

        pfpr = pfpr .* -1;
        minima = pfpr(pfpr > mean(pfpr));
        minima = minima(minima > minima - std(minima));
        minima = findpeaks(minima);
        
        % Create files to record peaks
        maximaSave(1) = district;
        for i = 1: length(maxima)
            maximaSave(i+1) = maxima(i); 
        end
        minimaSave(1) = district;
        for i = 1: length(minima)
            minimaSave(i+1) = abs(minima(i));
        end
        if i == 1
            csvwrite('Maxima.csv',maximaSave);
            csvwrite('Minima.csv',minimaSave);
            i = i+1;
        else
            dlmwrite('Maxima.csv',maximaSave,'-append');
            dlmwrite('Minima.csv',minimaSave,'-append');
        end
        % Plot from the maxima to the minima, connected by a line
        line([expected expected], [mean(maxima) abs(mean(minima))], 'color', [0, 0, 0, 0.25]);
        
        s = scatter(expected, mean(maxima), 75, colors(district, :), 'filled', 'MarkerEdgeColor', 'black');
        % add district
        row = dataTipTextRow('District', district);
        s.DataTipTemplate.DataTipRows(end+1) = row;
        text(expected+0.1,mean(maxima),districtStr(district),'FontSize',14);
        
        scatter(expected, abs(mean(minima)), 37.5, [99 99 99] / 255, 'filled');
        recorder(district, :) = [district,mean(maxima),abs(mean(minima)),expected];
    end
    hold off;
    csvwrite('recorder.csv',recorder);
    %recorder
    data = get(gca, 'YLim');
    data1 = get(gca, 'XLim');
    if data1(2) > data(2)
        data = data1;
    else
        data = data;
    end
    line([data(1) data(2)], [data(1) data(2)], 'Color', 'black', 'LineStyle', '-.');
    text(data(2),data(2),'\leftarrow +0%')
    % 5%
    line([data(1) data(2)], [data(1)*1.05 data(2)*1.05], 'Color', 'cyan', 'LineStyle', '-.');
    text(data(2),data(2)*1.05,'\leftarrow +5%')
    
    line([data(1) data(2)], [data(1)*0.95 data(2)*0.95], 'Color', 'cyan', 'LineStyle', '-.');
    text(data(2),data(2)*0.95,'\leftarrow -5%')
    % 10%
    line([data(1) data(2)], [data(1)*1.1 data(2)*1.1], 'Color', 'blue', 'LineStyle', '-.');
    text(data(2),data(2)*1.1,'\leftarrow +10%')
    
    line([data(1) data(2)], [data(1)*0.9 data(2)*0.9], 'Color', 'blue', 'LineStyle', '-.');
    text(data(2),data(2)*0.9,'\leftarrow -10%')
    % 15%
    line([data(1) data(2)], [data(1)*1.15 data(2)*1.15], 'Color', 'green', 'LineStyle', '-.');
    text(data(2),data(2)*1.15,'\leftarrow +15%')
    
    line([data(1) data(2)], [data(1)*0.85 data(2)*0.85], 'Color', 'green', 'LineStyle', '-.');
    text(data(2),data(2)*0.85,'\leftarrow -15%')
    % 20%
    line([data(1) data(2)], [data(1)*1.2 data(2)*1.2], 'Color', 'red', 'LineStyle', '-.');
    text(data(2),data(2)*1.2,'\leftarrow +20%')
    
    line([data(1) data(2)], [data(1)*0.8 data(2)*0.8], 'Color', 'red', 'LineStyle', '-.');
    text(data(2),data(2)*0.80,'\leftarrow -20%')
    
    ylabel('Simulated {\it Pf}PR_{2 to 10}, mean of peaks');
    xlabel('Reference {\it Pf}PR_{2 to 10}');

    title('Burkina Faso, Simuated versus Reference {\it Pf}PR_{2 to 10} values');

    graphic = gca;
    graphic.FontSize = 18;
end