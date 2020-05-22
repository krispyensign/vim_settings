#!/bin/bash
java_full_version=$(java -version 2>&1 | head -n1 | cut -f3 -d' ' | sed 's/"//g')

if [[ $java_full_version == 1\.8\.* ]]; then
  JAVA_VER='8'
fi

mkdir -p ~/.java8-lsp/
mkdir -p ~/.java-lsp/

if [[ $JAVA_VER == '8' ]]; then
  java\
    -Declipse.application=org.eclipse.jdt.ls.core.id1\
    -Dosgi.bundles.defaultStartLevel=4\
    -Declipse.product=org.eclipse.jdt.ls.core.product\
    -Dlog.level=ALL\
    -noverify\
    -Xmx1G\
    -jar ~/.local/share/eclipse.jdt.ls-8/org.eclipse.jdt.ls.product/target/repository/plugins/org.eclipse.equinox.launcher_1.5.400.v20190515-0925.jar\
    -configuration ~/.local/share/eclipse.jdt.ls-8/org.eclipse.jdt.ls.product/target/repository/config_mac\
    -data ~/.java8-lsp/
else
  java\
    -Declipse.application=org.eclipse.jdt.ls.core.id1\
    -Dosgi.bundles.defaultStartLevel=4\
    -Declipse.product=org.eclipse.jdt.ls.core.product\
    -Dlog.level=ALL\
    -noverify\
    -Xmx1G\
    -jar ~/.local/share/eclipse.jdt.ls-8/org.eclipse.jdt.ls.product/target/repository/plugins/org.eclipse.equinox.launcher_1.5.400.v20190515-0925.jar\
    -configuration ~/.local/share/eclipse.jdt.ls-8/org.eclipse.jdt.ls.product/target/repository/config_mac\
    -data ~/.java-lsp/\
    --add-modules=ALL-SYSTEM\
    --add-opens java.base/java.util=ALL-UNNAMED\
    --add-opens java.base/java.lang=ALL-UNNAMED
fi

