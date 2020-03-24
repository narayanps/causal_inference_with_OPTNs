
function h = entropy(x,y)
%%%%%%%%%%%%%%%%%
% this file is created by Nashat Abughalieh
% if you used this in ur work please refere to me first
%%%%%%%%%%%%%%%%

if nargin < 2
    h = jentropy(x');
else 
    if size(y,1) == 1
        h = jentropy([x;y]') - jentropy(y');
    else
        h = entropy([x;y(1,:)],y(2:end,:)) - entropy(y(1,:),y(2:end,:));
    end
end

% else 
%     if size(y,1) == 1
%         h = jentropy([x;y]') - jentropy(y');
%     else
%         h = entropy([x;y(1,:)],y(2:end,:)) - entropy(y(1,:),y(2:end,:));
%     end
% end
