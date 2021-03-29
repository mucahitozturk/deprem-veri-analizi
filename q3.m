%% BU PROGRAM
%       data3.csv dosyas�ndaki konum, derinlik bilgisi ve deprem �iddeti verillerini okuyarak,
%       deprem �iddeti ile di�er parametreler aras�nda Lineer Regresyon y�ntemi ile model kurar.
%
%%  M�CAH�T �ZT�RK
%   Harran �niversitesi Bilgisayar M�hendisli�i     
%   �r�nt� Tan�ma Final S�nav� �devi - 3. Soru
%% SAB�TLER
DosyaVeri='data3.csv';

%% VERININ OKUNMASI
% Verilerin okunmas�
fprintf('\n');
fprintf(1,'data3.csv dosyas� okunuyor .....\n\n');

fid=fopen(DosyaVeri);
Baslik=fgets(fid);
% Data = [Latitude Longitude Depth Magnitude]
Data=[];
tline = '99,9;99,9;99,9;9'; % ba�lang�� i�in atanan sa�ma de�er
while tline~=-1    
    tline = strrep(tline,',','.');
    p=strfind(tline,';');
    if ~isequal(size(p),[1 3]), error('Dosya i�inde veri ayr�m�nda sorun var'); end
    A=[str2double(tline(1:p(1)-1)) str2double(tline(p(1)+1:p(2)-1)) str2double(tline(p(2)+1:p(3)-1)) str2double(tline(p(3)+1:end))];
    if ~isequal(size(A),[1 4]), error('Ayr��t�r�lan veri boyutunda sorun var'); end
    Data=[Data;A];
    tline = fgets(fid);
end
Data=Data(2:end,:);
fclose(fid);
clear p A Baslik fid ans DosyaVeri tline

%% L�NEER REGRESYON UYGULANMASI
X=Data(:,1:3); y=Data(:,end);
mdl = fitlm(X,y); 
ModelSonuc=predict(mdl,X);

% RMSE hesab�
RMSE=sqrt(mean((y-ModelSonuc).^2));

%% SONU�LARIN YAZDIRILMASI
fprintf('\n');
fprintf(1,'LINEER REGRESYON TEST SONU�LARI:\n\n');
fprintf(1,'                 Toplam veri say�s�: %d \n',size(Data,1));
fprintf(1,'  Ger�ek - Model k�syaslamas� sonucu RMSE: %.2f \n\n',RMSE);

