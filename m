Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE39AC433DB
	for <linux-hardening@archiver.kernel.org>; Wed, 13 Jan 2021 01:20:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 92ACE2311F
	for <linux-hardening@archiver.kernel.org>; Wed, 13 Jan 2021 01:20:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726544AbhAMBUC (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Tue, 12 Jan 2021 20:20:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726531AbhAMBUA (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Tue, 12 Jan 2021 20:20:00 -0500
Received: from mail-qv1-xf2b.google.com (mail-qv1-xf2b.google.com [IPv6:2607:f8b0:4864:20::f2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65C18C061786
        for <linux-hardening@vger.kernel.org>; Tue, 12 Jan 2021 17:19:20 -0800 (PST)
Received: by mail-qv1-xf2b.google.com with SMTP id bd6so119620qvb.9
        for <linux-hardening@vger.kernel.org>; Tue, 12 Jan 2021 17:19:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=vt-edu.20150623.gappssmtp.com; s=20150623;
        h=sender:from:to:cc:subject:mime-version:date:message-id;
        bh=sQ8DknuOX6cEszUMAK4TjW4DpTvZqznr0/2Yp0CDLHo=;
        b=DBrGyaONyFBpVhbn1+CjZUD9gjG1UBk1O+llwONE8MBcZpPZX79Ejm+xpqSHicbwA9
         sui/fYOAdOE0PXdmv4jJ47N/lC3kBxlCwzk7WDiKLVSKKZr1VH/7rajjTiGhA5uLNhG2
         h3hVjPD14cR+/7iekBEJ9ZIxSxHjIIxNyOIbVUndp77h6/gieNhnLjv7d2dqUE7w+W42
         6JtCo1Pd6Lj5fhAWYGR05RM3l3TlOCp8ANLE3aJ1gtGJ8tWq/R/6LTI6uaqLC+qMWQ7t
         2OixnyEvFaaCDicHNlj0ExxBgGkja3+lF7AviEZrvoJOx+pP122LtHRxA5JlAUoSzbUH
         dFpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:mime-version:date
         :message-id;
        bh=sQ8DknuOX6cEszUMAK4TjW4DpTvZqznr0/2Yp0CDLHo=;
        b=ePB/iTuTDzpil2A8QLWtdL05DXzNrk3saRp7QlyWSWcl0wHU1llMi9Uhuz/sepbmV0
         Pj0rsTRi0CMHYeeXg4OonFNeqYBuOH48FkTTU+tzMDbz76FTfniMvaHmT8f0S8UVNI+q
         1oe6XwKff6A/hnp3H1KjD2vn/sBOOLW5G8V7l9ozq054sVPH0dN0BCjkPUdLRmCp4Fwy
         YkxbbLQqe9duHVmu63ZwmIXp6ffBkoen7Fe2y81ZGnxAqdPV9ysQ1cWSrMdZ0I7bgdWu
         /q532DQ9400gtbL0rmCFyUMBI5++e4HT8ypN2lk+j84Vo9ngCfUPadWLeoLk8WzxerRu
         xs7Q==
X-Gm-Message-State: AOAM532+hb+GQDxmP20H4WcsvDkKzxjxA6VMCWa0sNyo4XxMbYEKNRqZ
        dSkr8s5VAgGyvP8ZhshvCZKL4g==
X-Google-Smtp-Source: ABdhPJwRIYH8P0h+SOVfitntwxUwGY0psd45AWp5DOsEb7nsf/+7e1WVcQ2fn9Jq3w0g0ZsykFiNOg==
X-Received: by 2002:ad4:568a:: with SMTP id bc10mr2585570qvb.29.1610500759367;
        Tue, 12 Jan 2021 17:19:19 -0800 (PST)
Received: from turing-police ([2601:5c0:c380:d61::359])
        by smtp.gmail.com with ESMTPSA id 9sm225861qtr.64.2021.01.12.17.19.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Jan 2021 17:19:17 -0800 (PST)
Sender: Valdis Kletnieks <valdis@vt.edu>
From:   "Valdis =?utf-8?Q?Kl=c4=93tnieks?=" <valdis.kletnieks@vt.edu>
X-Google-Original-From: "Valdis =?utf-8?Q?Kl=c4=93tnieks?=" <Valdis.Kletnieks@vt.edu>
X-Mailer: exmh version 2.9.0 11/07/2018 with nmh-1.7+dev
To:     Kees Cook <keescook@chromium.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>
cc:     linux-hardening@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH v2] gcc-plugins: fix gcc 11 indigestion with plugins...
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date:   Tue, 12 Jan 2021 20:19:16 -0500
Message-ID: <38485.1610500756@turing-police>
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

Fedora Rawhide has started including gcc 11,and the g++ compiler
throws a wobbly when it hits scripts/gcc-plugins:

  HOSTCXX scripts/gcc-plugins/latent_entropy_plugin.so
In file included from /usr/include/c++/11/type_traits:35,
                 from /usr/lib/gcc/x86_64-redhat-linux/11/plugin/include/system.h:244,
                 from /usr/lib/gcc/x86_64-redhat-linux/11/plugin/include/gcc-plugin.h:28,
                 from scripts/gcc-plugins/gcc-common.h:7,
                 from scripts/gcc-plugins/latent_entropy_plugin.c:78:
/usr/include/c++/11/bits/c++0x_warning.h:32:2: error: #error This file requires compiler and library support for the ISO
 C++ 2011 standard. This support must be enabled with the -std=c++11 or -std=gnu++11 compiler options.
   32 | #error This file requires compiler and library support \

Patch is more complicated than would otherwise be needed, because
older gcc (4.9, 5.4) have gnu++11 but throw an error due to a gcc bug
https://gcc.gnu.org/bugzilla/show_bug.cgi?id=69959

Signed-off-by: Valdis Kletnieks <valdis.kletnieks@vt.edu>
---
diff --git a/scripts/gcc-plugins/Makefile b/scripts/gcc-plugins/Makefile
index d66949bfeba4..cc779973724a 100644
--- a/scripts/gcc-plugins/Makefile
+++ b/scripts/gcc-plugins/Makefile
@@ -21,10 +21,13 @@ always-y += $(GCC_PLUGIN)
 
 GCC_PLUGINS_DIR = $(shell $(CC) -print-file-name=plugin)
 
+# need gnu++11 for gcc 11, but 4.9 and 5.4 need gnu++98
+GCC_FLAVOR = $(call cc-ifversion, -ge, 1100, 11, 98)
+
 plugin_cxxflags	= -Wp,-MMD,$(depfile) $(KBUILD_HOSTCXXFLAGS) -fPIC \
-		   -I $(GCC_PLUGINS_DIR)/include -I $(obj) -std=gnu++98 \
+		   -I $(GCC_PLUGINS_DIR)/include -I $(obj) -std=gnu++$(GCC_FLAVOR) \
 		   -fno-rtti -fno-exceptions -fasynchronous-unwind-tables \
-		   -ggdb -Wno-narrowing -Wno-unused-variable -Wno-c++11-compat \
+		   -ggdb -Wno-narrowing -Wno-unused-variable \
 		   -Wno-format-diag
 
 plugin_ldflags	= -shared

