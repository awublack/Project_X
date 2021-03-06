function [figureHandle] = surfaceParametersInputDialog( parentWindow,surfaceIndex, tableName, rowNumber)
%surfaceParametersInputDialog display input window for differetn paramters of surfaces
% display the corresponding window to input boolean, choice and
% numeric data type parameter and make the cell editable for char type
% paramType :  'logical','char','numeric',{'choise 1','choise 2'}
% saves the paramValueNew and paramValueNewDisplay as workspace variable

aodHandles = parentWindow.AODParentHandles;
fontSize = aodHandles.FontSize;
fontName = aodHandles.FontName;
currentSurface =  aodHandles.OpticalSystem.SurfaceArray(surfaceIndex);

[ paramName,paramType,paramValueOld,paramValueOldDisplay] = ...
        getSurfaceParameter(currentSurface,tableName, rowNumber);

% Initialize handles structure
surfaceParameterInputDialogHandles = struct();

% Create all UI controls
buildSurfaceParameterInputDialogGUI();

% Assign function output
figureHandle = surfaceParameterInputDialogHandles.FigureHandle;

    function buildSurfaceParameterInputDialogGUI()
        surfaceParameterInputDialogHandles.FigureHandle = figure( ...
            'Tag', paramName, ...
            'Units', 'normalized', ...
            'Name', [paramName], ...
            'MenuBar', 'none', ...
            'NumberTitle', 'off', ...
            'Color', get(0,'DefaultUicontrolBackgroundColor'), ...
            'Resize', 'off','Visible','off',...
            'WindowStyle','Modal');
        surfaceParameterInputDialogHandles.btnOk = uicontrol( ...
            'FontSize',fontSize,'FontName', 'FixedWidth',...
            'Style','pushbutton',...
            'Tag', 'btnOk', ...
            'String','OK');
        surfaceParameterInputDialogHandles.btnCancel = uicontrol( ...
            'Units', 'Normalized', ...
            'FontSize',fontSize,'FontName', 'FixedWidth',...
            'Style','pushbutton',...
            'Tag', 'btnCancel', ...
            'String','Cancel');
        if strcmpi(class(paramType),'cell')
                % type is choice of popmenu
                 % --- PANELS -------------------------------------
                surfaceParameterInputDialogHandles.panelParameter = uipanel( ...
                    'Parent', surfaceParameterInputDialogHandles.FigureHandle, ...
                    'Tag', 'parameter', ...
                    'Units','Normalized',...
                    'Position', [0,0,1,0.95], ...
                    'FontSize',fontSize,'FontName',fontName,...
                    'Visible','on',...
                    'Title', 'Select Parameter');
                surfaceParameterInputDialogHandles.lblParameterName = uicontrol( ...
                    'Parent', surfaceParameterInputDialogHandles.panelParameter, ...
                    'Units', 'normalized', ...
                    'Position', [0 0.56 0.45 0.2],...
                    'Tag', 'lblParameterName', ...
                    'Style', 'text', ...
                    'HorizontalAlignment','right',...
                    'FontSize',fontSize,'FontName', 'FixedWidth',...
                    'String', paramName);
                oldValueIndex = find(strcmpi(paramType,paramValueOldDisplay));
                surfaceParameterInputDialogHandles.popParameterValue = uicontrol( ...
                    'Parent', surfaceParameterInputDialogHandles.panelParameter, ...
                    'Units', 'normalized', ...
                    'Position', [0.55 0.6 0.25 0.2],...
                    'Tag', 'popParameterValue', ...
                    'Style', 'popupmenu', ...
                    'FontSize',fontSize,'FontName', 'FixedWidth',...
                    'BackgroundColor', [1 1 1], ...
                    'String', paramType, 'Value',oldValueIndex,...
                    'HorizontalAlignment', 'left');
                                             
                set(surfaceParameterInputDialogHandles.FigureHandle,'Position', [0.3, 0.4, 0.4, 0.2]);
                set(surfaceParameterInputDialogHandles.btnOk,'Parent', surfaceParameterInputDialogHandles.panelParameter, ...
                    'Units', 'Normalized', ...
                    'Position', [0.15 0.1 0.3 0.2]);
                set(surfaceParameterInputDialogHandles.btnCancel,'Parent', surfaceParameterInputDialogHandles.panelParameter, ...
                    'Units', 'Normalized', ...
                    'Position', [0.55 0.1 0.3 0.2]);               
                
        else
        switch lower(paramType)
            case {lower('char')}
                % --- PANELS -------------------------------------
                surfaceParameterInputDialogHandles.panelParameter = uipanel( ...
                    'Parent', surfaceParameterInputDialogHandles.FigureHandle, ...
                    'Tag', 'parameter', ...
                    'Units','Normalized',...
                    'Position', [0,0,1,0.95], ...
                    'FontSize',fontSize,'FontName',fontName,...
                    'Visible','on',...
                    'Title', 'String Parameter');
                surfaceParameterInputDialogHandles.lblParameterName = uicontrol( ...
                    'Parent', surfaceParameterInputDialogHandles.panelParameter, ...
                    'Units', 'normalized', ...
                    'Position', [0 0.56 0.45 0.2],...
                    'Tag', 'lblParameterName', ...
                    'Style', 'text', ...
                    'HorizontalAlignment','right',...
                    'FontSize',fontSize,'FontName', 'FixedWidth',...
                    'String', paramName);
                
                surfaceParameterInputDialogHandles.txtParameterValue = uicontrol( ...
                    'Parent', surfaceParameterInputDialogHandles.panelParameter, ...
                    'Units', 'normalized', ...
                    'Position', [0.55 0.6 0.25 0.2],...
                    'Tag', 'txtParameterValue', ...
                    'Style', 'edit', ...
                    'FontSize',fontSize,'FontName', 'FixedWidth',...
                    'BackgroundColor', [1 1 1], ...
                    'String', paramValueOldDisplay, ...
                    'HorizontalAlignment', 'left');

                set(surfaceParameterInputDialogHandles.FigureHandle,'Position', [0.3, 0.4, 0.4, 0.2]);
                set(surfaceParameterInputDialogHandles.btnOk,'Parent', surfaceParameterInputDialogHandles.panelParameter, ...
                    'Units', 'Normalized', ...
                    'Position', [0.15 0.1 0.3 0.2]);
                set(surfaceParameterInputDialogHandles.btnCancel,'Parent', surfaceParameterInputDialogHandles.panelParameter, ...
                    'Units', 'Normalized', ...
                    'Position', [0.55 0.1 0.3 0.2]);
                
            case lower('numeric')
                % --- PANELS -------------------------------------
                surfaceParameterInputDialogHandles.panelParameter = uipanel( ...
                    'Parent', surfaceParameterInputDialogHandles.FigureHandle, ...
                    'Tag', 'parameter', ...
                    'Units','Normalized',...
                    'Position', [0,0,1,0.95], ...
                    'FontSize',fontSize,'FontName',fontName,...
                    'Visible','on',...
                    'Title', 'Numeric Parameter');
                surfaceParameterInputDialogHandles.lblParameterName = uicontrol( ...
                    'Parent', surfaceParameterInputDialogHandles.panelParameter, ...
                    'Units', 'normalized', ...
                    'Position', [0 0.56 0.45 0.2],...
                    'Tag', 'lblParameterName', ...
                    'Style', 'text', ...
                    'HorizontalAlignment','right',...
                    'FontSize',fontSize,'FontName', 'FixedWidth',...
                    'String', paramName);
                
                surfaceParameterInputDialogHandles.txtParameterValue = uicontrol( ...
                    'Parent', surfaceParameterInputDialogHandles.panelParameter, ...
                    'Units', 'normalized', ...
                    'Position', [0.55 0.6 0.25 0.2],...
                    'Tag', 'txtParameterValue', ...
                    'Style', 'edit', ...
                    'FontSize',fontSize,'FontName', 'FixedWidth',...
                    'BackgroundColor', [1 1 1], ...
                    'String', paramValueOldDisplay, ...
                    'HorizontalAlignment', 'left');
              
                set(surfaceParameterInputDialogHandles.FigureHandle,'Position', [0.3, 0.4, 0.4, 0.2]);
                set(surfaceParameterInputDialogHandles.btnOk,'Parent', surfaceParameterInputDialogHandles.panelParameter, ...
                    'Units', 'Normalized', ...
                    'Position', [0.15 0.1 0.3 0.2]);
                set(surfaceParameterInputDialogHandles.btnCancel,'Parent', surfaceParameterInputDialogHandles.panelParameter, ...
                    'Units', 'Normalized', ...
                    'Position', [0.55 0.1 0.3 0.2]);
            case lower('logical')
                % --- PANELS -------------------------------------
                surfaceParameterInputDialogHandles.panelParameter = uipanel( ...
                    'Parent', surfaceParameterInputDialogHandles.FigureHandle, ...
                    'Tag', 'parameter', ...
                    'Units','Normalized',...
                    'Position', [0,0,1,0.95], ...
                    'FontSize',fontSize,'FontName',fontName,...
                    'Visible','on',...
                    'Title', 'Logical Parameter');
                surfaceParameterInputDialogHandles.lblParameterName = uicontrol( ...
                    'Parent', surfaceParameterInputDialogHandles.panelParameter, ...
                    'Units', 'normalized', ...
                    'Position', [0 0.56 0.45 0.2],...
                    'Tag', 'lblParameterName', ...
                    'Style', 'text', ...
                    'HorizontalAlignment','right',...
                    'FontSize',fontSize,'FontName', 'FixedWidth',...
                    'String', paramName);
                    
                surfaceParameterInputDialogHandles.chkParameterValue = uicontrol( ...
                    'Parent', surfaceParameterInputDialogHandles.panelParameter, ...
                    'Units', 'normalized', ...
                    'Position', [0.55 0.6 0.05 0.2],...
                    'Tag', 'chkParameterValue', ...
                    'Style', 'checkbox', ...
                    'FontSize',fontSize,'FontName', 'FixedWidth',...
                    'BackgroundColor', [1 1 1], ...
                    'HorizontalAlignment', 'left',...
                    'Value',paramValueOldDisplay);
                
                set(surfaceParameterInputDialogHandles.FigureHandle,'Position', [0.3, 0.4, 0.4, 0.2]);
                set(surfaceParameterInputDialogHandles.btnOk,'Parent', surfaceParameterInputDialogHandles.panelParameter, ...
                    'Units', 'Normalized', ...
                    'Position', [0.15 0.1 0.3 0.2]);
                set(surfaceParameterInputDialogHandles.btnCancel,'Parent', surfaceParameterInputDialogHandles.panelParameter, ...
                    'Units', 'Normalized', ...
                    'Position', [0.55 0.1 0.3 0.2]);
        end
        end
        set(surfaceParameterInputDialogHandles.btnOk,...
            'Callback', {@btnOk_Callback,surfaceParameterInputDialogHandles,parentWindow,surfaceIndex, tableName, rowNumber});
        set(surfaceParameterInputDialogHandles.btnCancel,...
            'Callback', {@btnCancel_Callback,surfaceParameterInputDialogHandles,parentWindow,surfaceIndex, tableName, rowNumber});
        set(surfaceParameterInputDialogHandles.FigureHandle,'Visible','on');
    end


