function [] = monthlyPfPR(filename, startDate)
    % Load the data and reference data
    data = csvread(filename, 0, 0);
    reference = csvread('../../Calibration/out/weighted_pfpr.csv');
    dn = prepareDates(filename, 1, startDate);
    % Prepare the color map
    colors = colormap(parula(size(unique(data(:, 2)), 1)));
    % Prepare the burn-in marker point
    formatIn = 'mm/dd/yyyy';
    start = addtodate(datenum(startDate,formatIn), 4000, 'day');
    
    % Filter and iterate over the districts
    districts = unique(reference(:, 1));
    % Select the correct plot format
    hold on;
    
    subplot(3, 1, 1);
    hold on;
    for district = transpose(districts(1:ceil(length(districts)/3)))
        pfpr = data(data(:, 2) == district, 6);
        scatter(dn, pfpr, 50, colors(district, :), 'Filled');
        plot(dn,pfpr,'-x')
    end
    % Add the plot features
    yline(0, '-.');
    xline(start, '-.', 'Model Burn-in', 'LabelVerticalAlignment', 'bottom');

    datetick('x', 'yyyy');
    xlim([min(dn) max(dn)])
    ylabel('PfPR_{2 to 10}');
    xlabel('Model Year');
    title(sprintf('Simulated Monthly PfPr_{2 to 10} Over Time (Districts {%d - %d})',1,ceil(length(districts)/3)));
    hold off;
    
    
    subplot(3, 1, 2);
    hold on;
    for district = transpose(districts(ceil(length(districts)/3)+1:ceil(length(districts)/3)*2))
        pfpr = data(data(:, 2) == district, 6);
        scatter(dn, pfpr, 50, colors(district, :), 'Filled');
        plot(dn,pfpr,'-x')
    end
    % Add the plot features
    yline(0, '-.');
    xline(start, '-.', 'Model Burn-in', 'LabelVerticalAlignment', 'bottom');

    datetick('x', 'yyyy');
    xlim([min(dn) max(dn)])
    ylabel('PfPR_{2 to 10}');
    xlabel('Model Year');
    title(sprintf('Simulated Monthly PfPr_{2 to 10} Over Time (Districts {%d - %d})',ceil(length(districts)/3)+1,ceil(length(districts)/3)*2));
    hold off;
    
    
    subplot(3, 1, 3);
    hold on;
    for district = transpose(districts(ceil(length(districts)/3)*2+1:length(districts)))
        pfpr = data(data(:, 2) == district, 6);
        scatter(dn, pfpr, 50, colors(district, :), 'Filled');
        plot(dn,pfpr,'-x')
    end
    % Add the plot features
    yline(0, '-.');
    xline(start, '-.', 'Model Burn-in', 'LabelVerticalAlignment', 'bottom');

    datetick('x', 'yyyy');
    xlim([min(dn) max(dn)])
    ylabel('PfPR_{2 to 10}');
    xlabel('Model Year');
    title(sprintf('Simulated Monthly PfPr_{2 to 10} Over Time (Districts {%d - %d})',ceil(length(districts)/3)*2+1,length(districts)));
    hold off;
    
    %title('Simulated Monthly PfPr_{2 to 10} Over Time');
    %graphic = gca;
    %graphic.FontSize = 18;
    hold off;
end