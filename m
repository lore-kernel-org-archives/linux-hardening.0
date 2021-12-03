Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85696C433EF
	for <linux-hardening@archiver.kernel.org>; Fri,  3 Dec 2021 07:44:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350889AbhLCHrm (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Fri, 3 Dec 2021 02:47:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351036AbhLCHrk (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Fri, 3 Dec 2021 02:47:40 -0500
Received: from mail-yb1-xb29.google.com (mail-yb1-xb29.google.com [IPv6:2607:f8b0:4864:20::b29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BE10C061758
        for <linux-hardening@vger.kernel.org>; Thu,  2 Dec 2021 23:44:17 -0800 (PST)
Received: by mail-yb1-xb29.google.com with SMTP id f186so6874127ybg.2
        for <linux-hardening@vger.kernel.org>; Thu, 02 Dec 2021 23:44:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=UAVL9gAJ9L8uH+kEA+xjZGKt7HfdI9ctRFtotrW3lBk=;
        b=ib9GmhM7RHt8aAYLVx/Kgn+4sCphD+hO/mq/WH0eps59vJyGA040zGmkt/I2f5wNQO
         q/7qoqL35jF7fImXFJzFCwzsCNAc2I/2epM3ycQjb1OdNc7cW6+emTFAKT5uXZuSTiiE
         LJTQR7ejxp7GMzSCTW5frYCpBvLB0VwVMRoEjogXzKQf5hbqpMZxwhYuOqxhHM5/S33k
         kllBkKI8wNTHL4/PmqMCMNyYqAyg9N8oVxDtKeNUMSpThIIoHhB/yWr5HYgDulgMHCpR
         UEzBcf7JpUqB73tkeKA+hxjkpNjuv9+FIlvPI9bVjLmrUecmIGuWNKniRrHNF5l0JR6K
         P+fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=UAVL9gAJ9L8uH+kEA+xjZGKt7HfdI9ctRFtotrW3lBk=;
        b=HP3thiy4lf56YIqUJpLecAnXxGJ+1h0b2Ozgk6rbkXzk2Ro0T5dkx8XaGg3psCbm5T
         5TbpEqUzEtWMsdImlAR73WmgnyavFsXnIp567c3cWc10p7IFFWblKirtArUkbzNnSztw
         bzBVdeyflkonCzFhpFLjXiUULvUxzQq+iraRVH9gMo2/N7xYuAdudeCKSUk9d2L61ir0
         K7IQYpJh7XagGqpsmpev3PnI8hxPShx0HWqOecqJ92e3p7LzL36oqGbTjxq9JLRSErUG
         D6fgiKLhTJ8J2zwEoVSXjnqD8t9ZYM41G7tC5c2MBMXOsJrOCH+/KKfmpcyd4jWZqrcW
         irhA==
X-Gm-Message-State: AOAM531Jc/+dZaAtRF2QRaUJcrxk2qZqQdXTJfGw+Gzyv6+SpTIH2EfR
        dugNbHdgbXVCR3/kkfdd+znGJ699xmZ0KZpcCAPUhQ==
X-Google-Smtp-Source: ABdhPJyU7RtgdFpAiVz5xqahn/qyuv+79mBq3j9EZn5MJCyqHFBNnd+/EJH7t6ORkJIAzd+WWu3ypyX5expzKX/cRug=
X-Received: by 2002:a25:d685:: with SMTP id n127mr20888122ybg.523.1638517456254;
 Thu, 02 Dec 2021 23:44:16 -0800 (PST)
MIME-Version: 1.0
References: <20211203065647.2819707-1-keescook@chromium.org>
In-Reply-To: <20211203065647.2819707-1-keescook@chromium.org>
From:   Muchun Song <songmuchun@bytedance.com>
Date:   Fri, 3 Dec 2021 15:43:37 +0800
Message-ID: <CAMZfGtX-V35SbUJ6BE7Psa6dqrbcoyP9ABcjroAn_bO8rQ-6wg@mail.gmail.com>
Subject: Re: [PATCH] hugetlb/cgroup: Fix copy/paste array assignment
To:     Kees Cook <keescook@chromium.org>
Cc:     Mina Almasry <almasrymina@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Shakeel Butt <shakeelb@google.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Fri, Dec 3, 2021 at 2:56 PM Kees Cook <keescook@chromium.org> wrote:
>
> Fix mismatched array assignment, reported by an -Warray-bounds build:
>
> mm/hugetlb_cgroup.c: In function '__hugetlb_cgroup_file_legacy_init':
> mm/hugetlb_cgroup.c:850:35: error: array subscript 8 is above array bounds of 'struct cftype[8]' [-Werror=array-bounds ]
>   850 |         cft = &h->cgroup_files_dfl[8];
>       |                ~~~~~~~~~~~~~~~~~~~^~~
> In file included from mm/hugetlb_cgroup.c:23:
> ./include/linux/hugetlb.h:625:23: note: while referencing 'cgroup_files_dfl'
>   625 |         struct cftype cgroup_files_dfl[8];
>       |                       ^~~~~~~~~~~~~~~~
>
> Fixes: e45f4726bcad ("hugetlb: add hugetlb.*.numa_stat file")
> Signed-off-by: Kees Cook <keescook@chromium.org>

Reviewed-by: Muchun Song <songmuchun@bytedance.com>

Thanks.
