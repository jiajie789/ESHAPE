function varargout = ESHAPE(varargin)
% ESHAPE MATLAB code for ESHAPE.fig
%      ESHAPE, by itself, creates a new ESHAPE or raises the existing
%      singleton*.
%
%      H = ESHAPE returns the handle to a new ESHAPE or the handle to
%      the existing singleton*.
%
%      ESHAPE('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in ESHAPE.M with the given input arguments.
%
%      ESHAPE('Property','Value',...) creates a new ESHAPE or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before ESHAPE_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to ESHAPE_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help ESHAPE

% Last Modified by GUIDE v2.5 24-Oct-2023 11:51:36

% Begin initialization code - DO NOT EDIT
addpath(genpath('./functions'));
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @ESHAPE_OpeningFcn, ...
                   'gui_OutputFcn',  @ESHAPE_OutputFcn, ...
                   'gui_LayoutFcn',  [] , ...
                   'gui_Callback',   []);
if nargin && ischar(varargin{1})
    gui_State.gui_Callback = str2func(varargin{1});
end

if nargout
    [varargout{1:nargout}] = gui_mainfcn(gui_State, varargin{:});
else
    gui_mainfcn(gui_State, varargin{:});
end
% End initialization code - DO NOT EDIT


% --- Executes just before ESHAPE is made visible.
function ESHAPE_OpeningFcn(hObject, ~, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to ESHAPE (see VARARGIN)

% Choose default command line output for ESHAPE
set(gcf,'name','ESHAPE');
handles.output = hObject;
set(hObject,'toolbar','figure');
% set(hObject, 'toolbar', 'auto');
% set(gcf,'Units','pixels')
pt = get(gcf,'Position');
handles.figure_pt = pt;
axes(handles.axes6);
pt = get(gca,'Position');
handles.axes6_pt = pt;
axes(handles.axes3);
pt = get(gca,'Position');
handles.axes3_pt = pt;
axes(handles.axes4);
pt = get(gca,'Position');
handles.axes4_pt = pt;
handles.threshvalue = 0.05;
handles.usercheck = 0;
handles.rowidxori = 0;
handles.colidxori = 0;
handles.jpgnrows = 0;
handles.jpgncols = 0;
handles.axis1_rowst = 0;
handles.axis1_colst = 0;
handles.axis1_nrows = 0;
handles.axis1_ncols = 0;
handles.axis1_row_ratio = 1.0;
handles.axis1_col_ratio = 1.0;
handles.axis4_rowst = 0;
handles.axis4_colst = 0;
handles.axis4_nrows = 0;
handles.axis4_ncols = 0;
handles.axis4_row_ratio = 1.0;
handles.axis4_col_ratio = 1.0;
handles.jpgscale = 0;
handles.bmpscale = 0;
handles.pathname = '';
handles.filename = '';
handles.slice_increment = 0.34; %mm
handles.slice_thickness = 0.67; %mm
handles.field_of_view = 250;    %mm
handles.imagematrix = 1024;
handles.isaxis1dataready = 0;
handles.isaxis2dataready = 0;
handles.isaxis3dataready = 0;
handles.isaxis6dataready=0;
handles.ischaindataready = 0;
handles.ischaindataused = 0;
handles.issaved=0;
handles.chaincount = 0;
handles.buttonstatus = 0;
handles.tracebuffer = zeros(10000,2);
handles.tracecount = 0;
handles.typestr = '';
handles.chaincode_rowst = 0;
handles.chaincode_colst = 0;
handles.chaincode_udf = 0;
handles.filepath_orig='';
handles.erzhi=[];
handles.delta = handles.slice_increment*handles.imagematrix/handles.field_of_view;
handles.popup_sel_index=0;
handles.strs=[];
handles.isMoving=false;
handles.deltaPos=[0 0];
handles.method=1;
handles.unit=1;
set(handles.popupmenu1,'string',{'canny'});
set(handles.popupmenu1,'string',[get(handles.popupmenu1,'string');{'zerocross'}]);
set(handles.popupmenu1,'string',[get(handles.popupmenu1,'string');{'log'}]);
set(handles.popupmenu1,'string',[get(handles.popupmenu1,'string');{'roberts'}]);
set(handles.popupmenu1,'string',[get(handles.popupmenu1,'string');{'prewitt'}]);
set(handles.popupmenu1,'string',[get(handles.popupmenu1,'string');{'sobel'}]);
% Get all the button objects in the GUI window except button1.
all_buttons = findobj(gcf, 'Type', 'uicontrol', 'Style', 'pushbutton', '-not', 'Tag', get(handles.pushbutton1, 'Tag'));
set(all_buttons, 'Enable', 'off');

% Update handles structure
guidata(hObject, handles);




% --- Outputs from this function are returned to the command line.
function varargout = ESHAPE_OutputFcn(~, ~, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in pushbutton1.
function pushbutton1_Callback(hObject, ~, handles)
% hObject    handle to pushbutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
pathname = uigetdir;
handles.numofpics = 0;
if(pathname ~=0 )
    handles.pathname = pathname;
    D1 = dir([handles.pathname,'/*.jpg']);
    D2 = dir([handles.pathname,'/*.png']);
    D3 = dir([handles.pathname,'/*.tif']);
    D4 = dir([handles.pathname,'/*.bmp']);
    D = [D1;D2;D3;D4];
    if numel(D)> 0
        for n=1:numel(D)
            if n==1
                set(handles.popupmenu2,'string',{D(n).name});
            else
                set(handles.popupmenu2,'string',[get(handles.popupmenu2,'string');{D(n).name}]);
            end
        end
    end
    handles.numofpics = numel(D);
end
% delete(handles.ai);
guidata(hObject, handles);


% --- Executes during object creation, after setting all properties.
function edit1_CreateFcn(hObject, ~, ~)
% hObject    handle to edit1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on mouse press over axes background.
function axes1_ButtonDownFcn(hObject, eventdata, handles)
% hObject    handle to axes1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

guidata(hObject, handles);




% --- Executes on mouse press over axes background.
function axes3_refresh(hObject, ~, handles)
% hObject    handle to axes2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

guidata(hObject, handles);





% --- Executes on mouse press over figure background, over a disabled or
% --- inactive control, or over an axes background.
function figure1_WindowButtonDownFcn(hObject, ~, handles)
% hObject    handle to figure1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% disp(['figure1_WindowButtonDownFcn ',get(gcbf,'SelectionType')]);
ptf = get(gcf,'CurrentPoint');%view Properties Setting
pta = get(gca,'CurrentPoint');%axes Properties Setting
% disp(['gcf position: ',num2str(ptf(1)),' ',num2str(ptf(2))]);
% disp(['pta position: ',num2str(pta(1,1)),' ',num2str(pta(1,2))]);
handles.cursor_gcfst = ptf(1:2);% starting point
handles.cursor_gcast = pta(1,1:2);
handles.buttonstatus = 1;
handles.tracecount = 0;
pt = ptf;

areaflag = 0;
if(pt(1) > handles.axes6_pt(1) && pt(1) < (handles.axes6_pt(1)+handles.axes6_pt(3)))
    if(pt(2) > handles.axes6_pt(2) && pt(2) < (handles.axes6_pt(2)+handles.axes6_pt(4)))
        areaflag = 6;
    end
end
typestr = get(gcbf,'SelectionType'); %Determine if it is a left key press
if(handles.isaxis6dataready == 1 && areaflag == 6) 
    if (strcmp(typestr,'normal')==1)      
        % start moving image
        handles.isMoving = true;
        handles.prevMousePos = get(gca, 'CurrentPoint');
    end
end
if(handles.isaxis4dataready == 1 && areaflag==4)    
    if(strcmp(typestr, 'alt')==1)
        handles.isMoving4 = true;
        handles.prevMousePos4 = get(gca, 'CurrentPoint');
    end
end
guidata(hObject, handles);


function figure1_WindowKeyPressFcn(hObject, ~, handles)

function figure1_ButtonDownFcn (hObject, ~, handles)

% --- Executes on mouse press over figure background, over a disabled or
% --- inactive control, or over an axes background.
function figure1_WindowButtonUpFcn(hObject, ~, handles)
% hObject    handle to figure1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
typestr = get(gcbf,'SelectionType');
% disp(['figure1_WindowButtonUpFcn',typestr]);
ptf = get(gcf,'CurrentPoint');
pta = get(gca,'CurrentPoint');
handles.cursor_gcfed = ptf(1:2);%ending point 
handles.cursor_gcaed = pta(1,1:2);
handles.buttonstatus = 0;
pt = ptf;
% disp(num2str(handles.axis1_nrows));
areaflag = 0;
if(pt(1) > handles.axes6_pt(1) && pt(1) < (handles.axes6_pt(1)+handles.axes6_pt(3)))
    if(pt(2) > handles.axes6_pt(2) && pt(2) < (handles.axes6_pt(2)+handles.axes6_pt(4)))
        areaflag = 6;
    end
end

if(pt(1) > handles.axes3_pt(1) && pt(1) < (handles.axes3_pt(1)+handles.axes3_pt(3)))
    if(pt(2) > handles.axes3_pt(2) && pt(2) < (handles.axes3_pt(2)+handles.axes3_pt(4)))
        areaflag = 3;
    end
end
if(pt(1) > handles.axes4_pt(1) && pt(1) < (handles.axes4_pt(1)+handles.axes4_pt(3)))
    if(pt(2) > handles.axes4_pt(2) && pt(2) < (handles.axes4_pt(2)+handles.axes4_pt(4)))
        areaflag = 4;
    end
end


if(handles.isaxis6dataready == 1 && areaflag == 6) 
    if (strcmp(typestr,'normal')==1 && handles.isMoving==true)   
        % stop moving image
        currMousePos = get(gca, 'CurrentPoint');
        deltaPos = currMousePos - handles.prevMousePos;
        % update      
        axes(handles.axes6);  
        if(handles.axis1_rowst+1-deltaPos(1, 2)>0 && handles.axis1_rowst+handles.axis1_nrows-deltaPos(1, 2) < handles.jpgnrows &&  handles.axis1_colst+1-deltaPos(1, 1)>0 && handles.axis1_colst+handles.axis1_ncols-deltaPos(1, 1) < handles.jpgncols)
%             if(handles.axis1_nrows >= currMousePos(2) && handles.axis1_ncols >= currMousePos(1))
                axis6viewdata = handles.imdata(handles.axis1_rowst+1-deltaPos(1, 2):handles.axis1_rowst+handles.axis1_nrows-deltaPos(1, 2),handles.axis1_colst+1-deltaPos(1, 1):handles.axis1_colst+handles.axis1_ncols-deltaPos(1, 1),:);
                handles.axes6handle = imshow(axis6viewdata);
                handles.axis1_rowst = handles.axis1_rowst-deltaPos(1, 2);      %start row from the original picture
                handles.axis1_colst = handles.axis1_colst-deltaPos(1, 1);      %start col from the original picture
%             end
        elseif(handles.axis1_rowst+1-deltaPos(1, 2)<=0 && handles.axis1_rowst+handles.axis1_nrows-deltaPos(1, 2) < handles.jpgnrows &&  handles.axis1_colst+1-deltaPos(1, 1)>0 && handles.axis1_colst+handles.axis1_ncols-deltaPos(1, 1) < handles.jpgncols)
            axis6viewdata = handles.imdata(1:handles.axis1_nrows,handles.axis1_colst+1-deltaPos(1, 1):handles.axis1_colst+handles.axis1_ncols-deltaPos(1, 1),:);
            handles.axes6handle = imshow(axis6viewdata);
%             handles.deltaPos(1,1)=deltaPos(1,1);
%             handles.deltaPos(1,2)=handles.axis1_rowst;
            handles.axis1_rowst = 0;      %start row from the original picture
            handles.axis1_colst = handles.axis1_colst-deltaPos(1, 1);      %start col from the original picture
        elseif(handles.axis1_rowst+1-deltaPos(1, 2)<=0 && handles.axis1_colst+1-deltaPos(1, 1)<=0)
            axis6viewdata = handles.imdata(1:handles.axis1_nrows,1:handles.axis1_ncols,:);
            handles.axes6handle = imshow(axis6viewdata);
%             handles.deltaPos(1,1)=handles.axis1_colst;
%             handles.deltaPos(1,2)=handles.axis1_rowst;
            handles.axis1_rowst = 0;      %start row from the original picture
            handles.axis1_colst = 0;      %start col from the original picture
        elseif(handles.axis1_rowst+1-deltaPos(1, 2)<=0 && handles.axis1_colst+handles.axis1_ncols-deltaPos(1, 1) >= handles.jpgncols)
            axis6viewdata = handles.imdata(1:handles.axis1_nrows,handles.jpgncols-handles.axis1_ncols:handles.jpgncols,:);
            handles.axes6handle = imshow(axis6viewdata);
%             handles.deltaPos(1,1)=handles.axis1_colst+handles.axis1_ncols-handles.jpgncols;
%             handles.deltaPos(1,2)=handles.axis1_rowst;
            handles.axis1_rowst = 0;      %start row from the original picture
            handles.axis1_colst = handles.jpgncols-handles.axis1_ncols-1;      %start col from the original picture
        elseif(handles.axis1_rowst+handles.axis1_nrows-deltaPos(1, 2) >= handles.jpgnrows &&  handles.axis1_colst+1-deltaPos(1, 1)>0 && handles.axis1_colst+handles.axis1_ncols-deltaPos(1, 1) < handles.jpgncols)
            axis6viewdata = handles.imdata(handles.jpgnrows-handles.axis1_nrows:handles.jpgnrows,handles.axis1_colst+1-deltaPos(1, 1):handles.axis1_colst+handles.axis1_ncols-deltaPos(1, 1),:);
            handles.axes6handle = imshow(axis6viewdata);
%             handles.deltaPos(1,1)=deltaPos(1,1);
%             handles.deltaPos(1,2)=handles.axis1_rowst+handles.axis1_nrows-handles.jpgnrows;
            handles.axis1_rowst = handles.jpgnrows-handles.axis1_nrows-1;      %start row from the original picture
            handles.axis1_colst = handles.axis1_colst-deltaPos(1, 1);      %start col from the original picture 
        elseif(handles.axis1_rowst+handles.axis1_nrows-deltaPos(1, 2) >= handles.jpgnrows &&  handles.axis1_colst+1-deltaPos(1, 1)<=0)
            axis6viewdata = handles.imdata(handles.jpgnrows-handles.axis1_nrows:handles.jpgnrows,1:handles.axis1_ncols,:);
            handles.axes6handle = imshow(axis6viewdata);
%             handles.deltaPos(1,1)=handles.axis1_colst;
%             handles.deltaPos(1,2)=handles.axis1_rowst+handles.axis1_nrows-handles.jpgnrows;
            handles.axis1_rowst = handles.jpgnrows-handles.axis1_nrows-1;      %start row from the original picture
            handles.axis1_colst = 0;      %start col from the original picture  
        elseif(handles.axis1_rowst+handles.axis1_nrows-deltaPos(1, 2) >= handles.jpgnrows &&  handles.axis1_colst+1-deltaPos(1, 1)>= handles.jpgncols)
            axis6viewdata = handles.imdata(handles.jpgnrows-handles.axis1_nrows:handles.jpgnrows,handles.jpgncols-handles.axis1_ncols:handles.jpgncols,:);
            handles.axes6handle = imshow(axis6viewdata);
%             handles.deltaPos(1,1)=handles.axis1_colst+handles.axis1_ncols-handles.jpgncols;
%             handles.deltaPos(1,2)=handles.axis1_rowst+handles.axis1_nrows-handles.jpgnrows;
            handles.axis1_rowst = handles.jpgnrows-handles.axis1_nrows-1;      %start row from the original picture
            handles.axis1_colst = handles.jpgncols-handles.axis1_ncols-1;      %start col from the original picture  
        elseif(handles.axis1_rowst+1-deltaPos(1, 2)>0 && handles.axis1_rowst+handles.axis1_nrows-deltaPos(1, 2) < handles.jpgnrows &&   handles.axis1_colst+handles.axis1_ncols-deltaPos(1, 1) >= handles.jpgncols)
            axis6viewdata = handles.imdata(handles.axis1_rowst+1-deltaPos(1, 2):handles.axis1_rowst+handles.axis1_nrows-deltaPos(1, 2),handles.jpgncols-handles.axis1_ncols:handles.jpgncols,:);
            handles.axes6handle = imshow(axis6viewdata);
%             handles.deltaPos(1,1)=handles.axis1_colst+handles.axis1_ncols-handles.jpgncols;
%             handles.deltaPos(1,2)=deltaPos(1,2);
            handles.axis1_rowst = handles.axis1_rowst-deltaPos(1, 2);      %start row from the original picture
            handles.axis1_colst = handles.jpgncols-handles.axis1_ncols-1;      %start col from the original picture  
        elseif(handles.axis1_rowst+1-deltaPos(1, 2)>0 && handles.axis1_rowst+handles.axis1_nrows-deltaPos(1, 2) < handles.jpgnrows &&   handles.axis1_colst+1-deltaPos(1, 1)<=0)
            axis6viewdata = handles.imdata(handles.axis1_rowst+1-deltaPos(1, 2):handles.axis1_rowst+handles.axis1_nrows-deltaPos(1, 2),1:handles.axis1_ncols,:);
            handles.axes6handle = imshow(axis6viewdata);
%             handles.deltaPos(1,1)=handles.axis1_colst;
%             handles.deltaPos(1,2)=deltaPos(1,2);
            handles.axis1_rowst = handles.axis1_rowst-deltaPos(1, 2);      %start row from the original picture
            handles.axis1_colst = 0;      %start col from the original picture  
        end
        handles.isMoving = false;

    end
end

if(handles.isaxis3dataready == 1 && areaflag == 4)%edit axes4 
    %axes2_refresh(hObject, eventdata, handles);
    cursor_st = handles.cursor_gcfst;%
    cursor_ed = handles.cursor_gcfed;
    axis4_nrows = handles.axis4_nrows;
    axis4_ncols = handles.axis4_ncols;
    axis4_rowst = handles.axis4_rowst;%starting point
    axis4_colst = handles.axis4_colst;
    flag = 1;
    if(cursor_st(1) == cursor_ed(1) && cursor_st(2) == cursor_ed(2)) % the same point
        flag = 0;
    end
    if(flag == 1)
        if(strcmp(typestr,'normal')==1)
            tracebuffer = handles.tracebuffer;
            tracecount = 1;
            delta = min(handles.axes4_pt(4)/axis4_nrows,handles.axes4_pt(3)/axis4_ncols); %scale factor
            for n=2:handles.tracecount
                rowgap = handles.tracebuffer(n,1)-handles.tracebuffer(n-1,1);
                colgap = handles.tracebuffer(n,2)-handles.tracebuffer(n-1,2);
                if(abs(rowgap) > 1 || abs(colgap) > 1)
                    if(abs(rowgap) >= abs(colgap))
                        rowvecto = rowgap/abs(rowgap);
                        for m=1:fix(abs(rowgap)/delta)+1
                            rowinst = handles.tracebuffer(n-1,1) + m*delta*rowvecto;
                            colinst = handles.tracebuffer(n-1,2) + m*delta*colgap*rowvecto/rowgap;
                            tracecount = tracecount + 1;
                            tracebuffer(tracecount,:) = [rowinst,colinst];
                        end
                        tracecount = tracecount + 1;
                        tracebuffer(tracecount,:) = handles.tracebuffer(n,:);
                    else
                        colvecto = colgap/abs(colgap);
                        for m=1:fix(abs(colgap)/delta)+1
                            rowinst = handles.tracebuffer(n-1,1) + m*delta*rowgap*colvecto/colgap;
                            colinst = handles.tracebuffer(n-1,2) + m*delta*colvecto;
                            tracecount = tracecount + 1;
                            tracebuffer(tracecount,:) = [rowinst,colinst];
                        end
                        tracecount = tracecount + 1;
                        tracebuffer(tracecount,:) = handles.tracebuffer(n,:);
                    end
                end
            end
            handles.tracebuffer = tracebuffer;
            handles.tracecount = tracecount;
            for n=1:handles.tracecount
                current_pt = handles.tracebuffer(n,:);
                if(axis4_nrows >= axis4_ncols)
                    axis4_row_ratio = 1 - (current_pt(2) - handles.axes4_pt(2))/handles.axes4_pt(4);
                    rowidx = handles.axis4_rowst + fix(axis4_row_ratio*axis4_nrows);
                    axis4_col_ratio = (current_pt(1) - handles.axes4_pt(1))/handles.axes4_pt(3);
                    colidx = handles.axis4_colst + fix(axis4_col_ratio*axis4_nrows) - fix((axis4_nrows - axis4_ncols)/2);
                else
                    axis4_row_ratio = 1 - (current_pt(2) - handles.axes4_pt(2))/handles.axes4_pt(4);
                    rowidx = handles.axis4_rowst + fix(axis4_row_ratio*axis4_ncols) - fix((axis4_ncols - axis4_nrows)/2);
                    axis4_col_ratio = (current_pt(1) - handles.axes4_pt(1))/handles.axes4_pt(3);
                    colidx = handles.axis4_colst + fix(axis4_col_ratio*axis4_ncols);
                end
                handles.daseboard(rowidx+1,colidx+1) = 1;
            end
            [nrows,ncols] = size(handles.daseboard);
            %axes(handles.axes2);
            %imshow(imlincomb(1,handles.axes2graydata,1,uint8(255*handles.daseboard)));
            axes(handles.axes3);
            %         cla(handles.axes3)
            handles.axes3handle = imshow(handles.daseboard);
            axis4viewdata = handles.daseboard(axis4_rowst+1:min(axis4_rowst+axis4_nrows,nrows),axis4_colst+1:min(axis4_colst+axis4_ncols,ncols));
            axes(handles.axes4);
            handles.axes4handle = imshow(axis4viewdata);
        end
    else
        if(strcmp(typestr,'open')==1)
            [nrows,ncols] = size(handles.daseboard);
            if(axis4_nrows >= axis4_ncols)
                axis4_row_ratio = 1 - (cursor_ed(2) - handles.axes4_pt(2))/handles.axes4_pt(4);
                rowidx = handles.axis4_rowst + fix(axis4_row_ratio*axis4_nrows);
                axis4_col_ratio = (cursor_ed(1) - handles.axes4_pt(1))/handles.axes4_pt(3);
                colidx = handles.axis4_colst + fix(axis4_col_ratio*axis4_nrows) - fix((axis4_nrows - axis4_ncols)/2);
            else
                axis4_row_ratio = 1 - (cursor_ed(2) - handles.axes4_pt(2))/handles.axes4_pt(4);
                rowidx = handles.axis4_rowst + fix(axis4_row_ratio*axis4_ncols) - fix((axis4_ncols - axis4_nrows)/2);
                axis4_col_ratio = (cursor_ed(1) - handles.axes4_pt(1))/handles.axes4_pt(3);
                colidx = handles.axis4_colst + fix(axis4_col_ratio*axis4_ncols);
            end
            handles.daseboard(rowidx+1,colidx+1) = ~handles.daseboard(rowidx+1,colidx+1);
            %axes(handles.axes2);
            %imshow(imlincomb(1,handles.axes2graydata,1,uint8(255*handles.daseboard)));
            axes(handles.axes3);
            %         cla(handles.axes3)
            handles.axes3handle = imshow(handles.daseboard);
            axis4viewdata = handles.daseboard(axis4_rowst+1:min(axis4_rowst+axis4_nrows,nrows),axis4_colst+1:min(axis4_colst+axis4_ncols,ncols));
            axes(handles.axes4);
            handles.axes4handle = imshow(axis4viewdata);
            firstflag = 0;
            for n=max(rowidx-2,1):min(rowidx+4,nrows)
                for m = max(colidx-2,1):min(colidx+4,ncols) 
                    if(firstflag==0 && handles.daseboard(n,m)==1)
                        firstflag = 1;
                        handles.chaincode_rowst = n;
                        handles.chaincode_colst = m;
                        handles.chaincode_udf = 1;
                    end
                end
            end
        end
        if(strcmp(typestr,'normal')==1)
            [nrows,ncols] = size(handles.daseboard);
            if(axis4_nrows >= axis4_ncols)
                axis4_row_ratio = 1 - (cursor_ed(2) - handles.axes4_pt(2))/handles.axes4_pt(4);
                rowidx = handles.axis4_rowst + fix(axis4_row_ratio*axis4_nrows);
                axis4_col_ratio = (cursor_ed(1) - handles.axes4_pt(1))/handles.axes4_pt(3);
                colidx = handles.axis4_colst + fix(axis4_col_ratio*axis4_nrows) - fix((axis4_nrows - axis4_ncols)/2);
            else
                axis4_row_ratio = 1 - (cursor_ed(2) - handles.axes4_pt(2))/handles.axes4_pt(4);
                rowidx = handles.axis4_rowst + fix(axis4_row_ratio*axis4_ncols) - fix((axis4_ncols - axis4_nrows)/2);
                axis4_col_ratio = (cursor_ed(1) - handles.axes4_pt(1))/handles.axes4_pt(3);
                colidx = handles.axis4_colst + fix(axis4_col_ratio*axis4_ncols);
            end
            %disp([num2str(rowidxst),' ',num2str(rowidxed),' ',num2str(colidxst),' ',num2str(colidxed)]);
            handles.daseboard(rowidx+1,colidx+1) = ~handles.daseboard(rowidx+1,colidx+1);
            %axes(handles.axes2);
            %imshow(imlincomb(1,handles.axes2graydata,1,uint8(255*handles.daseboard)));
            axes(handles.axes3);
            %         cla(handles.axes3)
            handles.axes3handle = imshow(handles.daseboard);
            axis4viewdata = handles.daseboard(axis4_rowst+1:min(axis4_rowst+axis4_nrows,nrows),axis4_colst+1:min(axis4_colst+axis4_ncols,ncols));
            axes(handles.axes4);
            handles.axes4handle = imshow(axis4viewdata);
        end
    end
end

guidata(hObject, handles);


% --- Executes on selection change in listbox1.
function listbox1_Callback(hObject, eventdata, handles)
% hObject    handle to listbox1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox1 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox1


% --- Executes during object creation, after setting all properties.
function listbox1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on slider movement.
function slider1_Callback(hObject, eventdata, handles)
% hObject    handle to slider1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
minvalue = get(hObject,'Min');
maxvalue = get(hObject,'Max');
value = get(hObject,'Value');
handles.threshvalue = 0.99*(value-minvalue)/(maxvalue-minvalue);
guidata(hObject, handles);

% --- Executes during object creation, after setting all properties.
function slider1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on selection change in popupmenu1.
function popupmenu1_Callback(hObject, eventdata, handles)
% hObject    handle to popupmenu1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns popupmenu1 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popupmenu1


% --- Executes during object creation, after setting all properties.
function popupmenu1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmenu1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called
% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton2.
function pushbutton2_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
cla(handles.axes3);
strs = get(handles.popupmenu1,'String');
popup_sel_index = get(handles.popupmenu1, 'Value');
methodstr = strs{popup_sel_index};
if(handles.isaxis1dataready == 1)
    handles.daseboard = edge(handles.axes1graydata,methodstr,handles.threshvalue);
    handles.userboard = handles.daseboard;
    %         axes(handles.axes2);
    %         imshow(imlincomb(1,handles.axes2graydata,1,uint8(255*handles.daseboard)));
    
    axes(handles.axes3);
    %         cla(handles.axes3)
    handles.axes3handle = imshow(handles.daseboard(handles.axis1_rowst+1:handles.axis1_rowst+handles.axis1_nrows,handles.axis1_colst+1:handles.axis1_colst+handles.axis1_ncols));
    axes(handles.axes4);
    handles.axes4handle = imshow(handles.daseboard);
    [nrows,ncols] = size(handles.daseboard);
    handles.axis4_rowst = 0;
    handles.axis4_colst = 0;
    handles.axis4_nrows = nrows;
    handles.axis4_ncols = ncols;
    handles.isaxis3dataready = 1;
    handles.isaxis4dataready = 1;
    handles.ischaindataready = 0;
    handles.chaincode_rowst = 0;
    handles.chaincode_colst = 0;
    handles.chaincode_udf = 0;
end
guidata(hObject, handles);




% --- Executes on button press in pushbutton4.
function pushbutton4_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles.ischaindataused = 0;
if(handles.ischaindataready == 1 && handles.ischaindataused == 0)
%     disp(1)
    id_full=get(handles.edit14,'String');
    handles.idFullLeaf=id_full;
%     disp(handles.idFullLeaf)
    writeDataToFile(handles.boundary,['results/' handles.filename(1:end-4) '_' id_full '_b.txt']);
    chainfilename = ['results/',handles.filename(1:end-4),'_',id_full,'_c.txt'];
    writeDataToFile(handles.chain_code,chainfilename);
       
    id_full=get(handles.edit14,'String');
    imwrite(handles.daseboard,  ['label','/',handles.filename(1:end-4),'_',id_full,'.png'],'Compression', 'none');
    handles.ischaindataready = 0;
    
    
    x1=get(handles.edit9,'String');
    y1=get(handles.edit10,'String');
    x2=get(handles.edit11,'String');
    y2=get(handles.edit12,'String');
    x1=str2num(x1);y1=str2num(y1);
    x2=str2num(x2);y2=str2num(y2);
    dis_t=get(handles.edit13,'String');

    % Check if the text is number
    if isempty(dis_t) || isnan(str2double(dis_t)) || isequal(dis_t, 'NaN')
        disp('Incorrect input type');
        msgbox('Please enter the number in the text box');

    else
        
        dis=str2double(dis_t);
        pixel=sqrt((x1-x2)*(x1-x2)+(y1-y2)*(y1-y2));
        dis_pixel=pixel/dis;
        dis_mm=dis/pixel;
        handles.dis_pixel=dis_pixel;
        handles.dis_mm=dis_mm;
        disp(handles.dis_pixel)
        disp(handles.dis_mm)
      
        results = cell(2,7);
        if(handles.unit ==1)
            results(1,:) = [{'filepath'},{'scale:pixels/mm'},{'scale:mm/pixel'},{'circumference:pixel'},{'area:pixel'},{'circumference:mm'},{'area:mm^2'}];
        elseif( handles.unit==2)
            results(1,:) = [{'filepath'},{'scale:pixels/inch'},{'scale:inch/pixel'},{'circumference:pixel'},{'areaixel'},{'circumference:inch'},{'area:inch^2'}];
        end
    %     val = get(handles.popupmenu2,'value');  
    %     list = get(handles.popupmenu2,'string'); 
    %     temp=list{val};
        temp=handles.filename;
        results(2,1)={[temp(1:end-4) '_' handles.idFullLeaf]};
        results(2,2)={handles.dis_pixel};
        results(2,3)={handles.dis_mm};
        [area,circumference]=cal_area_c(handles.chain_code);
        results(2,4)={circumference};
        results(2,5)={area};
        results(2,6)={circumference*handles.dis_mm};
        results(2,7)={area*handles.dis_mm*handles.dis_mm};
    %     id_full=get(handles.edit14,'String');
        % disp(temp)
        xlswrite(['/results/' temp(1:end-4) '_' handles.idFullLeaf '_info.xlsx'],results,'Sheet1');
    end
    
    set(handles.pushbutton28, 'Enable', 'on'); 
%     set(handles.pushbutton30, 'Enable', 'on'); 

else
    disp('Chain code is null. /Chain code is not closed.');
    msgbox('Chain code is null. /Chain code is not closed.');
end

guidata(hObject, handles);


% --- Executes on button press in pushbutton5.
function pushbutton5_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
if handles.usercheck > 0
    [filename, pathname] = uigetfile('*.xlsx', 'Pick a excel file');
    xlswrite([pathname,'\',filename],handles.results,'Sheet1');
end

guidata(hObject, handles);



function edit2_Callback(hObject, eventdata, handles)
% hObject    handle to edit2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit2 as text
%        str2double(get(hObject,'String')) returns contents of edit2 as a double


% --- Executes during object creation, after setting all properties.
function edit2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in popupmenu2.
function popupmenu2_Callback(hObject, eventdata, handles)
% hObject    handle to popupmenu2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns popupmenu2 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popupmenu2
handles.strs = get(handles.popupmenu2,'String');
if(iscell(handles.strs))
    handles.popup_sel_index = get(handles.popupmenu2, 'Value');
    handles.filename = strrep(handles.strs{handles.popup_sel_index},'*','');
    if handles.filename ~= 0
        handles.imdata = imread([handles.pathname,'/',handles.filename]);
        [nrows,ncols,~] = size(handles.imdata);
%         disp(size(handles.imdata));
%         handles.axes1graydata = graydata;
        handles.jpgnrows = nrows;   %rows of the original picture
        handles.jpgncols = ncols;   %cols of the original picture
        handles.axis1_nrows = handles.axes6_pt(4);    %rows of axis veiw area
        handles.axis1_ncols = handles.axes6_pt(3);    %cols of axis veiw area
        axis1_rowst = fix((handles.jpgnrows - handles.axis1_nrows)/2);
        axis1_colst = fix((handles.jpgncols - handles.axis1_ncols)/2);
        handles.axis1_rowst = axis1_rowst;      %start row from the original picture
        handles.axis1_colst = axis1_colst;      %start col from the original picture
        handles.axis1_row_ratio = 1.0;
        handles.axis1_col_ratio = 1.0;
        axis6viewdata = handles.imdata(axis1_rowst+1:axis1_rowst+handles.axis1_nrows,axis1_colst+1:axis1_colst+handles.axis1_ncols,:);
        axes(handles.axes6);
        handles.axes6handle = imshow(axis6viewdata);
        cla(handles.axes1);
        cla(handles.axes3);
        cla(handles.axes4);
%         handles.chain_code = [];
        handles.isaxis1dataready = 1;
        handles.isaxis2dataready = 0;
        handles.isaxis3dataready = 0;
        handles.isaxis4dataready = 0;
        handles.ischaindataready = 0;
        handles.ischaindataused = 0;
        handles.isaxis6dataready= 1;
    end
end
set(handles.pushbutton20, 'Enable', 'on');  
set(handles.pushbutton21, 'Enable', 'on'); 
set(handles.pushbutton22, 'Enable', 'on'); 
set(handles.pushbutton29, 'Enable', 'on');  
guidata(hObject, handles);

% --- Executes during object creation, after setting all properties.
function popupmenu2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmenu2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function update_axes6_func(hObject, pt, handles)
% handles.jpgnrows = nrows;   %rows of the original picture
% handles.jpgncols = ncols;   %cols of the original picture
% handles.axis1_nrows = handles.axes6_pt(4);    %rows of axis veiw area
% handles.axis1_ncols = handles.axes6_pt(3);    %cols of axis veiw area
% handles.axis1_rowst = axis1_rowst;      %start row from the original picture
% handles.axis1_colst = axis1_colst;      %start col from the original picture
scale = 2^(handles.jpgscale/2);
axis1_nrows = fix(handles.axes6_pt(4) * scale);
axis1_ncols = fix(handles.axes6_pt(3) * scale);
if(axis1_nrows < handles.jpgnrows && axis1_ncols < handles.jpgncols)
    if(axis1_nrows >= handles.axes6_pt(4) && axis1_ncols >= handles.axes6_pt(3))
%         disp(['view rows:',num2str(axis1_nrows),' cols:',num2str(axis1_ncols)]);
%         disp(num2str(scale));
        axis1_col_ratio = (pt(1) - handles.axes6_pt(1)) / handles.axes6_pt(3);
        axis1_row_ratio = 1 - (pt(2) - handles.axes6_pt(2)) / handles.axes6_pt(4);
        axis1_colst = max(handles.axis1_colst - fix(axis1_ncols * axis1_col_ratio - handles.axis1_ncols * axis1_col_ratio),0);
        axis1_rowst = max(handles.axis1_rowst - fix(axis1_nrows * axis1_row_ratio - handles.axis1_nrows * axis1_row_ratio),0);
        axis1_nrows = min(axis1_rowst+axis1_nrows,handles.jpgnrows) - axis1_rowst;
        axis1_ncols = min(axis1_colst+axis1_ncols,handles.jpgncols) - axis1_colst;
        handles.axis1_rowst = axis1_rowst;      %start row from the original picture
        handles.axis1_colst = axis1_colst;      %start col from the original picture
        axis6viewdata = handles.imdata(axis1_rowst+1:axis1_rowst+axis1_nrows,axis1_colst+1:axis1_colst+axis1_ncols,:);
        handles.axis1_nrows = axis1_nrows;      %rows of axis veiw area
        handles.axis1_ncols = axis1_ncols;      %cols of axis veiw area
        axes(handles.axes6);
        handles.axes6handle = imshow(axis6viewdata);
    end
end
guidata(hObject, handles);



% --- Executes on scroll wheel click while the figure is in focus.
function figure1_WindowScrollWheelFcn(hObject, eventdata, handles)
% hObject    handle to figure1 (see GCBO)
% eventdata  structure with the following fields (see MATLAB.UI.FIGURE)
%	VerticalScrollCount: signed integer indicating direction and number of clicks
%	VerticalScrollAmount: number of lines scrolled for each click
% handles    structure with handles and user data (see GUIDATA)
% disp(['figure1_WindowScrollWheelFcn ',num2str(eventdata.VerticalScrollCount)]);
pt = get(gcf,'CurrentPoint');
% disp(num2str(handles.axis1_nrows));
areaflag = 0;
if(pt(1) > handles.axes6_pt(1) && pt(1) < (handles.axes6_pt(1)+handles.axes6_pt(3)))
    if(pt(2) > handles.axes6_pt(2) && pt(2) < (handles.axes6_pt(2)+handles.axes6_pt(4)))
        areaflag = 6;
    end
end

if(pt(1) > handles.axes3_pt(1) && pt(1) < (handles.axes3_pt(1)+handles.axes3_pt(3)))
    if(pt(2) > handles.axes3_pt(2) && pt(2) < (handles.axes3_pt(2)+handles.axes3_pt(4)))
        areaflag = 3;
    end
end
if(pt(1) > handles.axes4_pt(1) && pt(1) < (handles.axes4_pt(1)+handles.axes4_pt(3)))
    if(pt(2) > handles.axes4_pt(2) && pt(2) < (handles.axes4_pt(2)+handles.axes4_pt(4)))
        areaflag = 4;
    end
end

if(handles.isaxis6dataready == 1 && areaflag == 6)
%     handles.axes6_pt
    jpgscale = max(handles.jpgscale + eventdata.VerticalScrollCount,0);
    scale = 2^(jpgscale/2);
    axis1_nrows = fix(handles.axes6_pt(4) * scale);
    axis1_ncols = fix(handles.axes6_pt(3) * scale);
%     disp(handles.jpgnrows )
    if(axis1_nrows < 2*handles.jpgnrows && axis1_nrows>=handles.axes6_pt(4))
        handles.jpgscale = jpgscale;
    end
    if(axis1_nrows < handles.jpgnrows && axis1_ncols < handles.jpgncols)
        if(axis1_nrows >= handles.axes6_pt(4) && axis1_ncols >= handles.axes6_pt(3))
            %         disp(['view rows:',num2str(axis1_nrows),' cols:',num2str(axis1_ncols)]);
            %         disp(num2str(scale));
            axis1_col_ratio = (pt(1) - handles.axes6_pt(1)) / handles.axes6_pt(3);
            axis1_row_ratio = 1 - (pt(2) - handles.axes6_pt(2)) / handles.axes6_pt(4);
            axis1_colst = max(handles.axis1_colst - fix(axis1_ncols * axis1_col_ratio - handles.axis1_ncols * axis1_col_ratio),0);
            axis1_rowst = max(handles.axis1_rowst - fix(axis1_nrows * axis1_row_ratio - handles.axis1_nrows * axis1_row_ratio),0);
            axis1_nrows = min(axis1_rowst+axis1_nrows,handles.jpgnrows) - axis1_rowst;
            axis1_ncols = min(axis1_colst+axis1_ncols,handles.jpgncols) - axis1_colst;
            handles.axis1_rowst = axis1_rowst;      %start row from the original picture
            handles.axis1_colst = axis1_colst;      %start col from the original picture
            axis6viewdata = handles.imdata(axis1_rowst+1:axis1_rowst+axis1_nrows,axis1_colst+1:axis1_colst+axis1_ncols,:);
                                   
            
%             disp(size(axis6viewdata));
            handles.axis1_nrows = axis1_nrows;      %rows of axis veiw area
            handles.axis1_ncols = axis1_ncols;      %cols of axis veiw area
            handles.axis1_row_ratio=axis1_row_ratio;
            handles.axis1_col_ratio=axis1_col_ratio;
            axes(handles.axes6);
            handles.axes6handle = imshow(axis6viewdata);           
%             save axis6viewdata axis6viewdata
%             disp(1)
        end
    else
        handles.axis1_rowst = 0;      %start row from the original picture
        handles.axis1_colst = 0;      %start col from the original picture
        handles.axis1_nrows = handles.jpgnrows;      %rows of axis veiw area
        handles.axis1_ncols = handles.jpgncols;      %cols of axis veiw area
        axes(handles.axes6);
        handles.axes6handle = imshow(handles.imdata);
    end
end
if(handles.isaxis3dataready == 1 && areaflag == 4)
    %disp('in area axis4, ready to go!');
    bmpscale = max(handles.bmpscale + eventdata.VerticalScrollCount,-8);%
    scale = 2^(bmpscale/2);
    axis4_nrows = fix(handles.axes4_pt(4) * scale);
    axis4_ncols = fix(handles.axes4_pt(3) * scale);
    %disp([num2str(axis4_nrows),' ',num2str(axis4_ncols)]);
    [nrows,ncols] = size(handles.daseboard);
    if(axis4_nrows < 2*nrows && axis4_nrows > 0)
        handles.bmpscale = bmpscale;
    end
    if(axis4_nrows < nrows && axis4_ncols < ncols)
        if(axis4_nrows > 0 && axis4_ncols > 0)
            axis4_col_ratio = (pt(1) - handles.axes4_pt(1)) / handles.axes4_pt(3);
            axis4_row_ratio = 1 - (pt(2) - handles.axes4_pt(2)) / handles.axes4_pt(4);
            axis4_colst = max(handles.axis4_colst - fix(axis4_ncols * axis4_col_ratio - handles.axis4_ncols * axis4_col_ratio),0);
            axis4_rowst = max(handles.axis4_rowst - fix(axis4_nrows * axis4_row_ratio - handles.axis4_nrows * axis4_row_ratio),0);
            axis4_nrows = min(axis4_rowst+axis4_nrows,nrows) - axis4_rowst;
            axis4_ncols = min(axis4_colst+axis4_ncols,ncols) - axis4_colst;
            handles.axis4_rowst = axis4_rowst;      %start row from the original picture
            handles.axis4_colst = axis4_colst;      %start col from the original picture
            axis4viewdata = handles.daseboard(axis4_rowst+1:axis4_rowst+axis4_nrows,axis4_colst+1:axis4_colst+axis4_ncols);
            handles.axis4_nrows = axis4_nrows;      %rows of axis veiw area
            handles.axis4_ncols = axis4_ncols;      %cols of axis veiw area
            axes(handles.axes4);
            handles.axes4handle = imshow(axis4viewdata);
        end
    else
        handles.axis4_rowst = 0;      %start row from the original picture
        handles.axis4_colst = 0;      %start col from the original picture
        handles.axis4_nrows = nrows;      %rows of axis veiw area
        handles.axis4_ncols = ncols;      %cols of axis veiw area
        axes(handles.axes4);
        handles.axes4handle = imshow(handles.daseboard);
    end
end
guidata(hObject, handles);


% --- Executes on mouse motion over figure - except title and menu.
function figure1_WindowButtonMotionFcn(hObject, eventdata, handles)
% hObject    handle to figure1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% disp('figure1_WindowButtonMotionFcn');
pt = get(gcf,'CurrentPoint');
typestr = get(gcbf,'SelectionType');
areaflag = 0;
if(pt(1) > handles.axes6_pt(1) && pt(1) < (handles.axes6_pt(1)+handles.axes6_pt(3)))
    if(pt(2) > handles.axes6_pt(2) && pt(2) < (handles.axes6_pt(2)+handles.axes6_pt(4)))
        areaflag = 6;
    end
end

if(pt(1) > handles.axes3_pt(1) && pt(1) < (handles.axes3_pt(1)+handles.axes3_pt(3)))
    if(pt(2) > handles.axes3_pt(2) && pt(2) < (handles.axes3_pt(2)+handles.axes3_pt(4)))
        areaflag = 3;
    end
end
if(pt(1) > handles.axes4_pt(1) && pt(1) < (handles.axes4_pt(1)+handles.axes4_pt(3)))
    if(pt(2) > handles.axes4_pt(2) && pt(2) < (handles.axes4_pt(2)+handles.axes4_pt(4)))
        areaflag = 4;
    end
end
if(handles.buttonstatus == 1)
%     disp(['gcf position: ',num2str(pt(1)),' ',num2str(pt(2))]);
    tracecount = handles.tracecount + 1;
    handles.tracebuffer(tracecount,:) = [pt(1),pt(2)];
    handles.tracecount = tracecount;
    if(strcmp(typestr,'alt'))
        if(handles.isaxis3dataready == 1 && areaflag == 4)
            [nrows,ncols] = size(handles.daseboard);
            scale = 2^(handles.bmpscale/2);
            rowgap = fix((handles.tracebuffer(1,2) - pt(2))*scale);
            colgap = fix((pt(1) - handles.tracebuffer(1,1))*scale);
%             disp([num2str(rowgap),' ',num2str(colgap)]);
            axis4_nrows = handles.axis4_nrows;      %rows of axis veiw area
            axis4_ncols = handles.axis4_ncols;      %cols of axis veiw area
            axis4_rowst = handles.axis4_rowst - rowgap;      %start row from the original picture
            axis4_colst = handles.axis4_colst - colgap;      %start col from the original picture
            if(axis4_rowst > 0 && axis4_colst > 0 && (axis4_rowst+axis4_nrows)<=nrows && (axis4_colst+axis4_ncols)<=ncols)
                axis4viewdata = handles.daseboard(axis4_rowst+1:axis4_rowst+axis4_nrows,axis4_colst+1:axis4_colst+axis4_ncols);
                axes(handles.axes4);
                handles.axes4handle = imshow(axis4viewdata);
                handles.axis4_rowst = axis4_rowst;
                handles.axis4_colst = axis4_colst;
            end
        end
    end
end

guidata(hObject, handles);


% --- Executes on button press in pushbutton7.
function pushbutton7_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
[FileName,PathName] = uigetfile('*.bmp','Select the BMP file');
if(ischar(FileName))
    handles.filename = FileName;
    set(handles.edit2,'String',FileName);
    bmpboard = imread([PathName,'/',FileName]);
    [nrows,ncols] = size(bmpboard);
    bmpboard = logical(repmat(uint8(255),nrows,ncols)-bmpboard);
    handles.daseboard = bmpboard;
    handles.userboard = bmpboard;
    handles.axes4_rowst = 0;
    handles.axes4_colst = 0;
    handles.axis4_nrows = nrows;
    handles.axis4_ncols = ncols;
    handles.chaincount = 0;
    handles.buttonstatus = 0;
    handles.tracecount = 0;
    handles.bmpscale = 0;
    axes(handles.axes1);
    cla(handles.axes1);
    handles.isaxis1dataready = 0;

    axes(handles.axes3);
    handles.axes3handle = imshow(handles.userboard);
    handles.isaxis3dataready = 1;
    axes(handles.axes4);
    handles.axes4handle = imshow(handles.userboard);
    handles.isaxis4dataready = 1;
    handles.ischaindataready = 0;
    handles.ischaindataused = 0;
    handles.chaincode_rowst = 0;
    handles.chaincode_colst = 0;
    handles.chaincode_udf = 0;
end
guidata(hObject, handles);




function edit3_Callback(hObject, eventdata, handles)
% hObject    handle to edit3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit3 as text
%        str2double(get(hObject,'String')) returns contents of edit3 as a double


% --- Executes during object creation, after setting all properties.
function edit3_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton8.
function pushbutton8_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton8 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
filepath_orig = uigetdir('*.*','Please select a folder');
handles.filepath_orig=filepath_orig;
set(handles.edit3,'string',handles.filepath_orig);


% --- Executes on button press in pushbutton9.
function pushbutton9_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton9 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% x1=get(handles.edit4,'String');
% y1=get(handles.edit5,'String');
% x2=get(handles.edit6,'String');
% y2=get(handles.edit7,'String');
% x1=str2num(x1);y1=str2num(y1);
% x2=str2num(x2);y2=str2num(y2);
% 
% dis=get(handles.edit8,'String');
% dis=str2num(dis);
% pixel=sqrt((x1-x2)*(x1-x2)+(y1-y2)*(y1-y2));
% dis_pixel=pixel/dis;
% dis_mm=dis/pixel;
% 
% handles.dis_pixel=dis_pixel;
% handles.dis_mm=dis_mm;
% 
% 
% disp(handles.dis_pixel)
% disp(handles.dis_mm)
% 
% 
% results = cell(2,3);
% results(1,:) = [{'filepath'},{'scale:pixels/mm'},{'scale:mm/pixel'}];
% val = get(handles.popupmenu2,'value');  
% list = get(handles.popupmenu2,'string'); 
% temp=list{val};
% results(2,1)={temp};
% results(2,2)={handles.dis_pixel};
% results(2,3)={handles.dis_mm};
% 
% disp(temp)
% xlswrite([temp(1:end-11) '_scale.xlsx'],results,'Sheet1');
guidata(hObject, handles);

function edit4_Callback(hObject, eventdata, handles)
% hObject    handle to edit4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit4 as text
%        str2double(get(hObject,'String')) returns contents of edit4 as a double


% --- Executes during object creation, after setting all properties.
function edit4_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit5_Callback(hObject, eventdata, handles)
% hObject    handle to edit5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit5 as text
%        str2double(get(hObject,'String')) returns contents of edit5 as a double


% --- Executes during object creation, after setting all properties.
function edit5_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit6_Callback(hObject, eventdata, handles)
% hObject    handle to edit6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit6 as text
%        str2double(get(hObject,'String')) returns contents of edit6 as a double


% --- Executes during object creation, after setting all properties.
function edit6_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit7_Callback(hObject, eventdata, handles)
% hObject    handle to edit7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit7 as text
%        str2double(get(hObject,'String')) returns contents of edit7 as a double


% --- Executes during object creation, after setting all properties.
function edit7_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit8_Callback(hObject, eventdata, handles)
% hObject    handle to edit8 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit8 as text
%        str2double(get(hObject,'String')) returns contents of edit8 as a double


% --- Executes during object creation, after setting all properties.
function edit8_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit8 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes during object creation, after setting all properties.
function axes5_CreateFcn(hObject, eventdata, handles)
% hObject    handle to axes5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: place code in OpeningFcn to populate axes5


% --- Executes on button press in pushbutton10.
function pushbutton10_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton10 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
axes(handles.axes1)


% --- Executes during object creation, after setting all properties.
function pushbutton8_CreateFcn(hObject, eventdata, handles)
% hObject    handle to pushbutton8 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called


% --- Executes on button press in pushbutton11.
function pushbutton11_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton11 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

guidata(hObject, handles);





function edit9_Callback(hObject, eventdata, handles)
% hObject    handle to edit9 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit9 as text
%        str2double(get(hObject,'String')) returns contents of edit9 as a double


% --- Executes during object creation, after setting all properties.
function edit9_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit9 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit10_Callback(hObject, eventdata, handles)
% hObject    handle to edit10 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit10 as text
%        str2double(get(hObject,'String')) returns contents of edit10 as a double


% --- Executes during object creation, after setting all properties.
function edit10_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit10 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit11_Callback(hObject, eventdata, handles)
% hObject    handle to edit11 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit11 as text
%        str2double(get(hObject,'String')) returns contents of edit11 as a double


% --- Executes during object creation, after setting all properties.
function edit11_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit11 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit12_Callback(hObject, eventdata, handles)
% hObject    handle to edit12 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit12 as text
%        str2double(get(hObject,'String')) returns contents of edit12 as a double


% --- Executes during object creation, after setting all properties.
function edit12_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit12 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit13_Callback(hObject, eventdata, handles)
% hObject    handle to edit13 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit13 as text
%        str2double(get(hObject,'String')) returns contents of edit13 as a double


% --- Executes during object creation, after setting all properties.
function edit13_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit13 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end






function edit14_Callback(hObject, eventdata, handles)
% hObject    handle to edit14 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit14 as text
%        str2double(get(hObject,'String')) returns contents of edit14 as a double


% --- Executes during object creation, after setting all properties.
function edit14_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit14 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton13.
function pushbutton13_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton13 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

    points = ginput(2);
%     distance = sqrt(sum((points(2,:) - points(1,:)).^2));
    handles.pos(1)=points(1,1);
    handles.pos(2)=points(1,2);
    handles.pos(3)=points(2,1);
    handles.pos(4)=points(2,2);
    axes(handles.axes6);
    hold on
    plot(handles.pos(1), handles.pos(2), 'rs', 'linewidth', 1,'MarkerFaceColor','r');
    hold on;
    plot(handles.pos(3), handles.pos(4), 'rs', 'linewidth',1,'MarkerFaceColor','r');
    hold off;
    set(handles.edit9,'string',handles.pos(1));
    set(handles.edit10,'string',handles.pos(2));
    set(handles.edit11,'string',handles.pos(3));
    set(handles.edit12,'string',handles.pos(4));
    set(handles.pushbutton4, 'Enable', 'on');  
guidata(hObject, handles);


% --- Executes on button press in pushbutton14.
function pushbutton14_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton14 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
cla(handles.axes3);
if(handles.isaxis3dataready == 1)
    % [nrows,ncols] = size(handles.userboard);
%      handles.userboard = handles.daseboard;  
    B = bwboundaries(handles.daseboard, 'noholes');
%     [B,~,~,A] = bwboundaries(handles.daseboard);
%     enclosing_boundary  = find(A(m,:));
    handles.userboard = handles.daseboard;
       



    boundary=B{1};
    handles.boundary=boundary;
    size(boundary)
%     [chain_code1,startIndex]=coordinatesToChainCode(boundary);
%     disp(chain_code1);
    [h,w]=size(handles.daseboard);
    line_bo=zeros(h,w,'logical');
    [num,]=size(boundary)
    for i=1:num
%        t1=boundary(i,1);
%        t2=boundary(i,2);
       line_bo(boundary(i,1),boundary(i,2))=1;
       line_bo=uint8(line_bo);
%        fprintf(fid,'%d %d',t1,t2);
%        fprintf(fid,'\n');
    end 
    [chain_code,oringin,endpoint] = gui_chain_code_func20221129(line_bo,boundary(1,:));%user_point
    size(chain_code)
    axes(handles.axes3);
    axis3viewdata = handles.userboard(handles.axis1_rowst+1:handles.axis1_rowst+handles.axis1_nrows,handles.axis1_colst+1:handles.axis1_colst+handles.axis1_ncols);
    handles.axes3handle = imshow(axis3viewdata);
%     imshow(handles.userboard)
    if(~isempty(chain_code))
        handles.chain_code = chain_code;
%         oringin=boundary(startIndex,:);
        handles.pointoringin = oringin;
        hold on;
        plot(boundary(:,2)-handles.axis1_colst, boundary(:,1)-handles.axis1_rowst, '-g', 'linewidth',  3);
        x_ = calc_traversal_dist(chain_code);
        x = [0 0; x_];
        hold on;
%         x1_ = calc_traversal_dist(chain_code1);
%         x1 = [0 0; x1_];
%         plot(boundary(startIndex,2)+x1(:,1), boundary(startIndex,1)-x1(:,2), '-b', 'linewidth', 4);
%         hold on
        plot(oringin(2)+x(:,1)-handles.axis1_colst, oringin(1)-x(:,2)-handles.axis1_rowst, '-r', 'linewidth',  1);
        hold off
        handles.ischaindataready = 1;
    else
        disp('Chain code is null')
        msgbox('Chain code is null');
%         pause;
    end    
    
    % test if it is closed
    is_closed  = is_completed_chain_code(chain_code, handles.pointoringin);
    
       

    
    % Positioning to end position in axes4
    [nrows,ncols] = size(handles.userboard);
    handles.bmpscale = -8;
    scale = 2^(handles.bmpscale/2);
    axis4_nrows = fix(handles.axes4_pt(4) * scale);
    axis4_ncols = fix(handles.axes4_pt(3) * scale);
%         endpoint=boundary(currentPoint,:);
    if(endpoint(1) > 0 && endpoint(2) > 0)
        axis4_rowst = max(endpoint(1) - fix(axis4_nrows/2),0);
        axis4_colst = max(endpoint(2) - fix(axis4_ncols/2),0);
    else
        axis4_rowst = oringin(1);
        axis4_colst = oringin(2);
    end
    axis4viewdata = handles.userboard(axis4_rowst+1:min(axis4_rowst+axis4_nrows,nrows),axis4_colst+1:min(axis4_colst+axis4_ncols,ncols));
    axes(handles.axes4);
    handles.axes4handle = imshow(axis4viewdata);
    handles.axis4_rowst = axis4_rowst;
    handles.axis4_colst = axis4_colst;
    handles.axis4_nrows = axis4_nrows;
    handles.axis4_ncols = axis4_ncols; 
    
    
    if ~is_closed
        msgbox('Chain code is not closed, please edit. ','Error','error');
    else
%         set(handles.pushbutton28, 'Enable', 'on'); 
        msgbox(['Chain code is closed, and length is ' num2str(size(chain_code,2))],'Success','help');
    end 
    
    if(handles.ischaindataready)
        set(handles.pushbutton13, 'Enable', 'on');  
        set(handles.pushbutton31, 'Enable', 'on');  
    end
end
guidata(hObject, handles);


% --- Executes on button press in pushbutton15.
function pushbutton15_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton15 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


if(islogical(handles.axes1graydata))
    handles.axes1graydata = handles.axes1graydata;
else
    handles.axes1graydata = imadjust(handles.axes1graydata,[0.2;0.5],[0;1]);
end
axes(handles.axes1);
% handles.axes1handle = imshow(handles.axes1graydata);
axis1viewdata = handles.axes1graydata(handles.axis1_rowst+1:handles.axis1_rowst+handles.axis1_nrows,handles.axis1_colst+1:handles.axis1_colst+handles.axis1_ncols);
handles.axes1handle = imshow(axis1viewdata);
guidata(hObject, handles);


% --- Executes on button press in pushbutton16.
function pushbutton16_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton16 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

if(handles.isaxis1dataready == 1)
     %corrode 
    circle=get(handles.edit15,'String');
    se1=strel('disk',str2num(circle));%Create a flat disk structure element with a radius of 5
    handles.erzhi=imerode(handles.erzhi,se1);

    axes(handles.axes3);
%     handles.axes3handle = imshow(handles.erzhi);%
    axis3viewdata = handles.erzhi(handles.axis1_rowst+1:handles.axis1_rowst+handles.axis1_nrows,handles.axis1_colst+1:handles.axis1_colst+handles.axis1_ncols);
    handles.axes3handle = imshow(axis3viewdata);

    axes(handles.axes4);
    handles.axes4handle = imshow(handles.erzhi);
    [nrows,ncols] = size(handles.erzhi);
    handles.axis4_rowst = 0;
    handles.axis4_colst = 0;
    handles.axis4_nrows = nrows;
    handles.axis4_ncols = ncols;
    handles.isaxis3dataready = 1;
    handles.isaxis4dataready = 1;
    handles.ischaindataready = 0;
    handles.chaincode_rowst = 0;
    handles.chaincode_colst = 0;
    handles.chaincode_udf = 0;
    handles.daseboard=handles.erzhi;
end
guidata(hObject, handles);



function edit15_Callback(hObject, eventdata, handles)
% hObject    handle to edit15 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit15 as text
%        str2double(get(hObject,'String')) returns contents of edit15 as a double


% --- Executes during object creation, after setting all properties.
function edit15_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit15 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton17.
function pushbutton17_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton17 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
%inflate
if(handles.isaxis3dataready == 1)
    %inflate
    B=[0 1 0
       1 1 1
       0 1 0];
    handles.erzhi=imdilate(handles.erzhi,B); 
    
    axes(handles.axes3);
%     handles.axes3handle = imshow(handles.erzhi);%
    axis3viewdata = handles.erzhi(handles.axis1_rowst+1:handles.axis1_rowst+handles.axis1_nrows,handles.axis1_colst+1:handles.axis1_colst+handles.axis1_ncols);
    handles.axes3handle = imshow(axis3viewdata);

    axes(handles.axes4);
    handles.axes4handle = imshow(handles.erzhi);
    [nrows,ncols] = size(handles.erzhi);
    handles.axis4_rowst = 0;
    handles.axis4_colst = 0;
    handles.axis4_nrows = nrows;
    handles.axis4_ncols = ncols;
    handles.isaxis3dataready = 1;
    handles.isaxis4dataready = 1;
    handles.ischaindataready = 0;
    handles.chaincode_rowst = 0;
    handles.chaincode_colst = 0;
    handles.chaincode_udf = 0;
    handles.daseboard=handles.erzhi;
end
guidata(hObject, handles);


% --- Executes on button press in pushbutton18.
function pushbutton18_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton18 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
    unique_values = unique(handles.axes1graydata);
    num_unique_values = numel(unique_values);
    if num_unique_values == 2
%         disp('The input image is a binary image.');
        handles.erzhi =handles.axes1graydata;
    else
%         disp('The input image is a binary image.');
        temp = imbinarize(handles.axes1graydata);
        handles.erzhi = imcomplement(temp);
    end

    axes(handles.axes3);
%     handles.axes3handle = imshow(handles.erzhi);%
    axis3viewdata = handles.erzhi(handles.axis1_rowst+1:handles.axis1_rowst+handles.axis1_nrows,handles.axis1_colst+1:handles.axis1_colst+handles.axis1_ncols);
    handles.axes3handle = imshow(axis3viewdata);
    
 
    axes(handles.axes4);
    handles.axes4handle = imshow(handles.erzhi);
    [nrows,ncols] = size(handles.erzhi);
    handles.axis4_rowst = 0;
    handles.axis4_colst = 0;
    handles.axis4_nrows = nrows;
    handles.axis4_ncols = ncols;
    handles.isaxis3dataready = 1;
    handles.isaxis4dataready = 1;
    handles.ischaindataready = 0;
    handles.chaincode_rowst = 0;
    handles.chaincode_colst = 0;
    handles.chaincode_udf = 0;
    handles.daseboard=handles.erzhi;
guidata(hObject, handles);
    


% --- Executes on button press in pushbutton19.
function pushbutton19_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton19 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
    global mask1
    dimen_size = size(mask1);
    if(dimen_size(end) == 3)
        handles.axes1graydata = rgb2gray(mask1);% to grayscale
    else
        handles.axes1graydata = mask1;
    end
    axes(handles.axes1);
%     handles.axes1handle = imshow(handles.axes1graydata);
    axis1viewdata = handles.axes1graydata(handles.axis1_rowst+1:handles.axis1_rowst+handles.axis1_nrows,handles.axis1_colst+1:handles.axis1_colst+handles.axis1_ncols);
    handles.axes1handle = imshow(axis1viewdata);
guidata(hObject, handles);


% --- Executes on button press in pushbutton20.
function pushbutton20_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton20 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
%     disp(handles.axis1_colst);
%     disp(handles.axis1_rowst);

    set(handles.pushbutton13, 'Enable', 'off'); 
    global mask1
    [x,y,flag]=ginput(1);
    m(1)=x;
    n(1)=y;
    k=2;

    m_o(1)=handles.axis1_colst + m(1);n_o(1)=handles.axis1_rowst + n(1);
    while(flag==1)
        [x1,y1,flag1]=ginput(1);
        if flag1==1
            m(k)=x1;
            n(k)=y1;
%             m_o(k)=handles.axis1_col_ratio*handles.axes6_pt(3)+m(k)
%             n_o(k)=(1-handles.axis1_row_ratio)*handles.axes6_pt(4)+n(k)
            m_o(k)=handles.axis1_colst +1 + m(k);
            n_o(k)=handles.axis1_rowst +1 + n(k);
            line([m(k-1) m(k)],[n(k-1) n(k)],'color','r');
            k=k+1;
            flag=flag1;
        else
            break
        end
    end
    line([m(k-1) m(1)],[n(k-1) n(1)],'color','r');
%     save n n
%     save n_o n_o

    BW = roipoly(handles.imdata,m_o,n_o); 
    mask=uint8(BW);
    mask_3(:,:,1)=mask;mask_3(:,:,2)=mask;mask_3(:,:,3)=mask;
    mask1=mask_3.* handles.imdata;
    mask1(mask1==0) = 255;
    dimen_size = size(mask1);
%     save mask1 mask1
    if(dimen_size(end) == 3)
        graydata = rgb2gray(mask1);
    else
        graydata = mask1;
    end
    handles.axes1graydata=graydata;


    axes(handles.axes1);
%     handles.axes1handle = imshow(handles.axes1graydata);
%     disp(handles.axis1_rowst+1);
%     disp(handles.axis1_colst+1);
    axis1viewdata = handles.axes1graydata(handles.axis1_rowst+1:handles.axis1_rowst+handles.axis1_nrows,handles.axis1_colst+1:handles.axis1_colst+handles.axis1_ncols);
    handles.axes1handle = imshow(axis1viewdata);
    cla(handles.axes3);
    handles.chain_code = [];
    handles.isaxis1dataready = 1; 
    handles.isaxis3dataready = 0;
    handles.isaxis4dataready = 0;
    handles.ischaindataready = 0;
    handles.ischaindataused = 0;
    if(handles.isaxis1dataready)
%         set(handles.uibuttongroup4, 'Enable', 'on');  
        set(handles.pushbutton15, 'Enable', 'on');   
        set(handles.pushbutton19, 'Enable', 'on');   
        if(handles.method==1)
%             set(handles.pushbutton12, 'Enable', 'on');   
            set(handles.pushbutton14, 'Enable', 'on');   

            set(handles.pushbutton16, 'Enable', 'on');   
            set(handles.pushbutton17, 'Enable', 'on');   
            set(handles.pushbutton18, 'Enable', 'on');   

            set(handles.pushbutton2, 'Enable', 'off');   
%             set(handles.pushbutton3, 'Enable', 'off');   
        elseif(handles.method==2)
            set(handles.pushbutton2, 'Enable', 'on');   
%             set(handles.pushbutton3, 'Enable', 'on');   
%             set(handles.pushbutton12, 'Enable', 'off'); 
            set(handles.pushbutton14, 'Enable', 'on');  
%             set(handles.pushbutton15, 'Enable', 'off');   
            set(handles.pushbutton16, 'Enable', 'off');   
            set(handles.pushbutton17, 'Enable', 'off');   
            set(handles.pushbutton18, 'Enable', 'off');   
%             set(handles.pushbutton19, 'Enable', 'off');  
        end

    end
guidata(hObject, handles);


% --- Executes on button press in pushbutton21.
function pushbutton21_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton21 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
if(handles.popup_sel_index~= length(handles.strs))
    handles.popup_sel_index=handles.popup_sel_index+1;
    handles.filename = strrep(handles.strs{handles.popup_sel_index},'*','');
    if handles.filename ~= 0
        handles.imdata = imread([handles.pathname,'/',handles.filename]);
        
        [nrows,ncols,~] = size(handles.imdata);
%         disp(size(handles.imdata));
%         handles.axes1graydata = graydata;
        handles.jpgnrows = nrows;   %rows of the original picture
        handles.jpgncols = ncols;   %cols of the original picture
        handles.axis1_nrows = handles.axes6_pt(4);    %rows of axis veiw area
        handles.axis1_ncols = handles.axes6_pt(3);    %cols of axis veiw area
        axis1_rowst = fix((handles.jpgnrows - handles.axis1_nrows)/2);
        axis1_colst = fix((handles.jpgncols - handles.axis1_ncols)/2);
        handles.axis1_rowst = axis1_rowst;      %start row from the original picture
        handles.axis1_colst = axis1_colst;      %start col from the original picture
        handles.axis1_row_ratio = 1.0;
        handles.axis1_col_ratio = 1.0;
        axis6viewdata = handles.imdata(axis1_rowst+1:axis1_rowst+handles.axis1_nrows,axis1_colst+1:axis1_colst+handles.axis1_ncols,:);
        axes(handles.axes6);
        handles.axes6handle = imshow(axis6viewdata);
        cla(handles.axes1);
        cla(handles.axes3);
        cla(handles.axes4);
%         handles.chain_code = [];
        handles.isaxis1dataready = 1;
        handles.isaxis2dataready = 0;
        handles.isaxis3dataready = 0;
        handles.isaxis4dataready = 0;
        handles.ischaindataready = 0;
        handles.ischaindataused = 0;
        handles.isaxis6dataready=1;
                
        set(handles.popupmenu2,'Value',handles.popup_sel_index);
    end
else
    disp('This is the last one.')
    msgbox('This is the last one.')
end
guidata(hObject, handles);


% --- Executes on button press in pushbutton22.
function pushbutton22_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton22 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
if(handles.popup_sel_index~=1)
    handles.popup_sel_index=handles.popup_sel_index-1;
    handles.filename = strrep(handles.strs{handles.popup_sel_index},'*','');
    if handles.filename ~= 0
        handles.imdata = imread([handles.pathname,'/',handles.filename]);
                [nrows,ncols,~] = size(handles.imdata);
%         disp(size(handles.imdata));
%         handles.axes1graydata = graydata;
        handles.jpgnrows = nrows;   %rows of the original picture
        handles.jpgncols = ncols;   %cols of the original picture
        handles.axis1_nrows = handles.axes6_pt(4);    %rows of axis veiw area
        handles.axis1_ncols = handles.axes6_pt(3);    %cols of axis veiw area
        axis1_rowst = fix((handles.jpgnrows - handles.axis1_nrows)/2);
        axis1_colst = fix((handles.jpgncols - handles.axis1_ncols)/2);
        handles.axis1_rowst = axis1_rowst;      %start row from the original picture
        handles.axis1_colst = axis1_colst;      %start col from the original picture
        handles.axis1_row_ratio = 1.0;
        handles.axis1_col_ratio = 1.0;
        axis6viewdata = handles.imdata(axis1_rowst+1:axis1_rowst+handles.axis1_nrows,axis1_colst+1:axis1_colst+handles.axis1_ncols,:);
        axes(handles.axes6);
        handles.axes6handle = imshow(axis6viewdata);
        cla(handles.axes1);
        cla(handles.axes3);
        cla(handles.axes4);
%         handles.chain_code = [];
        handles.isaxis1dataready = 1;
        handles.isaxis2dataready = 0;
        handles.isaxis3dataready = 0;
        handles.isaxis4dataready = 0;
        handles.ischaindataready = 0;
        handles.ischaindataused = 0;
        handles.isaxis6dataready=1;
        
        set(handles.popupmenu2,'Value',handles.popup_sel_index);
    end
else
    disp('This is the first one.')
    msgbox('This is the first one.')
end
guidata(hObject, handles);


% --- Executes during object creation, after setting all properties.
function axes6_CreateFcn(hObject, eventdata, handles)
% hObject    handle to axes6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: place code in OpeningFcn to populate axes6
set(gca,'XColor',get(gca,'Color')) ;% 鏉╂瑤琚辩悰灞煎敩閻礁濮涢懗鏂ょ窗鐏忓棗娼楅弽鍥叡閸滃苯娼楅弽鍥у煝鎼达箒娴嗘稉铏规閼癸拷锟??
set(gca,'YColor',get(gca,'Color'));
 
set(gca,'XTickLabel',[]);  % 鏉╂瑤琚辩悰灞煎敩閻礁濮涢懗鏂ょ窗閸樺娅庨崸鎰垼閸掕�??
set(gca,'YTickLabel',[]);


% --- Executes on mouse press over axes background.
function axes6_ButtonDownFcn(hObject, eventdata, handles)
% hObject    handle to axes6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in pushbutton28.
function pushbutton28_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton28 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
EFA(handles.chain_code,handles.idFullLeaf,handles.filename);


% --- Executes when user attempts to close figure1.
function figure1_CloseRequestFcn(hObject, eventdata, handles)
% hObject    handle to figure1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% delete(Hs_figure);
% clear;
% Hint: delete(hObject) closes the figure
delete(hObject);


% --- Executes on button press in pushbutton29.
function pushbutton29_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton29 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles.imdata=imcomplement(handles.imdata);
axes(handles.axes6);
handles.axes6handle = imshow(handles.imdata);
guidata(hObject, handles);



function edit17_Callback(hObject, eventdata, handles)
% hObject    handle to edit17 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit17 as text
%        str2double(get(hObject,'String')) returns contents of edit17 as a double


% --- Executes during object creation, after setting all properties.
function edit17_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit17 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in popupmenu4.
function popupmenu4_Callback(hObject, eventdata, handles)
% hObject    handle to popupmenu4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns popupmenu4 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popupmenu4


% --- Executes during object creation, after setting all properties.
function popupmenu4_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmenu4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in radiobutton1.
function radiobutton1_Callback(hObject, eventdata, handles)
% hObject    handle to radiobutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of radiobutton1



% --- Executes on button press in radiobutton2.
function radiobutton2_Callback(hObject, eventdata, handles)
% hObject    handle to radiobutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of radiobutton2


% --- Executes when selected object is changed in uibuttongroup4.
function uibuttongroup4_SelectionChangedFcn(hObject, eventdata, handles)
% hObject    handle to the selected object in uibuttongroup4 
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% disp(get(hObject,'tag'))
switch get(hObject,'tag')
    case 'radiobutton1'
        handles.method=1;
        set(handles.pushbutton14, 'Enable', 'on');  
%         set(handles.pushbutton15, 'Enable', 'on'); 
        set(handles.pushbutton16, 'Enable', 'on');  
        set(handles.pushbutton17, 'Enable', 'on');   
        set(handles.pushbutton18, 'Enable', 'on'); 
%         set(handles.pushbutton19, 'Enable', 'on');  
        set(handles.pushbutton2, 'Enable', 'off'); 
%         set(handles.pushbutton3, 'Enable', 'off'); 
        disp(1)
    case 'radiobutton2'
        handles.method=2;
        set(handles.pushbutton2, 'Enable', 'on'); 
%         set(handles.pushbutton3, 'Enable', 'on');  
%             set(handles.pushbutton12, 'Enable', 'off'); 
        set(handles.pushbutton14, 'Enable', 'on'); 
%         set(handles.pushbutton15, 'Enable', 'off'); 
        set(handles.pushbutton16, 'Enable', 'off'); 
        set(handles.pushbutton17, 'Enable', 'off'); 
        set(handles.pushbutton18, 'Enable', 'off'); 
%         set(handles.pushbutton19, 'Enable', 'off'); 
        disp(2)
end
guidata(hObject, handles);

function uibuttongroup4_CreateFcn(hObject, eventdata, handles)



% --- Executes on button press in pushbutton30.
function pushbutton30_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton30 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA) 
hs_n=get(handles.edit17,'String');
numofharmoinc =str2num(hs_n) ;
coffs = cell(2,numofharmoinc*4 + 1);
coffs(1,1) = {'filepath'};
for n=2:4:numofharmoinc*4
    index = fix(n/4) + 1;
    coffs(1,n:1:n+3) = [cellstr(['a',num2str(index)]),cellstr(['b',num2str(index)]),cellstr(['c',num2str(index)]),cellstr(['d',num2str(index)])];
end
[~,a,b,c,d] = fourier_approx_norm_modify_20231008(handles.chain_code, numofharmoinc, 1000, 1, 0);
Hs = [a;b;c;d];
coffs(2,1) = {[handles.filename(1:end-4) '_' handles.idFullLeaf]};
coffs(2,2:end)=num2cell(Hs(:));
xlswrite(['/results/' handles.filename(1:end-4) '_' handles.idFullLeaf '_info.xlsx'],coffs,'Sheet2');
handles.numofharmoinc=numofharmoinc;
guidata(hObject, handles);


% --- Executes on button press in pushbutton31.
function pushbutton31_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton31 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

    handles.pos(1)=0;
    handles.pos(2)=0;
    handles.pos(3)=0;
    handles.pos(4)=0;
    
    set(handles.edit9,'string',handles.pos(1));
    set(handles.edit10,'string',handles.pos(2));
    set(handles.edit11,'string',handles.pos(3));
    set(handles.edit12,'string',handles.pos(4));
    set(handles.edit13,'string',0);
    set(handles.pushbutton4, 'Enable', 'on');   
guidata(hObject, handles);


% --- Executes on button press in radiobutton3.
function radiobutton3_Callback(hObject, eventdata, handles)
% hObject    handle to radiobutton3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of radiobutton3


% --- Executes on button press in radiobutton4.
function radiobutton4_Callback(hObject, eventdata, handles)
% hObject    handle to radiobutton4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of radiobutton4


% --- Executes when selected object is changed in uibuttongroup5.
function uibuttongroup5_SelectionChangedFcn(hObject, eventdata, handles)
% hObject    handle to the selected object in uibuttongroup5 
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
switch get(hObject,'tag')
    case 'radiobutton3'
        handles.unit=1;

    case 'radiobutton4'
        handles.unit=2;

end
guidata(hObject, handles);


% --- Executes during object creation, after setting all properties.
function figure1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to figure1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called
