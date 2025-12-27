#!/bin/bash

# --- CONFIG ---
REPO_NAME="Vani's Packages"
ROOT_OUTPUT="index.html"
RPM_OUTPUT="rpm/index.html"

# --- PART 1: Generate Root Landing Page ---
cat > $ROOT_OUTPUT <<EOF
<!DOCTYPE html>
<html>
<head>
    <title>$REPO_NAME</title>
    <style>
        body { font-family: sans-serif; background: #121212; color: #e0e0e0; padding: 40px; text-align: center; }
        h1 { margin-bottom: 20px; }
        .card {
            background: #1e1e1e; border: 1px solid #333; padding: 20px;
            margin: 10px auto; max-width: 400px; border-radius: 8px;
        }
        a { color: #81a2be; text-decoration: none; font-size: 1.2em; font-weight: bold; }
        a:hover { color: #b5bd68; }
        .cmd {
            background: #000; padding: 10px; border-radius: 4px;
            font-family: monospace; font-size: 0.9em; color: #fabd2f;
            margin-top: 10px; display: block; text-align: left;
        }
    </style>
</head>
<body>
    <h1>$REPO_NAME</h1>

    <div class="card">
        <a href="rpm/">📂 RPM Repository (Fedora/RHEL)</a>
        <p>Click above to browse files.</p>
        <span class="cmd">sudo dnf config-manager --add-repo https://vani.github.io/packages/rpm/</span>
    </div>

    <div class="card">
        <a href="deb/">📂 DEB Repository (Debian/Ubuntu)</a>
        <p>Coming soon...</p>
    </div>
</body>
</html>
EOF
echo "Generated Root Index ($ROOT_OUTPUT)"

# --- PART 2: Generate RPM File List ---
cat > $RPM_OUTPUT <<EOF
<!DOCTYPE html>
<html>
<head>
    <title>RPM Files</title>
    <style>
        body { font-family: monospace; background: #1a1a1a; color: #c5c8c6; padding: 20px; }
        a { color: #81a2be; text-decoration: none; display: block; margin: 5px 0; }
        a:hover { text-decoration: underline; color: #b5bd68; }
        h2 { border-bottom: 1px solid #333; padding-bottom: 10px; }
    </style>
</head>
<body>
    <h2>Index of /rpm</h2>
    <a href="../">.. (Go Back)</a>
EOF

# Loop through files
for file in $(ls -1 rpm/*.rpm 2>/dev/null); do
    filename=$(basename "$file")
    echo "    <a href=\"$filename\">$filename</a>" >> $RPM_OUTPUT
done

echo "</body></html>" >> $RPM_OUTPUT
echo "Generated RPM Index ($RPM_OUTPUT)"
