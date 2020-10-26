Return-Path: <SRS0=1bDI=EB=vger.kernel.org=linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63C4BC4363A
	for <linux-hardening@archiver.kernel.org>; Mon, 26 Oct 2020 21:24:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 047C3207F7
	for <linux-hardening@archiver.kernel.org>; Mon, 26 Oct 2020 21:24:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="wSeeY//9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731730AbgJZVYG (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Mon, 26 Oct 2020 17:24:06 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:34711 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731698AbgJZVYF (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Mon, 26 Oct 2020 17:24:05 -0400
Received: by mail-lf1-f68.google.com with SMTP id z2so14096692lfr.1
        for <linux-hardening@vger.kernel.org>; Mon, 26 Oct 2020 14:24:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=SmqPQzTxMFONQmC5uW8UTd8kW/+6dHu+eNEq5/wa33c=;
        b=wSeeY//9Rx8NmPLlC8ebnjxfkvSlOK1T651eFLQgaKlAx3ugOwHRopjfZxtKpxs6Y7
         ntZMbZ7C2MvOLQpN4xeSh8vgG3GtJLAofXfQG5duXY5A3iYieSds0iZylRXxOiCeX0FQ
         6NJxnkGxBUUDBYUXD8bOUVd3tB6BajLihkAtJRxR2XWDfPdEUoStvV5/vwBsdflIYJ3n
         VEiNccaqVDntWiUVBkdBLgebFvyOH7rzSXjMgf3nu/RqKLH2lf5xznAjvvQKO6vbvyEf
         ahULyn1oCbe/2hOzAkoMjzcPCC+mcY2xgjxoKoOcotiQarHM3SXMPWaqdJr1sqHGmrj5
         BwRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=SmqPQzTxMFONQmC5uW8UTd8kW/+6dHu+eNEq5/wa33c=;
        b=DpalwiAgS4c7Bc5gg64gZ3V2uJPNN7dGEV2MJQc3xGp7PpYsPRCy/xrt19DoLgXKja
         rnKyql2AuE87nb+sxeETbkN5nJykbMnV3cdJ8Ntdr8tFXly9nyltjQBMejxzFB4fWoBe
         tr06eo2Yb7/MoipERuDpB7QqnIU0RyiHW36igbxbRvdw+hgoIAfZ90ZaAo3dXn7Blu7e
         Cp+2HYYborWkWSz1prMZM2K25nup1THX01ew299FIxPVFI3aH8YnayTYie7Giikf+dXC
         dbG2xIDCv207lDxkkEcFfTzmWIHLLUY/IqCJshEPQhEFZJg/Y00aIn+O04hm/jCDgk6X
         ytUA==
X-Gm-Message-State: AOAM532tov7qNj8ciX0oqUzMp2P1++fohm9j1p4UFXJT9AlLevXn4WhW
        S/oweusRlWHmLeeLaQ681L0v6cO7MNsBjJuWbDzM0w==
X-Google-Smtp-Source: ABdhPJxfMX7rMGWHEd1Qd4RDbT2HrSTNYD7mItOORVkjg8nDp22FxxINJnBvFvDBminBErNddYPmM+KntioJ8s/qFy4=
X-Received: by 2002:a05:6512:52f:: with SMTP id o15mr5485016lfc.381.1603747442929;
 Mon, 26 Oct 2020 14:24:02 -0700 (PDT)
MIME-Version: 1.0
References: <CACT4Y+beaHrWisaSsV90xQn+t2Xn-bxvVgmx8ih_h=yJYPjs4A@mail.gmail.com>
 <20201026200715.170261-1-ebiggers@kernel.org>
