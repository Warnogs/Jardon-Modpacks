import { populateMarkdownList } from "./hamburger.js";

const markdownFiles = [
  { file: "./markdown-files/homepage.md", title: "Home" },
  { file: "./markdown-files/magic-1.7.10-2025.md", title: "1.7.10 Magic (2025)" },
  // ADD NEW MARKDOWN FILES HERE
];

const REPO_IMAGE_BASE = "https://warnogs.github.io/Jardon-Modpacks/images";

const fixImagePaths = (mdText) => {
  // Replace ../images/... with link to images in the repo
  return mdText.replace(/\.\.\/images\//g, `${REPO_IMAGE_BASE}/`);
};

// Load the Markdown parser (e.g., marked.js)
const loadMarkdownParser = () => {
  return new Promise((resolve, reject) => {
    const script = document.createElement("script");
    script.src = "https://cdn.jsdelivr.net/npm/marked/marked.min.js";
    script.onload = resolve;
    script.onerror = reject;
    document.head.appendChild(script);
  });
};

const renderMarkdownFile = async (file) => {
  await loadMarkdownParser();

  marked.setOptions({
    gfm: true,
    breaks: true,
    headerIds: false,
    mangle: false,
  });

  const container = document.getElementById("markdown-container");
  container.innerHTML = ""; // clear previous content

  try {
    const res = await fetch(`${file}?t=${Date.now()}`);
    if (!res.ok) throw new Error(`Failed to load ${file}`);

    let mdText = await res.text();
    mdText = fixImagePaths(mdText);
    const html = marked.parse(mdText);

    container.innerHTML = html; // Directly render markdown content
  } catch (err) {
    console.error(err);
    container.innerHTML = `<p>Error loading file: ${err.message}</p>`;
  }
};

// Populate the sidebar with file titles
populateMarkdownList(markdownFiles, ({ file }) => renderMarkdownFile(file));

// Load the first file by default
if (markdownFiles.length > 0) {
  renderMarkdownFile(markdownFiles[0].file);
}
