# Test the install script in a disposable Alpine Docker container,
@test:
    echo "✅ dotfiles successfully deployed" > "{{ invocation_directory() }}/home/test.txt"
    docker run --rm -it \
    	-v "{{ justfile_directory() }}:/dotfiles" \
    	-e HOME=/tmp/home \
    	alpine:latest \
    	sh -c "apk add --no-cache curl git bash && mkdir -p /tmp/home && bash /dotfiles/install.sh && cat /tmp/home/test.txt"
    rm "{{ justfile_directory() }}/home/test.txt"
    echo "✅ test complete"
