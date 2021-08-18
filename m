Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9050C4338F
	for <linux-hardening@archiver.kernel.org>; Wed, 18 Aug 2021 17:30:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9F2B0610CF
	for <linux-hardening@archiver.kernel.org>; Wed, 18 Aug 2021 17:30:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232621AbhHRRa7 (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Wed, 18 Aug 2021 13:30:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232305AbhHRRa6 (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Wed, 18 Aug 2021 13:30:58 -0400
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32A16C0617AD
        for <linux-hardening@vger.kernel.org>; Wed, 18 Aug 2021 10:30:23 -0700 (PDT)
Received: by mail-pl1-x633.google.com with SMTP id u15so2196165plg.13
        for <linux-hardening@vger.kernel.org>; Wed, 18 Aug 2021 10:30:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=1inDd5eyHi8yoiQnHGaJ9BwGaPHbUgg4tuNy6+qumVE=;
        b=Iupuf+3RwxJuxosGCLocOYc9olA/aq8z69O9QvJQtRXEpXJzsOlDOO9YizqF8Yj77B
         BY3CCBdwQEka6SjMkXWPFDLd37W2iHTjqi7cyPJKX6bU8J4ITPwq8wEkJXL9RyJTEnUV
         lgazx1gSqDbbdOPkXLBeedIs793GoD31zIpks=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=1inDd5eyHi8yoiQnHGaJ9BwGaPHbUgg4tuNy6+qumVE=;
        b=hUGXSMbhIRAdjWAizDdIYmQnSF+Xz5qXP/OVdcRuoFudksmdZY0UR9AjKouwLRzm21
         7XM+MkzgMccpRjD/sLPdBpgy7mjKhVqDXVVd9PJG+p/lMRXP80ltUrPhvcDm1ElkZq+d
         EMqeDwkDuOvApgNFDqWZHH5laOPQXmeyWG7KfimoVfBznw5X7mI8t7QTTkvHk74MBKQf
         qs/HVSNVmO79MKMSseVKUaSQG3A7q8AQ47vsaMK1rUCPMY88BRxVnVwOQh8HLR1mUUVB
         C6YbGt3Ckrcva/kUxVyz3el1Z8LcHtHiJv07LT5vcyDrfiObAQ/RZWZ2NQi0P31hVQUC
         2DFw==
X-Gm-Message-State: AOAM533UD732Q0881wKAVZJnJWiQuMxCRbnbpkd+eUYFw3ylFLppCi4J
        vvtiFUbzwuHF1r5YS3hax1gjfw==
X-Google-Smtp-Source: ABdhPJwGPaDyJhdK+zlmUGWcsGQMBbSdiWoZh/q5ESuw7MStI3YSfjsbN5Cv8oApp0opXugYf3sIqQ==
X-Received: by 2002:a17:902:f703:b029:12c:982:c9ae with SMTP id h3-20020a170902f703b029012c0982c9aemr8133218plo.20.1629307822684;
        Wed, 18 Aug 2021 10:30:22 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id e3sm373456pfi.189.2021.08.18.10.30.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Aug 2021 10:30:21 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Kees Cook <keescook@chromium.org>, Al Cooper <alcooperx@gmail.com>,
        Alan Stern <stern@rowland.harvard.edu>,
        linux-usb@vger.kernel.org, bcm-kernel-feedback-list@broadcom.com,
        Arnd Bergmann <arnd@arndb.de>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: [PATCH v2 2/2] USB: EHCI: Add alias for Broadcom INSNREG
Date:   Wed, 18 Aug 2021 10:30:18 -0700
Message-Id: <20210818173018.2259231-3-keescook@chromium.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210818173018.2259231-1-keescook@chromium.org>
References: <20210818173018.2259231-1-keescook@chromium.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3828; h=from:subject; bh=Ic/ECPtNICWDOxz06TvbRrHGkr4vbwjyAR8NDlWPPUs=; b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBhHUOqTyJZnaFGoj8eBHztQbtUiXSksbEPjAoT1lrp fLQRLdSJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCYR1DqgAKCRCJcvTf3G3AJk1CD/ wKbCTATmR+BoO2z6YhIH2cQXWXAeGfsVQyLbuC5e/XzkdVVonxnvjb0XzKyCuhplUwHhDoHt3sTkc+ Kl7SuIhfQhfRTG2OmIJdBbmtVuo5Mr9r+k7vbBJbPtOIHKOtqqsUoCbse2LTL4MhLEGPuSRN/rZgqT 0XZ+pS0dBMWhSEIkmuXl+xBWDutYSqXNQayX1IkExheB2+Po57bx0ou9XG43kf4Csu1D2btPkdbSCw xBM8LNaNSjg4yCD4aSZAz3ipuxa7++uAn+n49ySQoFwQXUBwQ1Le4KkkclZG8u/nGiPdJQc8eD1yEk 3bbeD372WokyN02d1QXMm84Jw+NnEOHRQt6TD1uhXl+irAZ20MigrAKJwELvrwN0OGvBA1wE2JIol+ xWhr9BSHWZ0faDxV2G+jxuH3zIQk1BzvyFPNzu8V3/KoUG8qxdiLSJCdCLurRMbSnYFceXATgIegW0 zW3BnxHE4/p9KG8qlnCloTGdQksiHh2Ngua/LFbq69MeO+Cxbu4Bkr9lyfLGXzm/vnaG3oVMta/cBz QLxGgPeGB4kqdPMgRBIszPidzVAgTKBjs37irge2SVN1wcIvupn8sI5c8aYrfQjcp+1B8wgeNonw4y Ob5rTAoR/LQOCI5Hbo89EMjblJ+2K+BlxYSl74ASFJwkUkVwrFdqSI3TYaAA==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

Refactor struct ehci_regs to avoid accessing beyond the end of
port_status. This change results in no difference in the final
object code.

Avoids several warnings when building with -Warray-bounds:

drivers/usb/host/ehci-brcm.c: In function 'ehci_brcm_reset':
drivers/usb/host/ehci-brcm.c:113:32: warning: array subscript 16 is above array bounds of 'u32[15]' {aka 'unsigned int[15]'} [-Warray-bounds]
  113 |  ehci_writel(ehci, 0x00800040, &ehci->regs->port_status[0x10]);
      |                                ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
In file included from drivers/usb/host/ehci.h:274,
                 from drivers/usb/host/ehci-brcm.c:15:
./include/linux/usb/ehci_def.h:132:7: note: while referencing 'port_status'
  132 |   u32 port_status[HCS_N_PORTS_MAX];
      |       ^~~~~~~~~~~

Note that the documentation around this proprietary register was
confusing. If "USB_EHCI_INSNREG00" is at port_status[0x0f], its offset
would be 0x80 (not 0x90). The comments have been adjusted to fix this
apparent typo.

Cc: Al Cooper <alcooperx@gmail.com>
Cc: Alan Stern <stern@rowland.harvard.edu>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-usb@vger.kernel.org
Cc: bcm-kernel-feedback-list@broadcom.com
Suggested-by: Arnd Bergmann <arnd@arndb.de>
Fixes: 9df231511bd6 ("usb: ehci: Add new EHCI driver for Broadcom STB SoC's")
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 drivers/usb/host/ehci-brcm.c | 11 ++++-------
 include/linux/usb/ehci_def.h | 13 ++++++++++---
 2 files changed, 14 insertions(+), 10 deletions(-)

diff --git a/drivers/usb/host/ehci-brcm.c b/drivers/usb/host/ehci-brcm.c
index 3e0ebe8cc649..d3626bfa966b 100644
--- a/drivers/usb/host/ehci-brcm.c
+++ b/drivers/usb/host/ehci-brcm.c
@@ -108,10 +108,9 @@ static int ehci_brcm_reset(struct usb_hcd *hcd)
 	/*
 	 * SWLINUX-1705: Avoid OUT packet underflows during high memory
 	 *   bus usage
-	 * port_status[0x0f] = Broadcom-proprietary USB_EHCI_INSNREG00 @ 0x90
 	 */
-	ehci_writel(ehci, 0x00800040, &ehci->regs->port_status[0x10]);
-	ehci_writel(ehci, 0x00000001, &ehci->regs->port_status[0x12]);
+	ehci_writel(ehci, 0x00800040, &ehci->regs->brcm_insnreg[1]);
+	ehci_writel(ehci, 0x00000001, &ehci->regs->brcm_insnreg[3]);
 
 	return ehci_setup(hcd);
 }
@@ -223,11 +222,9 @@ static int __maybe_unused ehci_brcm_resume(struct device *dev)
 	/*
 	 * SWLINUX-1705: Avoid OUT packet underflows during high memory
 	 *   bus usage
-	 * port_status[0x0f] = Broadcom-proprietary USB_EHCI_INSNREG00
-	 * @ 0x90
 	 */
-	ehci_writel(ehci, 0x00800040, &ehci->regs->port_status[0x10]);
-	ehci_writel(ehci, 0x00000001, &ehci->regs->port_status[0x12]);
+	ehci_writel(ehci, 0x00800040, &ehci->regs->brcm_insnreg[1]);
+	ehci_writel(ehci, 0x00000001, &ehci->regs->brcm_insnreg[3]);
 
 	ehci_resume(hcd, false);
 
diff --git a/include/linux/usb/ehci_def.h b/include/linux/usb/ehci_def.h
index dcbe2b068569..c892c5bc6638 100644
--- a/include/linux/usb/ehci_def.h
+++ b/include/linux/usb/ehci_def.h
@@ -176,16 +176,23 @@ struct ehci_regs {
 #define USBMODE_CM_HC	(3<<0)		/* host controller mode */
 #define USBMODE_CM_IDLE	(0<<0)		/* idle state */
 	};
-	u32		reserved4;
 
 /* Moorestown has some non-standard registers, partially due to the fact that
  * its EHCI controller has both TT and LPM support. HOSTPCx are extensions to
  * PORTSCx
  */
-	/* HOSTPC: offset 0x84 */
-	u32		hostpc[HCS_N_PORTS_MAX];
+	union {
+		struct {
+			u32	reserved4;
+			/* HOSTPC: offset 0x84 */
+			u32	hostpc[HCS_N_PORTS_MAX];
 #define HOSTPC_PHCD	(1<<22)		/* Phy clock disable */
 #define HOSTPC_PSPD	(3<<25)		/* Port speed detection */
+		};
+
+		/* Broadcom-proprietary USB_EHCI_INSNREG00 @ 0x80 */
+		u32	brcm_insnreg[4];
+	};
 
 	u32		reserved5[2];
 
-- 
2.30.2

