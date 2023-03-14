FROM ubuntu:22.04

RUN apt-get update -y
RUN apt-get install -y curl git

ARG USERNAME=foo
RUN useradd -m $USERNAME
USER $USERNAME
ENV HOME=/home/$USERNAME
WORKDIR $HOME/work

ENV PATH="$HOME/.tfenv/bin:$PATH"
RUN git clone --depth=1 https://github.com/tfutils/tfenv.git -b v3.0.0 ~/.tfenv

ENV PATH="${AQUA_ROOT_DIR:-${XDG_DATA_HOME:-$HOME/.local/share}/aquaproj-aqua}/bin:$PATH"
RUN curl -sSfL -O https://raw.githubusercontent.com/aquaproj/aqua-installer/v2.0.2/aqua-installer && \
    echo "acbb573997d664fcb8df20a8a5140dba80a4fd21f3d9e606e478e435a8945208  aqua-installer" | sha256sum -c && \
    chmod +x aqua-installer && \
    ./aqua-installer && \
    rm aqua-installer
