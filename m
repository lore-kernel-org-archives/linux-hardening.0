Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68212C433EF
	for <linux-hardening@archiver.kernel.org>; Thu, 21 Oct 2021 15:49:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 51C5460D42
	for <linux-hardening@archiver.kernel.org>; Thu, 21 Oct 2021 15:49:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230020AbhJUPvY (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Thu, 21 Oct 2021 11:51:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229702AbhJUPvX (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Thu, 21 Oct 2021 11:51:23 -0400
Received: from mail-ot1-x336.google.com (mail-ot1-x336.google.com [IPv6:2607:f8b0:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E30BEC061764
        for <linux-hardening@vger.kernel.org>; Thu, 21 Oct 2021 08:49:07 -0700 (PDT)
Received: by mail-ot1-x336.google.com with SMTP id e59-20020a9d01c1000000b00552c91a99f7so948122ote.6
        for <linux-hardening@vger.kernel.org>; Thu, 21 Oct 2021 08:49:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=g1iz+y2dgT4TyThdM3O09sVwf0lSDECVVm+U/8Y6eTE=;
        b=jiZK/wFzK96ej7OXvoXKuDbR9LrNxtZ0F86w5NqUywmSjSFdxHqliBrYwFEWbvXvBR
         OGk5w62oA27aoXI2675nUOy5DmnL2kvxzJOdDaWir0VN1IEBemEZED1hVfNZsK5wLOFC
         nYGUlxGr6jmsH386aiQCvvvIXT3Zmm2elb29BuwHhPUBmg26tTuNGVW12yujTTci35IZ
         XuywA4T9UEo3+Ng5N5gEgcdv6uT6KJcHMCD7yDsietoJK/GAc56utQssoQo4Oy5bDMUN
         TjokMSHKrhs0wEO2zVNW7G2u9n8Z98J+HAM7mk7D3y1zrzvDZAO6cpssdE3VIabva/D3
         r3Tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=g1iz+y2dgT4TyThdM3O09sVwf0lSDECVVm+U/8Y6eTE=;
        b=lQgjsNGpcYqD2blK3uj46SmVh4DzDs25sfjO6LXaK7Jb2cJ0lu5e/FJ92VZMWbrCN2
         eAi8aDVDvOW87n6A24eMdbWJvWvUCxWN+mx1vzAk9dKzNWZvgWV4HF1L65p95VMLx0My
         AN2eI0FeZ5RcdNULHMfHes8UQmK2DCvInhoNO0nCRhLKdh0YYosWzGh9fb75mi+i1LtD
         hc4gwfk8MOldCf3zF6jNul4KNkOxy+lmrAsL1y1Z2aDzLe+YxRMzPS0Hpr0XPa+KoTL6
         kivD0VYH5C0yfwtTqRNZv7wCcNd8ZcPAEJZ7bpXxNFSLhSfV+3zLgo6xKusHSsQGCNR+
         WMdw==
X-Gm-Message-State: AOAM532xuPGXS/E4ABKzI6L/yfn4GWpT/7FNko/8Un7G9Z/FPQ0Lt9J0
        uvLdq8X3OQqOjyjrQOgYKHXbAT+vQJteWMoXUmfwqw==
X-Google-Smtp-Source: ABdhPJzlHe8TmehB9EEpiwMyaSxAhGtHJlvCjHGlEUUQSwcnY0Ws2wHLbz53bzBtkpVStYOopOQfS/KLWNBMHCQQZ1I=
X-Received: by 2002:a9d:3c3:: with SMTP id f61mr5244045otf.196.1634831347026;
 Thu, 21 Oct 2021 08:49:07 -0700 (PDT)
MIME-Version: 1.0
References: <20211021154046.880251-1-keescook@chromium.org>
In-Reply-To: <20211021154046.880251-1-keescook@chromium.org>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Thu, 21 Oct 2021 17:48:55 +0200
Message-ID: <CACT4Y+YxOynnn1DPUe_7HE_Dc+302YnhnO0a8awqG0rSV9-JMw@mail.gmail.com>
Subject: Re: [PATCH] mm/secretmem: Avoid letting secretmem_users drop to zero
To:     Kees Cook <keescook@chromium.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Mike Rapoport <rppt@kernel.org>,
        Jordy Zomer <jordy@pwning.systems>, linux-mm@kvack.org,
        James Bottomley <james.bottomley@hansenpartnership.com>,
        David Hildenbrand <david@redhat.com>,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Thu, 21 Oct 2021 at 17:40, Kees Cook <keescook@chromium.org> wrote:
>
> Quoting Dmitry: "refcount_inc() needs to be done before fd_install().
> After fd_install() finishes, the fd can be used by userspace and we can
> have secret data in memory before the refcount_inc().
>
> A straightforward mis-use where a user will predict the returned fd
> in another thread before the syscall returns and will use it to store
> secret data is somewhat dubious because such a user just shoots themself
> in the foot.
>
> But a more interesting mis-use would be to close the predicted fd and
> decrement the refcount before the corresponding refcount_inc, this way
> one can briefly drop the refcount to zero while there are other users
> of secretmem."
>
> Move fd_install() after refcount_inc().
>
> Cc: Mike Rapoport <rppt@kernel.org>
> Cc: Jordy Zomer <jordy@pwning.systems>
> Cc: linux-mm@kvack.org
> Reported-by: Dmitry Vyukov <dvyukov@google.com>
> Link: https://lore.kernel.org/lkml/CACT4Y+b1sW6-Hkn8HQYw_SsT7X3tp-CJNh2ci0wG3ZnQz9jjig@mail.gmail.com
> Fixes: 9a436f8ff631 ("PM: hibernate: disable when there are active secretmem users")
> Signed-off-by: Kees Cook <keescook@chromium.org>

Reviewed-by: Dmitry Vyukov <dvyukov@google.com>

> ---
>  mm/secretmem.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/mm/secretmem.c b/mm/secretmem.c
> index 1fea68b8d5a6..924d84ba481f 100644
> --- a/mm/secretmem.c
> +++ b/mm/secretmem.c
> @@ -217,8 +217,8 @@ SYSCALL_DEFINE1(memfd_secret, unsigned int, flags)
>
>         file->f_flags |= O_LARGEFILE;
>
> -       fd_install(fd, file);
>         refcount_inc(&secretmem_users);
> +       fd_install(fd, file);
>         return fd;
>
>  err_put_fd:
> --
> 2.30.2
>
