Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C310433032
	for <linux-hardening@vger.kernel.org>; Tue, 14 Jul 2026 23:56:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.173
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784073411; cv=pass; b=l5LnH7pi5czEb39zRsU7vrU9I7xlCIl7Vg1bwHKxunrx6kY2YOxUb2e4o+sUcMRvCJlurtJUf5T4KMX2VazOTvLWL8knXC8k5ChLgaUdt0cUg3YDdj4LM0JI+jmwF4WuPUwo4TgPDVY44z1W5C3OPu9ghxmkzodJPNv0iYE/E4k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784073411; c=relaxed/simple;
	bh=6Fpv/SB25gudhh3flfFdWSjRk6FL3uKgMmFq0SGfsa0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gXcR/03GOYf50GTkPHj6AniOouac5fq02D20s0vrRccxBC+24zQjRsP+jLkL5P6I4O8SediBno0oM7vGaTJDRDHtX75hQI4vqw9LUhVwe1hVAIg/ma/HRwy+WfZdwnbZQPUXJYhsMCTt/aIdVKZkilBYOuT97seA2pZrOlT/xZ4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=asu.edu; spf=pass smtp.mailfrom=asu.edu; dkim=pass (2048-bit key) header.d=asu.edu header.i=@asu.edu header.b=syjGEi1m; arc=pass smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=asu.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=asu.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=asu.edu header.i=@asu.edu header.b="syjGEi1m"
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-845b6d9bf39so1518523b3a.1
        for <linux-hardening@vger.kernel.org>; Tue, 14 Jul 2026 16:56:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784073408; cv=none;
        d=google.com; s=arc-20260327;
        b=VvTT9ihUMyLteuL+47qJl3d+S5ixkTAZLY8zHtr0I1SelreoYBd3O7jqtF2/+ZdZ3r
         15vlO2feUuxZgEXx2Kp3G3EHqeBkuOdj6EMtvFLbChs2N5zETMu0cU0SpICFNv1Wv+F6
         2YEH29SSW8AC+U8B8+mJTzMR/p6TjM4EwyVogVlVEBY7dzZ2hm82M+EBZwmreDS6WTJZ
         P/XvQ/LqYz4rHgJ2lXGrY4T2yxVOSar/1/neFMvk66jgGq3BlGfG581//F3Cccg4qTFn
         uRQiGbXVMAmqPndsLy+AD1QnmUTKpU8c5Wd4BdgP9S5KKA/fSELw6RLpgtcAQS/fffPJ
         Nuqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=wbAPfP4ZbZmDgX9Nwlzq5TjRPzqN58/bDtfUIlP4wNM=;
        fh=jMMej+bnddY5oGxRPYb3tX0HG2koJbXvz7VxIEVK+LY=;
        b=gZWwJ7pvWwUHGWlSuEBLziew2Dsr8AuGb5zA/E6x8KmCwxHxKTn8UWm4Jjzk5p7Sxo
         oaoceW8cBSbvWKrw0DuBOhSalm602fTWlBT86fY7WaAwRI+6qGAtXjWHKDW65GXcoEBK
         v14KatElTcMyPrpXjQ6ngXUeNRRp1qvadUwo9grPFL2gxurX7q7gSC45uBCAEjBvXnzc
         PESTHbN5tY8kQCKtb3qdYSdU6f9EJeGpr8US8voLGU81Yv0zXsSTOPr3n7OGL/JtK9oq
         A2zaFFrBBdAnsp4fkJJZU/ZmQuTKL5utmVvkJk8RKW3B5a+dLmwNUF8Hpgte6N70HHIC
         Birw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=asu.edu; s=google; t=1784073408; x=1784678208; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=wbAPfP4ZbZmDgX9Nwlzq5TjRPzqN58/bDtfUIlP4wNM=;
        b=syjGEi1mCJWwN+bTLaJ7Z9hGL2on/VW/ZLpsabEt6Uz/6t8ssln8PocyQBReKWwPV3
         whdxJKjv2Y9I6jd/5P/IX8pfp7g+G9U6nlIKbpt21nXyg3Fg2e4vjd7nEJ+zpZC4P5r/
         sX8Li96UgdHkKvEv3EyseCVRrumKlfBvftVPrOoueC75tNrO32fNbzP40FmX3dy41Sob
         +b9JkqaTUHK9b0iFPNdOtm3Csb2+Wu0KmyB9Ww6qPAy9z8O8vzTGHNQ0xxWtgQ49ZwwG
         6Qb3jtgye7jVnxP2AZ46a+Cy8J3ZQRv3nyLZNUV6hfP2tLSinCjP7v9rYqNQz+7SyPFB
         I+lA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784073408; x=1784678208;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=wbAPfP4ZbZmDgX9Nwlzq5TjRPzqN58/bDtfUIlP4wNM=;
        b=YIr7NNU5sTIC4t86vcwH1T4UaSQgIr8vzgCZ4KYR3yUxKX4u7n1x5xhEYIvrByXV7R
         DDQLsyRKh/0U+8Ggy/KDBxKXHTz/hzw2bxdTtSo9cpydzR8h03luPpWnA5VeWNNUshtk
         eyEC8PhyOfs4tMYZIl9ST7x1FhcEEGm/4A8adx1A88k8jsr8c+XYJPf2gbj/+HOVl84P
         RlLDGcDXGB0sMUyqNJI2QKu7l2GH5XQf/5MbX4GgaGQYFDjZP6mBH+unijBKdAdwyW5R
         /lwbuTW0VEd2xY/B9wHvrouSq9rcoFzsJo93TBysC8vVcfdNZNVX0NFAlJJ7UGRbwoM3
         7fSg==
