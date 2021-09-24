Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7CFCC4332F
	for <linux-hardening@archiver.kernel.org>; Fri, 24 Sep 2021 06:21:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8935C60F24
	for <linux-hardening@archiver.kernel.org>; Fri, 24 Sep 2021 06:21:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244174AbhIXGXA (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Fri, 24 Sep 2021 02:23:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244223AbhIXGW4 (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Fri, 24 Sep 2021 02:22:56 -0400
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11C5FC061766
        for <linux-hardening@vger.kernel.org>; Thu, 23 Sep 2021 23:20:18 -0700 (PDT)
Received: by mail-pj1-x1036.google.com with SMTP id v19so6272719pjh.2
        for <linux-hardening@vger.kernel.org>; Thu, 23 Sep 2021 23:20:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=9E61IiyqgiZPaQ5JJt6jJisXsJdnb9CqQdu3yqoxd4A=;
        b=AWIHemkSpytiKoDQuMt0bk70vLDCuuEJLfSgudJrCpJhtrJXdrDr+ZwSgl744x4Hg3
         dHIlEF0ZNA7uNCssBkg8L3aitThERp2uGivOCFH1hnnQEGyo18gMAWZdeQwr0tLnV+oz
         PzOb1AGm7eax7V3o9lPUw/l/Odd+emKx092gw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=9E61IiyqgiZPaQ5JJt6jJisXsJdnb9CqQdu3yqoxd4A=;
        b=3qR8/0PDM+wNSpuvT1PICEsBKT4IZB/dY2RG6te1+JHCfVvK2u6RcQp4doj5c03pJI
         N2Ltj0aO/SXtD4JlFm2/7p7N+ZnZxM3lXXQaMJLqOnvsJARK9JgWvreMrayPmOrr2vfj
         x9lqL9Kh9I7m6dToBVbOC2L++o/rudaOxuOO92xQl7EUyC6hDGAal/+e6kAN2+ic4htm
         l2ckVMSv5eLomqDxdMXLJAYJPEgz2Xr38s0sb69+bgnCiu2pPVJwI7a8qhhdNJMt/rTr
         y8uCEdyN2qfHijfgqgP9ETMCmU/CkvgzelsHrhUpnxJzPkV12Ow1aoymGdCPua0bPqZZ
         P2Mg==
X-Gm-Message-State: AOAM531mtEf0qr6+VVsWVqttldYOMYxHTZy971ji4H22WD7iS/oEmz5R
        RW/j5tnOtJzqAMw8x3iSdg9cfQ==
X-Google-Smtp-Source: ABdhPJxdjM/pdKrwDeH1cRvSEy6UIRuGKTcUaReJTf/KTS7/Xa1s9swqpPinqm53J5IBEjEq19dMIQ==
X-Received: by 2002:a17:90a:307:: with SMTP id 7mr264729pje.176.1632464417534;
        Thu, 23 Sep 2021 23:20:17 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id h15sm7514075pjg.34.2021.09.23.23.20.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Sep 2021 23:20:16 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Kees Cook <keescook@chromium.org>, Helge Deller <deller@gmx.de>,
        Qi Zheng <zhengqi.arch@bytedance.com>,
        Vito Caputo <vcaputo@pengaru.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Jann Horn <jannh@google.com>, "Tobin C. Harding" <me@tobin.cc>,
        Tycho Andersen <tycho@tycho.pizza>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Jens Axboe <axboe@kernel.dk>,
        Peter Zijlstra <peterz@infradead.org>,
        Andy Lutomirski <luto@kernel.org>,
        Lai Jiangshan <laijs@linux.alibaba.com>,
        Stefan Metzmacher <metze@samba.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Michal Hocko <mhocko@suse.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Ohhoon Kwon <ohoono.kwon@samsung.com>,
        YiFei Zhu <yifeifz2@illinois.edu>,
        kernel test robot <oliver.sang@intel.com>,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        linux-hardening@vger.kernel.org, x86@kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: [PATCH 0/3] wchan: Fix ORC support and leaky fallback
Date:   Thu, 23 Sep 2021 23:20:03 -0700
Message-Id: <20210924062006.231699-1-keescook@chromium.org>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1249; h=from:subject; bh=EkIFdSXrni/R95qUfVOdnHiIj8PFLD2xTnJNuxRh/Xk=; b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBhTW4VRi6us9GloPeIwWDEwIiriKVsZmkkQ3LYCiBc Zy1t2qKJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCYU1uFQAKCRCJcvTf3G3AJjfqD/ 4z/hR0oCM68S4lK8ulzNT+IQlp1PUKQ00cMJmcNdGtfuA16BW8To+1IwE0oqoNkVYBWQiWbAZitW1R NNdU55kkvliyD93/yATgTDkOKDB+tPvc5wpJhualWs5rxO5TGGmE1qFM36Iy+2c/0xGJV7PnjZl8zy 4ZVjnFc0yi6/o4jqg9umcPV0H3xDKew0oGRai5hB8Q7Mlax8xbgmwfiDL28j3WAQs/RbZ5DBt8QVsh P6vHhJ1vaFKMMXXUGU8qea+ZFDLKjOWlhBv8xQZRWPYXGtnb6N1md/od0YqBgBPw8so1usRoQsqAzU kj1LRm65I010NWTpfLQtxiorWhmobP1YD+Tzm9HFslUqX1rrqRBi8eKTcfcV8k8h0kmfDRaTXqXUX6 JG6O+Z8s25n0ehhMHCik/d9TRwSTl9TxmjSd0hzYaQ8OREIOKEzBXyDtV8cr0glmsJql+aSRtYWHX/ C2x9ukf2UN3rEo+8x4RjBP1DAwAQbsNmK/uvA2a23pqrMdF+H6gtPy3aZk5fUgMpZPc2maHGI4/pnJ w0zWy7N12EgZjKr79lBkXFJNNyVGHgrIyQpjoJqsvkXZwBcpspOAZ5PJMF4Q4W1gPh04GibcGV/Ire BtzOQ6CmnASETFbbGlMFWRvll6XMQ2atsGfLUwpXZ+82tLedWplcQ5oMv/DQ==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

Hi,

This attempts to solve the issues from the discussion
here[1]. Specifically:

1) wchan has been broken under ORC, seen as a failure to stack walk
   resulting in _usually_ a 0 value, since ee9f8fce9964 (v4.14).

2) wchan leaking raw addresses since 152c432b128c (v5.12).

Based on what I can see in the stack walking code, the fix should be
safe. Jann may have more thoughts, but from what I can see, the walker
pins the stack, decodes only a single step, etc.

I'd like Josh's review of Qi Zheng's patch, though. :)

It's also not clear to me what impact this had on kernel/sched/fair.c:
it would have also been seeing 0s, so this may be fixing a bug there too.

Thanks!

-Kees

[1] https://lore.kernel.org/lkml/20210924054647.v6x6risoa4jhuu6s@shells.gnugeneration.com/

Kees Cook (2):
  Revert "proc/wchan: use printk format instead of lookup_symbol_name()"
  leaking_addresses: Always print a trailing newline

Qi Zheng (1):
  x86: Fix get_wchan() to support the ORC unwinder

 arch/x86/kernel/process.c    | 51 +++---------------------------------
 fs/proc/base.c               | 19 ++++++++------
 scripts/leaking_addresses.pl |  3 ++-
 3 files changed, 16 insertions(+), 57 deletions(-)

-- 
2.30.2

