#!/bin/bash


REPO_NAME="vani-pkgs"
REPO_URL="https://vani1-2.github.io/vani-pkgs" 
ROOT_OUTPUT="index.html"
RPM_OUTPUT="rpm/index.html"


cat > $ROOT_OUTPUT <<EOF
<!DOCTYPE html>
<html>
<head>
    <title>$REPO_NAME</title>
    <style>
        body { font-family: sans-serif; background: #121212; color: #e0e0e0; padding: 40px; text-align: center; }
        h1 { margin-bottom: 20px; text-transform: lowercase; font-family: monospace;}
        .card { 
            background: #1e1e1e; border: 1px solid #333; padding: 20px; 
            margin: 10px auto; max-width: 500px; border-radius: 8px; 
        }
        a { color: #81a2be; text-decoration: none; font-size: 1.2em; font-weight: bold; }
        a:hover { color: #b5bd68; }
        .cmd { 
            background: #000; padding: 15px; border-radius: 4px; 
            font-family: monospace; font-size: 0.85em; color: #fabd2f; 
            margin-top: 15px; display: block; text-align: left;
            overflow-x: auto; white-space: nowrap;
        }
        .label { color: #666; font-size: 0.8em; display: block; margin-bottom: 5px; text-align: left;}
    </style>
</head>
<body>
    <h1>$REPO_NAME</h1>
    
    <div class="card">
        <a href="rpm/">📂 RPM Repository</a>
        <p>Fedora / RHEL / CentOS</p>
        <div class="cmd">
            <span class="label"># Install Repo:</span>
            sudo dnf config-manager --add-repo $REPO_URL/rpm/
        </div>
    </div>

    <div class="card">
        <a href="deb/">📂 DEB Repository</a>
        <p>Debian / Ubuntu (Coming Soon)</p>
    </div>
</body>
</html>
EOF
echo "Generated Root Index ($ROOT_OUTPUT)"


cat > $RPM_OUTPUT <<EOF
<!DOCTYPE html>
<html>
<head>
    <title>Index of /rpm</title>
    <style>
        body { font-family: monospace; background: #1a1a1a; color: #c5c8c6; padding: 20px; }
        a { color: #81a2be; text-decoration: none; display: block; margin: 5px 0; }
        a:hover { text-decoration: underline; color: #b5bd68; }
        h2 { border-bottom: 1px solid #333; padding-bottom: 10px; }
        .back { margin-bottom: 20px; display: block; color: #b294bb; }
    </style>
</head>
<body>
    <h2>Index of /rpm</h2>
    <a href="../" class="back">.. (Go Back)</a>
EOF


for file in $(ls -1 rpm/*.rpm 2>/dev/null); do
    filename=$(basename "$file")
    echo "    <a href=\"$filename\">$filename</a>" >> $RPM_OUTPUT
done

echo "</body></html>" >> $RPM_OUTPUT
echo "Generated RPM Index ($RPM_OUTPUT)"