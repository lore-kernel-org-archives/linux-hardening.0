Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4ACD3338910
	for <linux-hardening@vger.kernel.org>; Wed, 15 Jul 2026 18:13:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784139205; cv=pass; b=Kg+ItvnBw2eRUuH5G/dWXVHEHh69IOrcp5rEyPpW//XmIT/69dl7N3pQzrFIphpro2DAAYKa0eHsBkvFyjg2QB73q4Z0tpuMDTSzosElMS4vh5WLrTuPOCNcOwLEhUaMORr5zUBVXBZgmIAiKYv+C5L9l+vyrhBCS1cF/jq2dk0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784139205; c=relaxed/simple;
	bh=TlTrHrgV9T9HsF1/ikFD5MM6TsMNEWuH7t9v3bzGGpA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=koRpqMBpo/OpbWDmtiLQujmxr+C3qJEdxvbBTDDQiq8Fn3kTGOcOidOKNdtsGEqHkCwSEaxpzMfAw/XD91UthN0woGHiUnXNvfk/HeF7AhPEZ7/ySKeg0yH4X0T8PIJ0PXHakeNAZVZ2kvtruuTZqqNdXKlHDnvnFateeIR2ysY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eCY8mLFC; arc=pass smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eCY8mLFC"
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-493c7902f47so47848005e9.1
        for <linux-hardening@vger.kernel.org>; Wed, 15 Jul 2026 11:13:19 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784139197; cv=none;
        d=google.com; s=arc-20260327;
        b=ffeWGm1XaHPfuIiNMi7kNts64Xqcg5Guc4Q3mVDx/RyhxPP9qP3LBaSdO9QnmtdNga
         aCfWAFHB/y5GR3vggKWrMCBFpqnRHGv31YyAW+jw4qulW7kozN4fnFOvYBaoxizHtBkP
         p/6U6S+5vMLlgQKYIzOxSnwwdkh6usR0xl2ktrGvhBK0w7sueyk+ZMgCywUq4I9VVC+m
         9wCr/eKff4bnV0SQj3hZKG7Z5m+ojCu1w2HcVRHQ9cC4QaFe0iaZSHM2IGDoyKAOgeLc
         nYFXaB6LcTBvioabQnnwdrAOiTwJs26qBORCn3rPv3zlHuHEBZ7zWv6ELXltZ8li/7W7
         1xjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=2Y5Uh47jmS2lL6sNnuOrdeSccdkAkRk2F1888yDlqwc=;
        fh=uXtDNwrLHpMSWw93w13F+eGLhaopt5hYeHPX98eUN6A=;
        b=AfwKx+q/ViHBSBc6oMbYVJCn94iNzx7mk53PzTZd9be3MOiBhignX2BnTLgUVZJMdU
         0yPTuHW9lXmiLwU0OA0AkOyhkCLU6oLRVE+QLaQ9FD4xXwVEqY6poR2olT1Mu+ylLoBB
         wJmoN3fSMimE3oG2t6BWQb3OnFky3E5MdxqESz7dTbtXpRN/Eh5ZrZ+zRimrCmZGKMZO
         SIQWrPuZvf7pIMxEVt8m4Mpoc2F3TwiTQC99+0LhjHfWafYU0DSaAhqEGxtWimNkSNSH
         NUeXisTQbuRnYTdxM8+us1JBbWh0DtOs8d3C2PZawDfCbIh0VlWuRvEP8pYKOcVzsD/D
         6dgg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784139197; x=1784743997; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=2Y5Uh47jmS2lL6sNnuOrdeSccdkAkRk2F1888yDlqwc=;
        b=eCY8mLFCyDK/RwIdj/rDFfVXDRCCUA4l7IN8DO3XrxtA2gjES13qUiYav+TcU5r9eb
         pFAo0JWD4Y5jUIInfOxzkIqdvIgUrYzIKtZCT4/i+13PqjvFvvKgqwgPal3hWl/BhqyG
         PG3ff8nIkg/T4JuHPtmn5a6YKXlH/mulsXmuP2s/cQA1cG6Dqxj8NJMsRzLcx2GJ0tP1
         ynQACydIRqxXRP2NjpENcO73Us9NPqlexFqn5hrn1jjfHcREYYED3RGkQaohgTCI9cOY
         arIz2NOv9zL5nDgln2tyCBg/+XnwUFevvewlFNB/gxAvSZrxbsmMP/E0mhHjZ0z8rWFQ
         kbwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784139197; x=1784743997;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=2Y5Uh47jmS2lL6sNnuOrdeSccdkAkRk2F1888yDlqwc=;
        b=pYPvpqW1m9KEiQSAPjBbqdANclaALkY9/0uTpiOVV/xkozKcJmFGllKpkqGsoI6cOj
         8GiP7bTQtT56xqQtVQ/TFMEwYknMlZ0v3TGYkNx+XBe0gBw/pQTrUWZlq8BoSBFQU2ip
         eG3fckY3AaKhG41nCrDqHvaTJQpYtmtBjo7p4XVJLMNk2PV6yvN4kzGGFsxvuR/APHhy
         aeQLsI3Lzs2St10DQ0fBijY9JOnoVsa0YEzDSfhs6Gmnirq7UkiC5u1SxwKBppGWZ+Pg
         P2ZiNkqZwD2zgDB0Jw4j+2s1YND7PMv05+CUgLMIGk2PQF2sKM9lT78Ke7eoKtsnEzh+
         MDPw==
