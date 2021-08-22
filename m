Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E431C432BE
	for <linux-hardening@archiver.kernel.org>; Sun, 22 Aug 2021 07:51:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EB85B6124D
	for <linux-hardening@archiver.kernel.org>; Sun, 22 Aug 2021 07:51:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231917AbhHVHwJ (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Sun, 22 Aug 2021 03:52:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231674AbhHVHwJ (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Sun, 22 Aug 2021 03:52:09 -0400
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F631C06175F
        for <linux-hardening@vger.kernel.org>; Sun, 22 Aug 2021 00:51:28 -0700 (PDT)
Received: by mail-pl1-x635.google.com with SMTP id m17so1322061plc.6
        for <linux-hardening@vger.kernel.org>; Sun, 22 Aug 2021 00:51:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=am5+0lycZIk04twfBqM4+s6qa8a+zRI/XASrtMJYUmk=;
        b=Q8QtAkeVcEvZ2e05ol7+45erTWdLPLFXsHwIdbwND45Tty3VD84g9oOcp19kUjY9p4
         xTKhcZHDD9DXwAaFFOgVjf2fj6Iar42u8Sc+tCR+vmkhUQcNHsoPfWkIUXB4YS/TvLI3
         mnzW2q6RQDwvGzcw/75L8gIdM7n8VpefXm8kI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=am5+0lycZIk04twfBqM4+s6qa8a+zRI/XASrtMJYUmk=;
        b=dpg03pj6valM6QSHp7QaEWSxOAo4ko0aqAh6bJQNEN529kuuemICDp6MXF4VyqwhzV
         EHCcJjTAALiigiptTCWywzW1ItaPkzz1fL/SOeLVqISyEe0G5fXjdtC7vCkKEQYSVNtv
         jzoSuuwdac6rIkZjTX0/hejDN3WAnzWwbgombmI0KJI1xs1nhKy+3PditqTrfLI0HOd9
         vGJbPVr3ngY5TD4br3JZVCGDE9Oe1ww5rPBoDvZW1a0rnJz21fmtnsFs25+wWoDfRntx
         t6RR+xtnre7De4DvB3omdw1ov5hxu47z+gspWpAbKWN4H9tBzzc61liNPbeWNe/OGpjU
         2HhQ==
X-Gm-Message-State: AOAM532njYLfu5DBmyFWWCbPQwBD69WVMC2wsEmhn6/Cb6CqooeDL9Pj
        QRqZ4QaCgGG6AvMl+u+A+iLKLA==
X-Google-Smtp-Source: ABdhPJxPaW29PiUnDfqde9+T62xJ2WBZy9Zt+meKwCRRJ/BJGPQ1N00ya9q3qZ5Ip3QeUFRVQNs+0g==
X-Received: by 2002:a17:902:9f87:b029:12d:316c:2b6f with SMTP id g7-20020a1709029f87b029012d316c2b6fmr23736449plq.20.1629618688077;
        Sun, 22 Aug 2021 00:51:28 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id y27sm5534628pfa.29.2021.08.22.00.51.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Aug 2021 00:51:27 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     linux-kernel@vger.kernel.org
Cc:     Kees Cook <keescook@chromium.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Daniel Micay <danielmicay@gmail.com>,
        Francis Laniel <laniel_francis@privacyrequired.com>,
        Bart Van Assche <bvanassche@acm.org>,
        David Gow <davidgow@google.com>, linux-mm@kvack.org,
        clang-built-linux@googlegroups.com, linux-hardening@vger.kernel.org
Subject: [PATCH for-next 00/25] Prepare for better FORTIFY_SOURCE
Date:   Sun, 22 Aug 2021 00:50:57 -0700
Message-Id: <20210822075122.864511-1-keescook@chromium.org>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=6640; h=from:subject; bh=2oB/qr8U5A9dbEoV6QCH+oIQNWp51rj1y+EgjbJ1gFM=; b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBhIgH0QQhRt5uNs0Hc8yeCDnG29Dc0nXypDoIpSkdQ AMMMlj2JAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCYSIB9AAKCRCJcvTf3G3AJgX4D/ 9KaXQZxp9eoRSwxtgQbAo80Tia7YY3oMxKwgjTDFtSGBaDknXDn8uo7IsSO/1csc9k5ycQ3/a+kT1o xUjbGspj8/Q96C8n0+9MS/ap0Jmp2lMKBuDzzfDP/2rh7yWCBnJNPut+eLn/iivb1Ij8NyE0es2fMe FQVMyovulfK777G1wR84BUoR3Wba0qMxxrDXrIioiOlKhZ7AC3Mxf8JdskVbCv3RorlR56rHlLMKPH Aits514/9D9S9nUk+sR6Q7Wu8YcHy4u4X1aL4O8EH8NTd4qTXOUZTDwxv7kcqcbeLUcdzudMFGAJpD VNrFNkTNGjVmg56mbQP71FTmYfITIp1m3WVLLIzODXq8yS4JZRHKzo/eFVZir+ROwzWoRPcZhsbA1F owBGVu7JMnL+ArDhrLgx/RRU+9GbO/iQIvlwjqV5k/1h/0D9Bj1AysmJwMDRBVjZKIQ+7/GzE92DEK Jg2C7pwxlKYo9gJflEEC+6yqRZgaz0tnnlolLv7L9f0Ov+zGixlDgkfILkS5Jne1OJ+qybOR7v1zD0 B5ttkdE31/MpoG5v+dnWOeB4g7BVeMwYjEYvIDu1gSUhWKR+tN6eNQo9Ppc2SzMBADw26caihma33t Lh4fpoc8qfWAqIsI/miVxkdjd1Pb4uNXkC4OLkMqw/EE+XC7i498ypKhe2mQ==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

Hi,

This is what I'm going to put into -next in my "overflow" tree, based on
the v2 of the most recent memcpy series[1]. It includes many of the
Ack/Reviewed patches, as well as most of the new helpers, the new
FORTIFY compile-time tests, memcpy() run-time tests, and the start of
the FORTIFY macro refactoring.

Any Acks/Reviews on the fortify changes are appreciated! :)

-Kees

[1] https://lore.kernel.org/lkml/20210818060533.3569517-1-keescook@chromium.org/

Changes since v2:
- teach script/kernel-doc about struct_group()
- split memset_after() from memset_startat()
- add MAINTAINERS section for FORTIFY_SOURCE

Kees Cook (25):
  scsi: ibmvscsi: Avoid multi-field memset() overflow by aiming at srp
  powerpc: Split memset() to avoid multi-field overflow
  stddef: Fix kerndoc for sizeof_field() and offsetofend()
  stddef: Introduce struct_group() helper macro
  cxl/core: Replace unions with struct_group()
  bnxt_en: Use struct_group_attr() for memcpy() region
  iommu/amd: Use struct_group() for memcpy() region
  drm/mga/mga_ioc32: Use struct_group() for memcpy() region
  HID: cp2112: Use struct_group() for memcpy() region
  HID: roccat: Use struct_group() to zero kone_mouse_event
  can: flexcan: Use struct_group() to zero struct flexcan_regs regions
  cm4000_cs: Use struct_group() to zero struct cm4000_dev region
  compiler_types.h: Remove __compiletime_object_size()
  lib/string: Move helper functions out of string.c
  fortify: Move remaining fortify helpers into fortify-string.h
  fortify: Explicitly disable Clang support
  fortify: Fix dropped strcpy() compile-time write overflow check
  fortify: Prepare to improve strnlen() and strlen() warnings
  fortify: Allow strlen() and strnlen() to pass compile-time known
    lengths
  fortify: Add compile-time FORTIFY_SOURCE tests
  lib: Introduce CONFIG_TEST_MEMCPY
  string.h: Introduce memset_after() for wiping trailing members/padding
  xfrm: Use memset_after() to clear padding
  string.h: Introduce memset_startat() for wiping trailing members and
    padding
  btrfs: Use memset_startat() to clear end of struct

 MAINTAINERS                                   |   9 +
 arch/arm/boot/compressed/string.c             |   1 +
 arch/s390/lib/string.c                        |   3 +
 arch/x86/boot/compressed/misc.h               |   2 +
 arch/x86/boot/compressed/pgtable_64.c         |   2 +
 arch/x86/lib/string_32.c                      |   1 +
 drivers/char/pcmcia/cm4000_cs.c               |   9 +-
 drivers/cxl/cxl.h                             |  61 ++--
 drivers/gpu/drm/mga/mga_ioc32.c               |  27 +-
 drivers/hid/hid-cp2112.c                      |  14 +-
 drivers/hid/hid-roccat-kone.c                 |   2 +-
 drivers/hid/hid-roccat-kone.h                 |  12 +-
 drivers/iommu/amd/init.c                      |   9 +-
 drivers/macintosh/smu.c                       |   3 +-
 drivers/net/can/flexcan.c                     |  68 ++---
 drivers/net/ethernet/broadcom/bnxt/bnxt_dcb.c |   4 +-
 drivers/net/ethernet/broadcom/bnxt/bnxt_dcb.h |  14 +-
 drivers/scsi/ibmvscsi/ibmvscsi.c              |   3 +-
 fs/btrfs/root-tree.c                          |   6 +-
 include/linux/compiler-gcc.h                  |   2 -
 include/linux/compiler_types.h                |   4 -
 include/linux/fortify-string.h                |  75 +++--
 include/linux/stddef.h                        |  52 +++-
 include/linux/string.h                        |  44 ++-
 include/linux/thread_info.h                   |   2 +-
 include/uapi/drm/mga_drm.h                    |  22 +-
 include/uapi/linux/stddef.h                   |  21 ++
 lib/.gitignore                                |   2 +
 lib/Kconfig.debug                             |  11 +
 lib/Makefile                                  |  34 +++
 lib/string.c                                  | 210 +------------
 lib/string_helpers.c                          | 195 ++++++++++++
 lib/test_fortify/read_overflow-memchr.c       |   5 +
 lib/test_fortify/read_overflow-memchr_inv.c   |   5 +
 lib/test_fortify/read_overflow-memcmp.c       |   5 +
 lib/test_fortify/read_overflow-memscan.c      |   5 +
 lib/test_fortify/read_overflow2-memcmp.c      |   5 +
 lib/test_fortify/read_overflow2-memcpy.c      |   5 +
 lib/test_fortify/read_overflow2-memmove.c     |   5 +
 lib/test_fortify/test_fortify.h               |  35 +++
 lib/test_fortify/write_overflow-memcpy.c      |   5 +
 lib/test_fortify/write_overflow-memmove.c     |   5 +
 lib/test_fortify/write_overflow-memset.c      |   5 +
 lib/test_fortify/write_overflow-strcpy-lit.c  |   5 +
 lib/test_fortify/write_overflow-strcpy.c      |   5 +
 lib/test_fortify/write_overflow-strlcpy-src.c |   5 +
 lib/test_fortify/write_overflow-strlcpy.c     |   5 +
 lib/test_fortify/write_overflow-strncpy-src.c |   5 +
 lib/test_fortify/write_overflow-strncpy.c     |   5 +
 lib/test_fortify/write_overflow-strscpy.c     |   5 +
 lib/test_memcpy.c                             | 289 ++++++++++++++++++
 net/xfrm/xfrm_policy.c                        |   4 +-
 net/xfrm/xfrm_user.c                          |   2 +-
 scripts/kernel-doc                            |   7 +
 scripts/test_fortify.sh                       |  59 ++++
 security/Kconfig                              |   3 +
 56 files changed, 1028 insertions(+), 380 deletions(-)
 create mode 100644 lib/test_fortify/read_overflow-memchr.c
 create mode 100644 lib/test_fortify/read_overflow-memchr_inv.c
 create mode 100644 lib/test_fortify/read_overflow-memcmp.c
 create mode 100644 lib/test_fortify/read_overflow-memscan.c
 create mode 100644 lib/test_fortify/read_overflow2-memcmp.c
 create mode 100644 lib/test_fortify/read_overflow2-memcpy.c
 create mode 100644 lib/test_fortify/read_overflow2-memmove.c
 create mode 100644 lib/test_fortify/test_fortify.h
 create mode 100644 lib/test_fortify/write_overflow-memcpy.c
 create mode 100644 lib/test_fortify/write_overflow-memmove.c
 create mode 100644 lib/test_fortify/write_overflow-memset.c
 create mode 100644 lib/test_fortify/write_overflow-strcpy-lit.c
 create mode 100644 lib/test_fortify/write_overflow-strcpy.c
 create mode 100644 lib/test_fortify/write_overflow-strlcpy-src.c
 create mode 100644 lib/test_fortify/write_overflow-strlcpy.c
 create mode 100644 lib/test_fortify/write_overflow-strncpy-src.c
 create mode 100644 lib/test_fortify/write_overflow-strncpy.c
 create mode 100644 lib/test_fortify/write_overflow-strscpy.c
 create mode 100644 lib/test_memcpy.c
 create mode 100644 scripts/test_fortify.sh

-- 
2.30.2

