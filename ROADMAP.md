# znpm Project Roadmap

---

### Phase 1: Project Setup & Basic CLI

1. **Set up Zig Project**:
   - Initialize a new Zig project.
   - Set up the basic project structure (e.g., `src` folder, main file).
   - Define CLI entry points (e.g., `znpm install`, `znpm update`, etc.).

2. **Implement CLI Parsing**:
   - Parse commands and options (e.g., `znpm install <package-name>`).
   - Print usage instructions for unrecognized commands or missing arguments.

---

### Phase 2: Connect to npm Registry

1. **Implement HTTP Requests**:
   - Set up a simple HTTP client to interact with the npm registry API.
   - Create a helper function to retrieve metadata for a package (e.g., `GET https://registry.npmjs.org/<package-name>`).

2. **Fetch and Parse Package Metadata**:
   - Fetch package information and parse JSON responses to get details like `version`, `dependencies`, and `tarball` URLs.

3. **Implement Basic Error Handling**:
   - Handle errors for network issues, missing packages, or invalid JSON responses.

---

### Phase 3: Package Installation

1. **Download Package Tarball**:
   - Retrieve the tarball URL from metadata and download it.
   - Save it to a temporary location (e.g., `.znpm-cache/`).

2. **Extract Tarball Contents**:
   - Decompress and extract the downloaded package tarball.
   - Implement file extraction to `node_modules/<package-name>`.

3. **Resolve Dependencies**:
   - Check for dependencies within package metadata.
   - Recursively fetch and install dependencies for each package.

---

### Phase 4: Local Caching System

1. **Implement Local Cache**:
   - Set up a caching mechanism to store downloaded packages and metadata locally.
   - Use a file-based cache to avoid re-downloading packages already installed.

2. **Create Cache Management Commands**:
   - Add `znpm cache clean` to clear cached packages.
   - Implement logic to update the cache when a newer package version is available.

---

### Phase 5: Performance Optimizations

1. **Parallel Downloading**:
   - Optimize installation speed by fetching multiple packages concurrently.

2. **Optimize Dependency Resolution**:
   - Implement a flattened dependency tree structure to minimize duplicate installs and improve performance.

---

This roadmap outlines the main steps for building znpm, focusing on performance and simplicity.