X-Forwarded-Encrypted: i=1; AHgh+Rpw7loxz4CLA3iiTbE1T5r8TfLWqpb88KqnXECG4DOlKfA6gjDrArXRyiDU403PXbuGI/kHm9wnhzMtE6TBex0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyXEyIGXT/bmEufWgAj4YkrVguiOfqHZkCz6m8YFHLBmQOtTXV2
	z9WlDyjU2709f/1rDa+Xhor6Uk0VlDXNrxDtY6IIxI9nrnAIZljapEthPo7UJZqqCrRc9pA12w/
	ZN5YrzTMBzx9/ovSNwtIgeRHenUlZXgwQSXVy
X-Gm-Gg: AfdE7cmFNy+wFNHFvUwsLqgjp58hrRmQY2ize6aqnEeqfpS1BgSSpnp2Uqw/o3TtfZq
	+VH2G3JioCo1MUKn3PBcXvwSVnhhhTOSRcwjgZEqmkmiVjCkCm6ZFeouzL1qa6pTpoMIIy3I6EV
	AWTbDFrD9DAZc5mypNn3lycD6Jp88eBGy6t/3aFOB6ZTiDgWkV8Ah+PJQPwDlqun/JZl3GfLAIb
	fk5LdF035h5PREfKtVY/tJpdaoCbjYuBRkIDAwVfp8pkWJAJuxTOvMTdlwYuRlEU0hSrJzhokPQ
	vkJa5zNtFqKU5QJJ6utD5gysSr06lhxiPcAafYBpWoyQzQj/wAd8
X-Received: by 2002:a05:600c:42c8:b0:490:d354:bcf4 with SMTP id
 5b1f17b1804b1-4953c28b5edmr28410535e9.27.1784139197027; Wed, 15 Jul 2026
 11:13:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260714235408.1666063-1-xmei5@asu.edu>
In-Reply-To: <20260714235408.1666063-1-xmei5@asu.edu>
From: Joanne Koong <joannelkoong@gmail.com>
Date: Wed, 15 Jul 2026 11:13:03 -0700
X-Gm-Features: AUfX_mw-teJ0Q6ljAmZl4MTwHTDoeMlbTti5lf97n8LexyPhS1kxB0kDNkM69po
Message-ID: <CAJnrk1b4VAsyEMx7obFTBgP8M3dBcD1+QnKVQK-r881MBySDOg@mail.gmail.com>
Subject: Re: [PATCH v4 1/3] fuse: whitelist the request headers for usercopy
To: Xiang Mei <xmei5@asu.edu>
Cc: Bernd Schubert <bernd@bsbernd.com>, Baokun Li <libaokun@linux.alibaba.com>, 
	Miklos Szeredi <miklos@szeredi.hu>, Kees Cook <kees@kernel.org>, 
	"Gustavo A . R . Silva" <gustavoars@kernel.org>, fuse-devel@lists.linux.dev, 
	linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org, Luis Henriques <luis@igalia.com>, 
	Pavel Begunkov <asml.silence@gmail.com>, bestswngs@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 14, 2026 at 4:54=E2=80=AFPM Xiang Mei <xmei5@asu.edu> wrote:
