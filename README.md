# ProgressingActivityItemProvider

This project is for the purpose of demonstrating how to display/present progress bar like view controller while generating items that could take more than few minutes.

## Motivation
I was planning to export some objects, say large PDF or movie file, to export/share using `UIActivityViewController`/`UIActivity`.  Subclassing `UIActivityItemProvider` could work, since `var item: Any` method is called by none-main thread so it's ok to take some time to produce such item.

However, once you touched on your activity icon, it starts producing an item, but there are no visual effect, and it is hard to tell the app is still working on it, or simply frozen.

Then it is natural that I start thinking of how to display/present a progress bar like view controller while producing a time consuming item.

## Environment
iOS 12/Xcode 10.2/Swift 5

## License
The MIT License



