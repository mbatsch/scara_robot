import tensorflow as tf
import matplotlib.pyplot as plt
import numpy as np
from sklearn.metrics import confusion_matrix, ConfusionMatrixDisplay
from tensorflow.keras.models import Sequential, load_model, model_from_json
from tensorflow.keras.preprocessing.image import ImageDataGenerator

model = load_model('model1.h5')

test_path = 'data/test'
test_batch = ImageDataGenerator(preprocessing_function=tf.keras.applications.vgg16.preprocess_input) \
    .flow_from_directory(directory=test_path, target_size=(90, 90), classes=['good','bad'], batch_size=10, shuffle=False)

test_imgs, test_labels = next(test_batch)

predictions = model.predict(x=test_batch, verbose=0)

cm = confusion_matrix(y_true=test_batch.classes, y_pred=np.argmax(predictions, axis=-1)) # argmax przekazujemy indeks

print(test_batch.class_indices)

cm_plot_labels = ['good', 'bad']
cmDisp = ConfusionMatrixDisplay(confusion_matrix=cm, display_labels=cm_plot_labels)
cmDisp.plot()
plt.show()
