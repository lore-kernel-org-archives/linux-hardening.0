Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F95F3EC69A
	for <linux-hardening@vger.kernel.org>; Mon, 27 Jul 2026 23:39:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.173
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785195558; cv=pass; b=sY/2JFOjbu3SmjHcbOnhkzWYYJvuK1+XGgLPpslRdmYuqIoknipNgqwxZSvCxPralBPcGT8ATyzJ6SL/v1L5nOsChaJba4SJe1S9N32Xihzh7VA86l3p7uY6YfOcv2H9EDjRENmpvbA6ddKbdMUgYcuQC0tFuLTd0OjF181r7hg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785195558; c=relaxed/simple;
	bh=V5YWr3MKVMqaHPNkDI2H2wxmRrxgahysyRn4PvMMfLE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MDc0c2h6ci9d/v4nIC03aB0n5fpFMNHREnM3BIZUp3NVqY8LE6XIf3dttuQoGgy1ia7o3HzHuSU+W+STHCPwFAgAiHs3nkmukigZz5nieOzw+AGuGvw8SVlp/43CFDRYSaB3MrHTmuJuAoMwNUIoLhX7WNs/s38j8r4gqjSOs9c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=asu.edu; spf=pass smtp.mailfrom=asu.edu; dkim=pass (2048-bit key) header.d=asu.edu header.i=@asu.edu header.b=W39Ie9dW; arc=pass smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=asu.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=asu.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=asu.edu header.i=@asu.edu header.b="W39Ie9dW"
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2ceed7018c8so21360325ad.1
        for <linux-hardening@vger.kernel.org>; Mon, 27 Jul 2026 16:39:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785195556; cv=none;
        d=google.com; s=arc-20260327;
        b=o4Vt0fu2Ir8wqFqEFnZ7zvbYOvgJgpAfU+D4HnNK3qlqR2/xpUY2PD21GpYwUzNUmk
         Xe/AEPCXalAhPNcjk+uXb+L+in8VOzw2HlqADM/uB1zUnKYMjDi6FkqzPxXZEtxlDbRM
         RBzIjGcCJZZkcOf9u8hOHzafLsDd3o6HDb24NoKTWWRnjhGOScOmzJ8oaBYoGulii0qQ
         6FdKfIEDnsIIhXqqZAdn6U1RzpeDJO61zoBsMQUmjyzSCuTbLlcJmWULrbm7FClaLMwe
         qEN+HmVxKPmdITFQmQ6iU7LPlA8gAptJ8eVYgJCIV+mjttuTAJt6COC9VtY1RtxAiD48
         I7Hg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=RqFceQZgdQjZo7xGdNfi40Q0nXWHUMZpsmINYgmFEmQ=;
        fh=ffiUu1JU+iTSK29LBy7cyzH5SBDQWa4tnThpRiwNr0w=;
        b=Z+cypE3eJQ09ZvDdimuMCUmIiHreRfmn39C9ydU/TRD+vKos1vbzijqDWM6pIdWFmD
         WCtMZscj26I4pkaHq5j6nl2Bx9hD6NAW8V/kxIdup6jyV091UuoOSgC1GVxRAlw60YOi
         EHehBNfy2qY1tLoS0frIhRGvqDXKIaOTlh4FuHt+2aUvKsFPW5ocNkNKL+Od7AUYT6qL
         6hEvASvi9SXEI640o2C5jh78dIUSwyBzZsS/XvFaKRC1VmZrm9cd9TSzfGzj0GJ+cTxS
         Ca8w90aRJ6+DpgDM6NBawztmXwe/JKWZGAp22JAEGKTbVXa8OKIlYSFuVuWADs0uxmIo
         k9YA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=asu.edu; s=google; t=1785195556; x=1785800356; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=RqFceQZgdQjZo7xGdNfi40Q0nXWHUMZpsmINYgmFEmQ=;
        b=W39Ie9dWiAkbrkSmuAVJI2+Y87fg39oHty7kwaLyoPkFBt8n7Ll0QACCSbMfHq518k
         OCQEofo+le5P2mIPD2abk4v4E5gDcRV5P+hjqBMCRwxi4TbyKxtmnudXkw3eKUD5OdfN
         n9v7sZv//bALCYzCCD6HWirP1WyLjeuqErMj2EGgCe7pVEJKZUaAih9hkcWenxUdTBO+
         +jLZJBoxXJiVpaJOlyIBCt82k3HwxSqtWhbL383xiLXsgqogc/IylOlWjUv5gwYORg7L
         MNbDggi/My2wFjTDjNmxpJJO3Ck44gJpjd15ZkYuM2QzYWvHmjCpUP5Twz7MPjjzckCt
         R6WQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785195556; x=1785800356;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=RqFceQZgdQjZo7xGdNfi40Q0nXWHUMZpsmINYgmFEmQ=;
        b=RaxcwyKnIaANyP6uM92cWEzj/NVWFadV9rAaarukr6Pvi5+fXYAxYMkfqzU24zsErf
         JziAwrWdTEYCQ0XqrrV+1+nxVM9icgzy95JHYe4FsyyPT8WTmP+kCsmMEpWAW96OCoT3
         1iTL8odxZ4Hz1qbASAD0+90JkllEmmff1ImO3hkBzq2TiLPcMm/prjLCk20NJtZTlPrz
         VZdX7sn4sagw9AdiF6Ypr2EqNgXRx/3SO2f3Ya7euknSC0qVgfn2RPaxqWLKB6KmP5ZP
         dg26VlzB6/8N1jPxDVNRGDHFY+cF+Vv+ASTb+FW0FYnXhqfPPz8hkckfAcCY2QCrb2PO
         8AMg==
