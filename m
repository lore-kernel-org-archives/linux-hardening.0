Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-22.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 708E4C63798
	for <linux-hardening@archiver.kernel.org>; Fri, 20 Nov 2020 18:28:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1E534246AA
	for <linux-hardening@archiver.kernel.org>; Fri, 20 Nov 2020 18:28:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="fP8LorIs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729553AbgKTS1c (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Fri, 20 Nov 2020 13:27:32 -0500
Received: from mail.kernel.org ([198.145.29.99]:48134 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729144AbgKTS1c (ORCPT <rfc822;linux-hardening@vger.kernel.org>);
        Fri, 20 Nov 2020 13:27:32 -0500
Received: from embeddedor (187-162-31-110.static.axtel.net [187.162.31.110])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E2C682415A;
        Fri, 20 Nov 2020 18:27:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1605896851;
        bh=fLmEoecdeaRM8oGYWWnG5fKqd37Y+u0nknDa9Jmb8Lw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=fP8LorIs/8eVqI3ODfsLIn5j59MeegzVg0DYIja9Z/zB9oBf5utSSBfZHR0G0BYHg
         xAPNfKCC3AIb1OQkLIeijObe1/KeuRACdBHZyqRYibDiDCLKtGtE5HiG9WQbBdkRqp
         GTfvK58daonZG1ru2fkAZ6biXxxBW8r+/F5n2keI=
Date:   Fri, 20 Nov 2020 12:27:37 -0600
From:   "Gustavo A. R. Silva" <gustavoars@kernel.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>
Subject: [PATCH 023/141] staging: rtl8723bs: core: Fix fall-through warnings
 for Clang
Message-ID: <cd07e3ebc11b44a3fe016341438e24cf950994a3.1605896059.git.gustavoars@kernel.org>
References: <cover.1605896059.git.gustavoars@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1605896059.git.gustavoars@kernel.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

In preparation to enable -Wimplicit-fallthrough for Clang, fix multiple
warnings by explicitly adding multiple break statements instead of just
letting the code fall through to the next case.

Link: https://github.com/KSPP/linux/issues/115
Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
---
 drivers/staging/rtl8723bs/core/rtw_cmd.c       | 1 +
 drivers/staging/rtl8723bs/core/rtw_mlme_ext.c  | 1 +
 drivers/staging/rtl8723bs/core/rtw_wlan_util.c | 1 +
 3 files changed, 3 insertions(+)

diff --git a/drivers/staging/rtl8723bs/core/rtw_cmd.c b/drivers/staging/rtl8723bs/core/rtw_cmd.c
index 2abe205e3453..232661e6a5c9 100644
--- a/drivers/staging/rtl8723bs/core/rtw_cmd.c
+++ b/drivers/staging/rtl8723bs/core/rtw_cmd.c
@@ -1487,6 +1487,7 @@ void lps_ctrl_wk_hdl(struct adapter *padapter, u8 lps_ctrl_type)
 		break;
 	case LPS_CTRL_TRAFFIC_BUSY:
 		LPS_Leave(padapter, "LPS_CTRL_TRAFFIC_BUSY");
+		break;
 	default:
 		break;
 	}
diff --git a/drivers/staging/rtl8723bs/core/rtw_mlme_ext.c b/drivers/staging/rtl8723bs/core/rtw_mlme_ext.c
index b912ad2f4b72..ea44d653a591 100644
--- a/drivers/staging/rtl8723bs/core/rtw_mlme_ext.c
+++ b/drivers/staging/rtl8723bs/core/rtw_mlme_ext.c
@@ -1708,6 +1708,7 @@ unsigned int OnAssocRsp(struct adapter *padapter, union recv_frame *precv_frame)
 
 		case _ERPINFO_IE_:
 			ERP_IE_handler(padapter, pIE);
+			break;
 
 		default:
 			break;
diff --git a/drivers/staging/rtl8723bs/core/rtw_wlan_util.c b/drivers/staging/rtl8723bs/core/rtw_wlan_util.c
index 372ce17c3569..2b13c683ba5c 100644
--- a/drivers/staging/rtl8723bs/core/rtw_wlan_util.c
+++ b/drivers/staging/rtl8723bs/core/rtw_wlan_util.c
@@ -1505,6 +1505,7 @@ unsigned int is_ap_in_tkip(struct adapter *padapter)
 			case _RSN_IE_2_:
 				if (!memcmp((pIE->data + 8), RSN_TKIP_CIPHER, 4))
 					return true;
+				break;
 
 			default:
 				break;
-- 
2.27.0

