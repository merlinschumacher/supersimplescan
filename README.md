# Super Simple Scan

This is a very simple no frills document scanner app for Android. The app simply scans a document (with one or multiple pages) and enables you to share the scan as a PDF file. Nothing more.

It leverages [Googles ML Kit document scanner](https://developers.google.com/ml-kit/vision/doc-scanner) feature to do the heavy lifting. So it's equal to Google Files or Google Drive in regards to the scanning, but I've only enabled the basic features of the document scanner, to keep it simple. The app itself is just a few buttons/elements and a few method calls. It is build with [Flutter](https://flutter.dev/). 

My intent was to create a very easy to use document scanner. Most other document scanner apps are either bound to commercial services and require subscriptions or require you to use their services to share scans. The integrated scanner features of Googles File and Google Drive app also introduce unnecessary complicated workflows. This is especially annoying if you're elderly and are often confused by changing and complex workflows, unexpected behaviors of apps or unexpected pay walls in apps.

A few examples for the issues I've seen with Googles integrated apps alone: Using Google Drive to send a PDF via Gmail creates a shared Google Drive document and the person receiving the mail must open Google Drive to download it. This might not be possible, when you send your document to a company or government body where the use of cloud services is restricted. 
The Files app stores the document in a folder where you have to look for later it to send it. It also won't nudge you to change the filename. This leads to folders full of scanned documents with meaningless names.
The integrated scan function of the Pixel camera is close to what I wanted, but you must hold your phone over a docment, wait for the "Scan document" chip to appear. If the document contains a QR code it won't show the scan chip, but a chip that links to the QR codes target. 
The available free and open source alternatives are also lacking. They often offer very detailed settings to tweak the results, which complicates usage or lead to accidental changes. Or they lack in usability in basic regards like scanning multiple pages.

[Super Simple Scan Demo.webm](https://github.com/user-attachments/assets/ae9a1b4f-d88e-433a-85af-dee75c332ebd)
