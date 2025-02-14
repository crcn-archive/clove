### Welcome:

Welcome! Here you will find all the information needed in order to start developing your own plugins for Clove. With the Clove SDK, you can easily, and quickly develop plugins that can tap into your favorite website. Of course, the site should provide an API, but if it doesn't, we recommend you use [Dapper](http://www.dapper.net/open/) to provide the functionality needed. Remember to check out our [licensing agreement](#) before you start using the [libraries](#) provided on our website.


If you would like to use the dependencies for anything other than Clove, then please contact us at <partners@spiceapps.com>.

If you have any questions, comments, or suggestions, please contact us at <dev@spiceapps.com>, or post it on our forums.


### Getting Started:

[VIDEO](#getting-started-video-1)

The first thing you need in order to start developing Clove plugins is Flex Builder. You can check out the [adobe website](#) to retain a valid copy.

Next you will need to download the [dependencies](#download-files) for Clove. The descriptions of each are as listed:

- `SpiceKit.swc`
    - The spice apps development kit, this package contains all the utility classes necessary
- `AIRSpiceKit.swc`  
    - The dev kit used only for AIR
- `CloveSDK.swc`
    - The package you include in each of your plugins
- `AIRCloveCore.swc`
    - This is the Clove core containing all driving classes. Use this for debugging your plugins
- Clove project
    - This is the application you should use when debugging your plugins
- sample plugins
    - sample plugins for clove

You will then need to create a new Flex project with the files listed. We've tried to make it easier for you by including the necessary libraries in each project, so in the "Clove project", you will find `AIRCloveCore.swc`, `AIRSpiceKit.swc`, and `SpiceKit.swc`. In each of the sample plugins, you will find `CloveSDK.swc`, and `SpiceKit.swc`.


Once you have your project made, you can [start developing Clove plugins](#getting-start-video-2).
