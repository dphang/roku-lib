RokuLib
=======

Lightweight library for making Roku UI development easier, especially if using the ``roScreen`` component. Currently incomplete, but hopefully I will have most of the library done by the end of August 2013.

##Installation

To use this library simply copy the contents of ``RokuLib`` into your source directory.

Using ``RokuLib`` with Eclipse is recommended since you'll have access to useful documentation written in Javadoc style.

##Components

Most components are UI components, meaning that they have some Draw(screen) function. By creating these components, you don't have to worry about the x, y coordinates once they're set: simply call Draw(screen) on each component you want to draw. This way, you can also create an array of drawable objects (most of these components) and simply call Draw() on each of them. Note that Draw() returns true or false depending on whether it could draw to a screen (99.9% of the time, this will return true). So you could make your own Draw() return nothing.

Animated components (such as ``RlSpinner`` or ``RlCarousel``) also have an Update(delta) function, which allows for framerate independent movement/rotation/animation. This can be used to construct complete screens. For example, if your screen has both an ``RlCarousel`` and ``RlSpinner`` object, you can create an Update() function that will call Update() on each of these updateable components.

Because the Roku players don't have very high performance to begin with, it is not recommended to always be drawing components. First, unlike a game, most UI components/images are static until the user does osmething. Second, drawing all screen elements continuously is very expensive.

One strategy is: only draw all components to a ``roScreen`` if something was updated. See the below code for an example, if you have a carousel and a spinner

```
function Update(msg as Dynamic, delta as Float) as Boolean
  'Update content based on event message received
  'Do stuff
  
  'Update spinner if something is loading
  if m.loading then m.spinner.Update(delta)
  if not m.carousel.Update(delta) then return false
  return true
end function

function Draw(screen as Object) as Void
  m.carousel.Draw(screen)
  m.spinner.Draw(screen)
end function
```

Then, in another while loop, you could do:

```
while true:
  msg = wait(1, screen.GetPort())
  'Calculate delta
  delta = ...
  
  if m.Update(msg, delta) then m.Draw(screen) 'Only draw if something was updated
end while
```

###RlImage

An object that stores an image path with x, y coordinates, as well as width/height. This is useful if you want to draw images but don't want to have to remember what their x, y coordinates are. Examples: static logos, UI elements. This image can be scaled both by the nearest neighbor algorithm or bilinearly.

###RlFocusableImage

An object that stores two RlImages: one to show when focused, and one to show by default.

###RlRotatableImage

Same as an RlImage, though the image can be rotated by an angle (though not scaled). Note that the RokuSDK's function DrawRotatedObject() rotates about the top-left coordinate; this object modifies that to use the image's center points. You can use this for creating rotating loading indicators (see also ``RlSpinner``) which does this.

###RlTextArea

Represents text that should fit in a rectangle. This component automatically calculates how text should be rendered based on the text supplied (intelligently splitting the text into lines that do not exceed the width and height). Additionally, if a full word cannot fit on the current line, it is placed on the next line instead. This supports left, center, and right alignment. By default, if there is too much text to fit, ellipses (...) are placed at the end.

###RlText

Represents text at some x, y position. Unlike RlTextArea, this does not try to fit the text in some rectangle. This is a better choice (read: less expensive) if the text you want to render is predefined.

###RlCarousel (Image Carousel)

There's a simple (animated) 2D image carousel you can use for displaying show images (think of it as a more basic Apple coverflow). I'm still working on optimizing its performance. Unfortunately, the image carousel is really slow unless one is on the Roku 2 or higher

###RlHorizontalGroup/RlVerticalGroup

These group components allow you to group components together, horizontally or vertically and with an offset. This is useful for creating menus of multiple icons at the same x or y position. Simply create a Group component, push them to the group, and you only need to call Draw() on the RlHorizontalGroup or RlVerticalGroup.

###RlButton

Represents a button with text centered on it. This is useful is you want to create clickable buttons (e.g. login, select, cancel, etc.)

##Utilities

###Math
There are several math utilities not native to the Roku SDK. Some functionality includes:

- Modulo
- Ceiling/floor

###Sorting

I've implemented insertion sort, merge sort, and quick sort, with optional comparators (default is ascending sort). Practically, quick sort works very well even on small array sizes, so I would use that unless you need a stable sort. I've benchmarked the algorithms on the Roku 3, using a 10000 member array containing pseudorandomly generated integers from 0 to 9999.

Insertion sort: >30 seconds

Merge sort: ~900 ms

Insertion sort: ~750 ms

###RlByteCache

For caching objects that are expensive to create (e.g. bitmaps), I've written an LRU cache that counts by bytes rather than by items. You can have it cache by count too, if you pass in a sizeFunction that simply returns a constant. For bitmaps, use RlBitmapManager, which uses a sizeFunction that estimates very closely the bitmap overhead in memory (basically, it counts the number of pixels and multiplies it by 4 bytes per pixel).

###Image scaling

The image scaling algorithms used by the Roku aren't very good, unless bilinear scaling is used. Unfortunately, ``roBitmaps`` themselves don't support bilinearly scaled drawing to a ``roScreen``. On the newer Roku models, you must create a ``roRegion`` (think of it as a region of a bitmap) set its scaling mode to 1, then draw it to a ``roScreen``. This is even more tricky on the Roku classic models, where bilinear scaling is only supported for ``roRegion`` to ``roRegion`` draw calls.

I've written a function to get a bilinearly scaled bitmap using ``roRegion`` to ``roRegion`` drawing (i.e. it gets the bitmap from the ``roRegion`` object). Note that because of the overhead of additional ``roBitmap`` and ``roRegion`` object creation, this *can* take a long time per image: about 200 ms on Roku classic models, or 50 ms on Roku 2/3 models. However, this seems to be the only way to get a nice image on Roku classic models.

###Bitmap managing

Roku developers know that ``roBitmaps`` are expensive to both create and store in memory (on the Roku 1, about 50-100 ms depending on bitmap dimensions). I've used lazy allocation and a manager to help with this: bitmaps are only allocated when they are needed (e.g. for a draw call). In addition, bitmap references are not stored in ``RlImage`` objects; they are stored in ``RlBitmapManager``. Hopefully this makes deallocating them easier, because can clear them in ``RlBitmapManager``. 

Though it is currently incomplete, I'm almost done implementing an LRU byte cache - similar to the one used for Android bitmaps. This be used in conjunction with the bitmap manager to maximize memory use and reduce bitmap creation overhead.

##License

RokuLib is released under the [MIT License](LICENSE)
