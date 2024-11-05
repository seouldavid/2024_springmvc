package com.ict.guestbook2.service;

import java.util.List;

import com.ict.guestbook2.vo.GuestBook2VO;

public interface GuestBook2Service {
public List<GuestBook2VO> getGuestBook2List();
public int getGuestBook2Insert(GuestBook2VO gb2vo);
public GuestBook2VO getGuestBook2Detail(String gb2_idx);
public int getGuestBook2Update(GuestBook2VO gb2vo);
public int getGuestBook2Delete(String gb2_idx);
}
