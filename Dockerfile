FROM mcr.microsoft.com/dotnet/runtime:7.0

RUN apt-get update && \
    apt-get install -y --no-install-recommends \
      wget && \
    rm -rf /var/cache/apt/archives /var/lib/apt/lists

ENV VS_SERVER_VERSION=1.19.4
ENV VS_SERVER_ROOT=/opt/vintagestory
ENV VS_SERVER_DATA=/var/vintagestory/data
RUN mkdir -p "${VS_SERVER_ROOT}" && \
    mkdir -p "${VS_SERVER_DATA}" && \
    wget -O - "https://cdn.vintagestory.at/gamefiles/stable/vs_server_linux-x64_${VS_SERVER_VERSION}.tar.gz" | tar -C "${VS_SERVER_ROOT}" -xzf -

ARG VS_SERVER_PORT=42420
EXPOSE ${VS_SERVER_PORT}
ENTRYPOINT dotnet "${VS_SERVER_ROOT}/VintagestoryServer.dll" --dataPath "${VS_SERVER_DATA}" --port "${VS_SERVER_PORT}" ${@}
