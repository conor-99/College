import numpy as np
from PIL import Image

def convolve(array, kernel):
    # pad the input array with zeros
    pad = len(kernel) // 2
    array = np.pad(array, pad, mode='constant')
    
    # get array and kernel dimensions
    N = len(array)
    K = len(kernel)
    
    # init result array
    result = np.zeros((N, N))
    
    # for each pixel in the image (ignoring the padding)
    for x in range(pad, N - pad):
        for y in range(pad, N - pad):
            value = 0
            # for each element in the kernel
            for kx in range(K):
                for ky in range(K):
                    # offset kernel element
                    ox = kx - (K // 2)
                    oy = ky - (K // 2)
                    # add to sum
                    value += kernel[ky][kx] * array[y + oy][x + ox]
            result[y][x] = value
    
    return result

def main():
    rgb = np.array(Image.open('image.png').convert('RGB'))
    red = rgb[:,:,0]
    kernel1 = np.array([[-1,-1,-1],[-1,8,-1],[-1,-1,-1]])
    kernel2 = np.array([[0,-1,0],[-1,8,-1],[0,-1,0]])
    result1 = convolve(red, kernel1)
    result2 = convolve(red, kernel2)
    image1 = Image.fromarray(np.uint8(result1))
    image2 = Image.fromarray(np.uint8(result2))
    image1.show()
    image2.show()
    image1.save('result1.png')
    image2.save('result2.png')

main()
