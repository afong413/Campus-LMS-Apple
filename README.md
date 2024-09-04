#  Campus LMS

__TL;DR__: this is a glitchy, awfui-gui, proof of concept app I made in around a week to accompany my application to the iTeam. It is mainly intended "feature you would add" section though I guess it could go under coding experience too. Keep in mind this is a proof of concept (or rather of a tiny part of the concept) that I made in a week. Yes, I know it has bugs. Yes, I know the GUI looks awful. And yes, I know it has many quite necessary features that are not implemented (see To Do section). Right now it is simply a way to view classes and assignments and to submit `text/plain` documents to said assignments. The rest is something I "_would_ add."

## Purpose

I've been thinking about making something like this for a while (mostly just for fun), but the iTeam applications gave me the motivation to start the project and the possibility of being able to work on things like this with other like minded people (even at CPS, I've yet to meet another Swift developer).

The app itself is meant to _eventually_ replace Canvas LMS (see where I got the name from), as our school's learning management system. I see this as serving two main objectives:

1. __Standardization__: Many teachers currently use a variety of different LMSs (Canvas, Google Classroom, etc.). I believe that we will be able to create an overall superior LMS for our specific use case by polling both teachers and students to see what _they_ like best. This would ease the burden on students who currently have to check multiple different sources for assignments, even within the same class.

2. __Unification__: Canvas and Campus are great. But they could be better if they were able to work along side one another. By building our own (hopefully better LMS), we would be able to integrate it directly into the Campus Ecosystem and therefore would have everything flow more smoothly. Imagine, classes pulled to the campus app directly from the LMS, profiles and pallets right in the LMS, and best of all, Campus's slick modern UI instead of Canvas's old boring one.

## Features (so far)

This list is kind of short. Don't bully me. I had a week. Remember this is mostly just features I "_would_ add". The ones I already did were just because I wanted something to code lol.

- Create assignments (in website but that's broken at the moment)
  - Using the TipTap rich text editor.
- View your courses!
- View the assignments of said courses!
  - Pulled as HTML from Firestore and rendered using WKWebView
- Submit plain text files!
  - Uploaded to Firebase Storage and a reference is dropped in the associated assignment's submissions in Firestore

## To Do/WIP/Didn't Have Time

Wow this list is long... 😭

### General
- Write rules for database/storage.

### Student
Here are some unimplemented features I think would be useful but didn't have time to code up in a week:
- View past submissions
  - Should be straightforward. Just need a module to render different file types.
- See grades
  - Also see grade assignments under the Teacher section.
- Customize layout
- Notifications
- Submit rich text
  - Still looking into this one. It's definitely doable for web (and in fact, that's how the assignments can be created in the first place, a ProseMirror wrapper for JS called TipTap), but with Swift, we don't have super good options.
  - I can render fine with `WKWebView`, but editing is the problem. I'm currently looking into [`RichTextKit`](https://danielsaidi.github.io/RichTextKit/documentation/richtextkit/).
- A lot more

### Teacher
I did pretty much none of this besides creating assignments, but that's in the `Campus-LMS-Web` private repo so its not really applicable. I _would_ like to get that added to the iOS app, but that might be difficult for the reasons listed in "Submit rich text" in the student section. Other things I hope to implement:
- Notifications (should be _very_ customizable)
- Grade assignments (lol this is pretty much a must do)
- See submissions
- Announcements
- Add pages
- Choose submission file types.
- More

### Admin
The Firebase console is very expansive, and gives a person the oppurtunity to screw a lot of things up (e.g. to `rm -rf` an entire collection). Thus, before release, this would need to be heavily abstacted with an admin dashboard from which classes could be created, and students/teachers could be assigned, among other things.

### macOS/iPadOS/watchOS
This is mainly just GUI stuff so I didn't bother with it at the moment given the fact that I put no effort into this UI to begin with (see purpose: this is just a proof of concept).

### Website
There is a website I have started building but I didn't make that repo public because it was broken when I modified the Firestore database to match the most recent iteration of the iOS app. Also the GUI is even worse than the apps (if that's possible).