% CellEditCallback

    function SaveSurfaceParameter(surfParamInputHandles,parentWindow,surfaceIndex, tableName, rowNumber)
        currentSurface =  aodHandles.OpticalSystem.SurfaceArray(surfaceIndex);
        
        [ paramName,paramType,paramValueOld,paramValueOldDisplay] = ...
        getSurfaceParameter(currentSurface,tableName, rowNumber);
    
    
%         [ surfaceParametersTable ] = ...
%             getSurfaceParametersTable(currentSurface);
%         paramName = surfaceParametersTable{parameterID,1};
%         paramType = surfaceParametersTable{parameterID,3};
        if strcmpi(class(paramType),'cell')
                % type is choice of popmenu
                allParam = get(surfParamInputHandles.popParameterValue,'String');
                newParam = allParam{get(surfParamInputHandles.popParameterValue,'Value'),:};
        else
        switch lower(paramType)
            case {lower('char')}
                newParam = get(surfParamInputHandles.txtParameterValue,'String');
                newParamDisp = newParam;
            case lower('numeric')
                newParam = str2num(get(surfParamInputHandles.txtParameterValue,'String'));
                newParamDisp = newParam;
            case lower('logical')
                newParam = get(surfParamInputHandles.chkParameterValue,'value');
                if newParam
                    newParamDisp = 'True';
                else
                    newParamDisp = 'False';
                end
            otherwise

        end
        end
        
        % Update the surface parameter and surface editor