X-Forwarded-Encrypted: i=1; AHgh+Rq8iy+moRu7iGeFHfy7bxUdyBAgnpi0vGj0l3iVAWasrIyHvR4WicJ/ak6PBWAYfMVmWTHwSIislY5Vrh99XN4=@vger.kernel.org
X-Gm-Message-State: AOJu0YygFSMCh4j7pozcn3T0VUwfGRCckfHlmUwJoffXBdkMCq18kDM/
	cARFU8vQrIMVt4YGhV7cZyskheQXnSor4CNGQ7F8KkQDnrAHfvOqeKmWxBIgJFzZDFnjuBWl7MH
	R+wItlcpxW+7myeFsnW3xxrDIqhSKKZhb0WbhbqxC
X-Gm-Gg: AfdE7clGRAq1zSMG6KO0ffEiNt0tuvul+5SwTpTEgd4sKIAR71ePFU9gybcNC3UjHDK
	PB7CJEHz/SilM8zH34My7PMcETrjG18a9uSHu9C/fLPHmXPAZMK6BRLNmcWqZ+BPsOAhmRdB03x
	qhhcLuJDd6cJ6+aN+2feo2S5NtjBhCeXN1lu3M4vo6AGvilk+TqjFrKulHadRiS7EQUyhJEMiPM
	uZ9acg0ZnsysU3lP21+brx6jG+cj+tqs63kMetYvn8kiXfLhsJ/bYs/W3gLdcMXxYNwclGd
X-Received: by 2002:a05:6a00:1d09:b0:848:2f58:e1ec with SMTP id
 d2e1a72fcca58-84870798902mr15715102b3a.39.1784073408405; Tue, 14 Jul 2026
 16:56:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260709211130.543773-1-xmei5@asu.edu> <26a9a225-617c-4492-af1d-152d71414f4d@linux.alibaba.com>
In-Reply-To: <26a9a225-617c-4492-af1d-152d71414f4d@linux.alibaba.com>
From: Xiang Mei <xmei5@asu.edu>
Date: Tue, 14 Jul 2026 16:56:36 -0700
X-Gm-Features: AUfX_mw5OdcJsljs_oJJ0LuEjIoWcseG9aZEf-wHZwZ0vy0tq-WnqPuMiDAI62k
Message-ID: <CAPpSM+QrQk8k8NH5Qz5XHf-O=U0Et_OJFpP4iBtX4dkJ8gamEg@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] fuse: copy request headers via a stack buffer for io-uring
To: Baokun Li <libaokun@linux.alibaba.com>
Cc: fuse-devel@lists.linux.dev, linux-hardening@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org, 
	Luis Henriques <luis@igalia.com>, Pavel Begunkov <asml.silence@gmail.com>, bestswngs@gmail.com, 
	"Gustavo A . R . Silva" <gustavoars@kernel.org>, Joanne Koong <joannelkoong@gmail.com>, 
	Kees Cook <kees@kernel.org>, Bernd Schubert <bernd@bsbernd.com>, Miklos Szeredi <miklos@szeredi.hu>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 13, 2026 at 1:20=E2=80=AFAM Baokun Li <libaokun@linux.alibaba.c=
