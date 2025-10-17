
# Contributing to pyARM

Thank you for your interest in contributing to pyARM!  
This guide explains how to get started, especially for HPC testing.

---

## Getting Started
1. Fork this repo on GitHub.
2. Clone your fork on the HPC:
   
   git clone https://github.com/<your_username>/earm_pipeline.git
   cd earm_pipeline

3. Create a branch:
git checkout -b your-feature-branch

4. Test locally:
bash scripts/test_env.sh
bash scripts/test_paths.sh


Good First Issues
Test pyARM on a new HPC account
Verify a_arm_paths.py paths
Add dependencies to environment.yml
Improve HPC_SETUP.md clarity
Report /projects/earm access issues

Guidelines
Use descriptive commit messages
Follow docs/HPC_SETUP.md
Run test scripts before PR
Open pull requests to main


Reporting Bugs
Include:
Full error
Node name (hostname)
Reproduction steps


Code of Conduct
Be respectful, collaborative, and open to feedback.
Our goal is a sustainable, research-focused open-source community.