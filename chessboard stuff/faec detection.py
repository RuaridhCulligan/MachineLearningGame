from numpy import *
from cv2 import *

face_cascade = CascadeClassifier('haarcascade_frontalface_default.xml')
eye_cascade = CascadeClassifier('haarcascade_eye.xml')

img = imread('person_test.jpeg')
grey = cvtColor(img, COLOR_BGR2GRAY)

faces =  face_cascade.detectMultiScale(grey, 1.3, 5)
for (x, y, w, h) in faces:
    img = rectangle(img, (x, y), (x + w, y + h), (255, 0, 0), 2)
    roi_grey = grey[y:y+h, x:x+w]
    roi_colour = img[y:y + h, x:x + w]
    eyes = eye_cascade.detectMultiScale(roi_grey)
    for (ex, ey, ew, eh) in eyes:
        rectangle(roi_colour, (ex, ey), (ex + ew, ey + eh), (0, 255, 0), 2)


imshow('image', img)
waitKey(0)
destroyAllWindows()
