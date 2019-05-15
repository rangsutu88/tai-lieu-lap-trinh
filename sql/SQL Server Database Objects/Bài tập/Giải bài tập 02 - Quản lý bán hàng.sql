create database QuanLyBanHang
go
use QuanLyBanHang
go
Create table NhaCungCap
(
	MaNhaCC nvarchar (10) not null primary key,
	TenNhaCC nvarchar (40) not null,
	DiaChi nvarchar (60) not null,
	Phone nvarchar (24) not null,
	Fax nvarchar (24) null,
	HomePage ntext  null
)
go
Create table LoaiSanPham
(
	MaLoaiSP nvarchar (10) not null primary key,
	TenLoaiSP nvarchar (15) not null,
	MoTa ntext null
)
go

Create table SanPham
(
	MaSP nvarchar (10) not null primary key,
	TenSP nvarchar (40) not null,
	MaNhaCC nvarchar (10) not null,
	MaLoaiSP nvarchar (10) not null,
	DVT nvarchar (20) not null,
	DonGia smallint not null default (0),
	SoLuong smallint not null default (0),
	SoLuongTT smallint not null default (0),
	Discontinued bit not null default (0)
)
go
Create table NhanVien
(
	MaNV nvarchar(10) not null primary key,
	HoTen nvarchar(20) not null,
	ChucDanh nvarchar(30) not null,
	NgaySinh smalldatetime not null,
	NgayNhanViec smalldatetime not null,
	DiaChi nvarchar(10) not null,
	Phone nvarchar(10) not null,
	PhoTo image null,
	GhiChu ntext
)
go
create table HoaDon
(
	MaHD nvarchar(10) not null primary key,
	MaKH nvarchar(10) not null,
	MaNV nvarchar(10) not null,
	NgayLapHD smalldatetime not null,
	NgayNhanHang smalldatetime not null,
	Tien int not null default(0),
	Thue real not null default(0.0),
	TongSoTien int not null default(0)
)
go
create table KhachHang
(
	MaKH nvarchar(10) not null primary key,
	TenKH nvarchar(30) not null,
	DiaChi nvarchar(50) not null,
	Phone nvarchar(24) not null,
	Email nvarchar(30) not null
)
go
create table HoaDonChiTiet
(
	MaHD nvarchar(10) not null,
	MaSP nvarchar(10) not null,
	DonGia int not null default(0),
	SoLuong smallint not null default(0),
	GiamGia real not null default(0.0),
	ThanhTien int not null default(0)
)
go

alter table SanPham
add
	constraint PK_SanPham_LoaiSanPham
	foreign key (MaLoaiSP)
	references LoaiSanPham(MaLoaiSP),
	constraint PK_SanPham_NhaCungCap
	foreign key (MaNhaCC)
	references NhaCungCap(MaNhaCC)
go
alter table HoaDon
add
	constraint PK_HoaDon_NhanVien
	foreign key(MaNV)
	references NhanVien(MaNV),
	constraint PK_HoaDon_KhacHang
	foreign key(MaKH)
	references KhachHang(MaKH)
go
alter table HoaDonChiTiet
add
	constraint PK_HoaDonChiTiet_SanPham
	foreign key(MaSP)
	references SanPham(MaSP),
	constraint PK_HoaDonChiTiet_HoaDon
	foreign key(MaHD)
	references HoaDon(MaHD)
