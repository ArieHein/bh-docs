# Doc5

This document is an example of a markdown file that has two image links.

The first image path, exists in the assets folder
The first image name, exists in the assets folder

Here is the image:
![image](../assets/image1.png)

The second image path, exists in the assets folder
The second image name, does NOT exists in the assets folder

Here is the image:
![image](../assets/image_not_found.png)

## Output

The output of the script should be a failure with a message displaying the number of images found in the document and then for each image display the image path with a status mark, image name with a status mark.
