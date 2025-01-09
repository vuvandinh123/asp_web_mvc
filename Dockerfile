# Sử dụng image .NET SDK để build ứng dụng
FROM mcr.microsoft.com/dotnet/sdk:6.0 AS build

# Thiết lập thư mục làm việc trong container
WORKDIR /app

# Sao chép các tệp từ thư mục gốc vào container
COPY . . 

# Restore các gói NuGet
RUN dotnet restore

# Build ứng dụng
RUN dotnet publish -c Release -o out

# Sử dụng image .NET runtime để chạy ứng dụng
FROM mcr.microsoft.com/dotnet/aspnet:6.0 AS base
WORKDIR /app
COPY --from=build /app/out .

# Mở cổng mà ứng dụng sẽ chạy
EXPOSE 80

# Chạy ứng dụng
ENTRYPOINT ["dotnet", "DoAn_LapTrinhWeb.dll"]
