Return-Path: <linux-hardening-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCC06EE6458
	for <linux-hardening@archiver.kernel.org>; Fri, 15 Sep 2023 10:59:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233589AbjIOK7n (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Fri, 15 Sep 2023 06:59:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231997AbjIOK7n (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Fri, 15 Sep 2023 06:59:43 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50772D3
        for <linux-hardening@vger.kernel.org>; Fri, 15 Sep 2023 03:59:37 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id 3f1490d57ef6-d818fb959f4so2062164276.1
        for <linux-hardening@vger.kernel.org>; Fri, 15 Sep 2023 03:59:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1694775576; x=1695380376; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Q96e0kuVpLqyiXurRtzULT7V48+oh0KsDqb/+UWKHpA=;
        b=mgh954mDu+rnYiMNpcqUCnwHvsCdynxhQlIIl0NkcZZTdwonts1YFXVdwrTNQCXcYn
         Uijsw258odlFnL9gBrMHEUxqJItL6ApUdS8LSyVkA4v1x8nikhpTFPvaT4DDnZ53nXUz
         mP8hOEc4O7t4SxmvX1peVzPT9BzPrNdQCNI0DRlVb963UG8rUSFm0JSm6vMT6TsdCTOA
         SVg3xRPlS7q+hnLJI+Ayu4A+ZHOWVzeHBMRjU3Ky54t87pUW7GRvbRsPJUSJ9h3UC+8l
         0z2c8dHsq3bJvkYAwllxXO1D+gPaLsBiIAUqw8maeGfYbUr/ZXGPZ4urxZbnWCmClLCc
         1ASA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694775576; x=1695380376;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Q96e0kuVpLqyiXurRtzULT7V48+oh0KsDqb/+UWKHpA=;
        b=TAMKDt7MRBlWqQ8GNqI2vgWTwQMD1Tr0A+wZCCW/bVI51lEB7WIHoMJi56/XzHkgxb
         bpkTAcaeuqCq62sJifmokmCcwUcWjTfsQsDupP5M7J3yrOPR86ldoyXhrRNcsfAd+1R2
         wiILek1Xm2I8Hy17/MQdCHJwsmWUCu0d8tMhVHINroAelDJzwMmYJ/JdC6cmAl1eAham
         ssZh5V7vNT5CC2cOWtjpIYXX1b5QRYkRFx9dvrCvwYjjc157XeQ34hUI0rRIyY+ohDsH
         eKM/O5lAZrZ7CNcluaPksE3YCYLVAoV8rk1BFvhpT/NOyKaoY8W4D8Nwpw88M5U79dgD
         MkRg==
X-Gm-Message-State: AOJu0Yy/LsWDpSQfQY1nmDXw+WidPMazHvlAwsaoMReIG1XjbLlM2JBC
        lpV7szH2hqEQn3RxowwhSuZz9TcyksGxzQvuaA==
X-Google-Smtp-Source: AGHT+IHAyZPRW+fz+wnC0QC2qAdXCfzyFvGgBvbmyG39sCaHUeo74IY504gFakd9PexJNIP9aoIzA1MrdwDX3eg0tA==
X-Received: from mr-cloudtop2.c.googlers.com ([fda3:e722:ac3:cc00:31:98fb:c0a8:2a6])
 (user=matteorizzo job=sendgmr) by 2002:a25:aa6c:0:b0:d7e:a025:2672 with SMTP
 id s99-20020a25aa6c000000b00d7ea0252672mr23125ybi.9.1694775576481; Fri, 15
 Sep 2023 03:59:36 -0700 (PDT)
Date:   Fri, 15 Sep 2023 10:59:19 +0000
Mime-Version: 1.0
X-Mailer: git-send-email 2.42.0.459.ge4e396fd5e-goog
Message-ID: <20230915105933.495735-1-matteorizzo@google.com>
Subject: [RFC PATCH 00/14] Prevent cross-cache attacks in the SLUB allocator
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

The goal of this patch series is to deterministically prevent cross-cache
attacks in the SLUB allocator.

Use-after-free bugs are normally exploited by making the memory allocator
reuse the victim object's memory for an object with a different type. This
creates a type confusion which is a very powerful attack primitive.

There are generally two ways to create such type confusions in the kernel:
one way is to make SLUB reuse the freed object's address for another object
of a different type which lives in the same slab cache. This only works in
slab caches that can contain objects of different types (i.e. the kmalloc
caches) and the attacker is limited to objects that belong to the same size
class as the victim object.

The other way is to use a "cross-cache attack": make SLUB return the page
containing the victim object to the page allocator and then make it use the
same page for a different slab cache or other objects that contain
attacker-controlled data. This gives attackers access to all objects rather
than just the ones in the same size class as the target and lets attackers
target objects allocated from dedicated caches such as struct file.

This patch prevents cross-cache attacks by making sure that once a virtual
address is used for a slab cache it's never reused for anything except for
other slabs in that cache.


Jann Horn (13):
  mm/slub: add is_slab_addr/is_slab_page helpers
  mm/slub: move kmem_cache_order_objects to slab.h
  mm: use virt_to_slab instead of folio_slab
  mm/slub: create folio_set/clear_slab helpers
  mm/slub: pass additional args to alloc_slab_page
  mm/slub: pass slab pointer to the freeptr decode helper
  security: introduce CONFIG_SLAB_VIRTUAL
  mm/slub: add the slab freelists to kmem_cache
  x86: Create virtual memory region for SLUB
  mm/slub: allocate slabs from virtual memory
  mm/slub: introduce the deallocated_pages sysfs attribute
  mm/slub: sanity-check freepointers
  security: add documentation for SLAB_VIRTUAL

Matteo Rizzo (1):
  mm/slub: don't try to dereference invalid freepointers

 Documentation/arch/x86/x86_64/mm.rst       |   4 +-
 Documentation/security/self-protection.rst | 102 ++++
 arch/x86/include/asm/page_64.h             |  10 +
 arch/x86/include/asm/pgtable_64_types.h    |  21 +
 arch/x86/mm/init_64.c                      |  19 +-
 arch/x86/mm/kaslr.c                        |   9 +
 arch/x86/mm/mm_internal.h                  |   4 +
 arch/x86/mm/physaddr.c                     |  10 +
 include/linux/slab.h                       |   8 +
 include/linux/slub_def.h                   |  25 +-
 init/main.c                                |   1 +
 kernel/resource.c                          |   2 +-
 lib/slub_kunit.c                           |   4 +
 mm/memcontrol.c                            |   2 +-
 mm/slab.h                                  | 145 +++++
 mm/slab_common.c                           |  21 +-
 mm/slub.c                                  | 641 +++++++++++++++++++--
 mm/usercopy.c                              |  12 +-
 security/Kconfig.hardening                 |  16 +
 19 files changed, 977 insertions(+), 79 deletions(-)


base-commit: 46a9ea6681907a3be6b6b0d43776dccc62cad6cf
-- 
2.42.0.459.ge4e396fd5e-goog

