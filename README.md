# MultiChannelCountingBoxGenerator

Originally designed for the validation of different label segmentation tools, but can be applied to multi-channel images as well

   User defines bounds of an ROI and the size of the desired counting boxes.  Script will generate counting boxes with an anchor point randomly generated within the defined ROI bounds.  With multiple input channels, the script ensures that corresponding counting boxes from one channel have the same range of pixel coordinates as those from the second channel.

   INPUTS: .tif format (not specific to bit depth)

       1) Image wit most visible cytoarchitechture.  This is generally a
       DAPI stained image, or something from which your ROI can be clearly
       identified

       2) Raw labelled image.  The image containing your unprocessed label
       of interest. These can then be used as your ground truth during
       validation.  If doing multi-channel image analysis, select your
       first channel here.

       3) Processed image.  The image containing your processed label of
       interest.  These will be used to assess the validity of your
       segmentation.  If doing multi-channel image analysis, select your
       second channel here.

   OUTPUTS: .png

       Outputs will populate in the desired output folder.  Images with
       "raw" in the file name were generated from the unprocessed image.
       Images with "processed" in the file name were generated from the
       processed image.

**Contributors:**
- **Dylan Terstege*** (code/tool conceptualization/written documentation) - ![twitter-icon_16x16](https://user-images.githubusercontent.com/44174532/113163958-e3d3e400-91fd-11eb-8d79-17906d8d3f25.png)[@dterstege](https://twitter.com/dterstege) - ![Mail](https://user-images.githubusercontent.com/44174532/113164412-50e77980-91fe-11eb-9282-dd83852578ce.png)
<dylan.terstege@ucalgary.ca>


Principal Investigator:
- Jonathan Epp (tool conceptualization) - https://epplab.com

<sub><sup>***corresponding author**</sup></sub>
