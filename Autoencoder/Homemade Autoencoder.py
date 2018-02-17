
# coding: utf-8

#Questions

#1. Linear activation vs sigmoid, etc

#2. How much compression do we want?

#3. How to account for string variables like brain region, etc?

#here I have outlined a simple, a deep, and a variational autoencoder. Chose not to implemnt a convultional neural 
#network because we are working with numeric data.

from keras.layers import Input, Dense
from keras.models import Model

# this is the size of our encoded representations
encoding_dim = 15  # number of hidden layers
#compression of factor of 100 with 8857-6 = 8851 numeric variables of gene expression?

# this is our input placeholder
input_img = Input(shape=(8851,))

# "encoded" is the encoded representation of the input
encoded = Dense(encoding_dim, activation='linear')(input_img)

# "decoded" is the lossy reconstruction of the input
decoded = Dense(8851, activation='linear')(encoded)

# this model maps an input to its reconstruction
autoencoder = Model(input_img, decoded)

# this model maps an input to its encoded representation
encoder = Model(input_img, encoded)

# create a placeholder for an encoded (X-dimensional) input
encoded_input = Input(shape=(encoding_dim,))
# retrieve the last layer of the autoencoder model
decoder_layer = autoencoder.layers[-1]
# create the decoder model
decoder = Model(encoded_input, decoder_layer(encoded_input))

autoencoder.compile(optimizer='adadelta', loss='binary_crossentropy')

import requests
import numpy as np
import pandas as pd
import string as st
import os

#os.chdir('/Users/caitdreisbach/Dropbox (Personal)/NeuroimmunologyCapstone-master 5/TFIDF/')

#Lun.full = pd.read_csv("processed_Lun.csv", encoding = "ISO-8859-1") #, encoding = "ISO-8859-1"

#lun with only gene expression values, no strings
#Lun = pd.read_csv("processed_Lun_GeneExp.csv", encoding = "ISO-8859-1") 

Lun = np.genfromtxt('/Users/caitdreisbach/Dropbox (Personal)/NeuroimmunologyCapstone-master 5/TFIDF/processed_Lun_GeneExp.csv',delimiter = ',')

#split into train and test sets

train_size = int(len(Lun)*0.60)
test_size = len(Lun)-train_size

x_train, x_test = Lun[0:train_size,:], Lun[train_size:len(Lun),:]

#Lun.m.dtypes

#print(Lun.columns[0:100]) #inspect the columns
#print(Lun.columns[101:200])

#Lun.describe() #summary statistics

#normalize to less than 1
x_train = x_train.astype('float64') / 255.
x_test = x_test.astype('float64') / 255.

print(x_train.shape)
print(x_test.shape)

autoencoder.fit(x_train, x_train,
                epochs=50,
                batch_size=100,
                shuffle=True,
                validation_data=(x_test, x_test))

# encode and decode some digits
# note that we take them from the *test* set
encoded_imgs = encoder.predict(x_test)
decoded_imgs = decoder.predict(encoded_imgs)

# display reconstruction
plt.plot(decoded_imgs[:,:])
plt.show() 

# display original
plt.plot(x_test[:,:])
plt.show()

#adding a sparsity constraint

from keras import regularizers

encoding_dim = 32

input_img = Input(shape=(8851,))
# add a Dense layer with a L1 activity regularizer
encoded = Dense(encoding_dim, activation='relu',
                activity_regularizer=regularizers.l1(10e-5))(input_img)
decoded = Dense(8851, activation='sigmoid')(encoded)

autoencoder = Model(input_img, decoded)


# this model maps an input to its encoded representation
encoder = Model(input_img, encoded)

# create a placeholder for an encoded (X-dimensional) input
encoded_input = Input(shape=(encoding_dim,))
# retrieve the last layer of the autoencoder model
decoder_layer = autoencoder.layers[-1]
# create the decoder model
decoder = Model(encoded_input, decoder_layer(encoded_input))

autoencoder.compile(optimizer='adadelta', loss='binary_crossentropy')

autoencoder.fit(x_train, x_train,
                epochs=50,
                batch_size=100,
                shuffle=True,
                validation_data=(x_test, x_test))

#Deep autoencoder

from keras import regularizers

encoding_dim = 32

input_img = Input(shape=(8851,))
encoded = Dense(128, activation='relu')(input_img)
encoded = Dense(64, activation='relu')(encoded)
encoded = Dense(32, activation='relu')(encoded)

decoded = Dense(64, activation='relu')(encoded)
decoded = Dense(128, activation='relu')(decoded)
decoded = Dense(8851, activation='sigmoid')(decoded)

autoencoder = Model(input_img, decoded)
autoencoder.compile(optimizer='adadelta', loss='binary_crossentropy')

autoencoder.fit(x_train, x_train,
                epochs=100,
                batch_size=256,
                shuffle=True,
                validation_data=(x_test, x_test))

from keras.layers import Input, Dense, Lambda
from keras.models import Model
from keras import backend as K
from keras import objectives
from scipy.stats import norm


#variational autoencoder
batch_size = 100
original_dim = 8851
latent_dim = 2
intermediate_dim = 256
nb_epoch = 50
epsilon_std = 1.0

x = Input(batch_shape=(batch_size, original_dim))
h = Dense(intermediate_dim, activation='relu')(x)
z_mean = Dense(latent_dim)(h)
z_log_sigma = Dense(latent_dim)(h)

def sampling(args):
    z_mean, z_log_sigma = args
    epsilon = K.random_normal(shape=(batch_size, latent_dim),
                              mean=0., std=epsilon_std)
    return z_mean + K.exp(z_log_sigma) * epsilon

# note that "output_shape" isn't necessary with the TensorFlow backend
# so you could write `Lambda(sampling)([z_mean, z_log_sigma])`
z = Lambda(sampling, output_shape=(latent_dim,))([z_mean, z_log_sigma])

decoder_h = Dense(intermediate_dim, activation='relu')
decoder_mean = Dense(original_dim, activation='sigmoid')
h_decoded = decoder_h(z)
x_decoded_mean = decoder_mean(h_decoded)

# end-to-end autoencoder
vae = Model(x, x_decoded_mean)

# encoder, from inputs to latent space
encoder = Model(x, z_mean)

# generator, from latent space to reconstructed inputs
decoder_input = Input(shape=(latent_dim,))
_h_decoded = decoder_h(decoder_input)
_x_decoded_mean = decoder_mean(_h_decoded)
generator = Model(decoder_input, _x_decoded_mean)

def vae_loss(x, x_decoded_mean):
    xent_loss = objectives.binary_crossentropy(x, x_decoded_mean)
    kl_loss = - 0.5 * K.mean(1 + z_log_sigma - K.square(z_mean) - K.exp(z_log_sigma), axis=-1)
    return xent_loss + kl_loss

vae.compile(optimizer='rmsprop', loss=vae_loss)

#x_train = x_train.astype('float64') / 255.
#x_test = x_test.astype('float64') / 255.

vae.fit(x_train, x_train,
        shuffle=True,
        epochs=epochs,
        batch_size=batch_size,
        validation_data=(x_test, x_test))

x_test_encoded = encoder.predict(x_test, batch_size=batch_size)
plt.figure(figsize=(6, 6))
plt.scatter(x_test_encoded[:, 0], x_test_encoded[:, 1], c=y_test)
plt.colorbar()
plt.show()