om> wrote:
>
> Hi Xiang,
>
> On 2026/7/10 05:11, Xiang Mei wrote:
> > The fuse-io-uring transport copies req->in.h out to the ring in
> > fuse_uring_copy_to_ring() and req->out.h back in fuse_uring_commit().
> > Both headers live inside the fuse_request slab object, whose cache
> > (fuse_req_cachep) is created without a usercopy whitelist,
>
>
> Then why not allocate "fuse_request" with kmem_cache_create_usercopy()
> to add a usercopy whitelist instead?
>
> That would avoid the extra stack usage for the bounce headers and
> the 56 bytes of copying they incur.
>
>
> Thanks,
> Baokun
You are right. I have dropped previous reviewers' tags and sent a v4
since it's a hot path:
https://lore.kernel.org/fuse-devel/20260714235408.1666063-1-xmei5@asu.edu/T=
/#t

Xiang
>
> >  so copying
> > them directly to/from userspace trips CONFIG_HARDENED_USERCOPY and
> > panics:
> >
> >   usercopy: Kernel memory exposure attempt detected from SLUB object
> >   'fuse_request' (offset 56, size 40)!
> >   kernel BUG at mm/usercopy.c:102!
> >   RIP: 0010:usercopy_abort+0x6c/0x80
> >   Call Trace:
> >    __check_heap_object
> >    __check_object_size
> >    copy_header_to_ring          fs/fuse/dev_uring.c:618
> >    fuse_uring_prepare_send
> >    fuse_uring_send_in_task
> >    ...
> >    __do_sys_io_uring_enter
> >    entry_SYSCALL_64_after_hwframe
> >
> > Bounce both headers through an on-stack copy so the usercopy touches
> > stack memory, not the slab object.
> >
> > Fixes: c090c8abae4b ("fuse: Add io-uring sqe commit and fetch support")
> > Cc: stable@vger.kernel.org
> > Reported-by: Weiming Shi <bestswngs@gmail.com>
> > Assisted-by: Claude:claude-opus-4-8
> > Signed-off-by: Xiang Mei <xmei5@asu.edu>
> > Reviewed-by: Bernd Schubert <bernd@bsbernd.com>
> > Reviewed-by: Joanne Koong <joannelkoong@gmail.com>
> > ---
> > v3: no context change; add Bernd's Reviewed-by
> >
> >  fs/fuse/dev_uring.c | 12 ++++++++----
> >  1 file changed, 8 insertions(+), 4 deletions(-)
> >
> > diff --git a/fs/fuse/dev_uring.c b/fs/fuse/dev_uring.c
> > index 77c8cec43d9c..0814681eb04b 100644
> > --- a/fs/fuse/dev_uring.c
> > +++ b/fs/fuse/dev_uring.c
> > @@ -744,6 +744,7 @@ static int fuse_uring_copy_to_ring(struct fuse_ring=
_ent *ent,
> >  {
> >       struct fuse_ring_queue *queue =3D ent->queue;
> >       struct fuse_ring *ring =3D queue->ring;
> > +     struct fuse_in_header in_header;
> >       int err;
> >
> >       err =3D -EIO;
> > @@ -765,8 +766,9 @@ static int fuse_uring_copy_to_ring(struct fuse_ring=
_ent *ent,
> >       }
> >
> >       /* copy fuse_in_header */
> > -     return copy_header_to_ring(ent, FUSE_URING_HEADER_IN_OUT, &req->i=
n.h,
> > -                                sizeof(req->in.h));
> > +     in_header =3D req->in.h;
> > +     return copy_header_to_ring(ent, FUSE_URING_HEADER_IN_OUT, &in_hea=
der,
> > +                                sizeof(in_header));
> >  }
> >
> >  static int fuse_uring_prepare_send(struct fuse_ring_ent *ent,
> > @@ -871,11 +873,13 @@ static void fuse_uring_commit(struct fuse_ring_en=
t *ent, struct fuse_req *req,
> >                             unsigned int issue_flags)
> >  {
> >       struct fuse_ring *ring =3D ent->queue->ring;
> > +     struct fuse_out_header out_header;
> >       ssize_t err =3D -EFAULT;
> >
> > -     if (copy_header_from_ring(ent, FUSE_URING_HEADER_IN_OUT, &req->ou=
t.h,
> > -                               sizeof(req->out.h)))
> > +     if (copy_header_from_ring(ent, FUSE_URING_HEADER_IN_OUT, &out_hea=
der,
> > +                               sizeof(out_header)))
> >               goto out;
> > +     req->out.h =3D out_header;
> >
> >       err =3D fuse_uring_out_header_has_err(&req->out.h, req);
> >       if (err) {
>
>
