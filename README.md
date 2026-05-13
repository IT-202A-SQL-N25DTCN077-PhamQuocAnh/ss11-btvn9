# Phân tích bài tập tổng hợp

## **Phân tích đầu vào đầu ra (IN/OUT)**

- Đầu vào :
    - p_patient_id, p_patient_id, p_quantity, p_voucher đây là những tham số đầu vào của procedure 

- Đầu ra : 
    - p_status_message sẽ trả về thông báo trạng thái xử lí, nếu thành công sẽ trả về 'Đã xử lí đơn thuốc' còn nếu không thì sẽ trả về thông báo xử lí đơn thuốc thất bại

## **Xử lí logic**

- Khai báo các biến cục bộ bằng DECLARE để hứng các giá trị từ các select 
- DÙng select để lấy thông tin từ bảng medicines kết hợp với into vào các biến cục bộ để hứng giá trị
- Sau đó tôi sẽ kiểm tra xem số lượng thuốc p_quantity IN vào có phù hợp với số lượng thuốc v_stock mà select trả về hay không 
    - Nếu đúng --> thực hiện các phép tính toán 
        - Sử dụng update để trừ đi số lượng thuốc trong kho 
        - sử dụng update để cộng thêm tổng tiền vào hóa đơn của bệnh nhân 
        - Biến cục bộ sẽ được khởi tạo để hứng giá trị tính toán số tiền mà bệnh nhân phải trả 
        - Sau đó sẽ kiểm tra voucher người dùng sử dụng có đúng với voucher được giảm giá hay không
        - Nếu đúng thì sẽ giảm giá 50% giá trị đơn hàng
        - Nếu sai thì giữ nguyên 100% giá trị đơn hàng
- Nếu số lượng thuốc p_quantity IN vào không phù hợp với số lượng thuốc v_stock mà select trả về --> sẽ dừng xử lí và trả về thông báo xử lí đơn thuốc thất bại 
