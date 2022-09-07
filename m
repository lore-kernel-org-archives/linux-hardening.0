Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5842CC54EE9
	for <linux-hardening@archiver.kernel.org>; Wed,  7 Sep 2022 22:55:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229517AbiIGWz3 (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Wed, 7 Sep 2022 18:55:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229531AbiIGWz2 (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Wed, 7 Sep 2022 18:55:28 -0400
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E2EA4BD28
        for <linux-hardening@vger.kernel.org>; Wed,  7 Sep 2022 15:55:27 -0700 (PDT)
Received: by mail-pf1-x435.google.com with SMTP id j12so3621123pfi.11
        for <linux-hardening@vger.kernel.org>; Wed, 07 Sep 2022 15:55:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date;
        bh=Q7pmrL+4wpGBCbVasMs4fSOlbSdHMQaBsvngND+c1lM=;
        b=Gbv62ufdc9ZHs+vkgxl3i8Wyc5jfPcgwUwck9cmVn2Unq5TqW0stEiF2Yh/9KvqGbR
         Bdom5pBR+tYMsrhM5doM4A4wRnJWX50FGhNIoTiWS3hqaikoYbEbIoyQbS28DhSo8qvI
         Z7qzB/b6HBkttLvXs5hbISf/DY4+kNqtBw3E8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=Q7pmrL+4wpGBCbVasMs4fSOlbSdHMQaBsvngND+c1lM=;
        b=SpOM50F8zh5IelCC4a7uDksN+qxeq41xhvfUo2oVRFE9vHiQHxleAM5GCp4xAG3Y2C
         cxBaUkRgGtYGZIIhBuUTwuCQgoNXsdRa7903k8aZHhq6Vhd1E2xtcdUk7RmBlLr2Gfs+
         3tGa76P2+Uy1QZ8wdoUPk9fcwat/74SqA66KvA3Jw3OQw0d7rSwrVWc+J9CTIpWH1HBb
         cCYZ4WSjuo+Ixdlybjtqas9w1wvFmTBY2tnUJUhQ4jHUTvJteYs4oUfI8yUKLl41GVhU
         noc+GIKzoEVNKE5KbZvmvpUwiSOqmueag8Drf0eu8cbpmw3vhuP43mxn4nFMT6tJyxTX
         9fGQ==
X-Gm-Message-State: ACgBeo0tOsAuijVexgesyN0HdmhJJJMeW5QT0JL+vOuCWZQcru55Aazm
        fK3DaKg95yx54M9oSoSI4EbG+XHdkKzlLQ==
X-Google-Smtp-Source: AA6agR4iPretcBm0dZThuzVqecZwXG9MyW8TFBNEW/TtH75AoPT84tbbR6bcda0YeCEWeNHbGzfU/Q==
X-Received: by 2002:a63:f547:0:b0:434:e1b8:45ef with SMTP id e7-20020a63f547000000b00434e1b845efmr5207647pgk.620.1662591327017;
        Wed, 07 Sep 2022 15:55:27 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id ik26-20020a170902ab1a00b00172d0c7edf4sm10440172plb.106.2022.09.07.15.55.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Sep 2022 15:55:26 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     Russell King <linux@armlinux.org.uk>
Cc:     Kees Cook <keescook@chromium.org>,
        kernel test robot <lkp@intel.com>,
        linux-arm-kernel@lists.infradead.org,
        Chris Down <chris@chrisdown.name>,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: [PATCH] ARM: decompressor: Include .data.rel.ro.local
Date:   Wed,  7 Sep 2022 15:55:20 -0700
Message-Id: <20220907225520.55855-1-keescook@chromium.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1585; h=from:subject; bh=ALlFctFnZceo9yABdixwcNtBAmKlABPuY5GvGOh0ppI=; b=owEBbAKT/ZANAwAKAYly9N/cbcAmAcsmYgBjGSFY1rlJ6AQJtVRC1NVyScvP4dCo4yiu/ywMziAD d4iSe56JAjIEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCYxkhWAAKCRCJcvTf3G3AJvm1D/ UYwfAMV9EwisJ8hT8C5PdYlmAVN1ymHS5fIzWpmqDh2iusCjeyOziuZ6NoniwHCeXqKoFKDyb6Ry3u aJBjEFGKMdYGYGc8eCLZ2GMRRubyQ6K/lHylV3jVPauuLv2qWgt6LCEACjt4cq6x5Wkd85+AduCVml DqkkhvpbwK5KqFv+bdWcF9Do8caNuZz5xRe2+enLPp5ETWy6uG1oSxYzFXF5GIQvuxhpJXJSUos5fB 8tG3n/EV2p4lX3MFGi1qSgxjU9mrxwv8Hit9ycuWqWa+VSOgCDV5CQBb41tM2RGkrPmJFGUd85P096 05zwShEKrFtZJv/MiUOIo46e3IH6i0R/4gspJDaM9e2HFyIB0LD+vrrVRwdFLjlRlTjBttIHFmuolW Xq223PeibLpMTF0LRGqMq+QG6EFbfG15kDYSGCwo0InzFFv2MgvlF2bS2y7rMlrsQjZ1ZD5aCQSgnY O00Vxuz41oGen66/ogh8SMYOwSV7GgGXOUdCNisL4PyFTAqurVydNE3QgxXp6yEZpvuKK1u3yP9VAx PHHfM0SnDOfVAiY9hODQrvpPtwkyFa88yArjcOqCK6ExHfNWX0OZwmoVDqpblLGF08ZBzXGwxlGzkd zM4LXI8RkGxChI/PwLPIKRV9By5jiUe1JcvAOF5ilS8HaGIJo58PG+S+0h
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

The .data.rel.ro.local section has the same semantics as .data.rel.ro
here, so include it in the .rodata section of the decompressor.
Additionally, Since the .printk_index section isn't usable outside of
the core kernel, discard it in the decompressor. Avoids these warnings:

arm-linux-gnueabi-ld: warning: orphan section `.data.rel.ro.local' from `arch/arm/boot/compressed/fdt_rw.o' being placed in section `.data.rel.ro.local'
arm-linux-gnueabi-ld: warning: orphan section `.printk_index' from `arch/arm/boot/compressed/fdt_rw.o' being placed in section `.printk_index'

Reported-by: kernel test robot <lkp@intel.com>
Link: https://lore.kernel.org/linux-mm/202209080545.qMIVj7YM-lkp@intel.com
Cc: Russell King <linux@armlinux.org.uk>
Cc: linux-arm-kernel@lists.infradead.org
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 arch/arm/boot/compressed/vmlinux.lds.S | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/boot/compressed/vmlinux.lds.S b/arch/arm/boot/compressed/vmlinux.lds.S
index 1bcb68ac4b01..3fcb3e62dc56 100644
--- a/arch/arm/boot/compressed/vmlinux.lds.S
+++ b/arch/arm/boot/compressed/vmlinux.lds.S
@@ -23,6 +23,7 @@ SECTIONS
     *(.ARM.extab*)
     *(.note.*)
     *(.rel.*)
+    *(.printk_index)
     /*
      * Discard any r/w data - this produces a link error if we have any,
      * which is required for PIC decompression.  Local data generates
@@ -57,6 +58,7 @@ SECTIONS
     *(.rodata)
     *(.rodata.*)
     *(.data.rel.ro)
+    *(.data.rel.ro.*)
   }
   .piggydata : {
     *(.piggydata)
-- 
2.34.1

