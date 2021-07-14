The latest Linux Kernel 5.13.1 and associated DTS does not require modifications for my revision of the 2GB Firefly RK-3399.

Instead, you can get kernel 5.13.1 working by blacklisting pwm-regulator and making sure you are building with regulators: rk808, fixed, and fan53555.

Kernel 5.13.1 also seems to resolve issues I previously had with the WiFi enablement - I can now also use WiFi from my Firefly RK-3399 with the mainline kernel!

For older kernels the following may still be relevant:

----

I've been working on an SDCard image for the Firefly RK3399 (2GB variant) that boots in conjunction with the Firefly provided eMMC images.

I have flashed a recent eMMC image provided by Firefly on the board (I think approx date of 2018-04-14?), this image will try to find the params & kernel image on the SDCard before it then uses eMMC.

See kernel/configs/working-5.3-mainline/ for working DTS and compiled kernel. Note that YMMV due to suspected variances in the boards.

