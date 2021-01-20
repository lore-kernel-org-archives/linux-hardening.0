Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61081C433E6
	for <linux-hardening@archiver.kernel.org>; Wed, 20 Jan 2021 19:21:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1DE97233FE
	for <linux-hardening@archiver.kernel.org>; Wed, 20 Jan 2021 19:21:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390895AbhATSqf (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Wed, 20 Jan 2021 13:46:35 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:42721 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1733269AbhATRjh (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Wed, 20 Jan 2021 12:39:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1611164288;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=veDG5mWnaW2Ixi8XXsaq9WVUVN6IJdn0R3qA8goBbxk=;
        b=fvNuLuSrbYE2BRtAek0KXB1lCp44lmbH9Ue/7fv84kZHWIeq3Rp1uLdBDvgKhLoVdcJ6NG
        SeYAlPITwPxL2k45kvBp+xR2+LBloCc9fEwiwhQk7/GSP9ZZj73LCnXVF9yTKDvdZvzuw3
        y+id3f6Vujn4DPq3P61dDZzaw6h7vEI=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-227--R4jyomdMV6gNdXmKVxbtQ-1; Wed, 20 Jan 2021 12:38:06 -0500
X-MC-Unique: -R4jyomdMV6gNdXmKVxbtQ-1
Received: by mail-wr1-f70.google.com with SMTP id z8so11985132wrh.5
        for <linux-hardening@vger.kernel.org>; Wed, 20 Jan 2021 09:38:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=veDG5mWnaW2Ixi8XXsaq9WVUVN6IJdn0R3qA8goBbxk=;
        b=puiydkYlVlyRESV+ZeQBR9B5Eiu6mhrDnULt/PCdVrji5SxWQxd0BnuFleHmPSQF7p
         w/ru3U97IMftgN+JWAo8bAD0P2drGr2R1i0X2weoghXX4w4L7/WogVUQBOLI6Jl/suO9
         2/PFOonUoI2HAMtq7NwtttZa9O/r1rZzY0RKU8lceYybYv9l6FkLQJ22M2tKwbXyg2zP
         VfTHI5eCdUjb9opOhbukKlCWWYAQw/k5fFindQnG0a8eAQIxRGNLAi/M5B7xskbc+SpV
         i4U+35NAluDYJOv9FXtxACdvVatKDx+7G5U+gd0sbNf2o40TIiz/WdgGSvySregfJFf7
         CNTQ==
X-Gm-Message-State: AOAM533gBp3gJgeYAEeZ8ISmbFR6hF+LRekEY4PcKmaAR9zzyS0FuLtu
        Vhmo8f5k7i9+ru/tUaVnmujV0udJJoRSo893v60hxg2t8tGXypzpEI/x3QPEsQPjQekqeUTUv0b
        lx3i7/n8x6bG6lnvw0idwJq6tGg1m
X-Received: by 2002:adf:e8c5:: with SMTP id k5mr10771816wrn.242.1611164285589;
        Wed, 20 Jan 2021 09:38:05 -0800 (PST)
X-Google-Smtp-Source: ABdhPJylft7yf7rgmFXUNRqNfNmGJKkqmx1XjdDH0fdpJqZZDyViFfZloLRO9kL6mc2iiU5PzrlGuw==
X-Received: by 2002:adf:e8c5:: with SMTP id k5mr10771802wrn.242.1611164285463;
        Wed, 20 Jan 2021 09:38:05 -0800 (PST)
Received: from redfedo.redhat.com ([2a01:cb14:499:3d00:cd47:f651:9d80:157a])
        by smtp.gmail.com with ESMTPSA id x11sm4948325wmi.4.2021.01.20.09.38.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Jan 2021 09:38:05 -0800 (PST)
From:   Julien Thierry <jthierry@redhat.com>
To:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     catalin.marinas@arm.com, will@kernel.org, ardb@kernel.org,
        masahiroy@kernel.org, keescook@chromium.org,
        michal.lkml@markovi.net, jpoimboe@redhat.com, peterz@infradead.org,
        mark.rutland@arm.com, broonie@kernel.org,
        linux-efi@vger.kernel.org, linux-hardening@vger.kernel.org,
        Julien Thierry <jthierry@redhat.com>
Subject: [RFC PATCH 01/17] tools: Add some generic functions and headers
Date:   Wed, 20 Jan 2021 18:37:44 +0100
Message-Id: <20210120173800.1660730-2-jthierry@redhat.com>
X-Mailer: git-send-email 2.25.4
In-Reply-To: <20210120173800.1660730-1-jthierry@redhat.com>
References: <20210120173800.1660730-1-jthierry@redhat.com>
MIME-Version: 1.0
Authentication-Results: relay.mimecast.com;
        auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jthierry@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

These will be needed to be able to use arm64 instruction decoder in
userland tools.

Signed-off-by: Julien Thierry <jthierry@redhat.com>
---
 tools/include/asm-generic/bitops/__ffs.h | 11 +++++++
 tools/include/linux/kernel.h             | 21 +++++++++++++
 tools/include/linux/printk.h             | 40 ++++++++++++++++++++++++
 3 files changed, 72 insertions(+)
 create mode 100644 tools/include/linux/printk.h

diff --git a/tools/include/asm-generic/bitops/__ffs.h b/tools/include/asm-generic/bitops/__ffs.h
index 9d1310519497..963f8a22212f 100644
--- a/tools/include/asm-generic/bitops/__ffs.h
+++ b/tools/include/asm-generic/bitops/__ffs.h
@@ -42,4 +42,15 @@ static __always_inline unsigned long __ffs(unsigned long word)
 	return num;
 }
 
+static inline unsigned long __ffs64(u64 word)
+{
+#if BITS_PER_LONG == 32
+	if (((u32)word) == 0UL)
+		return __ffs((u32)(word >> 32)) + 32;
+#elif BITS_PER_LONG != 64
+#error BITS_PER_LONG not 32 or 64
+#endif
+	return __ffs((unsigned long)word);
+}
+
 #endif /* _TOOLS_LINUX_ASM_GENERIC_BITOPS___FFS_H_ */
diff --git a/tools/include/linux/kernel.h b/tools/include/linux/kernel.h
index a7e54a08fb54..e748982ed5c1 100644
--- a/tools/include/linux/kernel.h
+++ b/tools/include/linux/kernel.h
@@ -114,6 +114,27 @@ int scnprintf_pad(char * buf, size_t size, const char * fmt, ...);
 #define round_up(x, y) ((((x)-1) | __round_mask(x, y))+1)
 #define round_down(x, y) ((x) & ~__round_mask(x, y))
 
+/**
+ * upper_32_bits - return bits 32-63 of a number
+ * @n: the number we're accessing
+ *
+ * A basic shift-right of a 64- or 32-bit quantity.  Use this to suppress
+ * the "right shift count >= width of type" warning when that quantity is
+ * 32-bits.
+ */
+#define upper_32_bits(n) ((u32)(((n) >> 16) >> 16))
+
+/**
+ * lower_32_bits - return bits 0-31 of a number
+ * @n: the number we're accessing
+ */
+#define lower_32_bits(n) ((u32)(n))
+
+/* Inspired from ALIGN_*_KERNEL */
+#define __ALIGN_MASK(x, mask)	(((x) + (mask)) & ~(mask))
+#define __ALIGN(x, a)		__ALIGN_MASK(x, (typeof(x))(a) - 1)
+#define ALIGN_DOWN(x, a)	__ALIGN((x) - ((a) - 1), (a))
+
 #define current_gfp_context(k) 0
 #define synchronize_rcu()
 
diff --git a/tools/include/linux/printk.h b/tools/include/linux/printk.h
new file mode 100644
index 000000000000..515ebdc47e6e
--- /dev/null
+++ b/tools/include/linux/printk.h
@@ -0,0 +1,40 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _TOOLS_LINUX_KERNEL_PRINTK_H_
+#define _TOOLS_LINUX_KERNEL_PRINTK_H_
+
+#include <stdarg.h>
+#include <stdio.h>
+#include <stdlib.h>
+
+#define printk(fmt, ...) fprintf(stdout, fmt, ##__VA_ARGS__)
+#define pr_info printk
+#define pr_notice printk
+#define pr_cont printk
+
+#define pr_warn(fmt, ...) fprintf(stderr, fmt, ##__VA_ARGS__)
+#define pr_err pr_warn
+#define pr_alert pr_warn
+#define pr_emerg pr_warn
+#define pr_crit pr_warn
+
+/*
+ * Dummy printk for disabled debugging statements to use whilst maintaining
+ * gcc's format checking.
+ */
+#define no_printk(fmt, ...)				\
+({							\
+	if (0)						\
+		printk(fmt, ##__VA_ARGS__);		\
+	0;						\
+})
+
+/* pr_devel() should produce zero code unless DEBUG is defined */
+#ifdef DEBUG
+#define pr_devel(fmt, ...) printk
+#else
+#define pr_devel(fmt, ...) no_printk
+#endif
+
+#define pr_debug pr_devel
+
+#endif /* _TOOLS_LINUX_KERNEL_PRINTK_H_ */
-- 
2.25.4

