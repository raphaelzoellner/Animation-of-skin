randn('state',[2979743726;1541610269]);

siz = 30;
step = .4;

x1 = 5:5:25;
y1 = 5:5:25;

x2 = 5:10:25;
y2 = 5:10:25;

numrow = 10/step+1;

X1 = zeros(numrow,numrow,5,5);
Y1 = zeros(numrow,numrow,5,5);
Z1 = zeros(numrow,numrow,5,5);

X2 = zeros(numrow,numrow,3,3);
Y2 = zeros(numrow,numrow,3,3);
Z2 = zeros(numrow,numrow,3,3);


for i = 0:1
    if i == 0
        var=2.5;
        for j = 1:5
            for k = 1:5
                [X1(:,:,j,k),Y1(:,:,j,k),Z1(:,:,j,k)] = gaussfun(var,[x1(j),y1(k)], step);
            end
        end
    else
        var=4;
        for j = 1:3
            for k = 1:3
                [X2(:,:,j,k),Y2(:,:,j,k),Z2(:,:,j,k)] = gaussfun(var+3*rand(1),[x2(j),y2(k)], step);
            end
        end
    end
end

X1 = reshape(X1,[numrow,numrow,25]);
X1 = reshape(X1,[numrow,25*numrow]);
Y1 = reshape(Y1,[numrow,numrow,25]);
Y1 = reshape(Y1,[numrow,25*numrow]);
Z1 = reshape(Z1,[numrow,numrow,25]);
Z1 = reshape(Z1,[numrow,25*numrow]);

X2 = reshape(X2,[numrow,numrow,9]);
X2 = reshape(X2,[numrow,9*numrow]);
Y2 = reshape(Y2,[numrow,numrow,9]);
Y2 = reshape(Y2,[numrow,9*numrow]);
Z2 = reshape(Z2,[numrow,numrow,9]);
Z2 = reshape(Z2,[numrow,9*numrow]);

Xo = X2;
Xn = X1;
Yo = Y2;
Yn = Y1;
Zo = Z2;
Zn = Z1;

Zor = Zo(:,1:numrow);
for i=1:4
    if mod(i,2)==0
        Zor = [Zor, Zo(:,(i/2)*numrow+1:(i/2+1)*numrow)];
    else
        Zor = [Zor, zeros(numrow,numrow)];
    end
end
Zor = [Zor, zeros(numrow,5*numrow)];
for i=6:10
    if mod(i,2)==0
        Zor = [Zor, Zo(:,(i/2)*numrow+1:(i/2+1)*numrow)];
    else
        Zor = [Zor, zeros(numrow,numrow)];
    end
end
Zor = [Zor, zeros(numrow,5*numrow)];
for i=12:16
    if mod(i,2)==0
        Zor = [Zor, Zo(:,(i/2)*numrow+1:(i/2+1)*numrow)];
    else
        Zor = [Zor, zeros(numrow,numrow)];
    end
end


    min_x = min(min(Xn));
    min_y = min(min(Yn));
    max_x = max(max(Xn));
    max_y = max(max(Yn));

    planeimg = Zor;

    figure; hold on;
    set(gca,'zlim',[-0.1 0.1])
  
    surf(Xn,Yn,Zor)
    
    colormap(gray);

    imgzposition = -0.08;

    surf(Xn,Yn,repmat(imgzposition, [numrow, 25*numrow]),...
        planeimg,'facecolor','texture')

    colormap(jet);

    view(37.5,22.5);
    
    planeimg = Zn;

    figure; hold on;
    set(gca,'zlim',[-0.1 0.1])
    
    surf(Xn,Yn,Zn)
    
    colormap(gray);

    imgzposition = -0.08;

    surf(Xn,Yn,repmat(imgzposition, [numrow, 25*numrow]),...
        planeimg,'facecolor','texture')

    colormap(jet);
    
    view(37.5,22.5);
    
    Z = zeros(numrow, 25*numrow);
    diff = Zn-Zor;
    figure('units','pixels','position',[0 0 1920 1080]); hold on;
    writerObj = VideoWriter('peaks.avi');
    open(writerObj);

    Z = peaks; surf(Z); 
    axis tight
    set(gca,'nextplot','replacechildren');
    set(gcf,'Renderer','zbuffer');
    
    
    for t=1:300
            
            surf(Xn,Yn,Zor+t/300*diff)
            set(gca,'zlim',[-0.1 0.1])
            frame = getframe;
            writeVideo(writerObj,frame);
    
    end
    
    close(writerObj);
   
     

    