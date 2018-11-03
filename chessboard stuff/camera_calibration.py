from numpy import *
from cv2 import *
from glob2 import *

# termination criteria
criteria = (TERM_CRITERIA_EPS + TERM_CRITERIA_MAX_ITER, 30, 0.001)

# prepare object points, like (0,0,0), (1,0,0), ..., (6,5,0)
objp = zeros((6*7,3), float32)
objp[:,:2] = mgrid[0:7, 0:6].T.reshape(-1,2)

# arrays to store object points and image points from all the images.
objpoints = []  # 3d point in real world space
imgpoints = []  # 2d point in image plane

images = glob('*.jpg')

for fname in images:
    img = imread(fname)
    grey = cvtColor(img, COLOR_BGR2GRAY)

    # find the chess board corners
    ret, corners = findChessboardCorners(grey, (7, 6), None)

    # if found, add object points, image points (after refining them)
    if ret:
        objpoints.append(objp)

        corners2 = cornerSubPix(grey, corners, (11, 11), (-1, -1), criteria)
        imgpoints.append(corners2)

        # draw and display the corners
        img = drawChessboardCorners(img, (7, 6), corners2, ret)
        imshow('img', img)
        waitKey(500)

destroyAllWindows()

ret, mtx, dist, rvecs, tvecs = calibrateCamera(objpoints, imgpoints, grey.shape[::-1], None, None)

for fname in images:
    img = imread(fname)
    h, w = img.shape[:2]
    newcameramtx, roi = getOptimalNewCameraMatrix(mtx, dist, (w, h), 1, (w,h))

    # undistort
    mapx, mapy = initUndistortRectifyMap(mtx, dist, None, newcameramtx, (w, h), 5)
    dst = remap(img, mapx, mapy, INTER_LINEAR)

    # crop the image
    x,y,w,h = roi
    dst = dst[y:y + h, x:x + w]
    imwrite('calibresult.png', dst)

    new_img = imread('calibresult.png')

    imshow('image', new_img)
    waitKey(500)

destroyAllWindows()

savez('temporary', mtx=mtx, dist=dist, rvecs=rvecs, tvecs=tvecs)