X-Forwarded-Encrypted: i=1; AHgh+Rrxa+nCT6K6mLsECj9L0t2ihehZtpiZ3BRySv2kLy8XiekexNykuv6iAtaP68fj5mdpFKSA+2GCqvj2sWonzi0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw+YshwVu2qbgD9WuHI47UB2yWyBn89ZHJcJZn+t1RKlkp3DZtV
	9xwWSabw1/k6AFNFuuMUmpvwuIeiXUmTgAMHcIHg52MYRhUdQllZhSn0xrcJFy5bAy5jq+tx3IW
	OaBSLBUcnr9fKm3cHyF+7NJXSFIEOrfabq/qhShFo
X-Gm-Gg: AR+sD10l3UTv7CBZV7L4j2r9x9THD1yeyPIt0QHhUP8Y4817pRTH7qASrKNeHtV6T9y
	AMx8N0NXs+h6Whs/LtoKdhMkVMC7Mzt6N8lhqoVv20dTpG+y8nTsCHC3JfdI883DmEtQkntINUz
	iYgAZIvTyDYTaFJYGFKxTPzvFPwslItIXSkgrqLXRvE4flgL7K2JAVVNMjsYmPuPNwTiInQU3YE
	ilssH4+A3KoBl7JPde2HyHHTw5oxKQahmfSSvpMIc68oAEI4Ok9Kk6dUykSPgApQcuEL9hcY54B
	yQ/i95E+/0+Hehu3By7k
X-Received: by 2002:a17:902:b701:b0:2cf:8131:75f3 with SMTP id
 d9443c01a7336-2d015a8940bmr115955ad.7.1785195556400; Mon, 27 Jul 2026
 16:39:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260714235408.1666063-1-xmei5@asu.edu> <CAJnrk1b4VAsyEMx7obFTBgP8M3dBcD1+QnKVQK-r881MBySDOg@mail.gmail.com>
 <c48c4541-c62a-45cc-aa3d-1c78a48d0676@bsbernd.com>
In-Reply-To: <c48c4541-c62a-45cc-aa3d-1c78a48d0676@bsbernd.com>
From: Xiang Mei <xmei5@asu.edu>
Date: Mon, 27 Jul 2026 16:39:05 -0700
X-Gm-Features: AUfX_mw5Vb7r-H4GegBkxIrI4-ULi3jkJQ4MMMUyOB-n1gwlaWOaUgAxYZC8Qr8
Message-ID: <CAPpSM+RbHh6toxSR00HCA_+R5Cj+yBwVXDw0ruiMbrVhnMX-6g@mail.gmail.com>
Subject: Re: [PATCH v4 1/3] fuse: whitelist the request headers for usercopy
To: Bernd Schubert <bernd@bsbernd.com>, Joanne Koong <joannelkoong@gmail.com>
Cc: Baokun Li <libaokun@linux.alibaba.com>, Miklos Szeredi <miklos@szeredi.hu>, 
	Kees Cook <kees@kernel.org>, "Gustavo A . R . Silva" <gustavoars@kernel.org>, fuse-devel@lists.linux.dev, 
	linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org, Luis Henriques <luis@igalia.com>, 
	Pavel Begunkov <asml.silence@gmail.com>, bestswngs@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 15, 2026 at 2:59=E2=80=AFPM Bernd Schubert <bernd@bsbernd.com> =
