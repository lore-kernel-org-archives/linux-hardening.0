Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E776AC4332F
	for <linux-hardening@archiver.kernel.org>; Thu, 17 Nov 2022 23:43:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240076AbiKQXng (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Thu, 17 Nov 2022 18:43:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235094AbiKQXnc (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Thu, 17 Nov 2022 18:43:32 -0500
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com [IPv6:2607:f8b0:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A07687644
        for <linux-hardening@vger.kernel.org>; Thu, 17 Nov 2022 15:43:30 -0800 (PST)
Received: by mail-pg1-x534.google.com with SMTP id o13so3516039pgu.7
        for <linux-hardening@vger.kernel.org>; Thu, 17 Nov 2022 15:43:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=LQKoNHkwXKQHXK1Rm3137rvxsN3jeB7ychTw9wiMCoA=;
        b=gzgQ67tGphKg9LC8dXQMsOdp6988Jh6y4uQ4wq39wUd2vtbr/8gxP0dLkj/cYJSQfU
         oJVP225UVvh8eZGzkuRft1/5qPdhlpTQCB04Dhk8Pza+YxTN6AkGI7wxVQ888beABqKJ
         7xM3YRAsM7rHhiSI+nNyQa/rVKea7ZVGyyzy8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LQKoNHkwXKQHXK1Rm3137rvxsN3jeB7ychTw9wiMCoA=;
        b=PKgmEFcW37CctHV5RWFzcnFOD50COeiSKguRSVTdLcxw7ds1Y3oULyF2Vf3lIm0P6X
         p2raf8k/L4hYkKkxpgjzZF9VydqpHN/Yj+0AtNopEUGoxrsvYy+Ez9LhjH7/+XwKQDH8
         QAxzWyrlC71geDG29bLhqku1B15fGR84b1naePWhjTsvzBS/fzZQem7+Y+FD9elCmmbq
         kSOdWXAhojv9lkXkahHC7IroZe7NsjmA35vLdZ52wOHrqaPAlMqg6LNrWG3DBWtEH8W8
         tO5qSqusIq2BSQ8N3QxXJBwijGohI9GJ01iY3QUdkaRWw0sQfYXxpDKQtP6AaFbA4wXX
         UWqw==
X-Gm-Message-State: ANoB5pnu9Ni4Mc9DLm+cI2Q0uYZ1wfCBDxPh/7qCxtI95tE4CQyHw7by
        58aNJSuGvHGYGccI5f++ayi2uA==
X-Google-Smtp-Source: AA0mqf4dMrpHROtIgMnip0OIwSGPEYdtdDWFsBd6CpaiKHR5PBA7FaDdD8tvh8Nw0f5yBbrJCuHeXA==
X-Received: by 2002:a63:3d8:0:b0:476:eee6:d394 with SMTP id 207-20020a6303d8000000b00476eee6d394mr4235676pgd.228.1668728610079;
        Thu, 17 Nov 2022 15:43:30 -0800 (PST)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id o9-20020a655bc9000000b004582e25a595sm1614221pgr.41.2022.11.17.15.43.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Nov 2022 15:43:29 -0800 (PST)
From:   Kees Cook <keescook@chromium.org>
To:     Jann Horn <jannh@google.com>
Cc:     Kees Cook <keescook@chromium.org>,
        Seth Jenkins <sethjenkins@google.com>,
        Greg KH <gregkh@linuxfoundation.org>,
        Linus Torvalds <torvalds@linuxfoundation.org>,
        Andy Lutomirski <luto@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        tangmeng <tangmeng@uniontech.com>,
        "Guilherme G. Piccoli" <gpiccoli@igalia.com>,
        Tiezhu Yang <yangtiezhu@loongson.cn>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Dmitry Vyukov <dvyukov@google.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Valentin Schneider <vschneid@redhat.com>,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        Alexander Potapenko <glider@google.com>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        David Gow <davidgow@google.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Eric Biggers <ebiggers@google.com>,
        Huang Ying <ying.huang@intel.com>,
        Anton Vorontsov <anton@enomsg.org>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Laurent Dufour <ldufour@linux.ibm.com>,
        Rob Herring <robh@kernel.org>, linux-kernel@vger.kernel.org,
        kasan-dev@googlegroups.com, linux-mm@kvack.org,
        linux-doc@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: [PATCH v3 0/6] exit: Put an upper limit on how often we can oops
Date:   Thu, 17 Nov 2022 15:43:20 -0800
Message-Id: <20221117233838.give.484-kees@kernel.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1558; h=from:subject:message-id; bh=Mevv31fJaznFTh44cD9Wkn2q46wN2KwgT2JblND2tEw=; b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBjdsccuB5/7Dud9dthXxlatod2tm4x+MLt8lSkzhG8 v6L92dWJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCY3bHHAAKCRCJcvTf3G3AJuVdD/ 0eNAawmC+gMqkT2rEKRxW1q1K4WlSNG660mYF+W/EAMANgbt6w31eLw4F1zcWZUz+34y5smj0BBaCU y5rzvHB47A7fuA9hXjcwb8TuxsSnjq3pkDquhBH7Y3KFkj90GGVkL/Mh9gVP+uOLjCYvc48iwOt2eG YHZ/y3jAgGhcr2jxeAYCwOwalTeHyyCeurbdvX7Oq+a45aPDWcVfffZbFVfHn8DxxTVcNQ7N/628uE z2kYsHca4qJwFAzPpArSYyVloSVtbEW5ckjt+Iq6kLO3u+oTgu+PvJpLJ9F8bnjbFIklvAwkomHvfV fixggchvSkevDB43e+wQvPrcKfiNN71mlbGfuMLs2VVFuzNQUGAZXRhHR3lwG9UIaNDuCzzxa1UWr9 3ktCososbPal1YX12fJhSFl8vzBMk7JLQEbTTHcYUAbjWHdpNJodiID252O9pAdmG1E9muAIZGy4qC tcH0IouHdUSPs2DP9Y16vdrEMok25wZU7rIjZ0VxdtGIMrgiqMZmxweeRnhXSgy/HFG+1IXtXgb9Ir Ro+U3RGzEYBu6Wklay2Dr6Gca6606I6a51/zw0fPXanLvL+dGU0ZHeXbx7SaSYZ0n2zPaL+1ET1p19 gLeTIC7R+E3l0BJ0ilq4VBoffYDaepF8i1hdfUaDnHhkEMaoDGmjbuFOnslg==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

Hi,

This builds on Jann's v1 patch[1]. Changes in v3:
- fix #if/#ifdef confusion (Bill)
- rename from "reason" or "origin" and add it to the warn output (Marco)

v2: https://lore.kernel.org/lkml/20221109194404.gonna.558-kees@kernel.org/

Thanks,

-Kees

[1] https://lore.kernel.org/lkml/20221107201317.324457-1-jannh@google.com

Jann Horn (1):
  exit: Put an upper limit on how often we can oops

Kees Cook (5):
  panic: Separate sysctl logic from CONFIG_SMP
  exit: Expose "oops_count" to sysfs
  panic: Consolidate open-coded panic_on_warn checks
  panic: Introduce warn_limit
  panic: Expose "warn_count" to sysfs

 .../ABI/testing/sysfs-kernel-oops_count       |  6 ++
 .../ABI/testing/sysfs-kernel-warn_count       |  6 ++
 Documentation/admin-guide/sysctl/kernel.rst   | 17 ++++++
 MAINTAINERS                                   |  2 +
 include/linux/panic.h                         |  1 +
 kernel/exit.c                                 | 60 +++++++++++++++++++
 kernel/kcsan/report.c                         |  3 +-
 kernel/panic.c                                | 45 +++++++++++++-
 kernel/sched/core.c                           |  3 +-
 lib/ubsan.c                                   |  3 +-
 mm/kasan/report.c                             |  4 +-
 mm/kfence/report.c                            |  3 +-
 12 files changed, 140 insertions(+), 13 deletions(-)
 create mode 100644 Documentation/ABI/testing/sysfs-kernel-oops_count
 create mode 100644 Documentation/ABI/testing/sysfs-kernel-warn_count

-- 
2.34.1

