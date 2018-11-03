from cv2 import *
from numpy import *
from glob2 import *

# Load previously saved data
with load('temporary.npz') as X:
    mtx, dist, _, _ = [X[i] for i in ('mtx', 'dist', 'rvecs', 'tvecs')]


def draw(img, corners, imgpts):
    imgpts = int32(imgpts).reshape(-1, 2)

    # darw ground floor in green
    img = drawContours(img, [imgpts[:4]], -1, (0, 255, 0), -3)

    # draw pillars in blue colour
    for i,j in zip(range(4), range(4,8)):
        img = line(img, tuple(imgpts[i]), tuple(imgpts[j]), (255), 3)

    # draw top layer in red colour
    img = drawContours(img, [imgpts[4:]], -1, (0, 0, 255), 3)

    return img


criteria = (TERM_CRITERIA_EPS + TERM_CRITERIA_MAX_ITER, 30, 0.001)
objp = zeros((6*7,3), float32)
objp[:,:2] = mgrid[0:7, 0:6].T.reshape(-1, 2)

axis = float32([[0, 0, 0], [0, 3, 0], [3, 3, 0], [3, 0, 0],
                [0, 0, -3], [0, 3, -3], [3, 3, -3], [3, 0, -3] ])

for fname in glob('left*.jpg'):
    img = imread(fname)
    grey = cvtColor(img, COLOR_BGR2GRAY)
    ret, corners = findChessboardCorners(grey, (7, 6), None)

    if ret:
        corners2 = cornerSubPix(grey, corners, (11, 11), (-1, 1), criteria)

        # find the rotation and translation vectors.
        _, rvecs, tvecs, inliers = solvePnPRansac(objp, corners2, mtx, dist)

        # project 3D points to image plane
        imgpts, jac = projectPoints(axis, rvecs, tvecs, mtx, dist)

        img = draw(img, corners2, imgpts)
        imshow('img', img)
        k = waitKey(0) & 0xff
        if k == 's':
            imwrite(fname[:6] + '.png', img)

destroyAllWindows()
