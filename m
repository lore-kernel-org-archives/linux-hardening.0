Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90DC1C4320E
	for <linux-hardening@archiver.kernel.org>; Wed, 18 Aug 2021 04:30:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7EA1660524
	for <linux-hardening@archiver.kernel.org>; Wed, 18 Aug 2021 04:30:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237071AbhHREbP (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Wed, 18 Aug 2021 00:31:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236664AbhHREbN (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Wed, 18 Aug 2021 00:31:13 -0400
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A90FBC06179A
        for <linux-hardening@vger.kernel.org>; Tue, 17 Aug 2021 21:30:39 -0700 (PDT)
Received: by mail-pf1-x42f.google.com with SMTP id x16so872960pfh.2
        for <linux-hardening@vger.kernel.org>; Tue, 17 Aug 2021 21:30:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=97Q2qblnPf+diifOtJqZrKrymA63HJNNPgH0AIN9kWw=;
        b=EJmRir8kX/xdWreBuW48PasqoLhhUpCqQaxJ9X+gi8GMI6jTy20Jjjp9aBQMkDVL9A
         hhVV8L1DUal19StjfVjaqERnGxePdPStYSNe8BSNbYxMQnD6PzNdtLyrDXEQZGnd8cDV
         BKViY4SEFU0sx4bciJF31uLF9E+mzWSXHXj6g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=97Q2qblnPf+diifOtJqZrKrymA63HJNNPgH0AIN9kWw=;
        b=blawp/s6bBBSHZF5I8bVTBXkqlg0ycJ23PC1e/XeUPZI6IuKwftFMT0CX7ekp3Fwhb
         hCJPxoi3cmZ1s3ooRd32wXhotUcK1j+r1K5wmwCqf7nHdZ8Yd4Ii68QQ/zRwCCiWmaqU
         izjeWM/B+amnUioCodq1nnTRS2LYBQ+PgOBlQIz0vwKVz0HRZa7DEwZnM8fehiFG9VLg
         9A5562s14fmGEZHrkm8H/OgFxEJV7uSGF0qrzSB6o0089XiYTb+0ZpBxBHg5F13xE6h5
         6dq9rpOQXK1x3cn8JlpoidbBhdReqHRpFKTGBubctSr7PVvH/lfNAMRYDkrvSvbfAnUx
         VDhw==
X-Gm-Message-State: AOAM531uqwWZSyuWUdBxtPXbiknvbsMz6WJ6WAsArXwS4DrQJZ5KmyCX
        OhAGxP3aF/At1bKn3tnuR+sfWg==
X-Google-Smtp-Source: ABdhPJz8UBWhQMexRqkMGyz82mBnyqjyomkDr/D1Lw7KhqFqVybpc2YOjEQVJ0KbZBxHHkfoqKI1VA==
X-Received: by 2002:a65:6111:: with SMTP id z17mr6950148pgu.335.1629261039205;
        Tue, 17 Aug 2021 21:30:39 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id mg11sm3521501pjb.28.2021.08.17.21.30.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Aug 2021 21:30:38 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Kees Cook <keescook@chromium.org>, Arnd Bergmann <arnd@arndb.de>,
        Al Cooper <alcooperx@gmail.com>,
        Alan Stern <stern@rowland.harvard.edu>,
        linux-usb@vger.kernel.org, Florian Fainelli <f.fainelli@gmail.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        linux-kernel@vger.kernel.org,
        bcm-kernel-feedback-list@broadcom.com,
        linux-hardening@vger.kernel.org
Subject: [PATCH 1/2] USB: EHCI: Add register array bounds to HCS ports
Date:   Tue, 17 Aug 2021 21:30:33 -0700
Message-Id: <20210818043035.1308062-2-keescook@chromium.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210818043035.1308062-1-keescook@chromium.org>
References: <20210818043035.1308062-1-keescook@chromium.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=7281; h=from:subject; bh=0RbT8T92X/JDlh0LDF75MOJUruyjSULSZmO5BN9GRWI=; b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBhHIzqjGvGYOda4gj0Hehm39EaWDMnKJOYgbdbr1FW sk8lDOuJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCYRyM6gAKCRCJcvTf3G3AJvRfD/ 9cEjCeEIunrMbMlQEO4nrF2VxsJgf2f7i55anT3F4lPvvpkDiKk00ooKxVOg3W7R8+UBwo2kO3CWZS T4RQVZH8YFYwGM7qbZa7hVyZ0ADS8tjKcDVQUJCnc66XHI0S2xpkkAi/tpvwGxRCSQ57vnjqNKMGYZ MbFaz+q0toul9KUqINxQxC5pImrJkxFXLken+oyZYb0J329aVk39BFGoHkVefSsS9tLUKY6wCsxF+9 PvmJZBm/K4ks+Vebs/mRLvMsNjmn8EqPI6I/63qyVhDfyo00tWc+ald28T+6ezD2aBtbyM0+DAtiVW r0T6LOYdTZDZR8YVaX2kWXfUDAp50VBbrJmYq6CCLX2sMCu3rv1eJvZiOlAEttJcYrpaxtWR5DWr3A Qn0weeFnGOmbkeeBY5emaHD3zy+zYtx+LztOxQXSNl0n9ivST6bBaiuDcH3BAUWDA7TMNcKLqE2gnA ctk9S9VqvlaAt37pEMSERJaQviOUFXFZ1FiqiAQkSeb6vt1FUmybvaqsrPIjHHNEl1KGvV8yNB4OLf 44LGhTeVDTK1TCUXlsRhk9eTbpPQO7WOVNVUcDSZuI0e4PE/qWC4EqV6/g1cjNOBpOBBAOcQlNJz0E D7rEtcqAe9h7n5cyDFJgoxi9hJlVkrhgnALlCxUF4V3pLqjlD2yJszWzYrZA==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

The original EHCI register struct used a trailing 0-element array for
addressing the N_PORTS-many available registers. However, after
commit a46af4ebf9ff ("USB: EHCI: define extension registers like normal ones")
the 0-element array started to overlap the USBMODE extension register.

To avoid future compile-time warnings about accessing indexes within a
0-element array, rearrange the struct to actually describe the expected
layout (max 15 registers) with a union. All offsets remain the same, and
bounds checking becomes possible on accesses to port_status and hostpc.

There are no binary differences, and struct offsets continue to match.
"pahole --hex -C ehci_regs" before:

struct ehci_regs {
	u32                        command;              /*     0   0x4 */
	u32                        status;               /*   0x4   0x4 */
	u32                        intr_enable;          /*   0x8   0x4 */
	u32                        frame_index;          /*   0xc   0x4 */
	u32                        segment;              /*  0x10   0x4 */
	u32                        frame_list;           /*  0x14   0x4 */
	u32                        async_next;           /*  0x18   0x4 */
	u32                        reserved1[2];         /*  0x1c   0x8 */
	u32                        txfill_tuning;        /*  0x24   0x4 */
	u32                        reserved2[6];         /*  0x28  0x18 */
	/* --- cacheline 1 boundary (64 bytes) --- */
	u32                        configured_flag;      /*  0x40   0x4 */
	u32                        port_status[0];       /*  0x44     0 */
	u32                        reserved3[9];         /*  0x44  0x24 */
	u32                        usbmode;              /*  0x68   0x4 */
	u32                        reserved4[6];         /*  0x6c  0x18 */
	/* --- cacheline 2 boundary (128 bytes) was 4 bytes ago --- */
	u32                        hostpc[0];            /*  0x84     0 */
	u32                        reserved5[17];        /*  0x84  0x44 */
	/* --- cacheline 3 boundary (192 bytes) was 8 bytes ago --- */
	u32                        usbmode_ex;           /*  0xc8   0x4 */

	/* size: 204, cachelines: 4, members: 18 */
	/* last cacheline: 12 bytes */
};

after:

struct ehci_regs {
	u32                        command;              /*     0   0x4 */
	u32                        status;               /*   0x4   0x4 */
	u32                        intr_enable;          /*   0x8   0x4 */
	u32                        frame_index;          /*   0xc   0x4 */
	u32                        segment;              /*  0x10   0x4 */
	u32                        frame_list;           /*  0x14   0x4 */
	u32                        async_next;           /*  0x18   0x4 */
	u32                        reserved1[2];         /*  0x1c   0x8 */
	u32                        txfill_tuning;        /*  0x24   0x4 */
	u32                        reserved2[6];         /*  0x28  0x18 */
	/* --- cacheline 1 boundary (64 bytes) --- */
	u32                        configured_flag;      /*  0x40   0x4 */
	union {
		u32                port_status[15];      /*  0x44  0x3c */
		struct {
			u32        reserved3[9];         /*  0x44  0x24 */
			u32        usbmode;              /*  0x68   0x4 */
		};                                       /*  0x44  0x28 */
	};                                               /*  0x44  0x3c */
	/* --- cacheline 2 boundary (128 bytes) --- */
	u32                        reserved4;            /*  0x80   0x4 */
	u32                        hostpc[15];           /*  0x84  0x3c */
	/* --- cacheline 3 boundary (192 bytes) --- */
	u32                        reserved5[2];         /*  0xc0   0x8 */
	u32                        usbmode_ex;           /*  0xc8   0x4 */

	/* size: 204, cachelines: 4, members: 16 */
	/* last cacheline: 12 bytes */
};

With this fixed, adding -Wzero-length-bounds to the build no longer
produces several warnings like this:

In file included from drivers/usb/host/ehci-hcd.c:306:
drivers/usb/host/ehci-hub.c: In function 'ehci_port_handed_over':
drivers/usb/host/ehci-hub.c:1194:8: warning: array subscript '<unknown>' is outside the bounds of an interior zero-length array 'u32[0]' {aka 'unsigned int[]'} [-Wzero-length-bounds]
 1194 |  reg = &ehci->regs->port_status[portnum - 1];
      |        ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
In file included from drivers/usb/host/ehci.h:274,
                 from drivers/usb/host/ehci-hcd.c:97:
./include/linux/usb/ehci_def.h:130:7: note: while referencing 'port_status'
  130 |  u32  port_status[0]; /* up to N_PORTS */
      |       ^~~~~~~~~~~

Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Al Cooper <alcooperx@gmail.com>
Cc: Alan Stern <stern@rowland.harvard.edu>
Cc: linux-usb@vger.kernel.org
Fixes: a46af4ebf9ff ("USB: EHCI: define extension registers like normal ones")
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 include/linux/usb/ehci_def.h | 24 +++++++++++++-----------
 1 file changed, 13 insertions(+), 11 deletions(-)

diff --git a/include/linux/usb/ehci_def.h b/include/linux/usb/ehci_def.h
index 78e006355557..5398f571113b 100644
--- a/include/linux/usb/ehci_def.h
+++ b/include/linux/usb/ehci_def.h
@@ -45,6 +45,7 @@ struct ehci_caps {
 #define HCS_PORTROUTED(p)	((p)&(1 << 7))	/* true: port routing */
 #define HCS_PPC(p)		((p)&(1 << 4))	/* true: port power control */
 #define HCS_N_PORTS(p)		(((p)>>0)&0xf)	/* bits 3:0, ports on HC */
+#define HCS_N_PORTS_MAX		0xf		/* N_PORTS valid 0x1-0xF */
 
 	u32		hcc_params;      /* HCCPARAMS - offset 0x8 */
 /* EHCI 1.1 addendum */
@@ -126,8 +127,9 @@ struct ehci_regs {
 	u32		configured_flag;
 #define FLAG_CF		(1<<0)		/* true: we'll support "high speed" */
 
-	/* PORTSC: offset 0x44 */
-	u32		port_status[0];	/* up to N_PORTS */
+	union {
+		/* PORTSC: offset 0x44 */
+		u32	port_status[HCS_N_PORTS_MAX];
 /* EHCI 1.1 addendum */
 #define PORTSC_SUSPEND_STS_ACK 0
 #define PORTSC_SUSPEND_STS_NYET 1
@@ -164,28 +166,28 @@ struct ehci_regs {
 #define PORT_CSC	(1<<1)		/* connect status change */
 #define PORT_CONNECT	(1<<0)		/* device connected */
 #define PORT_RWC_BITS   (PORT_CSC | PORT_PEC | PORT_OCC)
-
-	u32		reserved3[9];
-
-	/* USBMODE: offset 0x68 */
-	u32		usbmode;	/* USB Device mode */
+		struct {
+			u32	reserved3[9];
+			/* USBMODE: offset 0x68 */
+			u32	usbmode;	/* USB Device mode */
+		};
 #define USBMODE_SDIS	(1<<3)		/* Stream disable */
 #define USBMODE_BE	(1<<2)		/* BE/LE endianness select */
 #define USBMODE_CM_HC	(3<<0)		/* host controller mode */
 #define USBMODE_CM_IDLE	(0<<0)		/* idle state */
-
-	u32		reserved4[6];
+	};
+	u32		reserved4;
 
 /* Moorestown has some non-standard registers, partially due to the fact that
  * its EHCI controller has both TT and LPM support. HOSTPCx are extensions to
  * PORTSCx
  */
 	/* HOSTPC: offset 0x84 */
-	u32		hostpc[0];	/* HOSTPC extension */
+	u32		hostpc[HCS_N_PORTS_MAX];
 #define HOSTPC_PHCD	(1<<22)		/* Phy clock disable */
 #define HOSTPC_PSPD	(3<<25)		/* Port speed detection */
 
-	u32		reserved5[17];
+	u32		reserved5[2];
 
 	/* USBMODE_EX: offset 0xc8 */
 	u32		usbmode_ex;	/* USB Device mode extension */
-- 
2.30.2

