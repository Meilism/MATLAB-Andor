# Matlab-Andor
MATLAB image analysis code for cold atoms research.

## Functions

### CCD control

**Configuration**
The parameter `serial` is the current CCD serial number, serial = 'Upper': 19330 or 'Lower': 19331.
- [initializeCCD(serial)](/function/config/initializeCCD.m)
- [shutDownCCD(serial)](/function/config/shutDownCCD.m)
- [setCurrentCCD(serial)](/function/config/setCurrentCCD.m)
- [setDataLive1(exposure)](/function/config/setDataLive1.m)
- [setDataLive1Cropped(exposure)](/function/config/setDataLive1Cropped.m)
- [setDataLiveFK(exposure, num_frames)](/function/config/setDataLiveFK.m)
- [setDMDLive(exposure)](/function/config/setDMDLive.m)

**Acquisition**
- [acquireCCDImage(num_images=1, timeout=30)](/function/config/acquireCCDImage.m)
- 

**User Interface**
- [ImageAcquisition](ImageAcquisition.mlapp)
