Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB899C433EF
	for <linux-hardening@archiver.kernel.org>; Fri, 19 Nov 2021 17:53:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C06BF6120E
	for <linux-hardening@archiver.kernel.org>; Fri, 19 Nov 2021 17:53:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234843AbhKSR4b (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Fri, 19 Nov 2021 12:56:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231840AbhKSR4a (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Fri, 19 Nov 2021 12:56:30 -0500
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6BA0C06173E
        for <linux-hardening@vger.kernel.org>; Fri, 19 Nov 2021 09:53:27 -0800 (PST)
Received: by mail-pj1-x1033.google.com with SMTP id o6-20020a17090a0a0600b001a64b9a11aeso9425961pjo.3
        for <linux-hardening@vger.kernel.org>; Fri, 19 Nov 2021 09:53:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=LbDTRLuM6B/i4N4fLddPtlTt3fPn3atqp8keACoNBMI=;
        b=h3dU2JP1JNh2mb3NOfVHeFY13lYibRgwDzkNIRtt8sHoEBNK8QEyA5q1JtBlYA61Dn
         lOOI82qyaBHg6UgzQN8VxEqx8GceyPMSTEJe5KUwdlpyUK+f3yQNcMZdtfDaYMy2+NSs
         Qpl+Z5H0yf7Kol2cN7iiTLVKF/GerOUqR2UzE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=LbDTRLuM6B/i4N4fLddPtlTt3fPn3atqp8keACoNBMI=;
        b=U38+edEt1lEKbMu8IG4VWsH3iJZIUwj7N8JTZzw8Rr9xhxqx1uIV4vD7ntDTF2vS02
         K1l6BS9TcqRcnv3VUCVhpjf6G2R5VACelzo0vfQeAB1Vg58ToQpFGg13zeK2kZxVlhZj
         eiVU6mrS1is/xu0zAKUZXZ+7kHzEggu7rlL4u91EhTgxWTnW/B3+pgpyW7kGwJNDCSjC
         rsgishM/ZuJjAd0X5Af4ppVXaLBPWtPdd8Xs0fTz5vcQCyNWOjEGrBLA0eawKN0JH8zs
         5HLhDFejoU3Uiqr6KMc6zDQi9Lg0wRzTUAs+WmufhuP6raNpCvqc/pSBN11r6HLGqk4X
         yu3Q==
X-Gm-Message-State: AOAM530jmim5TtF3EOxN1DQxk/xRwdvYq2sFLRnTRsD0/N4t9wzMabS5
        r4QfHnmCcea4dFzZigdI+VbDfhmOjiNLvA==
X-Google-Smtp-Source: ABdhPJyJBPj4VRC/jY8Fe7nvF5PdNlnj5RFQf4A0+2py5iUREf0sg9kiz/khp65/bpHuTPmNAnm08A==
X-Received: by 2002:a17:90b:105:: with SMTP id p5mr1764517pjz.60.1637344407330;
        Fri, 19 Nov 2021 09:53:27 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id u22sm281417pfi.187.2021.11.19.09.53.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Nov 2021 09:53:27 -0800 (PST)
From:   Kees Cook <keescook@chromium.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Kees Cook <keescook@chromium.org>, Ingo Molnar <mingo@redhat.com>,
        Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org,
        x86@kernel.org, linux-hardening@vger.kernel.org
Subject: [PATCH] x86/boot/string: Add missing function declarations
Date:   Fri, 19 Nov 2021 09:53:25 -0800
Message-Id: <20211119175325.3668419-1-keescook@chromium.org>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1236; h=from:subject; bh=U7Ni1JpduMeuesGUuMzbPqvfcNzvY+ZcVCYe3F3B0wA=; b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBhl+SUVsqFFvXCn4HMMPCunL6eH7noZ+4hLfX23MgA pHWIjSWJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCYZfklAAKCRCJcvTf3G3AJntLEA CkhzuVGtMnh24Q/mpbP4K5J7fy6X8oDhFoYqY9YNGlZ2QM+T5o52F7l0yIdlTH/dJrRqup8nNq5vqh +Ya5jrwouSccXI+6ZaG7+RZYcN5O/hyuD9W+Lnaw1KSnfkMp983bki+i1Zo3EEc7YjIvnyTQTUhLie 9mIRnmP2d+W8YlaGDPaxcA8Lq1MI13I1XDQeIrHNem5A/NwNg8OkH2m6ayO5Z87c5I0A5TRpUYt9V+ QviDYUiDKCC6X6Zhan5/mU5CUWxn24PLXPl4OqctUDAiq+xO/8U8CPvxHQG7C/jF9AnsZtvsyToRsK LaJHtDVNGKAY9cU+Ly3kZir2UxzVCb6/kdyR4zwVniYEKHiQQ4pWwSN2tjfdXxOtRBkKvjThK2MgLs dshpDFFqTpLxXjSR2E4bAHtyDBSUkqNu3vJQm4P78pGxPrmThGBsLqrZBb6032Rv2cD3yW4bWIy9Fh yy4jHTqijKnehmGDd5H3XsYJAS5xc/lh6a4UR/UsnnCHMCd+MP19B+U868pw4tnCCKsiT9wmIEDtsD kRlyebxxD/lF2n604+1B3zykBUnht0ZMgDzrZGDJni2DJZAF6AoZe+SjhzKp3KvoMNUxJO2W5xZpSm /cBZADUu2C3+of9dkPi48xCqqJOOQOSGyxmCYRjy8VSAfJy7c9A9SSkdQifQ==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

Silence "missing function declaration" warnings from string.h when
building under W=1.

Signed-off-by: Kees Cook <keescook@chromium.org>
---
 arch/x86/boot/string.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/x86/boot/string.h b/arch/x86/boot/string.h
index a232da487cd2..e5d2c6b8c2f1 100644
--- a/arch/x86/boot/string.h
+++ b/arch/x86/boot/string.h
@@ -8,8 +8,10 @@
 #undef memcmp
 
 void *memcpy(void *dst, const void *src, size_t len);
+void *memmove(void *dst, const void *src, size_t len);
 void *memset(void *dst, int c, size_t len);
 int memcmp(const void *s1, const void *s2, size_t len);
+int bcmp(const void *s1, const void *s2, size_t len);
 
 /* Access builtin version by default. */
 #define memcpy(d,s,l) __builtin_memcpy(d,s,l)
@@ -25,6 +27,7 @@ extern size_t strnlen(const char *s, size_t maxlen);
 extern unsigned int atou(const char *s);
 extern unsigned long long simple_strtoull(const char *cp, char **endp,
 					  unsigned int base);
+long simple_strtol(const char *cp, char **endp, unsigned int base);
 
 int kstrtoull(const char *s, unsigned int base, unsigned long long *res);
 int boot_kstrtoul(const char *s, unsigned int base, unsigned long *res);
-- 
2.30.2

