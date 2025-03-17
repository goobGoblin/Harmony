
FROM ubuntu:22.04

#Install java jdk 8
RUN apt-get update && \
	apt-get install -y openjdk-8-jdk openjdk-8-jre && \
	apt-get install -y ant && \
    apt-get install -y clang && \
    apt-get install -y cmake && \
    apt-get install -y ninja-build && \
    apt-get install -y pkg-config && \
    apt-get install -y libx11-dev && \
    apt-get install -y snapd && \
    apt-get install -y libvlccore-dev &&\
    apt-get install -y libvlc-dev&& \
    apt-get install -y libgtk-3-dev && \
	rm -rf /var/lib/apt/lists/* && \
	rm -rf /var/cache/oracle-jdk8-installer






#testing (android studio dependencies and flutter dependencies)
RUN apt-get update -y && apt-get upgrade -y\
	&& apt-get install -y curl git unzip xz-utils zip libglu1-mesa \
    && apt-get install -y libc6:amd64 libstdc++6:amd64 lib32z1 libbz2-1.0:amd64

# Install dependencies
RUN apt update -y && \
    apt install snapd -y && \
    apt install -y --no-install-recommends \
    bash git wget curl unzip lib32stdc++6 \
    libnotify4 gnupg libxkbfile1 libxkbcommon-x11-0 \
    libgconf-2-4 libsecret-1-0 gnupg2 libglu1 xz-utils \
    gcc-multilib libgtk2.0-0 libx11-xcb-dev \
    libxss-dev libasound2 libnss3 libxtst6 \
    pulseaudio libgl1-mesa-glx libgtkd-3-0 \
    qemu-kvm usbutils \
    cpu-checker android-tools-adb && \
    rm -rf /var/lib/apt/lists/*



# User and Groups
RUN groupadd flutter
RUN groupadd kvm || true
RUN usermod -a -G flutter root

ENV DEVELOPER developer
ENV HOME_DIR /home/${DEVELOPER}
RUN useradd -ms /bin/bash ${DEVELOPER}
RUN usermod -a -G flutter ${DEVELOPER}
RUN usermod -a -G plugdev ${DEVELOPER}
RUN usermod -a -G kvm ${DEVELOPER}
RUN adduser ${DEVELOPER} kvm


# Android + flutter sdk - properties
ENV ANDROID_VERSION="35"

ENV ANDROID_SDK sdk-tools-linux-4333796.zip
ENV ANDROID_SDK_URL https://dl.google.com/android/repository/${ANDROID_SDK}
ENV ANDROID_HOME /opt/android-sdk

ENV FLUTTER_HOME /opt/flutter
ENV FLUTTER_SDK_URL https://storage.googleapis.com/flutter_infra_release/releases/stable/linux/flutter_linux_3.29.1-stable.tar.xz
ENV FLUTTER_SDK flutter_linux_3.29.1-stable.tar.xz

#Android studio properties
ENV ANDROID_STUDIO_URL https://redirector.gvt1.com/edgedl/android/studio/ide-zips/2024.3.1.13/android-studio-2024.3.1.13-linux.tar.gz
ENV ANDROID_STUDIO_SDK android-studio-2024.3.1.13-linux.tar.gz
ENV ANDROID_STUDIO_HOME /opt/android-studio



# Create folder and add flutter-group rights
RUN mkdir ${ANDROID_HOME}
RUN chown -R :flutter /opt
RUN chmod -R g+xrw /opt
RUN chown -R :flutter ${ANDROID_HOME}
RUN chmod -R g+xrw ${ANDROID_HOME}
USER ${DEVELOPER}

# Install android sdktools
RUN cd /opt && wget -q ${ANDROID_SDK_URL} --show-progress && \
    unzip ${ANDROID_SDK} -d $ANDROID_HOME && rm ${ANDROID_SDK}

#Install android sdk
# RUN cd /opt && wget -q ${ANDROID_EMULATOR_URL} --show-progress && \
#     unzip ${ANDROID_EMULATOR} -d $ANDROID_HOME && rm ${ANDROID_EMULATOR}

#install flutter

# RUN curl https://storage.googleapis.com/flutter_infra_release/releases/stable/linux/flutter_linux_3.29.1-stable.tar.xz -o flutter.xz
# RUN tar xf ./flutter.xz
RUN cd /opt && wget -q ${FLUTTER_SDK_URL} --show-progress && \
    tar xf ${FLUTTER_SDK} && rm ${FLUTTER_SDK}
RUN git config --global --add safe.directory /opt/flutter

#install android studio



RUN cd /opt && wget -q ${ANDROID_STUDIO_URL} --show-progress && \
    tar xf ${ANDROID_STUDIO_SDK} && rm ${ANDROID_STUDIO_SDK}


ENV JAVA_HOME /usr/lib/jvm/java-8-openjdk-amd64/
RUN export JAVA_HOME

#install commandline tools

#Android cmdline tools
# ENV ANDROID_CMDLINE_TOOLS_URL https://dl.google.com/android/repository/commandlinetools-linux-11076708_latest.zip
# ENV ANDROID_CMDLINE_TOOLS_SDK commandlinetools-linux-11076708_latest.zip
# ENV ANDROID_CMDLINE_TOOLS_HOME /opt/android-sdk/emulator

# RUN cd /opt && wget -q ${ANDROID_CMDLINE_TOOLS_URL} --show-progress && \
#     unzip ${ANDROID_CMDLINE_TOOLS_SDK} -d $ANDROID_CMDLINE_TOOLS_HOME && rm ${ANDROID_CMDLINE_TOOLS_SDK}
# RUN git config --global --add safe.directory /opt/flutter


#ENV PATH="/usr/local/flutter/bin:$PATH"

# RUN snap install flutter --classic
# RUN snap install android-studio --classic
# RUN cd ../
#Specify SDK_ROOT

#RUN set ANDROID_SDK_ROOT=$ANDROID_HOME
# Add android tools and platform tools to PATH
ENV PATH $PATH:$ANDROID_HOME/tools
ENV PATH $PATH:$ANDROID_HOME/platform-tools
ENV PATH $PATH:$ANDROID_HOME/tools/bin
# ENV PATH $PATH:$ANDROID_CMDLINE_TOOLS_HOME/cmdline-tools/bin

#add flutter to path
ENV PATH $PATH:$FLUTTER_HOME/bin

#add android studio to path
ENV PATH $PATH:$ANDROID_STUDIO_HOME/bin


#RUN cd /opt/android-studio/ && ls && sleep 6

RUN flutter config --android-sdk $ANDROID_HOME

# Install Android Tools
RUN yes | sdkmanager --update --verbose
RUN yes | sdkmanager "platform-tools"
RUN yes | sdkmanager "build-tools;34.0.0" --verbose
RUN yes | sdkmanager "platforms;android-$ANDROID_VERSION" --verbose
RUN yes | sdkmanager "extras;android;m2repository" --verbose
RUN yes | sdkmanager "extras;google;m2repository" --verbose
#RUN yes | sdkmanager --list --verbose && sleep 17
RUN yes | sdkmanager "system-images;android-35;google_apis_playstore;x86_64" --verbose
RUN yes | sdkmanager --install "cmdline-tools;latest" --verbose
RUN yes | sdkmanager --licenses

# Create fake keymap file
RUN mkdir $ANDROID_HOME/tools/keymaps && \
    touch $ANDROID_HOME/tools/keymaps/de-de

WORKDIR ${HOME_DIR}





RUN mkdir ./project

ADD docker/.bashrc .bashrc
RUN cat /usr/lib/git-core/git-sh-prompt > .bash_git

# Check flutter
RUN flutter doctor --android-licenses
RUN flutter doctor

ENTRYPOINT git config --global --add safe.directory /opt/flutter && flutter emulators --create [--name flutter_emulator] && flutter emulators --launch flutter_emulator && cd project && flutter clean && echo "Please wait for emulator to startup (Past the G screen). Before running "flutter run"" && /bin/bash 