Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98BD5C433F5
	for <linux-hardening@archiver.kernel.org>; Thu, 10 Feb 2022 01:58:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233707AbiBJB55 (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Wed, 9 Feb 2022 20:57:57 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:60016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233735AbiBJB4N (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Wed, 9 Feb 2022 20:56:13 -0500
Received: from mail-io1-xd2b.google.com (mail-io1-xd2b.google.com [IPv6:2607:f8b0:4864:20::d2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E1E02AAB0
        for <linux-hardening@vger.kernel.org>; Wed,  9 Feb 2022 17:40:52 -0800 (PST)
Received: by mail-io1-xd2b.google.com with SMTP id s18so5509267ioa.12
        for <linux-hardening@vger.kernel.org>; Wed, 09 Feb 2022 17:40:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=NnM5dCp68E2rE/49/oOSjnZsSaxmdjzgIGASXkmR6xY=;
        b=SAzNK2jOoju8Kh3tfB4nt1GBgAe2hFe+vZ/ZEcNq9+YseZkdv2Fs4ANx/8Njn2iHYw
         VgImwzzPwpqjZer2EaG3EFoHGPc7ZAG0lVoML//dwhD2BjDTxWacHXbShQifoKV37Z0B
         VlqmbomQWjifurbhavxvDrNbK8H8R7Dm5ffKg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=NnM5dCp68E2rE/49/oOSjnZsSaxmdjzgIGASXkmR6xY=;
        b=l4SZh5DjnXtq4FPw43obhMO0wLVEDjbS3YGpN3cvjVPKombL48DWBFG2tjjakq9IdR
         fEdjZUL43OEGxvRAcb3iRydqiN/7WMqwcSQE8i44mrtiWaeruRyRuoN/nOMvOIChHJFX
         c54ALZa1kQcZ4W7/MYFPC35ortN0ycDD7c5sQ9AmP1EGpUM+cLqQXBtljuQiuEOeN7OB
         X/1fIN1St+SkkLtIG/zcZLwyS64ht4mZJEos3HILOf7d/QVbJRdLGaYiZ6KQlJ/7LxG4
         mb507f+kGvT1pG2a8SIwlinrDwT6cQmugf+wRMerzhnvstPTT2JPdPO56KpeQ5DetHnT
         53sw==
X-Gm-Message-State: AOAM532aQFAdZiEevuDb50oe0H6GK74q4DPz0Il+IgVDR4u56QwyW5Nn
        CRzl6fuzMw9nxLs7ffWxeEP4FhJrIi/hSw==
X-Google-Smtp-Source: ABdhPJx1Wh7HpA/HF6B4EOxrjALlX3FDTxDRKrQ1wIzg5zjIWbRCBbc3R4Vri25XuSFgtzE6GDqv0A==
X-Received: by 2002:a63:cf05:: with SMTP id j5mr4054620pgg.544.1644453146584;
        Wed, 09 Feb 2022 16:32:26 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id lr7sm8382805pjb.42.2022.02.09.16.32.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Feb 2022 16:32:26 -0800 (PST)
From:   Kees Cook <keescook@chromium.org>
To:     Jeff Dike <jdike@addtoit.com>
Cc:     Kees Cook <keescook@chromium.org>,
        Richard Weinberger <richard@nod.at>,
        Anton Ivanov <anton.ivanov@cambridgegreys.com>,
        David Gow <davidgow@google.com>, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com,
        linux-um@lists.infradead.org, linux-hardening@vger.kernel.org
Subject: [PATCH] um: Enable FORTIFY_SOURCE
Date:   Wed,  9 Feb 2022 16:32:24 -0800
Message-Id: <20220210003224.773957-1-keescook@chromium.org>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=965; h=from:subject; bh=8p9qV7nCUTAMY0NIWHaERW8Fzn7HqVa7AIuy3N51Nyw=; b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBiBF0Xl67ZsAL362Vl2CFFWCSHpRPRaKgRKXg0mWx7 ZMVp4xqJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCYgRdFwAKCRCJcvTf3G3AJgidD/ 0ZTEYhKrilkWGasprf9ZIJxdPF1kViXr2K/C6/H7qvfbMkbD5Fg2txX23xhIDwLbpy5MpK6IDxNR2P MaUrUJnHJl0ZNl2PNf2uHwC/kjyyYsTvIHWJcdwDIBceeGQ7ub0Oq7j2vm/ldaha1PEymXloMWDwHz /3fj9YBHe5CKyezHu0V0lUx0hm4jNUDN3meuyyr3VAQ7sclsdreGSU+Ci0IhyaH6KuOlPtxmK+GGXQ r8lfsQiPVm5BJl8l+52BHMXlCQNhs4Nz6qv0Woxb9YML5Dv62TkyeGp/lWSPgPJFsSnnm3oycROEtr YxP3tKf0eBqiYZ/BmpO+svULC2RCO1ZBCuZ3Dl7hWtoC0hj6p2l8MwjH/P/VJDj8Qi4IjNAg8Pk1ou Zh7Fye8CDaK8vxMKBKB0HQ+OmgTnf4CM3eYhEvTQgnzhmnsiHS5rsAhfH0pgDMyp8F+WXGDc9CPYaF dBEixq9z4prhX1xhEZ9oZosu4MH0rUOwjFzaLuqJkSlfpIw8limtRgTkrtVFa4NLOjQqLZ1MAkRx5C B4ipNCCEMFhMf21hLLc54+iBrfAutksrvAhvYx8YLdOX/6nn3doqRqbjRwq38WqJsIzWgWeDv1veIK JO/xEQBVhQRO5nJ3XymXJQv5p2F7scM+73OoDDW+Hg+88tMp6ynYwykvph0A==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

Enable FORTIFY_SOURCE so running Kunit tests can test fortified
functions.

Signed-off-by: Kees Cook <keescook@chromium.org>
---
 arch/um/Kconfig              | 1 +
 arch/um/os-Linux/user_syms.c | 1 +
 2 files changed, 2 insertions(+)

diff --git a/arch/um/Kconfig b/arch/um/Kconfig
index 4d398b80aea8..746e661395d7 100644
--- a/arch/um/Kconfig
+++ b/arch/um/Kconfig
@@ -9,6 +9,7 @@ config UML
 	select ARCH_HAS_KCOV
 	select ARCH_HAS_STRNCPY_FROM_USER
 	select ARCH_HAS_STRNLEN_USER
+	select ARCH_HAS_FORTIFY_SOURCE
 	select ARCH_NO_PREEMPT
 	select HAVE_ARCH_AUDITSYSCALL
 	select HAVE_ARCH_SECCOMP_FILTER
diff --git a/arch/um/os-Linux/user_syms.c b/arch/um/os-Linux/user_syms.c
index 715594fe5719..d9845b5219ce 100644
--- a/arch/um/os-Linux/user_syms.c
+++ b/arch/um/os-Linux/user_syms.c
@@ -1,4 +1,5 @@
 // SPDX-License-Identifier: GPL-2.0
+#define __NO_FORTIFY
 #include <linux/types.h>
 #include <linux/module.h>
 
-- 
2.30.2

