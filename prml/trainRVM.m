function classifier = trainRVM(features, targets, varargin)

[kernel] = process_options(varargin, 'kernel', @linear_kernel);

classifier.type = 'rvm';
classifier.kernel = kernel;

classifier.feature = features;
classifier.targets = targets;

C	= features;
BASIS	= classifier.kernel(features,C);
% OPTIONS		= SB2_UserOptions('iterations',500,...
% 							  'diagnosticLevel', 2,...
% 							  'monitor', 10);
OPTIONS = SB2_UserOptions('iterations',500);
[PARAMETER, HYPERPARAMETER, DIAGNOSTIC] = ...
    SparseBayes('Bernouli', BASIS, targets, OPTIONS);

classifier.basis = BASIS;
classifier.parameter = PARAMETER;
classifier.hyperparameter = HYPERPARAMETER;
classifier.diagnostic = DIAGNOSTIC;

end