go
/*Chen du lieu cho bang*/
--chen du lieu vao bang NhaCungCap
insert into NhaCungCap values('BAN','Cong ty Ban Mai','64 Hang Bun','048286745','','WWW.binhminh.com')
go
insert into NhaCungCap values('OCE','Cong ty Ocean','26 Tran Quy Cap','048924712','','www.ocean.com')
go
insert into NhaCungCap values('RDO','Cong ty Rang Dong','97 Hoang Hoa Tham','048923711','','www.rdong.com')
go
--chen du lieu vao bang KhachHang
insert into KhachHang values('01','Hoa Binh','Ha Noi','0913567222','hb@fpt.vn')
go
insert into KhachHang values('02','Quang Long','Ha Noi','048123445','qlong@yahoo.com')
go
insert into KhachHang values('03','Nguyen Tuan','Hai Phong','098467231','Tuan@yahoo.com')
go
--chen du lieu vao bang nhan vien
insert into NhanVien values('01','Lan Huong','Ban Hang','11/23/1980','1/15/2004','Hoa Binh','0912349865','','')
go
insert into NhanVien values('02','Bich Hue','Tiep thi','12/31/1979','1/22/2001','Quang Binh','098768324','','')
go
insert into NhanVien values('03','Ting Chu','Ban Hang','8/9/1986','1/14/2005','Hai Phong','098568253','','')
go
insert into NhanVien values('04','Kien Cuong','Thu kho','9/19/1979','1/22/2003','Ha Noi','0912367299','','')
go
--Chen du lieu vao bang LoaiSanPham
insert into LoaiSanPham values('DL','Dien lanh','')
go
insert into LoaiSanPham values('DT','Dien tu','')
go
insert into LoaiSanPham values('MP','Hang my Pham','')
go
insert into LoaiSanPham values('TD','Hang tieu dung','')
go
--chen du lieu bang SanPham
insert into SanPham values('001','Vo tuyet','BAN','DT','Chiec',4000,25,5,0)
go
insert into SanPham values('002','Radio','BAN','DT','Chiec',200,150,20,0)
go
insert into SanPham values('003','CD player','BAN','DT','Chiec',2000,45,10,0)
go
insert into SanPham values('004','Tu lanh','RDO','DL','Chiec',6000,22,5,0)
go
insert into SanPham values('005','May lam kem','RDO','DL','Chiec',7000,19,4,0)
go
insert into SanPham values('007','May dieu hoa','RDO','DL','Chiec',9000,38,7,0)
go
insert into SanPham values('008','Xa phong thom','OCE','TD','Banh',6,200,50,0)
go
insert into SanPham values('009','Duong','OCE','TD','Kg',9,550,50,0)
go
insert into SanPham values('010','Sua','OCE','TD','Hop',120,80,20,0)
go
insert into SanPham values('011','Mi miliket','OCE','TD','Thung',200,56,8,0)
go
--chen du lieu vao bang HoaDon
insert into HoaDon values('01','02','01','12/14/2007','12/15/2007',0,0.05,0)
go
insert into HoaDon values('02','01','01','1/19/2006','2/15/2006',0,0.05,0)
go
insert into HoaDon values('03','02','02','10/30/2006','1/1/2006',0,0.1,0)
go
--Chen du lieu vao bang HoaDonChiTiet
insert into HoaDonChiTiet values('03','003',0,3,0.02,0)
go
insert into HoaDonChiTiet values('03','007',0,2,0.01,0)
go
insert into HoaDonChiTiet values('03','011',0,10,0.0,0)
go
insert into HoaDonChiTiet values('02','010',0,11,0.04,0)
go
insert into HoaDonChiTiet values('02','002',0,2,0.01,0)
go
insert into HoaDonChiTiet values('01','004',0,1,0.05,0)
go
insert into HoaDonChiTiet values('01','009',0,15,0.04,0)
go
/***************************Bai Lam***********************************************/
/*Cau 1:Tao cac loai index mot cach thich hop va theo doi tac dong cua cac lenh nay
khi thuc hien cac lenh truy van (select)
*/ 
create unique clustered index id_SanPham on SanPham(MaSP)
go
Create unique clustered index id_NhanVien on NhanVien(MaNV)
go
Create unique Clustered index id_NhaCungCap on NhaCungCap(MaNhaCC)
go
create unique clustered index id_HoaDon on HoaDon(MaHD)
go
create unique clustered index id_KhachHang on KhachHang(MaKH)
go
Create unique clustered index id_LoaiSanPham on LoaiSanPham(MaLoaiSP)
go
/*Cau 2: Trong bang HoaDonChiTiet cot thanh tien con chua duoc tinh toan, hay cap nhap
truong ThanhTien=DonGia*SoLuong*(1-GiamGia).
*/  
update HoaDonChiTiet
set ThanhTien=(DonGia*SoLuong*(1-GiamGia))
go
/*Cau 3:Sau khi da co thong tin ve ThanhTien trong HoaDonChiTiet, hay cap nhap thong
tin cua truong Tien trong Hoa Don= Tong so tien cua cac mat hang co trong hoa don
= Tong cua cot ThanhTien cua cac ban ghi trong HoaDonChiTiet co cung so hoa don(MaHD).
Cap nhap truong TongSoTien=Tien*(1+Thue).
*/
--Cach 1:
create view dshd
as
select MaHD,sum(ThanhTien) as tien 
from HoaDonChiTiet
group by MaHD
go
update HoaDon
set HoaDon.Tien=dshd.tien
from dshd,HoaDon
where dshd.MaHD=HoaDon.MaHD
go
update HoaDon set TongSoTien=Tien*(1+Thue)
go
--Cach 2:su dung con tro
create proc proc_update
as
begin
	Declare Ptr Cursor
	For Select HoaDon.MaHD,Sum(HoaDonChiTiet.ThanhTien)As'Tien'
	From HoaDon,HoaDonChiTiet 
	where HoaDon.MaHD=HoaDonChiTiet.MaHD
	Group By HoaDon.MaHD
	Open Ptr
	Declare @MaHD Nvarchar(10)
	Declare @Tien Float
	Fetch Next From Ptr Into @MaHD,@Tien
	While @@Fetch_Status=0
	Begin
		Update HoaDon Set Tien=@Tien Where MaHD=@MaHD
		Fetch Next From Ptr Into @MaHD,@Tien
	End
	Close Ptr
	DeAllocate Ptr 
	update HoaDon set TongSoTien=Tien*(1+Thue)
