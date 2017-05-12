# Pull from Red Hat
FROM registry.access.redhat.com/3scale-amp20/apicast-gateway/images

USER root

# ENVs
ENV INSTALL_LOCATION /usr/local/openresty/luajit

# Install software
RUN yum install -y expat-devel net-tools
RUN yum group install -y "Development Tools"
RUN ln -s /usr/local/openresty/luajit/include/luajit-2.1/* /usr/include/
RUN luarocks install luaexpat --tree=/usr/local/openresty/luajit
RUN luarocks install luaxpath --tree=/usr/local/openresty/luajit
RUN ln -s /usr/local/openresty/luajit/lib64/lua/5.1/* /usr/local/openresty/luajit/lib/lua/5.1/
RUN mkdir /opt/app-root/src/client_registrations
ADD client_registrations/webhook_handler.lua /opt/app-root/src/client_registrations
RUN chmod -R 755 /opt/app-root/src/client_registrations

# Add Configuration files
ADD sites.d/* /opt/app-root/src/sites.d/
RUN chmod -R 755 /opt/app-root/src/sites.d
ADD main.d/* /opt/app-root/src/main.d/
RUN chmod -R 755 /opt/app-root/src/main.d

# Ports
EXPOSE 8080
EXPOSE 8180

# Start the container
CMD ["/opt/app-root/src/bin/entrypoint"]