>
> The fuse-io-uring transport copies req->in.h out to the ring in
> fuse_uring_copy_to_ring() and req->out.h back in fuse_uring_commit().
> Both headers live inside the fuse_request slab object, whose cache
> (fuse_req_cachep) is created without a usercopy whitelist, so copying
> them directly to/from userspace trips CONFIG_HARDENED_USERCOPY and
> panics:
>
>   usercopy: Kernel memory exposure attempt detected from SLUB object
>   'fuse_request' (offset 56, size 40)!
>   kernel BUG at mm/usercopy.c:102!
>   Oops: invalid opcode: 0000 [#1] SMP KASAN NOPTI
>   RIP: 0010:usercopy_abort (mm/usercopy.c:90)
>   Call Trace:
>    __check_heap_object (mm/slub.c:8268)
>    __check_object_size (mm/usercopy.c:197 mm/usercopy.c:258 mm/usercopy.c=
:223)
>    copy_header_to_ring (fs/fuse/dev_uring.c:618)
>    fuse_uring_prepare_send (fs/fuse/dev_uring.c:776 fs/fuse/dev_uring.c:7=
85)
>    fuse_uring_send_in_task (fs/fuse/dev_uring.c:1306)
>    tctx_task_work_run (io_uring/tw.c:96)
>    task_work_run (kernel/task_work.c:233)
>    io_run_task_work (io_uring/tw.h:84)
>    io_cqring_wait (io_uring/wait.c:278)
>    __do_sys_io_uring_enter (io_uring/io_uring.c:2685)
>    entry_SYSCALL_64_after_hwframe (arch/x86/entry/entry_64.S:121)
>
> in.h and out.h are adjacent in struct fuse_req, so a single usercopy
> region starting at in.h covers both and nothing else.  Create the cache
> with that region whitelisted.
>
> Fixes: c090c8abae4b ("fuse: Add io-uring sqe commit and fetch support")
> Cc: stable@vger.kernel.org
> Reported-by: Weiming Shi <bestswngs@gmail.com>
> Suggested-by: Baokun Li <libaokun@linux.alibaba.com>
> Assisted-by: Claude:claude-opus-4-8
> Signed-off-by: Xiang Mei <xmei5@asu.edu>
> ---
> v3: no context change; add Bernd's Reviewed-by
> v4: drop previous tags; use kmem_cache_args to reserve usercopy area
>
>  fs/fuse/dev.c        | 9 +++++++--
>  fs/fuse/fuse_dev_i.h | 5 +++++
>  2 files changed, 12 insertions(+), 2 deletions(-)
>
> diff --git a/fs/fuse/dev.c b/fs/fuse/dev.c
> index 5763a7cd3b37..b8e43e374b35 100644
> --- a/fs/fuse/dev.c
> +++ b/fs/fuse/dev.c
> @@ -2404,10 +2404,15 @@ static struct miscdevice fuse_miscdevice =3D {
>
>  int __init fuse_dev_init(void)
>  {
> +       struct kmem_cache_args args =3D {
> +               .useroffset =3D offsetof(struct fuse_req, in.h),
> +               .usersize =3D sizeof_field(struct fuse_req, in.h) +
> +                           sizeof_field(struct fuse_req, out.h),
> +       };
>         int err =3D -ENOMEM;
> +
>         fuse_req_cachep =3D kmem_cache_create("fuse_request",
> -                                           sizeof(struct fuse_req),
> -                                           0, 0, NULL);
> +                                           sizeof(struct fuse_req), &arg=
s, 0);
>         if (!fuse_req_cachep)
>                 goto out;
>
> diff --git a/fs/fuse/fuse_dev_i.h b/fs/fuse/fuse_dev_i.h
> index 668c8391d61c..b511aaab6bfc 100644
> --- a/fs/fuse/fuse_dev_i.h
> +++ b/fs/fuse/fuse_dev_i.h
> @@ -81,6 +81,11 @@ struct fuse_req {
>         /** @flags: Request flags, updated with test/set/clear_bit() */
>         unsigned long flags;
>
> +       /*
> +        * @in and @out are the usercopy region of this cache (see
> +        * fuse_dev_init()); keep them adjacent.
> +        */
> +
>         /** @in: The request input header */
>         struct {
>                 /** @in.h: The request input header */
> --
> 2.43.0
>

I think this is more a matter of preference as they're both
functionally correct but imo the previous approach seemed cleaner,
given that only the io-uring path needs this. The extra hop goes
through a tmp stack variable whose memory is already in the L1 cache
and the memcpys are small (~40 bytes), so I think the cost is
essentially negligible. Not sure if Bernd or Miklos or Amir have a
preference here.

Thanks,
Joanne
