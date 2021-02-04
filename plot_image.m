function h=plot_image(p,LPNS,cardLPNS)
if p==2
    if nargout
        h=figure;
    end
    for i=1:cardLPNS
        plot(LPNS{i}(1),LPNS{i}(2),'LineStyle','none','Marker','.','MarkerEdgeColor',[0 0 0])
        hold on;
        xlabel('f1(x)');
        ylabel('f2(x)');
        set(gca,'Color',[0.9 0.9 0.9], 'Fontsize', 15)
    end
else
    if p==3
        if nargout
            h=figure;
        end
        for i=1:cardLPNS
            
            scatter3(LPNS{i}(1),LPNS{i}(2),LPNS{i}(3),'.','MarkerEdgeColor',[0 0 0])
            hold on;
            xlabel('f1(x)');
            ylabel('f2(x)');
            zlabel('f3(x)');
            set(gca,'Fontsize', 15)
        end
    else
        h=[];
    end
end

drawnow;
hold off;


end