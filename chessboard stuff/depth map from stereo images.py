from cv2 import *

imgL = imread('left.jpg', 0)
imgR = imread('right.jpg', 0)

stereo = StereoBM_create(numDisparities=48, blockSize=5)
disparity = stereo.compute(imgL, imgR)
imshow('disparity', disparity)
waitKey(0)

destroyAllWindows()

# doesn't work
