Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E46C9C43214
	for <linux-hardening@archiver.kernel.org>; Wed, 18 Aug 2021 05:08:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CE2E6610A3
	for <linux-hardening@archiver.kernel.org>; Wed, 18 Aug 2021 05:08:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234141AbhHRFJW (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Wed, 18 Aug 2021 01:09:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237227AbhHRFJU (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Wed, 18 Aug 2021 01:09:20 -0400
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32079C0617A8
        for <linux-hardening@vger.kernel.org>; Tue, 17 Aug 2021 22:08:45 -0700 (PDT)
Received: by mail-pj1-x1032.google.com with SMTP id w13-20020a17090aea0db029017897a5f7bcso1516900pjy.5
        for <linux-hardening@vger.kernel.org>; Tue, 17 Aug 2021 22:08:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ibfYg9pbryt9B5bM+TpRAt9ju/X9d6W3Gs+jxd+YtkU=;
        b=g4c93iNehB9VMgT8ohcQ2DTJpLbRTcPBX11gQZpAeoIJv0399CHnkPyELherSb4clp
         1K/KxP5FszZ81iDLg0QVY2WZlelG+LztfsxtZ2Rkb/8pSReiRloywS6qUGybT55xP3oo
         Y/pu24ZALeRP4SMmrarBPMhnrqDCkEa+A5N3E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ibfYg9pbryt9B5bM+TpRAt9ju/X9d6W3Gs+jxd+YtkU=;
        b=pddqA8mLKbQo6/RmUl6ujtJZ7m5jEvHkCYMpiB/rjt7FVyeTH+dAxBi3HEQ/o16Mnf
         tJ9ErQd0Ipx83j7m+gdCIRmHaCuPv6jNj307BSbHsX2Qd3jgkTjIbz3v4oLE4X0k4Zxe
         ZmZTv4NTLGMVWOPi7tWeg8AeZP9Z4mC1waDVWj2T9IKU9+7kr1Aflo/2QTlIgNpvWTTL
         l69z9l6UZfiPNSdScSjfJMelYxfYeiLfO/wR7UDzYln2oR812RMl62fS+Nvl/b3D+KlK
         nXSWsgpqiAtmGcZJaWHUB9LgdRNEUTzBoOgwsR7fAiySWvUyhb6+LqNzcvzispPK9NsC
         YyQg==
X-Gm-Message-State: AOAM533VVSRn09IA7AT5ub6ckom8pFvwfRm9fHyJRp/8KNJ1buf6CLVI
        VJjPHKI7RuaxGB0ms6RmYH7fGg==
X-Google-Smtp-Source: ABdhPJyUeG6+/fDFxS9Zq+Bmi6OpbrosbvZbi/vfiZ0w8iRHjHykfuiwrP9/HatrLXYJ89g6pzdjlw==
X-Received: by 2002:a17:90b:360a:: with SMTP id ml10mr7312861pjb.134.1629263324660;
        Tue, 17 Aug 2021 22:08:44 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id q21sm3578775pjg.55.2021.08.17.22.08.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Aug 2021 22:08:43 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     linux-kernel@vger.kernel.org
Cc:     Kees Cook <keescook@chromium.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Miguel Ojeda <ojeda@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Daniel Micay <danielmicay@gmail.com>,
        Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Dennis Zhou <dennis@kernel.org>, Tejun Heo <tj@kernel.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Michal Marek <michal.lkml@markovi.net>,
        clang-built-linux@googlegroups.com, linux-mm@kvack.org,
        linux-kbuild@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: [PATCH 0/5] Add __alloc_size() for better bounds checking
Date:   Tue, 17 Aug 2021 22:08:36 -0700
Message-Id: <20210818050841.2226600-1-keescook@chromium.org>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1503; h=from:subject; bh=M1Tok+LfKYfKMg3IsfepbLLdtBAUXEFJ6hNboUgrVcQ=; b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBhHJXX4iubi2i9iuFz+LsiKuwROx1EI+5yY5ZbGOgo sK/JE9+JAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCYRyV1wAKCRCJcvTf3G3AJpXhD/ 4z085X3Ll8rZJC6uVrygExuVDtlwKRRcu1+fsHdRvTBsNePyBe6eM7MdWyzSU6pRDGSwoPBBggFZ0F jYxajPqmHe9N5J8ZRMoRF/c+TcctzqSJjvaMxRrULJzBvM00RDUmapmE7i7gGeB8nsgMopdiuNpIFk eSzlfd5/V66zAWa2+vZ2gDFgHjWQIMrU4U7QeajbQOfbxYmzeN7nT5T7UTAtszzl4Dz29khVmFSxQK 8O8+mgv+S3HnLHpsm/X9189a9gx9FrY5CmmojA1NLFshWiMFwt0HqBWax2L0RA+QCj5YBTy5blQUve +qaLIvFS/G43o2Hr2KaK2BeROLFr9c/ridogvWg/BGM7Ohlervc/vSS9vGnrd1EAyNZ8VovR76HmA0 YceN0FYjjjrn0C2IaX1315H6wz71VTBRZMfQ3UUrzGFDzPLpqRd1jXKw0sXKQxAOJAqNIhOrdYse2U Z1DmuGpFHPFq7IWT12lvVMbY6on1GJy72xVVct1ZgUQpLTolS2BmWvpDFgTATpXlRSiiylxlEGY8dT AJEBIUkvRLFhe/ThymPuUkqCLfnMVsiTlbo3grvPI74w2D0zbBpsQXXry5IOI/9wBDD98Dczq0qdDd pwOrFTKxLBfnL6zBGq7mCyUtLzJzOTgVR+wyP4t3kuzVj/KqpTV0/LACImUQ==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

Hi,

GCC and Clang both use the "alloc_size" attribute to assist with bounds
checking around the use of allocation functions. Add the attribute,
adjust the Makefile to silence needless warnings, and add the hints to
the allocators where possible. These changes have been in use for a
while now in GrapheneOS.

To build without warnings, this series needs a couple small fixes for
allmodconfig, which I sent separately:
https://lore.kernel.org/lkml/20210818044540.1601664-1-keescook@chromium.org/
https://lore.kernel.org/lkml/20210818044252.1533634-1-keescook@chromium.org/
https://lore.kernel.org/lkml/20210818043912.1466447-1-keescook@chromium.org/

I figure I can take this via my "overflow" series, or it could go via
-mm?

-Kees

Kees Cook (5):
  Compiler Attributes: Add __alloc_size() for better bounds checking
  slab: Add __alloc_size attributes for better bounds checking
  mm/page_alloc: Add __alloc_size attributes for better bounds checking
  percpu: Add __alloc_size attributes for better bounds checking
  mm/vmalloc: Add __alloc_size attributes for better bounds checking

 Makefile                            |  6 +++-
 include/linux/compiler_attributes.h |  6 ++++
 include/linux/gfp.h                 |  4 +--
 include/linux/percpu.h              |  6 ++--
 include/linux/slab.h                | 50 ++++++++++++++++++-----------
 include/linux/vmalloc.h             | 22 ++++++-------
 6 files changed, 58 insertions(+), 36 deletions(-)

-- 
2.30.2