end
exec proc_update

/*Cau 4:Hien thi danh sach cac mat hang voi day du cac thong tin sau:
LoaiHang,mahang,tenhang sap xep tang dan theo ten hang.
*/
select l.TenLoaiSP,s.MaSP,s.TenSP
from LoaiSanPham as l,SanPham as s
where l.MaLoaiSP=s.MaLoaiSP
order by s.TenSP ASC
go
/*Cau 5: Liet ke tung mat hang va tong so hang da ban(co trong hoa don chi tiet)
theo tung mat hang.
*/
select s.TenSP,h.SoLuong
from SanPham as s,HoaDonChiTiet as h
where s.MaSP=h.MaSP
go
/*Cau 6:Liet ke tung mat hang va tong so tien da ban(Co trong hoa don chi tiet)
theo tung mat hang
*/
select s.TenSP,Sum(h.ThanhTien) as TongSoTien
from SanPham as s,HoaDonChiTiet as h
where s.MaSP=h.MaSP
group by s.TenSP
go
/*Cau 7: Liet ke chi tiet cac mat hang da ban bao gom cac thong tin sau:
So hoa don, Ma san pham(hang),ten san pham,don gia,So luong,giam gia va thanh tien.
Chi liet ke nhung mat hang co giam gia tren 1%(tuc la trong giam gia>0.01),
va ThanhTien <10000.
*/
select h.MaHD,h.MaSP,s.TenSP,h.DonGia,h.SoLuong,h.GiamGia,h.ThanhTien
from SanPham as s, HoaDonChiTiet as h
where h.MaSP=s.MaSP and GiamGia >0.01 and ThanhTien<10000
go
/*Cau 8: Hay liet ke danh sach khach ahng voi day du cac thong tin nhu:
MaKH,TenKH,DiaChi,DienThoai,So hoa donn da mua hang trong thang 3 nam 1997.
(Chi liet ke cac khach hang nay va sap xep theo thu tu tang dan cua ho ten.*/

select k.MaKH,k.TenKH,k.DiaChi,k.Phone,h.MaHD,Count(h.MaHD) as SoHoaDonDaMua
from KhachHang as k,HoaDon as h
where k.MaKH=h.MaKH and NgayLapHD between '3/1/2006' and '3/31/2006'
group by k.MaKH,k.TenKH,k.DiaChi,k.Phone,h.MaHD
order by k.TenKH ASC
go
/*Cau 9: Liet ke danh sach cac mat hang da ban theo tung loai hang. Voi moi loai hang
tinh tong so mat hang da ban, Tong so tien va cuoi cung co tong tat ca cac mat hang
da ban va tong so tien*/
select s.TenSP
from SanPham as s,LoaiSanPham as l,HoaDonChiTiet as h
where l.MaLoaiSP=s.MaLoaiSP and s.MaSP=h.MaSP and l.MaLoaiSP='TD'
go
create view DanhSach
as
select s.TenSP,Sum(h.SoLuong) as TongSoLuong,Sum(h.ThanhTien)TongSoTien
from SanPham as s,LoaiSanPham as l,HoaDonChiTiet as h
where l.MaLoaiSP=s.MaLoaiSP and s.MaSP=h.MaSP and l.MaLoaiSP='TD'
group by s.TenSP
go
select * from DanhSach
go
select Sum(TongSoLuong) as TongTatCaSoLuong,Sum(TongSoTien) as TongTatCaSoTien
from DanhSach
go

