# lets start from debian
FROM debian:testing

# maintainer
MAINTAINER Leszek Grzanka <grzanka@agh.edu.pl>

# Install necessary system packages
RUN apt-get -qq update && \
    apt-get install -qq -y sudo && \
    rm -rf /var/lib/apt/lists/*


# Install necessary packages to get code and compile SHIELDHIT
RUN apt-get -qq update && \
    apt-get install -qq -y --no-install-recommends git gfortran make && \
    rm -rf /var/lib/apt/lists/*

# Install LaTeX to produce SHIELDHIT documentation
RUN apt-get -qq update && \
    apt-get install -qq -y --no-install-recommends ghostscript texlive-latex-base texlive-latex-extra && \
    apt-get install -qq -y --no-install-recommends texlive-science texlive-lang-cyrillic texlive-fonts-recommended texlive-publishers && \
    rm -rf /var/lib/apt/lists/*

# Install necessary packages to run python converter bdo2txt
RUN apt-get -qq update && \
    apt-get install -qq -y --no-install-recommends python3 python3-setuptools python3-pip && \
    apt-get install -qq -y --no-install-recommends python3-numpy python3-matplotlib gnuplot-nox && \
    rm -rf /var/lib/apt/lists/*


# Install graphviz and gprof2dot to visualize profiling results
RUN apt-get -qq update && \
    apt-get install -qq -y --no-install-recommends graphviz && \
    pip3 install gprof2dot && \
    rm -rf /var/lib/apt/lists/*


# Add temporary user
RUN useradd -m -d /home/test/ test
RUN echo "test:test" | chpasswd
RUN echo "test    ALL=(ALL) ALL" >> /etc/sudoers

# Activate user, compilation as root is not wise
USER test
WORKDIR /home/test
