%% BU PROGRAM
%       data3.csv dosyasýndaki konum, derinlik bilgisi ve deprem þiddeti verillerini okuyarak,
%       deprem þiddeti ile diðer parametreler arasýnda Lineer Regresyon yöntemi ile model kurar.
%
%%  MÜCAHÝT ÖZTÜRK
%   Harran Üniversitesi Bilgisayar Mühendisliði     
%   Örüntü Tanýma Final Sýnavý Ödevi - 3. Soru
%% SABÝTLER
DosyaVeri='data3.csv';

%% VERININ OKUNMASI
% Verilerin okunmasý
fprintf('\n');
fprintf(1,'data3.csv dosyasý okunuyor .....\n\n');

fid=fopen(DosyaVeri);
Baslik=fgets(fid);
% Data = [Latitude Longitude Depth Magnitude]
Data=[];
tline = '99,9;99,9;99,9;9'; % baþlangýç için atanan saçma deðer
while tline~=-1    
    tline = strrep(tline,',','.');
    p=strfind(tline,';');
    if ~isequal(size(p),[1 3]), error('Dosya içinde veri ayrýmýnda sorun var'); end
    A=[str2double(tline(1:p(1)-1)) str2double(tline(p(1)+1:p(2)-1)) str2double(tline(p(2)+1:p(3)-1)) str2double(tline(p(3)+1:end))];
    if ~isequal(size(A),[1 4]), error('Ayrýþtýrýlan veri boyutunda sorun var'); end
    Data=[Data;A];
    tline = fgets(fid);
end
Data=Data(2:end,:);
fclose(fid);
clear p A Baslik fid ans DosyaVeri tline

%% LÝNEER REGRESYON UYGULANMASI
X=Data(:,1:3); y=Data(:,end);
mdl = fitlm(X,y); 
ModelSonuc=predict(mdl,X);

% RMSE hesabý
RMSE=sqrt(mean((y-ModelSonuc).^2));

%% SONUÇLARIN YAZDIRILMASI
fprintf('\n');
fprintf(1,'LINEER REGRESYON TEST SONUÇLARI:\n\n');
fprintf(1,'                 Toplam veri sayýsý: %d \n',size(Data,1));
fprintf(1,'  Gerçek - Model kýsyaslamasý sonucu RMSE: %.2f \n\n',RMSE);