In-Reply-To: <20201026200715.170261-1-ebiggers@kernel.org>
From:   Jann Horn <jannh@google.com>
Date:   Mon, 26 Oct 2020 22:23:35 +0100
Message-ID: <CAG48ez2Og6fWUKZbNO5EtYK-jS+J8rf6r+rOyfUp1MUuy4kMyA@mail.gmail.com>
Subject: Re: [PATCH] crypto: af_alg - avoid undefined behavior accessing salg_name
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     "open list:HARDWARE RANDOM NUMBER GENERATOR CORE" 
        <linux-crypto@vger.kernel.org>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        linux-hardening@vger.kernel.org,
        Linux API <linux-api@vger.kernel.org>,
        kernel list <linux-kernel@vger.kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Elena Petrova <lenaptr@google.com>,
        Vegard Nossum <vegard.nossum@oracle.com>,
        "Gustavo A . R . Silva" <gustavoars@kernel.org>,
        stable <stable@vger.kernel.org>,
        syzbot <syzbot+92ead4eb8e26a26d465e@syzkaller.appspotmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Mon, Oct 26, 2020 at 9:08 PM Eric Biggers <ebiggers@kernel.org> wrote:
> Commit 3f69cc60768b ("crypto: af_alg - Allow arbitrarily long algorithm
> names") made the kernel start accepting arbitrarily long algorithm names
> in sockaddr_alg.

That's not true; it's still limited by the size of struct
sockaddr_storage (128 bytes total for the entire address). If you make
it longer, __copy_msghdr_from_user() will silently truncate the size.

> This is broken because the kernel can access indices >= 64 in salg_name,
> which is undefined behavior -- even though the memory that is accessed
> is still located within the sockaddr structure.  It would only be
> defined behavior if the array were properly marked as arbitrary-length
> (either by making it a flexible array, which is the recommended way
> these days, or by making it an array of length 0 or 1).
>
> We can't simply change salg_name into a flexible array, since that would
> break source compatibility with userspace programs that embed
> sockaddr_alg into another struct, or (more commonly) declare a
> sockaddr_alg like 'struct sockaddr_alg sa = { .salg_name = "foo" };'.
>
> One solution would be to change salg_name into a flexible array only
> when '#ifdef __KERNEL__'.  However, that would keep userspace without an
> easy way to actually use the longer algorithm names.
>
> Instead, add a new structure 'sockaddr_alg_new' that has the flexible
> array field, and expose it to both userspace and the kernel.
> Make the kernel use it correctly in alg_bind().
[...]
> @@ -147,7 +147,7 @@ static int alg_bind(struct socket *sock, struct sockaddr *uaddr, int addr_len)
>         const u32 allowed = CRYPTO_ALG_KERN_DRIVER_ONLY;
>         struct sock *sk = sock->sk;
>         struct alg_sock *ask = alg_sk(sk);
> -       struct sockaddr_alg *sa = (void *)uaddr;
> +       struct sockaddr_alg_new *sa = (void *)uaddr;
>         const struct af_alg_type *type;
>         void *private;
>         int err;
> @@ -155,7 +155,11 @@ static int alg_bind(struct socket *sock, struct sockaddr *uaddr, int addr_len)
>         if (sock->state == SS_CONNECTED)
>                 return -EINVAL;
>
> -       if (addr_len < sizeof(*sa))
> +       BUILD_BUG_ON(offsetof(struct sockaddr_alg_new, salg_name) !=
> +                    offsetof(struct sockaddr_alg, salg_name));
> +       BUILD_BUG_ON(offsetof(struct sockaddr_alg, salg_name) != sizeof(*sa));
> +
> +       if (addr_len < sizeof(*sa) + 1)
>                 return -EINVAL;
>
>         /* If caller uses non-allowed flag, return error. */
> @@ -163,7 +167,7 @@ static int alg_bind(struct socket *sock, struct sockaddr *uaddr, int addr_len)
>                 return -EINVAL;
>
>         sa->salg_type[sizeof(sa->salg_type) - 1] = 0;
> -       sa->salg_name[sizeof(sa->salg_name) + addr_len - sizeof(*sa) - 1] = 0;
> +       sa->salg_name[addr_len - sizeof(*sa) - 1] = 0;

This looks like an out-of-bounds write in the case `addr_len ==
sizeof(struct sockaddr_storage)`.
