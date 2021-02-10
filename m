Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-21.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CB22C433E6
	for <linux-hardening@archiver.kernel.org>; Wed, 10 Feb 2021 22:50:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5CB5764ED0
	for <linux-hardening@archiver.kernel.org>; Wed, 10 Feb 2021 22:50:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232212AbhBJWuV (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Wed, 10 Feb 2021 17:50:21 -0500
Received: from mail.kernel.org ([198.145.29.99]:50694 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232164AbhBJWuU (ORCPT <rfc822;linux-hardening@vger.kernel.org>);
        Wed, 10 Feb 2021 17:50:20 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id C3D4564EAC;
        Wed, 10 Feb 2021 22:49:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1612997380;
        bh=9GWrJH4D5kRgV/kzJAspNT1VfbR+T+Ol4bGBDgM0IRc=;
        h=Date:From:To:Cc:Subject:From;
        b=Il60EIAoC2ATFfXoB1WHPMkFGbMkSGpRkdh6Zv7EoyIuFW0pUqEiABptrMOFVqRXY
         d4Yz1B1z3ZDPwVERGoeQr+qzNKDNK8QtMZHYncWEaooR7tIUeOc5f7o4Mm6/wOx8R9
         ne3dUOXMNOLT3O8pWsYE0GSOV1tOeYWwSzSTvA+1i6i2Nj8Q9+ducSP+XuFCo5P59D
         PMsxsdr9fl7jqzROgs3mfHewaSPx7tcqt9LBObOp3nl5D+zwFobPdpRi0l8RJqiFeF
         GhpH4P2rMq9otYRHDBl/Dn5ntdVYnzfr99c6bKzvtRAUOr7b9g0FY/vVoKGTzUktT4
         qI3RsfdzFNpvQ==
Date:   Wed, 10 Feb 2021 16:49:37 -0600
From:   "Gustavo A. R. Silva" <gustavoars@kernel.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        linux-hardening@vger.kernel.org
Subject: [PATCH][next] staging: rtl8723bs: Replace one-element array with
 flexible-array member in struct ndis_80211_var_ie
Message-ID: <20210210224937.GA11922@embeddedor>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

There is a regular need in the kernel to provide a way to declare having
a dynamically sized set of trailing elements in a structure. Kernel code
should always use “flexible array members”[1] for these cases. The older
style of one-element or zero-length arrays should no longer be used[2].

Refactor the code according to the use of a flexible-array member in
struct ndis_80211_var_ie, instead of a one-element array.

Also, this helps with the ongoing efforts to enable -Warray-bounds and
fix the following warnings:

  CC [M]  drivers/staging/rtl8723bs/core/rtw_wlan_util.o
In file included from ./drivers/staging/rtl8723bs/include/drv_types.h:20,
                 from drivers/staging/rtl8723bs/core/rtw_wlan_util.c:9:
drivers/staging/rtl8723bs/core/rtw_wlan_util.c: In function ‘HT_caps_handler’:
./drivers/staging/rtl8723bs/include/basic_types.h:108:11: warning: array subscript 1 is above array bounds of ‘u8[1]’ {aka ‘unsigned char[1]’} [-Warray-bounds]
  108 |  (EF1BYTE(*((u8 *)(__pstart))))
      |           ^
./drivers/staging/rtl8723bs/include/basic_types.h:42:8: note: in definition of macro ‘EF1BYTE’
   42 |  ((u8)(_val))
      |        ^~~~
./drivers/staging/rtl8723bs/include/basic_types.h:127:4: note: in expansion of macro ‘LE_P1BYTE_TO_HOST_1BYTE’
  127 |   (LE_P1BYTE_TO_HOST_1BYTE(__pstart) >> (__bitoffset)) & \
      |    ^~~~~~~~~~~~~~~~~~~~~~~
./drivers/staging/rtl8723bs/include/rtw_ht.h:97:55: note: in expansion of macro ‘LE_BITS_TO_1BYTE’
   97 | #define GET_HT_CAPABILITY_ELE_RX_STBC(_pEleStart)     LE_BITS_TO_1BYTE((_pEleStart)+1, 0, 2)
      |                                                       ^~~~~~~~~~~~~~~~
drivers/staging/rtl8723bs/core/rtw_wlan_util.c:1104:58: note: in expansion of macro ‘GET_HT_CAPABILITY_ELE_RX_STBC’
 1104 |   if (TEST_FLAG(phtpriv->stbc_cap, STBC_HT_ENABLE_TX) && GET_HT_CAPABILITY_ELE_RX_STBC(pIE->data)) {
      |                                                          ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~
drivers/staging/rtl8723bs/core/rtw_wlan_util.c:1051:75: warning: array subscript 2 is above array bounds of ‘u8[1]’ {aka ‘unsigned char[1]’} [-Warray-bounds]
 1051 |    if ((pmlmeinfo->HT_caps.u.HT_cap_element.AMPDU_para & 0x3) > (pIE->data[i] & 0x3))
      |                                                                  ~~~~~~~~~^~~
drivers/staging/rtl8723bs/core/rtw_wlan_util.c: In function ‘check_assoc_AP’:
drivers/staging/rtl8723bs/core/rtw_wlan_util.c:1606:19: warning: array subscript 4 is above array bounds of ‘u8[1]’ {aka ‘unsigned char[1]’} [-Warray-bounds]
 1606 |      if (pIE->data[4] == 1)
      |          ~~~~~~~~~^~~
drivers/staging/rtl8723bs/core/rtw_wlan_util.c:1609:20: warning: array subscript 5 is above array bounds of ‘u8[1]’ {aka ‘unsigned char[1]’} [-Warray-bounds]
 1609 |       if (pIE->data[5] & RT_HT_CAP_USE_92SE)
      |           ~~~~~~~~~^~~
drivers/staging/rtl8723bs/core/rtw_wlan_util.c:1613:19: warning: array subscript 5 is above array bounds of ‘u8[1]’ {aka ‘unsigned char[1]’} [-Warray-bounds]
 1613 |      if (pIE->data[5] & RT_HT_CAP_USE_SOFTAP)
      |          ~~~~~~~~~^~~
drivers/staging/rtl8723bs/core/rtw_wlan_util.c:1617:20: warning: array subscript 6 is above array bounds of ‘u8[1]’ {aka ‘unsigned char[1]’} [-Warray-bounds]
 1617 |       if (pIE->data[6] & RT_HT_CAP_USE_JAGUAR_BCUT) {
      |           ~~~~~~~~~^~~

[1] https://en.wikipedia.org/wiki/Flexible_array_member
[2] https://www.kernel.org/doc/html/v5.9/process/deprecated.html#zero-length-and-one-element-arrays

Link: https://github.com/KSPP/linux/issues/79
Link: https://github.com/KSPP/linux/issues/109
Build-tested-by: kernel test robot <lkp@intel.com>
Link: https://lore.kernel.org/lkml/602434b8.jc5DoXJ0bmHoxgIL%25lkp@intel.com/
Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
---
 drivers/staging/rtl8723bs/include/wlan_bssdef.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/rtl8723bs/include/wlan_bssdef.h b/drivers/staging/rtl8723bs/include/wlan_bssdef.h
index ea370b2bb8db..27cd2c5d90af 100644
--- a/drivers/staging/rtl8723bs/include/wlan_bssdef.h
+++ b/drivers/staging/rtl8723bs/include/wlan_bssdef.h
@@ -68,7 +68,7 @@ struct ndis_802_11_fix_ie {
 struct ndis_80211_var_ie {
 	u8  ElementID;
 	u8  Length;
-	u8  data[1];
+	u8  data[];
 };
 
 /* Length is the 4 bytes multiples of the sum of
-- 
2.27.0

