function varargout = EFA(varargin)
% EFA MATLAB code for EFA.fig
%      EFA, by itself, creates a new EFA or raises the existing
%      singleton*.
%
%      H = EFA returns the handle to a new EFA or the handle to
%      the existing singleton*.
%f
%      EFA('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in EFA.M with the given input arguments.
%
%      EFA('Property','Value',...) creates a new EFA or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before EFA_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to EFA_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help EFA

% Last Modified by GUIDE v2.5 24-Oct-2023 11:54:08

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @EFA_OpeningFcn, ...
                   'gui_OutputFcn',  @EFA_OutputFcn, ...
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


% --- Executes just before EFA is made visible.
function EFA_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to EFA (see VARARGIN)

% Choose default command line output for EFA
set(gcf,'name','ESHAPE');
handles.output = hObject;
set(hObject,'toolbar','figure');
var1 = varargin{1};
var2 = varargin{2};
var3 = varargin{3};
handles.chain_code=var1;
handles.idFullLeaf=var2;
handles.filename=var3;
% Update handles structure
cla(handles.axes1);
cla(handles.axes2);
set(handles.pushbutton1, 'Enable', 'off'); 
set(handles.pushbutton3, 'Enable', 'off'); 
guidata(hObject, handles);

% UIWAIT makes EFA wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = EFA_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;



function edit1_Callback(hObject, eventdata, handles)
% hObject    handle to edit1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit1 as text
%        str2double(get(hObject,'String')) returns contents of edit1 as a double


% --- Executes during object creation, after setting all properties.
function edit1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton1.
function pushbutton1_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% handles.chain_code
if(size(handles.chain_code))
    contour_points=[0 0];
    % chain_points =  chain_code_to_points_func(handles.chain_code)
    chain_points=code2axis(handles.chain_code,contour_points);
    axes(handles.axes1);
    plot(chain_points(:,2),chain_points(:,1),'-b');
    % plot(chain_points(:,1)+contour_points(1,1),  contour_points(1,2) - chain_points(:,2) , '-b'); 
    hold on;
    % plot_fourier_approx(chain_code, 15, 100, 0, 'r');
    % [a,b,c,d] = plot_fourier_approx(chain_code, 15, 100, 1, 'r');

    mode=0;
    circle=get(handles.edit1,'String');
    numofharmoinc=str2num(circle);
    if(numofharmoinc>handles.numofharmoinc)
        msgbox(['The input must be less than' num2str(handles.numofharmoinc) ],'');
    else
        ro = get (handles.checkbox2,'Value');
        sc = get (handles.checkbox3,'Value');
        re = get (handles.checkbox4,'Value');
        y_sy = get (handles.checkbox5,'Value');
        x_sy = get (handles.checkbox6,'Value');
        sta = get (handles.checkbox7,'Value');
        trans = get (handles.checkbox8,'Value');
        option=[ro,sc,re,y_sy,x_sy,sta,trans];
        [x_,~,~,~,~] = fourier_approx_norm_modify_20231008(handles.chain_code, numofharmoinc, 400, 0, mode,option);
        chain_points_approx = [x_; x_(1,1) x_(1,2)];
        % %[a,b,c,d,chain_points_approx] = fourier_approx_func_modify(chain_code, numofharmoinc, 1000, 0);%涓変釜鏁�?渚濇涓鸿皭娉㈢偣鏁版嵁锛岄噸鏋勭偣鏁版嵁锛屼互鍙婃爣鍑嗗寲�?涓洪潪鏍囧噯鍖栵�?        % tan_theta2 = 2 * (a(1) * b(1) + c(1) * d(1)) / ...
        %     (a(1)^2 + c(1)^2 - b(1)^2 - d(1)^2);
        % sin_theta2 = tan_theta2/sqrt(1+tan_theta2^2);
        % cos_theta2 = 1/sqrt(1 + tan_theta2^2);
        % cos_theta_square = (1 + cos_theta2)/2;
        % sin_theta_square = (1 - cos_theta2)/2;
        % % Compute theta1
        % theta1 = 0.5 * atan(2 * (a(1) * b(1) + c(1) * d(1)) / ...
        %     (a(1)^2 + c(1)^2 - b(1)^2 - d(1)^2));
        % axis_theta1 = (a(1)^2+c(1)^2)*cos_theta_square+...
        %     (a(1)*b(1)+c(1) * d(1))*sin_theta2 +...
        %     (b(1)^2+d(1)^2) * sin_theta_square;
        % axis_theta2 = (a(1)^2+c(1)^2)*sin_theta_square-...
        %     (a(1)*b(1)+c(1) * d(1))*sin_theta2 +...
        %     (b(1)^2+d(1)^2) * cos_theta_square;
        % %modified by razorenhua@20220209
        % if(axis_theta1 < axis_theta2)
        %     major_axis = axis_theta2;
        %     minor_axis = axis_theta1;
        %     theta1 = theta1 + pi/2;
        % else
        %     major_axis = axis_theta1;
        %     minor_axis = axis_theta2;
        % end
        % costh1 = cos(theta1);
        % sinth1 = sin(theta1);
        % a_star_1 = costh1 * a(1) + sinth1 * b(1);
        % b_star_1 = -sinth1 * a(1) + costh1 * b(1);
        % c_star_1 = costh1 * c(1) + sinth1 * d(1);
        % d_star_1 = -sinth1 * c(1) + costh1 * d(1);
        % % Compute psi1
        % psi1 = atan(c_star_1 / a_star_1) ;

        plot(chain_points_approx(:,1)+contour_points(1,1), contour_points(1,2)- chain_points_approx(:,2), '-r'); 
        % [a,b,c,d,~] = fourier_approx_func_modify(chain_code, numofharmoinc, 1000, 1);%涓変釜鏁�?渚濇涓鸿皭娉㈢偣鏁版嵁锛岄噸鏋勭偣鏁版嵁锛屼互鍙婃爣鍑嗗寲�?涓洪潪鏍囧噯鍖栵�?        axis equal

        % h6 = figure('visible','off');,{an}
        axes(handles.axes2);
%         plot_fourier_approx_modify(handles.chain_code, numofharmoinc, 1000, 1, 'r.',2,mode);
%         axis([-2, 2, -2, 2]);
        [x_,~,~,~,~] = fourier_approx_norm_modify_20231008(handles.chain_code, numofharmoinc, 400, 1, mode,option);
        x=[x_; x_(1,1) x_(1,2)];
        plot(x(:,1), x(:,2), 'r', 'linewidth', 2);           
        axis equal

        % saveas(h6,[basedir,'/',jpgname(1:end-4),'_part6.jpg']);
        % saveas(handles.EFA,['fig','/',handles.filename(1:end-4),'_',id_full,'.png'],'png');
        % saveas(gcf,[basedir,'_results','/',jpgname(1:end-4),'.fig'],'fig');

    end
else
    disp('Chain code is null');
    msgbox('Chain code is null');
end


% --- Executes on button press in pushbutton3.
function pushbutton3_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
    % Get the current figure handle
    fig = gcf;
    defaultPath = './results/';
    defaultFileName = [handles.filename(1:end-4) '_' handles.idFullLeaf '.png'];

    [file, path] = uiputfile({'*.png', 'PNG files (*.png)'; ...
                                  '*.jpg', 'JPEG files (*.jpg)'; ...
                                  '*.fig', 'MATLAB Figure files (*.fig)'}, 'Save File', [defaultPath defaultFileName]);
    % Ask the user for a file name to save the figure
%     [file, path] = uiputfile({'*.png', 'PNG files (*.png)'; ...
%                               '*.jpg', 'JPEG files (*.jpg)'; ...
%                               '*.fig', 'MATLAB Figure files (*.fig)'}, ...
%                               'Save Figure As');
    
    % Check if the user canceled the operation
    if isequal(file, 0) || isequal(path, 0)
        disp('Figure saving canceled.');
        return;
    end
    
    % Generate the full file path
    filePath = fullfile(path, file);
    
    % Save the figure as the selected file type
    [~, ~, extension] = fileparts(file);
    switch extension
        case '.png'
            saveas(fig, filePath, 'png');
        case '.jpg'
            saveas(fig, filePath, 'jpg');
        case '.fig'
            savefig(fig, filePath);
        otherwise
            disp('Unsupported file format. Figure not saved.');
    end
    
    disp(['Figure saved as: ', filePath]);
%     saveas(fig,['./results/' handles.filename(1:end-4) '_' handles.idFullLeaf '.fig'],'fig');
%     saveas(fig,['./results/' handles.filename(1:end-4) '_' handles.idFullLeaf '.png'],'png');

% --- Executes on button press in pushbutton5.
function pushbutton5_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)