/*Cau 10: Liet ke danh sach tat ca cac khach hang da mua hang trong thang 11/2006
va tong so tien ma ho da mua.*/
select k.TenKH,Sum(h.TongSoTien) as TongSoTienDaMua
from KhachHang as k,HoaDon as h
where k.MaKH=h.MaKH and NgaylapHD between '11/1/2006' and '11/30/2006'
group by k.TenKH
go
/*Cau 11.	Liệt kê danh sách tất cả các nhân viên và số tiền hàng họ bán được trong tháng  11/2006.*/
select n.HoTen,Sum(h.TongSoTien) as TongSoTienBanDuoc
from NhanVien as n,HoaDon as h
where n.MaNV=h.MaNV and NgaylapHD between '11/1/2006' and '11/30/2006'
group by n.HoTen
go
/*Cau 12.	Viết Stored Procedure có tên là  procProductList có hai tham số vào  là  pYear và pMonth. 
Cả hai tham số  là số nguyên chỉ năm và tháng. 
Procedure có một tham số OUTPUT  là  pMaLoaiHang, là mã của loại hàng đã bán được số tiền nhiều nhất trong tháng pMonth và năm pYear. 
Số tiền cho mỗi mặt hàng là: DonGia x SoLuong, không tính đến GiamGia. 
Sau khi viết xong Procedure thì thử lại, sau đó in ra mã và cả tên loại hàng có mã là  pMaLoaiHang.
*/

Create proc procProductList
@pYear int, @pMonth int,@pMaLoaiHang nvarchar(10) output
as
begin
	select top 1 @pMaLoaiHang=l.MaLoaiSP
	from HoaDon as h,
		HoaDonChiTiet as hc,
		SanPham as s,LoaiSanPham as l
	where l.MaLoaiSP=s.MaLoaiSP and s.MaSP=hc.MaSP and hc.MaHD=h.MaHD 
		and datepart(mm,NgayLapHD)=@pMonth and datepart(yy,NgayLapHD)=@pYear
	group by l.MaLoaiSP
	order by (select max(hc.DonGia*hc.SoLuong)) desc
end
go
declare @ma nvarchar(10)
exec dbo.procProductList 12,2007,@ma output
select MaLoaiSP,TenLoaiSP
from LoaiSanPham
where MaLoaiSP=@ma
go
	

/*Cau 13.Viết Function có tên là  funcDonGia có tham số vào là mã mặt hàng (sản phẩm) và trả về đơn giá của mặt hàng này. 
Viết lệnh thử lại kết quả trên màn hình.*/
Create function funcDonGia(@MaSP nvarchar(10))
Returns money
As
Begin
	Declare @Gia as money
	Select  @Gia=DonGia from SanPham Where MaSP=@MaSP
	Return @Gia
End
go
Declare @DonGia money
set @DonGia=dbo.FuncDonGia('001')
print @DonGia 
go
/*Cau 14:Viết trigger xóa bản ghi trong bảng  LoaiSanPham. 
Khi xóa thi lưu thông tin mã loại sản phẩm (MaLoaiSP), và thông tin ngày xóa (DelDate) vào bảng LoaiSP_Hist 
đồng thời xóa các bản ghi tương ứng trong các bảng liên quan (tức là các bảng có chứa khóa ngoại tham chiếu đến bảng LoaiSanPham. */
Create table LoaiSP_Hist
(
	MaLoaiSP nvarchar(10) not null,
	DelDate datetime
)
go
--tao 1 trigger
create trigger trig_del on LoaiSanPham
instead of delete
as
begin
	declare ptr cursor fast_forward--khai bao 1 con tro
	for select MaLoaiSP from deleted--lay ma
	open ptr--
	declare @Ma nvarchar(10)
	declare @date datetime
	set @date=getdate()
	declare @MaSP nvarchar(10)
	fetch next from ptr into @Ma
	while(@@fetch_status=0)
	begin
		--delete HoaDonChiTet where MaSP=@Ma
		delete HoaDonChiTiet from HoaDonChiTiet,SanPham,LoaiSanPham where LoaiSanPham.MaLoaiSP=SanPham.MaLoaiSP and SanPham.MaSP=HoaDonChiTiet.MaSP and LoaiSanPham.MaLoaiSP=@Ma
		delete SanPham where MaLoaiSP=@Ma
		delete LoaiSanPham where MaLoaiSP=@Ma
		insert into LoaiSP_Hist values(@Ma,@date)
		fetch next from ptr into @Ma
	end
	close ptr
	deallocate ptr
end
go
drop trigger trig_del
go
delete LoaiSanPham
where MaLoaiSP='DT'
go 
