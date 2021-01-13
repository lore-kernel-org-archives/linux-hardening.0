Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D264C433DB
	for <linux-hardening@archiver.kernel.org>; Wed, 13 Jan 2021 19:36:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3852F2054F
	for <linux-hardening@archiver.kernel.org>; Wed, 13 Jan 2021 19:36:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726803AbhAMTgU (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Wed, 13 Jan 2021 14:36:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725997AbhAMTgU (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Wed, 13 Jan 2021 14:36:20 -0500
Received: from mail-qv1-xf36.google.com (mail-qv1-xf36.google.com [IPv6:2607:f8b0:4864:20::f36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7AD8CC0617A2
        for <linux-hardening@vger.kernel.org>; Wed, 13 Jan 2021 11:35:06 -0800 (PST)
Received: by mail-qv1-xf36.google.com with SMTP id a1so1299136qvd.13
        for <linux-hardening@vger.kernel.org>; Wed, 13 Jan 2021 11:35:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=vt-edu.20150623.gappssmtp.com; s=20150623;
        h=sender:from:to:cc:subject:mime-version:date:message-id;
        bh=x5rG9aYCLmGpPdT1gIS00tPAzki6U9cSpND2lD2WOlM=;
        b=Jr/LwR+1aBDOGFxCZ796ZMpHwB8wKSDYuhL7seCwNspDhSQugiUqevDcJfW/4f4mtp
         bFHuif7MvM8PiTUbw0OQQa/QYiIhY1NUnkl+/CxkG6fxIG60Iud71VWOOaTZOdS+Gizg
         RMOlBb25K26TC5UsWrI/Fbx+1GC5oM21SwBItOC4WaujLs8yXam1uP86YsO/+7i7Tre3
         p0DH3Hq9JvR8elvRujilHYUM8bS3BDx1BikLSWLHdU9oc8sXOEKvaRCgPCTfciuekSH1
         DVSvzqk1LXKQbD++imblHTLsqxq4HRMWeXfTmC5uex5peZNHKhiKz+N82G6goDm9yZHK
         I/hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:mime-version:date
         :message-id;
        bh=x5rG9aYCLmGpPdT1gIS00tPAzki6U9cSpND2lD2WOlM=;
        b=rU8JupApAoynfKPjx9SxQBHNsmAtCwUtkhZZf9xNrAooxjQvzQGwBuHdST1/GHMy3M
         O8ne5lYW4V/q3dgC6FqrnKerfUBdUXenaYUzhqZk94XPtN3GL91IArWROgYXuW2E11dd
         iDsabM4U6VuGCsedEDeCqw8PBEb7Q9jxbhaBZ6Wq1Pr4FKSHPDeTpGjZOmSdQhTUoKKe
         +gMHmGbjeIx4QhZfN8S44Ftqj3hTF8Dm9Em8w3OTdWl5ixW2f1LV9nscGIC6tmB5qo23
         VMCFzweuAqEKQNpNr0z0k9IiI9apaGcXT2gc2ztekv9tjtC4QsOidiR4YLcN0VFh5MMX
         MNGw==
X-Gm-Message-State: AOAM53102YC2DVccHfNZdNcBVxrx8eDU0U6/w6MJ9GamwFM6UJp9/yhb
        UrX9x5QZiIvRueDnXYoKn4e8kQ==
X-Google-Smtp-Source: ABdhPJxQyZfyGrOPr+YfUhrteGln7/R3+FdNZBJMHxk99/iZLVgwDCkdctwL7+SHr2YfPBGQkdBzPw==
X-Received: by 2002:a05:6214:321:: with SMTP id j1mr4095127qvu.32.1610566505433;
        Wed, 13 Jan 2021 11:35:05 -0800 (PST)
Received: from turing-police ([2601:5c0:c380:d61::359])
        by smtp.gmail.com with ESMTPSA id h22sm1479815qth.55.2021.01.13.11.35.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Jan 2021 11:35:04 -0800 (PST)
Sender: Valdis Kletnieks <valdis@vt.edu>
From:   "Valdis =?utf-8?Q?Kl=c4=93tnieks?=" <valdis.kletnieks@vt.edu>
X-Google-Original-From: "Valdis =?utf-8?Q?Kl=c4=93tnieks?=" <Valdis.Kletnieks@vt.edu>
X-Mailer: exmh version 2.9.0 11/07/2018 with nmh-1.7+dev
To:     Kees Cook <keescook@chromium.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>
cc:     linux-hardening@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH] gcc-plugins: avoid errors with -std=gnu++11 on old gcc
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date:   Wed, 13 Jan 2021 14:35:03 -0500
Message-ID: <104383.1610566503@turing-police>
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

It turns out that older gcc (4.9 and 5.4) have gnu++11 support, but
due to a gcc bug fixed in gcc6, throw errors during the build.
The relevant gcc bug is https://gcc.gnu.org/bugzilla/show_bug.cgi?id=69959

Version the option based on what gcc we're using.

Signed-off-by: Valdis Kletnieks <valdis.kletnieks@vt.edu>
Fixes: 27c287b41659 ("gcc-plugins: fix gcc 11 indigestion with plugins...")
---
diff --git a/scripts/gcc-plugins/Makefile b/scripts/gcc-plugins/Makefile
index b5487cce69e8..cc779973724a 100644
--- a/scripts/gcc-plugins/Makefile
+++ b/scripts/gcc-plugins/Makefile
@@ -21,8 +21,11 @@ always-y += $(GCC_PLUGIN)
 
 GCC_PLUGINS_DIR = $(shell $(CC) -print-file-name=plugin)
 
+# need gnu++11 for gcc 11, but 4.9 and 5.4 need gnu++98
+GCC_FLAVOR = $(call cc-ifversion, -ge, 1100, 11, 98)
+
 plugin_cxxflags	= -Wp,-MMD,$(depfile) $(KBUILD_HOSTCXXFLAGS) -fPIC \
-		   -I $(GCC_PLUGINS_DIR)/include -I $(obj) -std=gnu++11 \
+		   -I $(GCC_PLUGINS_DIR)/include -I $(obj) -std=gnu++$(GCC_FLAVOR) \
 		   -fno-rtti -fno-exceptions -fasynchronous-unwind-tables \
 		   -ggdb -Wno-narrowing -Wno-unused-variable \
 		   -Wno-format-diag

