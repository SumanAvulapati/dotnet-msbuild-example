FROM registry.access.redhat.com/ubi8/dotnet-50:5.0 AS build
WORKDIR /app
COPY *.csproj ./
COPY . ./
RUN dotnet restore
WORKDIR /app
RUN dotnet publish -c Release -o /app
FROM registry.access.redhat.com/ubi8/dotnet-50:5.0 AS base
EXPOSE 5000
WORKDIR /app
ENV ASPNETCORE_URLS=http://+:5000
COPY --from=build /app ./
ENTRYPOINT ["dotnet", "MsbuildLibrary.dll"]