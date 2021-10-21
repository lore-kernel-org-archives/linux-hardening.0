Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58BB1C433F5
	for <linux-hardening@archiver.kernel.org>; Thu, 21 Oct 2021 16:47:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3D2F360FD8
	for <linux-hardening@archiver.kernel.org>; Thu, 21 Oct 2021 16:47:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232041AbhJUQuB (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Thu, 21 Oct 2021 12:50:01 -0400
Received: from h2.fbrelay.privateemail.com ([131.153.2.43]:35905 "EHLO
        h2.fbrelay.privateemail.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232064AbhJUQt4 (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Thu, 21 Oct 2021 12:49:56 -0400
Received: from MTA-05-3.privateemail.com (mta-05-1.privateemail.com [198.54.122.55])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by h1.fbrelay.privateemail.com (Postfix) with ESMTPS id 09E26815C3;
        Thu, 21 Oct 2021 12:47:39 -0400 (EDT)
Received: from mta-05.privateemail.com (localhost [127.0.0.1])
        by mta-05.privateemail.com (Postfix) with ESMTP id 175DE180030B;
        Thu, 21 Oct 2021 12:47:35 -0400 (EDT)
Received: from APP-03 (unknown [10.50.14.153])
        by mta-05.privateemail.com (Postfix) with ESMTPA id BDC4E18000BF;
        Thu, 21 Oct 2021 12:47:34 -0400 (EDT)
Date:   Thu, 21 Oct 2021 12:47:34 -0400 (EDT)
From:   Jordy Zomer <jordy@pwning.systems>
To:     Kees Cook <keescook@chromium.org>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Mike Rapoport <rppt@kernel.org>, linux-mm@kvack.org,
        Dmitry Vyukov <dvyukov@google.com>,
        James Bottomley <James.Bottomley@HansenPartnership.com>,
        David Hildenbrand <david@redhat.com>,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Message-ID: <813047099.1390041.1634834854748@privateemail.com>
In-Reply-To: <20211021154046.880251-1-keescook@chromium.org>
References: <20211021154046.880251-1-keescook@chromium.org>
Subject: Re: [PATCH] mm/secretmem: Avoid letting secretmem_users drop to
 zero
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Priority: 3
Importance: Normal
X-Mailer: Open-Xchange Mailer v7.10.5-Rev24
X-Originating-Client: open-xchange-appsuite
X-Virus-Scanned: ClamAV using ClamSMTP
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

Reviewed-by: Jordy Zomer <jordy@pwning.systems>

That's a nice find, Dmitry! Thanks. Also, thank you for writing a patch in such a short period of time, Kees:)

Looks good to me!

> On 10/21/2021 11:40 AM Kees Cook <keescook@chromium.org> wrote:
> 
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
>  	file->f_flags |= O_LARGEFILE;
>  
> -	fd_install(fd, file);
>  	refcount_inc(&secretmem_users);
> +	fd_install(fd, file);
>  	return fd;
>  
>  err_put_fd:
> -- 
> 2.30.2
