from cv2 import *
from numpy import *

img1 = imread('left.jpg', 0)  # query image  # left image
img2 = imread('right.jpg', 0)  # train image  # right image

sift = xfeatures2d.FREAK_create()

# find the keypoints and descriptors with SIFT
kp1, des1 = sift.compute(img1, None)
kp2, des2 = sift.compute(img2, None)

# FLANN parameters
FLANN_INDEX_KDTREE = 0
index_params = dict(algorithm=FLANN_INDEX_KDTREE, trees=5)
search_params = dict(checks=50)

flann = FlannBasedMatcher(index_params, search_params)
matches = flann.knnMatch(des1, des2, k=2) # finding no matches and program is unusable as a result

good = []
pts1 = []
pts2 = []

# ratio test as per Lowe's paper
for i, (m, n) in enumerate(matches):
    if m.distance < 0.8*n.distance:
        good.append(m)
        pts2.append(kp2[m.trainIdx].pt)
        pts1.append(kp1[m.queryIdx].pt)

pts1 = int32(pts1)
pts2 = int32(pts2)
F, mask = findFundamentalMat(pts1, pts2, FM_LMEDS)

# we select only inlier points
pts1 = pts1(mask.ravel() == 1)
pts2 = pts2(mask.ravel() == 1)

def drawLines(img1, img2, lines, pts1, pts2):
    ''' img1 - image on which we draw the epilines for the points in img2
    lines - corresponding epilines'''
    r, c = img1.shape
    img1 = cvtColor(img1, COLOR_GRAY2BGR)
    img2 = cvtColor(img2, COLOR_GRAY2BGR)
    for r, pt1, pt2 in zip(lines, pts1, pts2):
        colour = tuple(random.randint(0, 255, 3).tolist())
        x0, y0 = map(int, [0, -r[2]/r[1] ])
        x1, y1 = map(int, [c, -(r[2] + r[0]*c)/r[1] ])
        img1 = line(img1, (x0, y0), (x1, y1), colour, 1)
        img1 = circle(img1, tuple(pt1), 5, colour, -1)
        img2 = circle(img2, tuple(pt2), 5, colour, -1)
    return img1, img2


# find epilines corresponding to points in right image (second image) and
# drawing its lines on left image
lines1 = xfeatures2d.computeCorrespondingEpilines_create(pts1.reshape(-1, 1, 2), 2, F)
lines1 = lines1.reshape(-1, 3)
img5, img6 = drawLines(img1, img2, lines1, pts1, pts2)

# find epilines corresponding to points in left image (first image) and
# drawing its lines on right image
lines2 = xfeatures2d.computeCorrespondingEpilines_create(pts2.reshape(-1, 1, 2), 1, F)
lines2 = lines2.reshape(-1, 3)
img3, img4 = drawLines(img2, img1, lines2, pts2, pts1)

imshow('img', img5)
imshow('img', img3)
k = waitKey(0) & 0xff
if k == 's':
    destroyAllWindows()
