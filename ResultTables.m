function ResultTables(param,betavec,result_js,result_jr87,dopltos)
	%this function makes nice tables of results from the MC run
	%it can be called during the MC loop to save intermediate results on disk

	%number of produced results for different betas
	numbetas=min([numel(betavec);numel(result_js);numel(result_jr87)]);

	fprintf('\n\n\n');
	diary 'GrandResultsMC.txt'
	disp(datestr(now));

	fprintf('Table 1: Estimation results (RMSE in brackets)\n');
	fprintf('----------------------------------------------------------------------------------------------------------------------------------------------------------\n');
	fprintf('%20s %18s %18s %18s %18s %18s %18s %18s\n','Method','RC','c','p1','p2','p3','p4','p5');
	fprintf('----------------------------------------------------------------------------------------------------------------------------------------------------------\n');
	fprintf('%20s %18.4f %18.4f %18.4f %18.4f %18.4f %18.4f %18.4f\n','True values -->     ',param.RC,param.thetaCost,param.thetaProbs);
	fprintf('----------------------------------------------------------------------------------------------------------------------------------------------------------\n');
	for i=1:numbetas
	fprintf('beta = %1.5f\n',betavec(i));
	%corrections of the results for display
	%add zeros if dimentions are too low
	if sum(size(result_js{i}.mean_estimates)<[7 4])
		result_js{i}.mean_estimates(7,4)=0;
	end
	if sum(size(result_js{i}.std_estimates)<[7 3])
		result_js{i}.std_estimates(7,3)=0;
	end
	if size(result_jr87{i}.p.est,2)<5
		result_jr87{i}.p.est(size(result_jr87{i}.p.est,1),5)=0;
	end
	fprintf('----------------------------------------------------------------------------------------------------------------------------------------------------------\n');
	js_method=1;%MPEC/AMPL
	fprintf('%20s %8.4f(%8.4f) %8.4f(%8.4f) %8.4f(%8.4f) %8.4f(%8.4f) %8.4f(%8.4f) %8.4f(%8.4f) %8.4f(%8.4f)\n',...
					'MPEC/AMPL',...
					result_js{i}.mean_estimates(7,js_method+1),result_js{i}.rmse_estimates(7,js_method),...
					result_js{i}.mean_estimates(1,js_method+1),result_js{i}.rmse_estimates(1,js_method),...
					result_js{i}.mean_estimates(2,js_method+1),result_js{i}.rmse_estimates(2,js_method),...
					result_js{i}.mean_estimates(3,js_method+1),result_js{i}.rmse_estimates(3,js_method),...
					result_js{i}.mean_estimates(4,js_method+1),result_js{i}.rmse_estimates(4,js_method),...
					result_js{i}.mean_estimates(5,js_method+1),result_js{i}.rmse_estimates(5,js_method),...
					result_js{i}.mean_estimates(6,js_method+1),result_js{i}.rmse_estimates(6,js_method)...
				 )
	js_method=2;%MPEC/ktrlink
	fprintf('%20s %8.4f(%8.4f) %8.4f(%8.4f) %8.4f(%8.4f) %8.4f(%8.4f) %8.4f(%8.4f) %8.4f(%8.4f) %8.4f(%8.4f)\n',...
					'MPEC/ktrlink',...
					result_js{i}.mean_estimates(7,js_method+1),result_js{i}.rmse_estimates(7,js_method),...
					result_js{i}.mean_estimates(1,js_method+1),result_js{i}.rmse_estimates(1,js_method),...
					result_js{i}.mean_estimates(2,js_method+1),result_js{i}.rmse_estimates(2,js_method),...
					result_js{i}.mean_estimates(3,js_method+1),result_js{i}.rmse_estimates(3,js_method),...
					result_js{i}.mean_estimates(4,js_method+1),result_js{i}.rmse_estimates(4,js_method),...
					result_js{i}.mean_estimates(5,js_method+1),result_js{i}.rmse_estimates(5,js_method),...
					result_js{i}.mean_estimates(6,js_method+1),result_js{i}.rmse_estimates(6,js_method)...
				 )
	js_method=3;%NFXP-SA with ktrlink
	fprintf('%20s %8.4f(%8.4f) %8.4f(%8.4f) %8.4f(%8.4f) %8.4f(%8.4f) %8.4f(%8.4f) %8.4f(%8.4f) %8.4f(%8.4f)\n',...
					'NFXP-SA/ktrlink',...
					result_js{i}.mean_estimates(7,js_method+1),result_js{i}.rmse_estimates(7,js_method),...
					result_js{i}.mean_estimates(1,js_method+1),result_js{i}.rmse_estimates(1,js_method),...
					result_js{i}.mean_estimates(2,js_method+1),result_js{i}.rmse_estimates(2,js_method),...
					result_js{i}.mean_estimates(3,js_method+1),result_js{i}.rmse_estimates(3,js_method),...
					result_js{i}.mean_estimates(4,js_method+1),result_js{i}.rmse_estimates(4,js_method),...
					result_js{i}.mean_estimates(5,js_method+1),result_js{i}.rmse_estimates(5,js_method),...
					result_js{i}.mean_estimates(6,js_method+1),result_js{i}.rmse_estimates(6,js_method)...
				 )
	fprintf('%20s %8.4f(%8.4f) %8.4f(%8.4f) %8.4f(%8.4f) %8.4f(%8.4f) %8.4f(%8.4f) %8.4f(%8.4f) %8.4f(%8.4f)\n',...
					'NFXP-NK/BHHH',...
					mean(result_jr87{i}.RC.est),sqrt(mean((result_jr87{i}.RC.est-param.RC).^2)),...
					mean(result_jr87{i}.c.est),sqrt(mean((result_jr87{i}.c.est-param.thetaCost).^2)),...
					mean(result_jr87{i}.p.est(:,1)),sqrt(mean((result_jr87{i}.p.est(:,1)-param.thetaProbs(1)).^2)),...
					mean(result_jr87{i}.p.est(:,2)),sqrt(mean((result_jr87{i}.p.est(:,2)-param.thetaProbs(2)).^2)),...
					mean(result_jr87{i}.p.est(:,3)),sqrt(mean((result_jr87{i}.p.est(:,3)-param.thetaProbs(3)).^2)),...
					mean(result_jr87{i}.p.est(:,4)),sqrt(mean((result_jr87{i}.p.est(:,4)-param.thetaProbs(4)).^2)),...
					mean(result_jr87{i}.p.est(:,5)),sqrt(mean((result_jr87{i}.p.est(:,5)-param.thetaProbs(5)).^2))...
				 )

	fprintf('----------------------------------------------------------------------------------------------------------------------------------------------------------\n');
	end
	fprintf('\n\n');

	fprintf('Table 2: Numerical performance\n');
	fprintf('-----------------------------------------------------------------------------------------------------------------------\n');

	fprintf('%14s  %14s %14s %14s %14s %14s %14s\n', ''    , 'Runs Converged', 'CPU Time' ,'# of Major'	,'# of Func.'	,'# of Contract','# of N-K');
	fprintf('%-14s %14s %14s %14s %14s %14s %14s\n', 'beta', sprintf('(out of %g)',param.MC*param.multistarts) ,'(in sec.)','Iter'			,'Eval.'		,'Iter.','Iter.') 
	fprintf('-----------------------------------------------------------------------------------------------------------------------\n');
	fprintf('                                                  MPEC/AMPL\n');
	fprintf('-----------------------------------------------------------------------------------------------------------------------\n');
	for i=1:numbetas
		fprintf('%-14.4g %14d %14.4f %14.4f %14.4f %14s %14s\n', ...
			betavec(i),  result_js{i}.TotalSuccess(1) ,mean(result_js{i}.runtime(result_js{i}.converged(:,1)==1,1)) , ...
			result_js{i}.num_iter(1),result_js{i}.ave_feval(1), '-','-') 
	end
	fprintf('-----------------------------------------------------------------------------------------------------------------------\n');
	fprintf('                                                  MPEC/ktrlink\n');
	fprintf('-----------------------------------------------------------------------------------------------------------------------\n');
	for i=1:numbetas
		fprintf('%-14.4g %14d %14.4f %14.4f %14.4f %14s %14s\n', ...
			betavec(i),  result_js{i}.TotalSuccess(2) ,mean(result_js{i}.runtime(result_js{i}.converged(:,2)==1,2)) , ...
			result_js{i}.num_iter(2),result_js{i}.ave_feval(2), '-','-') 
	end
	fprintf('-----------------------------------------------------------------------------------------------------------------------\n');
	fprintf('                                                  NFXP-SA with ktrlink\n');
	fprintf('-----------------------------------------------------------------------------------------------------------------------\n');
	for i=1:numbetas
		fprintf('%-14.4g %14d %14.4f %14.4f %14.4f %14.4f %14s\n', ...
			betavec(i),  result_js{i}.TotalSuccess(3) ,mean(result_js{i}.runtime(result_js{i}.converged(:,3)==1,3)) , ...
			result_js{i}.num_iter(3),result_js{i}.ave_feval(3), result_js{i}.ave_bellmaniter,'-') 
	end
	fprintf('-----------------------------------------------------------------------------------------------------------------------\n');
	fprintf('                                                  NFXP-NK with 2 step ML and BHHH\n');
	fprintf('-----------------------------------------------------------------------------------------------------------------------\n');
	for i=1:numbetas
		fprintf('%-14.4g %14d %14.4f %14.4f %14.4f %14.4f %14.4f\n', ...
			betavec(i),  result_jr87{i}.TotalSuccess ,mean(result_jr87{i}.runtime(result_jr87{i}.converged)) , ...
			mean(result_jr87{i}.MajorIter),mean(result_jr87{i}.FuncEval), ...
			mean(result_jr87{i}.BellmanIter),mean(result_jr87{i}.NKIter))
	end
	fprintf('-----------------------------------------------------------------------------------------------------------------------\n');
	fprintf('\n');
	fprintf('Remaining parameters\n');
	fprintf('RC   = %10.5f \n',param.RC);
	fprintf('c    = %10.5f \n',param.thetaCost);
	for i= 1:numel(param.thetaProbs)
		fprintf('p(%d) = %10.5f \n',i, param.thetaProbs(i));
	end
	fprintf('n    = %10.5f \n',param.N);
	fprintf('N    = %10.5f \n',param.nBus);
	fprintf('T    = %10.5f \n',param.nT);
	fprintf('\n\n');

	diary off

	if dopltos
		for i=1:numbetas
			fig=figure('Color',[1 1 1],'NextPlot','new');
			ax=axes('Parent',fig);
			xx=(0.001:0.001:1)';
			data{1}=result_js{i}.runtime(result_js{i}.converged(:,1)==1,1);
			hold on
			plot(quantile(data{1},xx),xx, '-k','DisplayName','MPEC/AMPL','Parent',ax);
			plot(quantile(result_jr87{i}.runtime,xx),xx, '-r','DisplayName','NFXP-NK with 2 stage ML and BHHH','Parent',ax);
			xlabel('CPU time (seconds)')
			legend1 = legend(ax,'show');
			set(legend1,'EdgeColor',[1 1 1],'Location','SouthEast','YColor',[1 1 1],'XColor',[1 1 1]);
			title(sprintf('Distribution of estimation CPU Time with beta=%1.5f (conditional on converging)',betavec(i)));
		end
	end
end