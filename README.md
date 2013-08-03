RokuLib
=======

Lightweight library for making Roku UI development easier, especially if using the ``roScreen`` component. Currently incomplete, but hopefully I will have most of the library done by the end of August 2013. Right now this supports loading images, buttons, horizontal/vertical control groups, etc. In addition, there is a simple 2D carousel that can support animations.

##Installation

To use this library simply copy the contents of ``RokuLib`` into your source directory.

Using ``RokuLib`` with Eclipse is recommended since you'll have access to useful documentation written in Javadoc style.

##Components

###Image Carousel

There's a simple (animated) 2D image carousel you can use for displaying show images (think of it as a more basic Apple coverflow). I'm still working on optimizing its performance. Unfortunately, the image carousel is really slow unless one is on the Roku 2 or higher

##Utilities

###Math
There are several math utilities not native to the Roku SDK. Some functionality includes:

-Modulo
-Ceiling/floor

###Image scaling

The image scaling algorithms used by the Roku aren't very good, unless bilinear scaling is used. Unfortunately, ``roBitmaps`` themselves don't support bilinearly scaled drawing to a ``roScreen``. On the newer Roku models, you must create a ``roRegion`` (think of it as a region of a bitmap) set its scaling mode to 1, then draw it to a ``roScreen``. This is even more tricky on the Roku classic models, where bilinear scaling is only supported for ``roRegion`` to ``roRegion`` draw calls.

I've written a function to get a bilinearly scaled bitmap using ``roRegion`` to ``roRegion`` drawing (i.e. it gets the bitmap from the ``roRegion`` object). Note that because of the overhead of additional ``roBitmap`` and ``roRegion`` object creation, this *can* take a long time per image: about 200 ms on Roku classic models, or 50 ms on Roku 2/3 models. However, this seems to be the only way to get a nice image on Roku classic models.

###Bitmap managing

Roku developers know that ``roBitmaps`` are expensive to both create and store in memory (on the Roku 1, about 50-100 ms depending on bitmap dimensions). I've used lazy allocation and a manager to help with this: bitmaps are only allocated when they are needed (e.g. for a draw call). In addition, bitmap references are not stored in ``RlImage`` objects; they are stored in ``RlBitmapManager``. Hopefully this makes deallocating them easier, because you only have to call ``Clear()`` in ``RlBitmapManager``.
