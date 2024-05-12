clear all
close all


% omezeni zbytecnych varovani
warning('off');


dataDir = 'data2024'; % adresar s xls soubory
dataFiles = dir(fullfile(dataDir,'*.xlsx')); % vrat vsechny xlsx soubory
picDir = 'pics';

% smazu vsechny stavajici obrazky
delete(append(picDir,'/*'));


% smycka pres vsechny soubory
for k = 1:length(dataFiles)
    baseFileName = dataFiles(k).name;
    fullFileName = fullfile(dataDir, baseFileName);
    fprintf('Zpracovavam %s\n', fullFileName);


    data = readtable(fullFileName,  ...
        'Sheet', 'List1', 'Range', 'A6:EG13');

    % info o mereni
    tokeny = split(fullFileName, {'_', '/', '.'});

    titulek_grafu_1 = "";
    titulek_grafu_2 = "";
    if strcmp(baseFileName, 'adla.xlsx') == 1
        titulek_grafu_1 = 'Žena, 23 let';
    else

        switch lower(char(tokeny(7))) % typ strikacky
            case 'm'
                titulek_grafu_1 = append(titulek_grafu_1, "Model: ");
            case 'l'
                titulek_grafu_1 = append(titulek_grafu_1, "Kalibrační stříkačka: ");
            otherwise
                titulek_grafu_1 = append(titulek_grafu_1, "?");
        end

        switch lower(char(tokeny(2))) % velikost nadoby
            case '5l'
                titulek_grafu_1 = append(titulek_grafu_1, "5L, ");
            case '10l'
                titulek_grafu_1 = append(titulek_grafu_1, "10L, ");
            case '54l'
                titulek_grafu_1 = append(titulek_grafu_1, "54L, ");
            otherwise
                titulek_grafu_1 = append(titulek_grafu_1, "?, ");
        end
                
        % token 5 napisu primo
        titulek_grafu_1 = append(titulek_grafu_1,  "trubice ");
        titulek_grafu_1 = append(titulek_grafu_1,  char(tokeny(5)));
        titulek_grafu_1 = append(titulek_grafu_1,  ", ");

        switch lower(char(tokeny(3))) % parabolicky odpor u lahve
            case '0rp'
                titulek_grafu_2 = append(titulek_grafu_2, "Rp 0 + ");
            case '5rp'
                titulek_grafu_2 = append(titulek_grafu_2, "Rp 5 + ");
            case '20rp'
                titulek_grafu_2 = append(titulek_grafu_2, "Rp 20 + ");
            case '50rp'
                titulek_grafu_2 = append(titulek_grafu_2, "Rp 50 + ");
            otherwise
                titulek_grafu_2 = append(titulek_grafu_2, "Rp ? +");
        end

        switch lower(char(tokeny(4))) % parabolicky odpor u tremofla
            case '0rp'
                titulek_grafu_2 = append(titulek_grafu_2, "Rp 0, ");
            case '5rp'
                titulek_grafu_2 = append(titulek_grafu_2, "Rp 5, ");
            case '20rp'
                titulek_grafu_2 = append(titulek_grafu_2, "Rp 20, ");
            case '50rp'
                titulek_grafu_2 = append(titulek_grafu_2, "Rp 50, ");
            otherwise
                titulek_grafu_2 = append(titulek_grafu_2, "Rp ?,");
        end



        switch lower(char(tokeny(6))) % case mereni
            case '3s'
                titulek_grafu_2 = append(titulek_grafu_2, "čas 3s");
            case '4s'
                titulek_grafu_2 = append(titulek_grafu_2, "čas 4s");
            case '5s'
                titulek_grafu_2 = append(titulek_grafu_2, "čas 5s");
            case '6s'
                titulek_grafu_2 = append(titulek_grafu_2, "čas 6s");
            otherwise
                titulek_grafu_2 = append(titulek_grafu_2, "čas ?");
        end



    end %neni if adla


    fig = figure;
    set(fig, 'Position', [0 0 1000 1000]);
    hold on

    axis([4 24 -20 60])


    rplot = draw_points (5*ones(1,length(data.R5)), data.R5, 'r');
    rrplot = draw_points (5*ones(1,length(data.R5_Ref_)), data.R5_Ref_, 'rr');

    draw_points (11*ones(1,length(data.R11)), data.R11, 'r');
    draw_points (11*ones(1,length(data.R11_Ref_)), data.R11_Ref_, 'rr');

    draw_points (13*ones(1,length(data.R13)), data.R13, 'r');
    draw_points (13*ones(1,length(data.R13_Ref_)), data.R13_Ref_,'rr');

    draw_points (17*ones(1,length(data.R17)), data.R17, 'r');
    draw_points (17*ones(1,length(data.R17_Ref_)), data.R17_Ref_, 'rr');

    draw_points (19*ones(1,length(data.R19)), data.R19, 'r');
    draw_points (19*ones(1,length(data.R19_Ref_)), data.R19_Ref_, 'rr');

    draw_points (23*ones(1,length(data.R23)), data.R23, 'r');
    draw_points (23*ones(1,length(data.R23_Ref_)), data.R23_Ref_, 'rr');


    xplot = draw_points (5*ones(1,length(data.X5)), data.X5, 'x');
    xrplot = draw_points (5*ones(1,length(data.X5_Ref_)), data.X5_Ref_, 'xr');

    draw_points (11*ones(1,length(data.X11)), data.X11, 'x');
    draw_points (11*ones(1,length(data.X11_Ref_)), data.X11_Ref_, 'xr');

    draw_points (13*ones(1,length(data.X13)), data.X13, 'x');
    draw_points (13*ones(1,length(data.X13_Ref_)), data.X13_Ref_, 'xr');

    draw_points (17*ones(1,length(data.X17)), data.X17, 'x');
    draw_points (19*ones(1,length(data.X19)), data.X19, 'x');
    draw_points (23*ones(1,length(data.X23)), data.X23, 'x');


    % prolozeni pw linear primkou
    r_rada = [data.R5, data.R11, data.R13, data.R17, data.R19, data.R23];
    x_rada = [data.X5, data.X11, data.X13, data.X17, data.X19, data.X23];

    if isa(r_rada,'cell')
        r_rada = str2double(r_rada);
    end

    if isa(x_rada,'cell')
        x_rada = str2double(x_rada);
    end

    fit_r_rada = mean(r_rada(2:end, :), "omitnan");
    fit_x_rada = mean(x_rada(2:end, :), "omitnan");

    freq = [5,11,13,17,19,23];

    rfit_plot = plot (freq', fit_r_rada', '--');
    rfit_plot.Color = 'k';


    xfit_plot = plot (freq', fit_x_rada', '--');
    xfit_plot.Color =  [255/255, 95/255, 31/255]; % oranzova


    title( {titulek_grafu_1, titulek_grafu_2});
    xlabel("Frekvence [Hz]");
    ylabel( "Resistence/reaktance [cmH2Os/L]");

    %
    % leg = legend([rplot, rrplot, rfit_plot, xplot, xrplot, xfit_plot], ...
    %       {'Resistence', 'Referenční resistence','Interpolovaná resistence', ...
    %       'Reaktance', 'Referenční reaktance', 'Interpolovaná reaktance'}, ...
    %       'location', 'southoutside');
    % %leg.Interpreter='latex';
    % leg.FontSize = 8;


    hold off

    picfileName = append(picDir, '/', baseFileName, '.png');

    % v1 save
    % exportgraphics(fig, picfileName);

    % v2 save
    %  f = getframe(fig);
    % imwrite(f.cdata, picfileName, 'png')

    % v3
    output_size = [1200 1200];%Size in pixels
    resolution = 300;%Resolution in DPI
    set(gcf,'paperunits','inches','paperposition',[0 0 output_size/resolution]);
    % use 300 DPI
    print(picfileName,'-dpng',['-r' num2str(resolution)]);


    % zakomentuj kdyz nechces aby se obrazky zaviraly
    close;

    %break


end


function s1 = draw_points(x, y, typ)
x1 = x(2:end);
y1 = y(2:end);

if isa(x1,'cell')
    x1 = str2double(x1);
end

if isa(y1,'cell')
    y1 = str2double(y1);
end

s1 = 0;
switch typ
    case 'r'
        % modra
        s1 = scatter(x1, y1, 50, [0 51/256 150/256], "filled");
        s1.Marker = "o";

    case 'rr'
        % svetle modra
        s1 = scatter(x1, y1, 50, [48/256 213/256 200/256]);
        s1.Marker = "o";

    case 'x'
        % cervena
        s1 = scatter(x1, y1, 50, [158/256 0 0], "filled");
        s1.Marker = "square";

    case 'xr'
        % oranzova
        s1 = scatter(x1, y1, 50,  [242/256 140/256 40/256]);
        s1.Marker = "square";
    otherwise
        disp('neznamy typ!!')
        % nedelej nic
end

% legendu udelam rucne
s1.DisplayName = "";

end
