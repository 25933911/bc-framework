-- ��������
create sequence HIBERNATE_SEQUENCE
    minvalue 1
    start with 1
    increment by 1
    cache 20;

-- ������
create table TBALE1 (
    ID NUMBER(19) not null,
    NAME varchar2(255) not null,
    CODE VARCHAR2(255),
    primary key (ID)
);

-- ������ע��
COMMENT ON TABLE TBALE1 IS '�����ߵ���չ����';

-- ������ע��
COMMENT ON COLUMN TBALE1.NAME IS '����ʱ��';

-- �������
ALTER TABLE TBALE1 ADD CONSTRAINT FK1 FOREIGN KEY (DETAIL_ID) REFERENCES TBALE2 (ID);
ALTER TABLE TBALE1 ADD CONSTRAINT FK1 FOREIGN KEY (DETAIL_ID) REFERENCES TBALE2 (ID) ON DELETE CASCADE;

-- ��������
CREATE INDEX IDX1 ON TBALE1 (NAME ASC);


-- ���ý���Ϣ���������̨���������SQL Plus�������������sql�ļ���������ִ�����������ܿ��������Ϣ��
-- set serveroutput on;

-- ����ɾ��ָ���û���Ĵ洢����
CREATE OR REPLACE PROCEDURE dropUserTable
(
   --����IN��ʾ���������
   --OUT��ʾ������������Ϳ���ʹ������Oracle�еĺϷ����͡�
   i_table_name IN varchar2
)
AS
--�������
num number;
BEGIN
	select count(1) into num from user_tables where table_name = upper(i_table_name) or table_name = lower(i_table_name); 
	if num > 0 then 
		execute immediate 'drop table ' || i_table_name;
		dbms_output.put_line('�� ' || i_table_name || ' ��ɾ��');
	end if; 
	if num <= 0 then 
		dbms_output.put_line('�� ' || i_table_name || ' �����ڣ�����');
	end if; 
END;
/

-- ��ȡ�û���������������֯����λ�����ţ�
select f.name,m.name from BC_IDENTITY_ACTOR m,BC_IDENTITY_ACTOR f
	where f.type_=4 --f.code='qiong'
    and f.pcode like (case when m.pcode is null then '' else m.pcode || '/' end) || '[' || m.type_ || ']' || m.code || '%'
    order by m.order_;
    
