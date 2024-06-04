# Book iShader



## A Known Issue

Currently, there is no known practical way to read the URL of a metal files included in the `iShader` modules at runtime using `Bundle.<module-name>.url()`. Additionally, copying the metal files directly into the project's bundle does not resolve the issue.

This is likely due to the fact that metal files are precompiled resources, and obtaining their URLs at runtime **could not** be possible.

As a workaround, copies of the metal files without the `.metal` extension have been created and stored within the project's bundle (`/Frameworks/iShaderMetalResources/`). The `SourceCodeView` reads these strings to display the source.

However, it is important to note that any changes made to these copied sources will not affect the actual shader results.

Of course, there might be a solution for both of these issues and I'd be happy if anyone wants to contribute.
