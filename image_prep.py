import cv2
import numpy as np
import keyboard

def img_crop(image):
    cv2.imwrite('1.png', image)
    crop = image[11:412, 98:585]
    cv2.imshow("cropped", crop)
    cv2.imwrite('2.png', crop)
    params = cv2.SimpleBlobDetector_Params()
    params.minThreshold = 120
    params.maxThreshold = 200
    detector = cv2.SimpleBlobDetector_create(params)
    keypoints = detector.detect(crop)
    # print(keypoints)
    im_with_keypoints = cv2.drawKeypoints(crop, keypoints, np.array([]), (0, 0, 255),
                                          cv2.DRAW_MATCHES_FLAGS_DRAW_RICH_KEYPOINTS)
    cv2.imshow("Keypoints", im_with_keypoints)
    points = cv2.KeyPoint.convert(keypoints)
    ind = np.array(np.floor(points).astype(int))
    xc = ind[0, 0]
    yc = ind[0, 1]
    img_to_save = crop[yc - 45:yc + 45, xc - 45:xc + 45]
    cv2.imshow("img_to_save", img_to_save)
    cv2.waitKey(0)
    return img_to_save

vid = cv2.VideoCapture(0)
i = 1
while True:

    ret, img = vid.read()
    cv2.imshow('img', img[11:412, 98:585])
    if keyboard.is_pressed("q"):
        print("q pressed, ending loop")
        break

    if cv2.waitKey(1) & 0xFF == ord('a'):
        print('saved:', i)
        path = "bad/bad" + str(i) + ".png"
        to_save = img_crop(img)
        cv2.imwrite(path, to_save)
        i += 1

vid.release()
cv2.destroyAllWindows()




