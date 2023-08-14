# QuickPES

QuickPES is a simple macOS application that assists users in transferring `.pes` files from their system to a selected USB drive.

## Features

1. **File Selection**: Allows users to select `.pes` files or folders containing `.pes` files. It recursively searches through folders to find all `.pes` files.
2. **USB Selection**: Users can select the target USB directory where they'd like their `.pes` files to be copied.
3. **Custom Subfolder**: Users can specify a custom subfolder name in the USB where the files should be copied. The default subfolder name is "PES_Files".

## Usage

1. **Select .PES Files**: Click the "Select .PES Files" button to select files or folders. The application will automatically filter and select only `.pes` files.
2. **Specify Subfolder Name**: Enter your desired subfolder name in the text field. If left empty, it defaults to "PES_Files".
3. **Select Target USB**: Click the "Select Target USB Directory" button to choose your desired USB location.
4. **Copy .PES Files**: Click the "Copy .PES Files" button to start the transfer. Ensure that the USB remains connected during this process.

## Installation & Build Instructions

1. **Clone the Repository**: First, clone the QuickPES repository to your local machine using Git.
   ```bash
   git clone https://github.com/hjbockholt/quickPES.git

