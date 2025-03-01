FROM mcr.microsoft.com/dotnet/sdk:8.0 AS build
WORKDIR /app

# Copy solution and project files first for better layer caching
COPY ECommerceApp.sln .
COPY server/ECommerceApp.API/*.csproj ./server/ECommerceApp.API/
COPY server/ECommerceApp.Core/*.csproj ./server/ECommerceApp.Core/
COPY server/ECommerceApp.Infrastructure/*.csproj ./server/ECommerceApp.Infrastructure/
COPY server/ECommerceApp.Tests/*.csproj ./server/ECommerceApp.Tests/

# Restore packages
RUN dotnet restore

# Copy all other source files
COPY server/ ./server/

# Build and publish
RUN dotnet publish -c Release -o out server/ECommerceApp.API

# Build runtime image
FROM mcr.microsoft.com/dotnet/aspnet:8.0 AS runtime
WORKDIR /app
COPY --from=build /app/out .

# Set environment variables
ENV ASPNETCORE_URLS=http://+:80
ENV ASPNETCORE_ENVIRONMENT=Production

EXPOSE 80
ENTRYPOINT ["dotnet", "ECommerceApp.API.dll"]