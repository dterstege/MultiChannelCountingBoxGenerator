%%          Generating Counting Boxes for Label Quantification
%   
%   Originally designed for the validation of different label segmentation
%   tools, but can be applied to multi-channel images as well
%
%   User defines bounds of an ROI and the size of the desired counting
%   boxes.  Script will generate counting boxes with an anchor point
%   randomly generated within the defined ROI bounds.  With multiple input
%   channels, the script ensures that corresponding counting boxes from one
%   channel have the same range of pixel coordinates as those from the
%   second channel.
%   
%
%   INPUTS: .tif format (not specific to bit depth)
%
%       1) Image wit most visible cytoarchitechture.  This is generally a
%       DAPI stained image, or something from which your ROI can be clearly
%       identified
%
%       2) Raw labelled image.  The image containing your unprocessed label
%       of interest. These can then be used as your ground truth during
%       validation.  If doing multi-channel image analysis, select your
%       first channel here.
%
%       3) Processed image.  The image containing your processed label of
%       interest.  These will be used to assess the validity of your
%       segmentation.  If doing multi-channel image analysis, select your
%       second channel here.
%
%   OUTPUTS: .png
%
%       Outputs will populate in the desired output folder.  Images with
%       "raw" in the file name were generated from the unprocessed image.
%       Images with "processed" in the file name were generated from the
%       processed image.
%   
%
%   Created 04/09/2020 Dylan Terstege
%   Epp Lab, University of Calgary
%   Contact: dylan.terstege@ucalgary.ca



%user inputs - box information
prompt='How many ROIs? ';
regnum=input(prompt);
prompt='How many boxes per ROI? ';
boxnum=input(prompt);
prompt='Desired counting box height (in pixels): ';
ybox=input(prompt);

%user inputs - image information
warning('off','all');
disp('Select the image with the most visible cytoarcitechture');
[dapifile,dapipath]=uigetfile('*.tif','Select an image to register');
disp('Select the raw unprocessed labelled imaged');
[rawfile,rawpath]=uigetfile('*.tif','Select the corresponding raw labelled image');
disp('Select the corresponding processed image');
[iofile,iopath]=uigetfile('*.tif','Select the corresponding processed image');
disp('Select a folder to output your images to');
outpath=uigetdir(dapipath,'Select and output folder');

%initialization
dapiim=strcat(dapipath,dapifile);
rawim=strcat(rawpath,rawfile);
ioim=strcat(iopath,iofile);

[dapi,~]=imread(dapiim);
[raw,~]=imread(rawim);
[io,~]=imread(ioim);
[yim,xim,channels]=size(dapi);


%point and click
for ii=1:regnum
    imshow(dapi);
    hold on
    disp('Click on the bottom left corner of an imaginary box around the ROI');
    [bx,by]=ginput(1);
    plot(bx,by,'ro');
    disp('Click on the top right corner of an imaginary box around the ROI');
    [tx,ty]=ginput(1);
    plot(tx,ty,'ro');

    prompt='What is the name of this region? ';
    regname=input(prompt,'s');
    close()

    inbx=round(bx);
    inby=round(by);
    intx=round(tx);
    inty=round(ty);

    for k=1:boxnum
        y1 = randi([inty, inby]);
        x1 = randi([inbx, intx]);
        y2 = y1 + ybox - 1;
        x2 = x1 + ybox - 1;
        while y2 > yim
            y1 = randi([inty, inby]);
            y2 = y1 + ybox - 1;
        end
        while x2 > xim
            x1 = randi([inbx, intx]);
            x2 = x1 + ybox - 1;
        end
        countbox=raw(y1:y2, x1:x2, 1:channels);
        figure();imshow(countbox);
        imname=strcat(regname,'_raw_',num2str(k));
        newPathL=char(strcat(outpath,'\',imname));
        saveas(gca,newPathL,'png');
        close()
        countbox=io(y1:y2, x1:x2, 1:channels);
        figure();imshow(countbox);
        imname=strcat(regname,'_processed_',num2str(k));
        newPathL=char(strcat(outpath,'\',imname));
        saveas(gca,newPathL,'png');
        close()
    end
end