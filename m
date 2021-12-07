Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0B75C433F5
	for <linux-hardening@archiver.kernel.org>; Tue,  7 Dec 2021 01:54:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236354AbhLGB6A (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Mon, 6 Dec 2021 20:58:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236471AbhLGB54 (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Mon, 6 Dec 2021 20:57:56 -0500
Received: from mail-io1-xd2b.google.com (mail-io1-xd2b.google.com [IPv6:2607:f8b0:4864:20::d2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FDC5C0613F8
        for <linux-hardening@vger.kernel.org>; Mon,  6 Dec 2021 17:54:27 -0800 (PST)
Received: by mail-io1-xd2b.google.com with SMTP id q72so10603057iod.12
        for <linux-hardening@vger.kernel.org>; Mon, 06 Dec 2021 17:54:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8GCfs3UIWYheIdOcXQxitSGok4TtBWFHvnOhGvwh4LU=;
        b=EJPgQEgeubJfZbHmJT+ml4muCB9PM20VpdG8wGJniHE0bGeY3FD0kxAK49lCQDtaN/
         c9RubZAQFKlfJft+x9GcWe2k8R4GLCJw8aC+uWAZujXFa+FQ2OHp6/GVBGyMoeDyOaxh
         YbQgyFIGjS0Kv9cK2z8rBcaH5o950iDBlH4BPFCdBi8Y/z4n6uAQQXyXln5423emXYaY
         WXtWlcablEGXFLzbJzWiKvlmC7bWD756LZ/7FPR/+YyEin0MNq45sHiiSHH3DKg9Bhuu
         IGOkO2r0avMCnseKZx7Gu8jEZ3D5IIVeT0tRml2C3G6f6cRQPz7nqLWuEntfYpz2S1TK
         l2VQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8GCfs3UIWYheIdOcXQxitSGok4TtBWFHvnOhGvwh4LU=;
        b=Xbpmbc/UK5Be0iZr03Rd6RgJblz8JIdI0txurFKkBjmVhHGdOps+qnjte/sz/jzlIR
         sPcuvCHge68R7774FsrsnQdR0Ips2NK60KQ2PW7kd0fqg5cTappG+t8TrgpAW6sWz6wW
         v55Zylec9TdTxgUqQGrfBxHpClf/3idytyp4o+fd0OqQP30ntZ1y8+6oRsjrUewIqDIj
         2BtF+F8Mngmnz8L07gvG5S9gKe3OA3f3Hc0AYNVb2kVDfXXj09z0/xnutY2GM1Zs327U
         1tLIpMGiKFGPxRs0bweAvR2QiIVYbAQwB0AfAz1JKGY0QmXq2AdewsDiDE00pf3M7zEt
         71kg==
X-Gm-Message-State: AOAM5305BEfrUGJVIB2vnjTe3hvUMGXKLeYurGUY0SU2SZBxrmFCLmRe
        zsX7OKtz+RkgeXFnOG0VSXwxshH72rbBALoXM+85Ug==
X-Google-Smtp-Source: ABdhPJyQjwGuVEpanwRxhs05NMKibfDWQCJJpGsPeH8foH3M53khXDQmMTwCV/a+WLqELyEiS/7cVz+m5Tuka3bF1/w=
X-Received: by 2002:a6b:ea0a:: with SMTP id m10mr36636252ioc.91.1638842066584;
 Mon, 06 Dec 2021 17:54:26 -0800 (PST)
MIME-Version: 1.0
References: <20211203065647.2819707-1-keescook@chromium.org>
In-Reply-To: <20211203065647.2819707-1-keescook@chromium.org>
From:   Mina Almasry <almasrymina@google.com>
Date:   Mon, 6 Dec 2021 17:54:15 -0800
Message-ID: <CAHS8izMqjZqK9h42pXaAxfD=Spdwem8PEAgErDhXSBtLBO8eCA@mail.gmail.com>
Subject: Re: [PATCH] hugetlb/cgroup: Fix copy/paste array assignment
To:     Kees Cook <keescook@chromium.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Shakeel Butt <shakeelb@google.com>,
        Muchun Song <songmuchun@bytedance.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Thu, Dec 2, 2021 at 10:56 PM Kees Cook <keescook@chromium.org> wrote:
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

Sorry about that and thanks for the fix!

Reviewed-by: Mina Almasry <almasrymina@google.com>

> ---
>  mm/hugetlb_cgroup.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/mm/hugetlb_cgroup.c b/mm/hugetlb_cgroup.c
> index 9eebe8df3c39..f9942841df18 100644
> --- a/mm/hugetlb_cgroup.c
> +++ b/mm/hugetlb_cgroup.c
> @@ -847,7 +847,7 @@ static void __init __hugetlb_cgroup_file_legacy_init(int idx)
>         cft->read_u64 = hugetlb_cgroup_read_u64;
>
>         /* Add the numa stat file */
> -       cft = &h->cgroup_files_dfl[8];
> +       cft = &h->cgroup_files_legacy[8];
>         snprintf(cft->name, MAX_CFTYPE_NAME, "%s.numa_stat", buf);
>         cft->private = MEMFILE_PRIVATE(idx, 1);
>         cft->seq_show = hugetlb_cgroup_read_numa_stat;
> --
> 2.30.2
>