wrote:
>
>
>
> On 7/15/26 20:13, Joanne Koong wrote:
> > On Tue, Jul 14, 2026 at 4:54=E2=80=AFPM Xiang Mei <xmei5@asu.edu> wrote=
:
> >>
> >> The fuse-io-uring transport copies req->in.h out to the ring in
> >> fuse_uring_copy_to_ring() and req->out.h back in fuse_uring_commit().
> >> Both headers live inside the fuse_request slab object, whose cache
> >> (fuse_req_cachep) is created without a usercopy whitelist, so copying
> >> them directly to/from userspace trips CONFIG_HARDENED_USERCOPY and
> >> panics:
> >>
> >>   usercopy: Kernel memory exposure attempt detected from SLUB object
> >>   'fuse_request' (offset 56, size 40)!
> >>   kernel BUG at mm/usercopy.c:102!
> >>   Oops: invalid opcode: 0000 [#1] SMP KASAN NOPTI
> >>   RIP: 0010:usercopy_abort (mm/usercopy.c:90)
> >>   Call Trace:
> >>    __check_heap_object (mm/slub.c:8268)
> >>    __check_object_size (mm/usercopy.c:197 mm/usercopy.c:258 mm/usercop=
y.c:223)
> >>    copy_header_to_ring (fs/fuse/dev_uring.c:618)
> >>    fuse_uring_prepare_send (fs/fuse/dev_uring.c:776 fs/fuse/dev_uring.=
c:785)
> >>    fuse_uring_send_in_task (fs/fuse/dev_uring.c:1306)
> >>    tctx_task_work_run (io_uring/tw.c:96)
> >>    task_work_run (kernel/task_work.c:233)
> >>    io_run_task_work (io_uring/tw.h:84)
> >>    io_cqring_wait (io_uring/wait.c:278)
> >>    __do_sys_io_uring_enter (io_uring/io_uring.c:2685)
> >>    entry_SYSCALL_64_after_hwframe (arch/x86/entry/entry_64.S:121)
> >>
> >> in.h and out.h are adjacent in struct fuse_req, so a single usercopy
> >> region starting at in.h covers both and nothing else.  Create the cach=
e
> >> with that region whitelisted.
> >>
> >> Fixes: c090c8abae4b ("fuse: Add io-uring sqe commit and fetch support"=
)
> >> Cc: stable@vger.kernel.org
> >> Reported-by: Weiming Shi <bestswngs@gmail.com>
> >> Suggested-by: Baokun Li <libaokun@linux.alibaba.com>
> >> Assisted-by: Claude:claude-opus-4-8
> >> Signed-off-by: Xiang Mei <xmei5@asu.edu>
> >> ---
> >> v3: no context change; add Bernd's Reviewed-by
> >> v4: drop previous tags; use kmem_cache_args to reserve usercopy area
> >>
> >>  fs/fuse/dev.c        | 9 +++++++--
> >>  fs/fuse/fuse_dev_i.h | 5 +++++
> >>  2 files changed, 12 insertions(+), 2 deletions(-)
> >>
> >> diff --git a/fs/fuse/dev.c b/fs/fuse/dev.c
> >> index 5763a7cd3b37..b8e43e374b35 100644
> >> --- a/fs/fuse/dev.c
> >> +++ b/fs/fuse/dev.c
> >> @@ -2404,10 +2404,15 @@ static struct miscdevice fuse_miscdevice =3D {
> >>
> >>  int __init fuse_dev_init(void)
> >>  {
> >> +       struct kmem_cache_args args =3D {
> >> +               .useroffset =3D offsetof(struct fuse_req, in.h),
> >> +               .usersize =3D sizeof_field(struct fuse_req, in.h) +
> >> +                           sizeof_field(struct fuse_req, out.h),
> >> +       };
> >>         int err =3D -ENOMEM;
> >> +
> >>         fuse_req_cachep =3D kmem_cache_create("fuse_request",
> >> -                                           sizeof(struct fuse_req),
> >> -                                           0, 0, NULL);
> >> +                                           sizeof(struct fuse_req), &=
args, 0);
> >>         if (!fuse_req_cachep)
> >>                 goto out;
> >>
> >> diff --git a/fs/fuse/fuse_dev_i.h b/fs/fuse/fuse_dev_i.h
> >> index 668c8391d61c..b511aaab6bfc 100644
> >> --- a/fs/fuse/fuse_dev_i.h
> >> +++ b/fs/fuse/fuse_dev_i.h
> >> @@ -81,6 +81,11 @@ struct fuse_req {
> >>         /** @flags: Request flags, updated with test/set/clear_bit() *=
/
> >>         unsigned long flags;
> >>
> >> +       /*
> >> +        * @in and @out are the usercopy region of this cache (see
> >> +        * fuse_dev_init()); keep them adjacent.
> >> +        */
> >> +
> >>         /** @in: The request input header */
> >>         struct {
> >>                 /** @in.h: The request input header */
> >> --
> >> 2.43.0
> >>
> >
> > I think this is more a matter of preference as they're both
> > functionally correct but imo the previous approach seemed cleaner,
> > given that only the io-uring path needs this. The extra hop goes
> > through a tmp stack variable whose memory is already in the L1 cache
> > and the memcpys are small (~40 bytes), so I think the cost is
> > essentially negligible. Not sure if Bernd or Miklos or Amir have a
> > preference here.
>
> Sorry for late replies, currently on vacation and reviews only when
> everyone else is asleep.
>
> I don't have a strong opinion, I wondered the same if the stack copy was
> avoidable, but then came to the same conclusion as Joanne - negligible
> overhead.
>
>
> Thanks,
> Bernd


Sorry for the late reply. I just got some free time to continue the
patch. Thanks for all of your review and advice. I'll keep the code
simple and just use the stack var to fix it for 1/3 and add Joanne's
suggested comment to 3/3.


The v5 has been sent:

https://lore.kernel.org/fuse-devel/20260727233706.218446-1-xmei5@asu.edu/T/=
#t

Thanks so much!
Xiang


Xiang
