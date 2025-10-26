# USV Cross-Platform Dashboard

Ứng dụng Flutter hiển thị và giám sát dữ liệu từ **USV (Unmanned Surface Vehicle)** — bao gồm thông số vận hành và chất lượng nước theo thời gian thực.

---

## Tính năng Hệ thống

| **Tính năng** | **Mô tả** | **Chi tiết Dữ liệu** |
|------------------|-------------|--------------------------|
| **Trạng thái USV** | Hiển thị các chỉ số vận hành cốt lõi của phương tiện. | Pin (%), Vận tốc (km/h), Hướng di chuyển (Heading). |
| **Chất lượng Nước** | Giám sát các thông số môi trường quan trọng. | pH, DO (Oxy hòa tan), COD (Nhu cầu Oxy Hóa học), TSS (Tổng chất rắn lơ lửng). |
| **Đồ thị Lịch sử** | Trực quan hóa dữ liệu lịch sử theo thời gian. | Biểu đồ đường (Line Chart) cho phép theo dõi xu hướng của các chỉ số chất lượng nước. |
| **Xử lý Lỗi** | Cơ chế `try-catch` tích hợp để hiển thị lỗi kết nối/dữ liệu và nút **Thử lại (Retry)**. | Ngăn chặn ứng dụng crash do lỗi bất đồng bộ. |

---

## 3. Hướng dẫn Cài đặt & Chạy Ứng dụng

### 3.1. Yêu cầu Tiên quyết (Prerequisites)

- **Flutter SDK:** Đảm bảo bạn đã cài đặt Flutter và thiết lập biến môi trường.  
  Kiểm tra bằng lệnh:
  ```bash
  flutter doctor
  ```
- Dart SDK: (Đi kèm với Flutter)
- Môi trường Phát triển (IDE): Visual Studio Code hoặc Android Studio.

### 3.2. Thiết lập Môi trường

Clone Kho lưu trữ:
```bash
git clone https://github.com/thanhtra3105/USV-Cross-platform.git
cd USV-Cross-platform
```

Cài đặt Thư viện Phụ thuộc:
```bash
flutter pub get
```
### 3.3. Khởi chạy Ứng dụng

Ứng dụng này được thiết kế để chạy đa nền tảng (Mobile, Web, Desktop).

Mở IDE: Mở thư mục USV-Cross-platform trong IDE của bạn.

Chọn Thiết bị: Chọn một thiết bị (Emulator/Simulator hoặc thiết bị thật).

Chạy Ứng dụng:
```bash
  flutter run
```

Ứng dụng sẽ khởi chạy và hiển thị giao diện Dashboard.

💡 Lưu ý: Ứng dụng mô phỏng việc lấy dữ liệu (Delay, Random Error) để kiểm tra tính ổn định của FutureBuilder và logic bất đồng bộ.

#4. Cấu trúc Dự án Chính
```plaintext
lib/
├── pages/
│   ├── dashboardPage.dart     # Trang Dashboard chính (hiển thị dữ liệu tổng quan)
│   ├── missionPage.dart       # Trang chọn mission cho USV
│   ├── overviewPage.dart      # Trang Tổng quan hệ thống
│   └── streamPage.dart        # Trang Truyền Video Stream
├── widgets/
│   ├── batteryCard.dart       # Thẻ hiển thị trạng thái pin
│   ├── dashboardCard.dart     # Thẻ hiển thị thông tin chung của Dashboard
│   ├── historyChart.dart      # Biểu đồ lịch sử (Line Chart)
│   └── speedCard.dart         # Thẻ hiển thị vận tốc hiện tại
└── main.dart                  # main
```
# Giấy phép
...

# ©️ Bản quyền
© 2025 thanhtra3105.
Bản quyền thuộc về tác giả thanhtra3105 & Mojinnn

## Tác giả: thanhtra3105 & Mojinnn
### Phiên bản: 1.0.0

