## QuickPES Developer's Guide

### Setting Up Your Development Environment

1. **Fork the Repository**: Click on the 'Fork' button on the top right corner of the [QuickPES repository](https://github.com/hjbockholt/quickPES.git) page on GitHub. This will create a copy of the repository in your GitHub account.

2. **Clone Your Fork**: Clone your forked repository to your local machine. Replace `your-username` with your GitHub username.
   ```bash
   git clone https://github.com/your-username/quickPES.git
   ```

3. **Set Upstream Remote**: Navigate to your cloned repository directory and add the original QuickPES repository as an upstream remote. This will help you fetch updates from the main project.
   ```bash
   cd quickPES
   git remote add upstream https://github.com/hjbockholt/quickPES.git
   ```

### Development Workflow

1. **Create a New Branch**: Before you start with your changes, create a new branch. Naming your branch relevantly will help maintainers understand your contribution.
   ```bash
   git checkout -b feature/your-feature-name
   ```

2. **Make Changes**: Implement your feature or fix the bug you're addressing. Make sure you follow any coding standards and guidelines specific to the project.

3. **Commit Your Changes**: Commit your changes with a meaningful commit message.
   ```bash
   git add .
   git commit -m "Short description of your changes"
   ```

4. **Fetch Latest Changes**: Before pushing your changes, fetch the latest updates from the main project to avoid potential merge conflicts.
   ```bash
   git pull upstream main
   ```

5. **Push to Your Fork**: Push your branch to your forked repository on GitHub.
   ```bash
   git push origin feature/your-feature-name
   ```

6. **Create a Pull Request (PR)**: Go to the GitHub page of your forked repository and click on 'New Pull Request'. Make sure the base repository is `hjbockholt/quickPES` and the base branch is `main`. Fill out the PR template with all the required details.

7. **Address Review Comments**: Once the PR is reviewed, maintainers might suggest changes. Make the required changes on your branch and push them. The PR will be updated automatically.

### Code Standards and Guidelines

- **Commit Messages**: Write clear, concise commit messages that explain the purpose and context of your changes.
- **Code Style**: Adhere to any coding styles and guidelines provided by the project maintainers.
- **Documentation**: Comment your code adequately and update relevant documentation files if necessary.

### How to Contribute

- **Bug Reports**: If you find a bug, check if it's already been reported in the Issues section. If not, create a new issue with detailed information about the bug.
- **Feature Requests**: If you have a feature in mind, check the Issues section to see if someone else had a similar idea. If it's not there, create a new issue describing your feature request.
- **Code Contributions**: If you wish to contribute code, please refer to the Development Workflow section above.

---

