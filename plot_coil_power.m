
load results_SAR_shift6_vflip0_hflip1.mat

% whatever regularization value you choose
reg_index = 12;
% should be arbitrary
slice_index = 32;

bmat = results.all_b(reg_index,:,slice_index);

coil_groupings = results.solution_coil_groupings;

coil_powers = zeros(size(coil_groupings));

num_groups = 8;
num_coils_per_group = 4;
for group_index = 1:num_groups
    for coil_index = 1:num_coils_per_group
        index = coil_groupings(group_index,coil_index);
        if index == -1
            % this indicates the unused coil index (group of 2)
            power = 0;
        else
            power = bmat(index);
        end
        coil_powers(group_index,coil_index) = power;
    end
end

figure, im(coil_powers'/max(abs(coil_powers),[],"all")),
colormap jet
colorbar
xlabel('coil index')
ylabel('group #')