%         if isnumeric(parameterID)
%         currentSurface.OtherStandardData.(paramName) = newParam;   
%         else
%             currentSurface.(paramName) = newParam; 
%         end
%         
%         % Update surface editor
        switch tableName
            case 'Basic'
                switch rowNumber
                    case 1
                        currentSurface.Thickness = newParam; 
                    case 2
                        currentSurface.Glass = newParam; 
                    case 3
                        currentSurface.Coating = newParam;   
                    otherwise
                        currentSurface.OtherStandardData.(paramName) = newParam;   
                end
                
                oldData = get(aodHandles.tblSurfaceBasicParameters,'data');
                newData = oldData;
                newData{rowNumber,2} = newParamDisp;
                set(aodHandles.tblSurfaceBasicParameters,'data',newData);
            case 'TiltDecenter'
                oldData = get(aodHandles.tblSurfaceTiltDecenterParameters,'data');
                newData = oldData;
                newData{rowNumber,2} = newParamDisp;
                set(aodHandles.tblSurfaceTiltDecenterParameters,'data',newData);                     
            case 'Aperture'              
                oldData = get(aodHandles.tblSurfaceApertureParameters,'data');
                newData = oldData;
                newData{rowNumber,2} = newParamDisp;
                set(aodHandles.tblSurfaceApertureParameters,'data',newData);                
        end
    
        aodHandles.OpticalSystem.SurfaceArray(surfaceIndex) = currentSurface;

