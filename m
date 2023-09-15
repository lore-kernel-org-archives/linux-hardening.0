Return-Path: <linux-hardening-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F12EEE6456
	for <linux-hardening@archiver.kernel.org>; Fri, 15 Sep 2023 11:00:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234285AbjIOLA2 (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Fri, 15 Sep 2023 07:00:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234367AbjIOLAZ (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Fri, 15 Sep 2023 07:00:25 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A0E61BF4
        for <linux-hardening@vger.kernel.org>; Fri, 15 Sep 2023 03:59:59 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id 3f1490d57ef6-d7e7e70fa52so2271864276.0
        for <linux-hardening@vger.kernel.org>; Fri, 15 Sep 2023 03:59:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1694775598; x=1695380398; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=PIsfdB6xTDxZC/lwkP7uk8Z8Jcdw9pIYLJmg+xNA39E=;
        b=2vUDZjgvuJgT6Dxl96lpPH2wdVDJTwodMyV+fgNSXrXWT39dB78Ag5ylWhOB6Ng213
         VcaopasHaEJZl7Q1UrT0FoVUJCkrcCSlnxLz7I8g0tcGM6BG0T7LAszHfQj3JZ6ZpKbB
         YQR+GK0WpNc27Qu6Wi0ouGX/KiDXdd6qZIHy75+0tPXuhBa2bXos3QzUmgA4BAbqb78o
         YaGcHh2ENF3PkXvYE8zSppYsW/skio12alDCH5V3jj4Sxp/sGgS+O87Dy3Hu9twJf+co
         uO2aPSyDPkJqlrjaJ4Uedwr484h3CKPnSQ2RQH4Wn0O+uqhfmz8oQ7pjmOk955rdW4KC
         XhjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694775598; x=1695380398;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PIsfdB6xTDxZC/lwkP7uk8Z8Jcdw9pIYLJmg+xNA39E=;
        b=FBPT7XbIAIczXLf7oFBarJrHo96EwPByiqpBP+nBlHjg1yo4ag6rrq1U4dO4yuE2IY
         YXfzTE3LlqnJXdzqypLlhYVyuKAhAceH4Un9JThaOqIixDWBXKUe599gVTPV2ZKQCjUX
         v7pi2Bishf+PFztuo/+gWDrk+BGiFXY7agrKK92gyD6Xzj8KD1CYF1NZ9VjK5eaUJ41P
         nWtnALMnxOceD+UdruAZTUBL1iFXAdOos/JlLqTd92ABjfpzn9qzOAd1FB3e4vCwM6fv
         rsOkJ/yx4kyekQUnoQ3AF14QcbPb1X4MKfIs8C1NZAD2waRzm/OLZCvlvaLqSZmOtYQX
         cJyw==
X-Gm-Message-State: AOJu0Yz3yQWUwckuArJXXWt0DvsmxCKhyxHhTuNBD3scmaaP5lhHtKTt
        +b00N6P/vmE4oa205ixNK089chsmkVxZd3a/Ug==
X-Google-Smtp-Source: AGHT+IHof1ICS1lqUlllRxkXI3ZaCAbe0FHMFloFuiAiVd7ISUWF8gEW5L/+IOYmFoxGVNOKnVGZCUEbaXvmEPeHwA==
X-Received: from mr-cloudtop2.c.googlers.com ([fda3:e722:ac3:cc00:31:98fb:c0a8:2a6])
 (user=matteorizzo job=sendgmr) by 2002:a5b:d10:0:b0:d81:7f38:6d65 with SMTP
 id y16-20020a5b0d10000000b00d817f386d65mr22869ybp.2.1694775598311; Fri, 15
 Sep 2023 03:59:58 -0700 (PDT)
Date:   Fri, 15 Sep 2023 10:59:27 +0000
In-Reply-To: <20230915105933.495735-1-matteorizzo@google.com>
Mime-Version: 1.0
References: <20230915105933.495735-1-matteorizzo@google.com>
X-Mailer: git-send-email 2.42.0.459.ge4e396fd5e-goog
Message-ID: <20230915105933.495735-9-matteorizzo@google.com>
Subject: [RFC PATCH 08/14] security: introduce CONFIG_SLAB_VIRTUAL
From:   Matteo Rizzo <matteorizzo@google.com>
To:     cl@linux.com, penberg@kernel.org, rientjes@google.com,
        iamjoonsoo.kim@lge.com, akpm@linux-foundation.org, vbabka@suse.cz,
        roman.gushchin@linux.dev, 42.hyeyoo@gmail.com,
        keescook@chromium.org, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-mm@kvack.org,
        linux-hardening@vger.kernel.org, tglx@linutronix.de,
        mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com,
        x86@kernel.org, hpa@zytor.com, corbet@lwn.net, luto@kernel.org,
        peterz@infradead.org
Cc:     jannh@google.com, matteorizzo@google.com, evn@google.com,
        poprdi@google.com, jordyzomer@google.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

From: Jann Horn <jannh@google.com>

SLAB_VIRTUAL is a mitigation for the SLUB allocator which prevents reuse
of virtual addresses across different slab caches and therefore makes
some types of use-after-free bugs unexploitable.

SLAB_VIRTUAL is incompatible with KASAN and we believe it's not worth
adding support for it. This is because SLAB_VIRTUAL and KASAN are aimed
at two different use cases: KASAN is meant for catching bugs as early as
possible in debug/fuzz/testing builds, and it's not meant to be used in
production. SLAB_VIRTUAL on the other hand is an exploit mitigation that
doesn't attempt to highlight bugs but instead tries to make them
unexploitable. It doesn't make sense to enable it in debugging builds or
during fuzzing, and instead we expect that it will be enabled in
production kernels.

SLAB_VIRTUAL is not currently compatible with KFENCE, removing this
limitation is future work.

Signed-off-by: Jann Horn <jannh@google.com>
Co-developed-by: Matteo Rizzo <matteorizzo@google.com>
Signed-off-by: Matteo Rizzo <matteorizzo@google.com>
---
 security/Kconfig.hardening | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/security/Kconfig.hardening b/security/Kconfig.hardening
index 0f295961e773..9f4e6e38aa76 100644
--- a/security/Kconfig.hardening
+++ b/security/Kconfig.hardening
@@ -355,4 +355,18 @@ config GCC_PLUGIN_RANDSTRUCT
 	   * https://grsecurity.net/
 	   * https://pax.grsecurity.net/
 
+config SLAB_VIRTUAL
+	bool "Allocate slab objects from virtual memory"
+	depends on SLUB && !SLUB_TINY
+	# If KFENCE support is desired, it could be implemented on top of our
+	# virtual memory allocation facilities
+	depends on !KFENCE
+	# ASAN support will require that shadow memory is allocated
+	# appropriately.
+	depends on !KASAN
+	help
+	  Allocate slab objects from kernel-virtual memory, and ensure that
+	  virtual memory used as a slab cache is never reused to store
+	  objects from other slab caches or non-slab data.
+
 endmenu
-- 
2.42.0.459.ge4e396fd5e-goog

