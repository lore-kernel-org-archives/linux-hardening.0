Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-21.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8402BC4708D
	for <linux-hardening@archiver.kernel.org>; Fri, 28 May 2021 20:05:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 67338613D1
	for <linux-hardening@archiver.kernel.org>; Fri, 28 May 2021 20:05:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229585AbhE1UH0 (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Fri, 28 May 2021 16:07:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:38350 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229476AbhE1UHZ (ORCPT <rfc822;linux-hardening@vger.kernel.org>);
        Fri, 28 May 2021 16:07:25 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 281956108E;
        Fri, 28 May 2021 20:05:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1622232350;
        bh=rNXvajikrlV72340IFgnljvPJYbW/u6BaNNESC1jKf0=;
        h=Date:From:To:Cc:Subject:From;
        b=VtnyLHFzS0lwpm6U1rJ8sgkc5VKIHXO/znswk7NtAo+H20DeC8uhhSF/NqCjH0wJF
         HP+6Avq4ZtHr2wv8h2qoD042KHsbPpLyL1+ZpVH0j4Yo/b2EC2hTZUHl9ItVI2YgRx
         XTd0at2dLV41sO7y4kKvzRNVeBUmKLpvtU49x3O8+iH1efKGVEno0u0PCSPxiaVmV3
         UnRXyarSpdWbLxMNpiPZiTcU6xfprPXi6ZD27pSRrtKbLmnz8jAfLwnrxIRY9lbp1q
         CN9UdyrXRP6H5V2V+PvROhaZgIXbFYz5jaeEUOKv8N74xwClak4LrWRaE8IjRiqZY1
         yU4Wfxh/wPQog==
Date:   Fri, 28 May 2021 15:06:50 -0500
From:   "Gustavo A. R. Silva" <gustavoars@kernel.org>
To:     Larry Finger <Larry.Finger@lwfinger.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        linux-hardening@vger.kernel.org
Subject: [PATCH][next] staging: rtl8188eu: Fix fall-through warnings for Clang
Message-ID: <20210528200650.GA39289@embeddedor>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

In preparation to enable -Wimplicit-fallthrough for Clang, fix multiple
warnings by explicitly adding multiple break statements instead
of just letting the code fall through to the next case.

Link: https://github.com/KSPP/linux/issues/115
Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
---
JFYI: We had thousands of these sorts of warnings and now we are down
      to just 25 in linux-next. These are some of those last remaining
      warnings.

 drivers/staging/rtl8188eu/core/rtw_mlme_ext.c  | 1 +
 drivers/staging/rtl8188eu/core/rtw_wlan_util.c | 2 ++
 2 files changed, 3 insertions(+)

diff --git a/drivers/staging/rtl8188eu/core/rtw_mlme_ext.c b/drivers/staging/rtl8188eu/core/rtw_mlme_ext.c
index b4d81d3a856c..6803e9327eb2 100644
--- a/drivers/staging/rtl8188eu/core/rtw_mlme_ext.c
+++ b/drivers/staging/rtl8188eu/core/rtw_mlme_ext.c
@@ -3378,6 +3378,7 @@ static unsigned int OnAssocRsp(struct adapter *padapter,
 			break;
 		case WLAN_EID_ERP_INFO:
 			ERP_IE_handler(padapter, pIE);
+			break;
 		default:
 			break;
 		}
diff --git a/drivers/staging/rtl8188eu/core/rtw_wlan_util.c b/drivers/staging/rtl8188eu/core/rtw_wlan_util.c
index 3e244e949995..c9043f49ec9e 100644
--- a/drivers/staging/rtl8188eu/core/rtw_wlan_util.c
+++ b/drivers/staging/rtl8188eu/core/rtw_wlan_util.c
@@ -1029,6 +1029,7 @@ unsigned int is_ap_in_tkip(struct adapter *padapter)
 			case WLAN_EID_RSN:
 				if (!memcmp((pIE->data + 8), RSN_TKIP_CIPHER, 4))
 					return true;
+				break;
 			default:
 				break;
 			}
@@ -1226,6 +1227,7 @@ unsigned char check_assoc_AP(u8 *pframe, uint len)
 			} else {
 				break;
 			}
+			break;
 
 		default:
 			break;
-- 
2.27.0

