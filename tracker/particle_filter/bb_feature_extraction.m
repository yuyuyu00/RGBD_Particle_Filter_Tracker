function x = bb_feature_extraction ( bb , g, rgb_raw, dep_raw, rgb_msk, dep_msk, features )
x.bb = bb;

for f = 1:size(features,2)
    
    % global initilization of feature who needs it
    switch (features{f}.name)

        case 'HoC(RGB Clustering)'
            x.cell(1,1).rgb_hist    = histogram_of_colors   (bb_content(rgb_raw,bb), bb_content(rgb_msk,bb), features{f}.rgb_ctr );
            
        case 'HoC(Uniform)'
            x.cell(1,1).rgb_hist    = histogram_of_colors   (bb_content(rgb_raw,bb), bb_content(rgb_msk,bb), features{f}.rgb_ctr );
            
        case 'HoC (RGB Clustering,Grid2)'
            g = 2;
            for i = 1:g
                for j = 1:g
                    cell_bb = bb_grid (bb,g,i,j);
                    x.cell(i,j).rgb_hist    = histogram_of_colors   (bb_content(rgb_raw,cell_bb), bb_content(rgb_msk,cell_bb), features{f}.rgb_ctr );
                end
            end
            
        case 'Grid Confidence (Beta)'
            for i = 1:g
                for j = 1:g
                    cell_bb = bb_grid (bb,g,i,j);
                    x.cell(i,j).fg_ratio    = box_confidence        (bb_content(rgb_msk,cell_bb));  
                    x.cell(i,j).confidence  = 1; %pdf(prior_dist(i,j),f.cell(i,j).fg_ratio);
                end
            end
            
        case 'medD'
            x.cell(1,1).depth_med   = median_of_depth       (bb_content(dep_raw,bb),bb_content(dep_msk,bb));
    end
end



% 
% for i = 1:g
%     for j = 1:g
%         cell_bb = bb_grid (bb,g,i,j);
%         
%         x.cell(i,j).rgb_hist    = histogram_of_colors   (bb_content(rgb_raw,cell_bb), bb_content(rgb_msk,cell_bb), rgb_ctr );
%         x.cell(i,j).fg_ratio    = box_confidence        (bb_content(rgb_msk,cell_bb));  
%         x.cell(i,j).confidence  = 1; %pdf(prior_dist(i,j),f.cell(i,j).fg_ratio);
%         x.cell(i,j).depth_med   = median_of_depth       (bb_content(dep_raw,cell_bb),bb_content(dep_msk,cell_bb));
%     end
% end
