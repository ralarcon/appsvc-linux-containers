FROM mcr.microsoft.com/appsvc/dotnetcore:5.0_20201229.1 AS base
WORKDIR /app
EXPOSE 80
EXPOSE 443

FROM mcr.microsoft.com/dotnet/sdk:5.0-buster-slim AS build
WORKDIR /src
COPY . .
RUN dotnet restore "hello-world-net5.csproj"

RUN dotnet build "hello-world-net5.csproj" -c Release -o /app/build

FROM build AS publish
RUN dotnet publish "hello-world-net5.csproj" -c Release -o /app/publish

FROM base AS final
WORKDIR /home/site/wwwroot
COPY --from=publish /app/publish .