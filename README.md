I've been working on an SDCard image for the Firefly RK3399 (2GB variant) that boots in conjunction with the Firefly provided eMMC images.

I have flashed a recent eMMC image provided by Firefly on the board (I think approx date of 2018-04-14?), this image will try to find the params & kernel image on the SDCard before it then uses eMMC.

See kernel/configs/working-5.3-mainline/ for working DTS and compiled kernel. Note that YMMV due to suspected variances in the boards.

