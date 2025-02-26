FROM mcr.microsoft.com/dotnet/aspnet:9.0 AS base
WORKDIR /app
EXPOSE 80
EXPOSE 443

FROM mcr.microsoft.com/dotnet/sdk:9.0 AS build
WORKDIR /src

COPY ["server/ECommerceApp.API/ECommerceApp.API.csproj", "ECommerceApp.API/"]
COPY ["server/ECommerceApp.Core/ECommerceApp.Core.csproj", "ECommerceApp.Core/"]
COPY ["server/ECommerceApp.Infrastructure/ECommerceApp.Infrastructure.csproj", "ECommerceApp.Infrastructure/"]
RUN dotnet restore "ECommerceApp.API/ECommerceApp.API.csproj"

COPY ["server/", "."]

WORKDIR "/src/ECommerceApp.API"
RUN dotnet build "ECommerceApp.API.csproj" -c Release -o /app/build

FROM build AS publish
RUN dotnet publish "ECommerceApp.API.csproj" -c Release -o /app/publish

FROM base AS final
WORKDIR /app
COPY --from=publish /app/publish .
ENTRYPOINT ["dotnet", "ECommerceApp.API.dll"]