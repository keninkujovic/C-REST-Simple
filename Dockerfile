FROM mcr.microsoft.com/dotnet/sdk:8.0 AS build-env
WORKDIR /build
COPY WebApi .
RUN dotnet restore
RUN dotnet publish -c Release -o out

# 2. Build runtime image
FROM mcr.microsoft.com/dotnet/aspnet:8.0 
LABEL description="Sample WebApi"
LABEL organisation="kenin.ch"
LABEL author="Kenin Kujovic"
WORKDIR /app
COPY --from=build-env /build/out .
ENV ASPNETCORE_URLS=http://0.0.0.0:5001
EXPOSE 5001
ENTRYPOINT ["dotnet", "WebApi.dll"]