%         % Display surface parmeters in the main window
%         [ surfParamTable,surfParamTableDisplay ] = getSurfaceParametersTable(currentSurface);
%         
%         set(aodHandles.tblSurfaceParameters,'Data', surfParamTableDisplay);
        
        parentWindow.AODParentHandles = aodHandles;
    end
  
    function btnOk_Callback(~,~,surfParamInputHandles,parentWindow,surfaceIndex, tableName, rowNumber)
        aodHandles = parentWindow.AODParentHandles;
        figHandle = surfParamInputHandles.FigureHandle;
        SaveSurfaceParameter(surfParamInputHandles,parentWindow,surfaceIndex, tableName, rowNumber);
        delete(figHandle);        
    end
    function btnCancel_Callback(~,~,surfParamInputHandles,parentWindow,surfaceIndex, tableName, rowNumber)
%         aodHandles = parentWindow.AODParentHandles;
        figHandle = surfParamInputHandles.FigureHandle;
%         
%         currentSurface =  aodHandles.OpticalSystem.SurfaceArray(surfaceIndex);
%         [ surfaceParametersTable ] = ...
%             getSurfaceParametersTable(currentSurface);
%         paramName = surfaceParametersTable{parameterIndex,1};
%         paramValueOld = surfaceParametersTable{parameterID,2};
%         
%         aodHandles.OpticalSystem.SurfaceArray(surfaceIndex).Parameters.(paramName) = paramValueOld;
        delete(figHandle);
    end
end

