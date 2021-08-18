Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A092C4338F
	for <linux-hardening@archiver.kernel.org>; Wed, 18 Aug 2021 04:30:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 71A4461053
	for <linux-hardening@archiver.kernel.org>; Wed, 18 Aug 2021 04:30:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237281AbhHREbN (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Wed, 18 Aug 2021 00:31:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229768AbhHREbN (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Wed, 18 Aug 2021 00:31:13 -0400
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com [IPv6:2607:f8b0:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11A6AC061764
        for <linux-hardening@vger.kernel.org>; Tue, 17 Aug 2021 21:30:39 -0700 (PDT)
Received: by mail-pg1-x529.google.com with SMTP id w8so935760pgf.5
        for <linux-hardening@vger.kernel.org>; Tue, 17 Aug 2021 21:30:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=V2X/mxX2JsXaFx3uHx7XfXuFDu4h8hiqjhXj9NlMMhk=;
        b=ibL5UnsQt1SYxsp2yAMnW/YdrE++qVDdbpFlPIR6K3BB3E/EL9QLtKLHVpv/sb+A2I
         QqVNtNDjg0FxDzj3EGuspL3soU04SueY6DrCrix/Qoqq8dTCQLyXVmYf6RNjWzO42bit
         gKD2wuDNIoCJ39WY5UdovaLbVACpnXVsYjpOI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=V2X/mxX2JsXaFx3uHx7XfXuFDu4h8hiqjhXj9NlMMhk=;
        b=CGw85I9q1oiJKRVTeDIpIA6O1hbdCRMJRa9MYzZFlwD4oY1+nnpZ/AhqfKtTp3gasc
         RoJLtAlMAAMb1ROJkpaJssLcsef6NWUYSzE8Hxl2lKE11OMoWbPp77jhww9jg3+ovmJk
         RYjxJoFMonYqKNYCnND0JfR50pd3oW8jrt4ewVncSD7k7PabNlkUVYSQwmvhDvkqvyNw
         EZsIjib0QKls+c4eeIGJoutk27S6CkI2mMBc3MXyyHtE29yaARL1T4UTCr3TUvvvrUcz
         +fgi6fHk2cnME6VbrYYpno0kzB49uVz3KM2gI+gyid/uPHdZM8UCmUeH9m3YLVan4TcT
         2r7w==
X-Gm-Message-State: AOAM530f6apTn1Thf3p5GZNCMzs6n2PnK/5w8F5SmhmQKSonLka+d8FC
        f0XHyZaVFc+3zYYno3/fQsZpOA==
X-Google-Smtp-Source: ABdhPJw1ksquoom3IZ39xMEuJgVWQ1Q6NY25QexNmmpWeR1q+Q+a1R2JE3N7ucasubJfjonP0rUhJw==
X-Received: by 2002:a65:6454:: with SMTP id s20mr6888248pgv.18.1629261038655;
        Tue, 17 Aug 2021 21:30:38 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id d15sm4164692pfd.115.2021.08.17.21.30.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Aug 2021 21:30:38 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Kees Cook <keescook@chromium.org>, Al Cooper <alcooperx@gmail.com>,
        Alan Stern <stern@rowland.harvard.edu>,
        linux-usb@vger.kernel.org, bcm-kernel-feedback-list@broadcom.com,
        Arnd Bergmann <arnd@arndb.de>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: [PATCH 2/2] USB: EHCI: Add alias for Broadcom INSNREG
Date:   Tue, 17 Aug 2021 21:30:34 -0700
Message-Id: <20210818043035.1308062-3-keescook@chromium.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210818043035.1308062-1-keescook@chromium.org>
References: <20210818043035.1308062-1-keescook@chromium.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=4103; h=from:subject; bh=dbE9XtQqA1foyjO9XHfNdBcom5iwk3VUrY6aFfs8pzE=; b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBhHIzqWW4Dnh2cHuYYKw2gyNoMoIme6IWK0iCv0MPN OeoYX/qJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCYRyM6gAKCRCJcvTf3G3AJrzhD/ wNbeAOjAr4lW8fDMrecWwpHX2eXvTr+XMm96DimUg6tIH97iX+zEiP/9LjKFgvWIhwHvSugqbqLoHa eUmVDy+RkwFaLrCMkHxelC1gbzIvhbXP7he27rf8K9ui3oZPgesGPUMlJ8UnD7BiZ0DADVCLb8fJU9 jCvr35gJxbNf181nJ/gfvBF/u7C7ttBEUwRmaRqwa9kkfLjtYUchTJnbG7Su+UEZGfBBBWUPu98t5I n2oswPAhqcZaz+x/+iCXv47PJLxV2dcnGjgo3s5tdvFnd3YXUcK/5HKvCJDHXF/3E601O2H4Rq6Ra4 7ey2FrXPEzrIlWqn+NoxdDzd2dy2+kgiQmMzmyvVA4VWcjctVybZ7TXnpIHztvAz8sqxG2OQkXdrpJ s23ivnmbQwqHZfH1B8KnDVmxbyA5nGGTSZeHENa9SeEMYUwTufITBXjLsczZN7cvQMNH5EbE8zzFgx 12JdzIB8Du2HLuMKXNGmdTQI/yRCqOYwrdIfmG1U20A4X300ZqJ59DBzopOAwdVGwska3cInzLVvSA 5eNRr0ne5IpWzUISrAp/BiD/vZ/Rszu2ihREt62Kqx2PsCS/wSQy7XR9v7AkgF1uDbKEVAVxsn9ZD1 yHngqYzMN0HRFHb+yHnU5mVeMfHrIlOZ+T6Zrd2lAnucoWpkmIMH6sttrNcw==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

Refactor struct ehci_regs to avoid accessing beyond the end of
port_status. This change results in no difference in the resulting
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

Note that the documentation around this proprietary register is
confusing. If "USB_EHCI_INSNREG00" is at port_status[0x0f], its offset
would be 0x80 (not 0x90). The code uses port_status[0x10], so is that
not using "USB_EHCI_INSNREG00"?

Perhaps port_status[0x10] is USB_EHCI_INSNREG01 and port_status[0x12]
is USB_EHCI_INSNREG03? If so, the union could be adjusted to better
represent the layout.

Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Al Cooper <alcooperx@gmail.com>
Cc: Alan Stern <stern@rowland.harvard.edu>
Cc: linux-usb@vger.kernel.org
Cc: bcm-kernel-feedback-list@broadcom.com
Suggested-by: Arnd Bergmann <arnd@arndb.de>
Fixes: 9df231511bd6 ("usb: ehci: Add new EHCI driver for Broadcom STB SoC's")
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 drivers/usb/host/ehci-brcm.c | 11 +++++------
 include/linux/usb/ehci_def.h | 16 ++++++++++++++--
 2 files changed, 19 insertions(+), 8 deletions(-)

diff --git a/drivers/usb/host/ehci-brcm.c b/drivers/usb/host/ehci-brcm.c
index 3e0ebe8cc649..5d232d3701f9 100644
--- a/drivers/usb/host/ehci-brcm.c
+++ b/drivers/usb/host/ehci-brcm.c
@@ -110,8 +110,8 @@ static int ehci_brcm_reset(struct usb_hcd *hcd)
 	 *   bus usage
 	 * port_status[0x0f] = Broadcom-proprietary USB_EHCI_INSNREG00 @ 0x90
 	 */
-	ehci_writel(ehci, 0x00800040, &ehci->regs->port_status[0x10]);
-	ehci_writel(ehci, 0x00000001, &ehci->regs->port_status[0x12]);
+	ehci_writel(ehci, 0x00800040, &ehci->regs->brcm_insnreg[0]);
+	ehci_writel(ehci, 0x00000001, &ehci->regs->brcm_insnreg[2]);
 
 	return ehci_setup(hcd);
 }
@@ -223,11 +223,10 @@ static int __maybe_unused ehci_brcm_resume(struct device *dev)
 	/*
 	 * SWLINUX-1705: Avoid OUT packet underflows during high memory
 	 *   bus usage
-	 * port_status[0x0f] = Broadcom-proprietary USB_EHCI_INSNREG00
-	 * @ 0x90
+	 * port_status[0x0f] = Broadcom-proprietary USB_EHCI_INSNREG00 @ 0x90
 	 */
-	ehci_writel(ehci, 0x00800040, &ehci->regs->port_status[0x10]);
-	ehci_writel(ehci, 0x00000001, &ehci->regs->port_status[0x12]);
+	ehci_writel(ehci, 0x00800040, &ehci->regs->brcm_insnreg[0]);
+	ehci_writel(ehci, 0x00000001, &ehci->regs->brcm_insnreg[2]);
 
 	ehci_resume(hcd, false);
 
diff --git a/include/linux/usb/ehci_def.h b/include/linux/usb/ehci_def.h
index 5398f571113b..86f0909cab99 100644
--- a/include/linux/usb/ehci_def.h
+++ b/include/linux/usb/ehci_def.h
@@ -182,11 +182,23 @@ struct ehci_regs {
  * its EHCI controller has both TT and LPM support. HOSTPCx are extensions to
  * PORTSCx
  */
-	/* HOSTPC: offset 0x84 */
-	u32		hostpc[HCS_N_PORTS_MAX];
+	union {
+		/* HOSTPC: offset 0x84 */
+		u32	hostpc[HCS_N_PORTS_MAX];
 #define HOSTPC_PHCD	(1<<22)		/* Phy clock disable */
 #define HOSTPC_PSPD	(3<<25)		/* Port speed detection */
 
+		/*
+		 * This was originally documented as:
+		 * "port_status[0x0f] = Broadcom-proprietary USB_EHCI_INSNREG00 @ 0x90"
+		 * but this doesn't make sense: the code was using
+		 * port_status[0x10]. port_status[0x0f] would be reserved4.
+		 * Also, none of these are near 0x90. port_status[0x10] is
+		 * offset 0x84, and port_status[0x0f] would be 0x80.
+		 */
+		u32	brcm_insnreg[3];
+	};
+
 	u32		reserved5[2];
 
 	/* USBMODE_EX: offset 0xc8 */
-- 
2.30.2

