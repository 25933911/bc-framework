-- ##bcƽ̨�� oracle �Զ��庯���ʹ洢����##

-- ���ý���Ϣ���������̨���������SQL Plus�������������sql�ļ���������ִ�����������ܿ��������Ϣ��
-- set serveroutput on;

-- ����ɾ��ָ���û���Ĵ洢����
CREATE OR REPLACE PROCEDURE update_actor_pcodepname(
   --actor�������ϼ���id��Ϊ0�����㵥λ
   pid IN number
)
AS
--�������
pfcode varchar2(4000);
pfname varchar2(4000);
cid number;
cursor curChilden is select a.id from bc_identity_actor a inner join bc_identity_actor_relation r on r.follower_id = a.id where r.type_=0 and r.master_id=pid;
BEGIN
	dbms_output.put_line('pid=' || pid);
    
  	if pid > 0 then
		select pcode || '/' || code,pname || '/' || name into pfcode,pfname from bc_identity_actor where id=pid;
        dbms_output.put_line('pfcode='||pfcode);
        dbms_output.put_line('pfname='||pfname);
        open curChilden;
        fetch curChilden into cid;
        while curChilden%found loop
            dbms_output.put_line('cid='||cid);
            fetch curChilden into cid;-- ���α�ָ��������¼, ����Ϊ��ѭ��.
        end loop;
        close curChilden;
	else
		dbms_output.put_line('pid=null');
	end if; 
END;
/


-- �������
set serveroutput on SIZE number(1000);
CALL update_actor_pcodepname(1);

-- ɾ���Խ��Ĵ洢����
-- drop procedure DROP_USER_TABLE;
-- drop procedure DROP_USER_SEQUENCE;
select * from bc_identity_actor a inner join bc_identity_actor_relation r on r.follower_id = a.id where r.type_=0 and r.master_id=1;
