FROM mcr.microsoft.com/dotnet/aspnet:5.0 AS base
WORKDIR /app
EXPOSE 80
EXPOSE 443

FROM mcr.microsoft.com/dotnet/sdk:5.0 AS build
WORKDIR /src
COPY ["hello-world-net5.csproj", "./"]
RUN dotnet restore "hello-world-net5.csproj"
COPY . .
WORKDIR "/src/."
RUN dotnet build "hello-world-net5.csproj" -c Release -o /app/build

FROM build AS publish
RUN dotnet publish "hello-world-net5.csproj" -c Release -o /app/publish

FROM base AS final
WORKDIR /app
COPY --from=publish /app/publish .


#SETUP SSH

# Install OpenSSH and set the password for root to "Docker!".
RUN apt-get update \
     && apt-get install -y --no-install-recommends openssh-server \
     && echo "root:Docker!" | chpasswd 

COPY ssh/sshd_config /etc/ssh/
COPY ssh/ssh_setup.sh /tmp

RUN chmod -R +x /tmp/ssh_setup.sh \
   && (sleep 1;/tmp/ssh_setup.sh 2>&1 > /dev/null) \
   && rm -rf /tmp/*

COPY custom_start.sh /bin/
RUN chmod 755 /bin/custom_start.sh

EXPOSE 2222

#ENTRYPOINT ["dotnet", "hello-world-net5.dll"]
ENTRYPOINT [ "/bin/custom_start.sh" ]