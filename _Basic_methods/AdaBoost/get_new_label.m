function [new_label] = get_new_label(old_label)

% 把两类的label变成指定的值

label_value_vec = unique(old_label);
new_label = old_label;
if length(label_value_vec) ~= 2
    disp(['Not a binary-problem!']);
else
    v1 = label_value_vec(1);
    v2 = label_value_vec(2);
    if sum(old_label == v1) >= sum(old_label == v2)
        new_label(find(old_label == v1)) = 1;
        new_label(find(old_label == v2)) = 2;
    else
        new_label(find(old_label == v1)) = 2;
        new_label(find(old_label == v2)) = 1;
    end%if
end%if

end% function