hs_n=get(handles.edit2,'String');
numofharmoinc =str2num(hs_n) ;
% coffs = cell(2,numofharmoinc*4 + 1);
% coffs(1,1) = {'filepath'};
% for n=2:4:numofharmoinc*4
%     index = fix(n/4) + 1;
%     coffs(1,n:1:n+3) = [cellstr(['a',num2str(index)]),cellstr(['b',num2str(index)]),cellstr(['c',num2str(index)]),cellstr(['d',num2str(index)])];
% end

ro = get (handles.checkbox2,'Value');
sc = get (handles.checkbox3,'Value');
re = get (handles.checkbox4,'Value');
y_sy = get (handles.checkbox5,'Value');
x_sy = get (handles.checkbox6,'Value');
sta = get (handles.checkbox7,'Value');
trans = get (handles.checkbox8,'Value');
option=[ro,sc,re,y_sy,x_sy,sta,trans];

[~,a,b,c,d] = fourier_approx_norm_modify_20231008(handles.chain_code, numofharmoinc, 1000, 1, 0,option);
% Hs = [a;b;c;d];
% coffs(2,1) = {[handles.filename(1:end-4) '_' handles.idFullLeaf]};
% coffs(2,2:end)=num2cell(Hs(:));
t=[a b c d];
Hs=reshape(t',1,[]);
coffs = cell(2,numofharmoinc*4 + 1);
coffs(1,1) = {'filepath'};

cols = numofharmoinc*4; 
matrix = cell(1, cols);  
for col = 1:cols
    letter = char('a' + mod(col - 1, 4));
    number = num2str(ceil(col / 4));
    matrix{col} = strcat(letter, number);
end
coffs(1,2:end)=matrix;
coffs(2,1) = {[handles.filename(1:end-4) '_' handles.idFullLeaf]};
coffs(2,2:end)=num2cell(Hs(:));

xlswrite(['/results/' handles.filename(1:end-4) '_' handles.idFullLeaf '_info.xlsx'],coffs,'Sheet2');
msgbox('done');
set(handles.pushbutton1, 'Enable', 'on'); 
set(handles.pushbutton3, 'Enable', 'on');
handles.numofharmoinc=numofharmoinc;
% handles.option=option;
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


% --- Executes on button press in checkbox2.
function checkbox2_Callback(hObject, eventdata, handles)
% hObject    handle to checkbox2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
t_1=get(handles.checkbox2,'value');
t_2=get(handles.checkbox7,'value');
if((t_1==1)&&(t_2==1))    
    set(handles.checkbox5, 'Enable', 'on');
    set(handles.checkbox6, 'Enable', 'on');
else
    set(handles.checkbox5, 'value', 0);
    set(handles.checkbox6, 'value', 0);
    set(handles.checkbox5, 'Enable', 'off');
    set(handles.checkbox6, 'Enable', 'off');
end
% Hint: get(hObject,'Value') returns toggle state of checkbox2


% --- Executes on button press in checkbox3.
function checkbox3_Callback(hObject, eventdata, handles)
% hObject    handle to checkbox3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of checkbox3


% --- Executes on button press in checkbox4.
function checkbox4_Callback(hObject, eventdata, handles)
% hObject    handle to checkbox4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of checkbox4


% --- Executes on button press in checkbox5.
function checkbox5_Callback(hObject, eventdata, handles)
% hObject    handle to checkbox5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of checkbox5


% --- Executes on button press in checkbox6.
function checkbox6_Callback(hObject, eventdata, handles)
% hObject    handle to checkbox6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of checkbox6


% --- Executes on button press in checkbox7.
function checkbox7_Callback(hObject, eventdata, handles)
% hObject    handle to checkbox7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
t_1=get(handles.checkbox2,'value');
t_2=get(handles.checkbox7,'value');
if((t_1==1)&&(t_2==1))  
    set(handles.checkbox5, 'Enable', 'on');
    set(handles.checkbox6, 'Enable', 'on');   
else
    set(handles.checkbox5, 'value', 0);
    set(handles.checkbox6, 'value', 0);
    set(handles.checkbox5, 'Enable', 'off');
    set(handles.checkbox6, 'Enable', 'off');
end
% Hint: get(hObject,'Value') returns toggle state of checkbox7


% --- Executes on button press in checkbox8.
function checkbox8_Callback(hObject, eventdata, handles)
% hObject    handle to checkbox8 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of checkbox8
