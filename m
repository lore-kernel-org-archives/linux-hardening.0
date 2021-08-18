Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-21.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2A61C4338F
	for <linux-hardening@archiver.kernel.org>; Wed, 18 Aug 2021 22:11:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8CEE561103
	for <linux-hardening@archiver.kernel.org>; Wed, 18 Aug 2021 22:11:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234485AbhHRWLw (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Wed, 18 Aug 2021 18:11:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:47452 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234362AbhHRWLt (ORCPT <rfc822;linux-hardening@vger.kernel.org>);
        Wed, 18 Aug 2021 18:11:49 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id A61F2610D2;
        Wed, 18 Aug 2021 22:11:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1629324674;
        bh=5o0UqbvakauILVn4+9hHpTa5fsfopsPUcCG31EYkD2o=;
        h=Date:From:To:Cc:Subject:From;
        b=cmQsFyNWBn9CiXT/g6KTF8i37CvcvN3+XbdWjGJZTnV6I+n6p6ykj/gk0cbLT9Tu8
         EeRTiQXNsC8vgmCSQKfVoJSo6qXjURKMlBVk2k9F93FTnKQ1mc3hEWPopK0ZXG20sr
         bGZ6bUfJ2tbsvfCcZZqtAioJingRYXjFQQpuJDiDzBLuBkTj499lfTwrzRLK4oPY1+
         7zE+K/prm/FdAJ1v4mPyYvC4+mn0TVx+NtqoUrL5X/wrN0WqRJcpduU663tq5xquVR
         SkK2KZf4IG3zF/tnJIYOiNz7NWbpa/XwCm7RUAY0d5fFTe42c6iQB4g9zu882QXV/K
         YTVRJEDgrWmxA==
Date:   Wed, 18 Aug 2021 17:14:18 -0500
From:   "Gustavo A. R. Silva" <gustavoars@kernel.org>
To:     Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        linux-hardening@vger.kernel.org
Subject: [PATCH][next] staging: r8188eu: Fix fall-through warnings for Clang
Message-ID: <20210818221418.GA311735@embeddedor>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

Fix the following fallthrough warnings:

drivers/staging/r8188eu/core/rtw_mlme_ext.c:1498:3: warning: unannotated fall-through between switch labels [-Wimplicit-fallthrough]
drivers/staging/r8188eu/core/rtw_wlan_util.c:1113:4: warning: unannotated fall-through between switch labels [-Wimplicit-fallthrough]
drivers/staging/r8188eu/core/rtw_wlan_util.c:1147:4: warning: unannotated fall-through between switch labels [-Wimplicit-fallthrough]
drivers/staging/r8188eu/core/rtw_wlan_util.c:1405:3: warning: unannotated fall-through between switch labels [-Wimplicit-fallthrough]

This helps with the ongoing efforts to globally enable
-Wimplicit-fallthrough for Clang.

Link: https://github.com/KSPP/linux/issues/115 
Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
---
 drivers/staging/r8188eu/core/rtw_mlme_ext.c  | 1 +
 drivers/staging/r8188eu/core/rtw_wlan_util.c | 3 +++
 2 files changed, 4 insertions(+)

diff --git a/drivers/staging/r8188eu/core/rtw_mlme_ext.c b/drivers/staging/r8188eu/core/rtw_mlme_ext.c
index 61b239651e1a..590a4572c23f 100644
--- a/drivers/staging/r8188eu/core/rtw_mlme_ext.c
+++ b/drivers/staging/r8188eu/core/rtw_mlme_ext.c
@@ -1495,6 +1495,7 @@ unsigned int OnAssocRsp(struct adapter *padapter, struct recv_frame *precv_frame
 			break;
 		case _ERPINFO_IE_:
 			ERP_IE_handler(padapter, pIE);
+			break;
 		default:
 			break;
 		}
diff --git a/drivers/staging/r8188eu/core/rtw_wlan_util.c b/drivers/staging/r8188eu/core/rtw_wlan_util.c
index cddacf023fa6..e0ce2b796abe 100644
--- a/drivers/staging/r8188eu/core/rtw_wlan_util.c
+++ b/drivers/staging/r8188eu/core/rtw_wlan_util.c
@@ -1110,6 +1110,7 @@ unsigned int is_ap_in_tkip(struct adapter *padapter)
 			case _RSN_IE_2_:
 				if (!memcmp((pIE->data + 8), RSN_TKIP_CIPHER, 4))
 					return true;
+				break;
 			default:
 				break;
 			}
@@ -1144,6 +1145,7 @@ unsigned int should_forbid_n_rate(struct adapter *padapter)
 				if  ((!memcmp((pIE->data + 8), RSN_CIPHER_SUITE_CCMP, 4))  ||
 				     (!memcmp((pIE->data + 12), RSN_CIPHER_SUITE_CCMP, 4)))
 					return false;
+				break;
 			default:
 				break;
 			}
@@ -1401,6 +1403,7 @@ unsigned char check_assoc_AP(u8 *pframe, uint len)
 			} else {
 				break;
 			}
+			break;
 
 		default:
 			break;
-- 
2.27.0

