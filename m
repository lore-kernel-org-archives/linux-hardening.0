Received: from mail-dl1-f47.google.com (mail-dl1-f47.google.com [74.125.82.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E88A349CFB
	for <linux-hardening@vger.kernel.org>; Wed,  1 Jul 2026 14:34:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782916456; cv=pass; b=PKZsIT6GWVasjwPj60xRJSKPiffgCbudig9qyknjiu3SXB8+Cz46WctvqGBlEhFufsxKGcaWkp32mp5ffOGFQumvj3jX2O+EqVsAg403dA//Dp3voqAT6Ym7QVzdzvkpkVwAQi3ssiWf08m6IV9HWE225rL7710+c+D3QnsrOoY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782916456; c=relaxed/simple;
	bh=nScH6XgHWG5/YH6hVP52IOK9IGeYY63RZu3Ttrlpw3s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hU5zHcJG1+KpPN79xjHnz4dMQAfJEWSaQDP1fbJJg2kJBt+JoOkUvUzHoWlstdpUGa7cFdh9jGYeUc17I8m87AxcBsf/RSD0XxF0tXqy67WpqoF+IoUixIkHaZAGKmn+NmfHLT0sgPlgL7U5KJxzTspG9nVjK6kdmAtTcHPOERA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=T1tNx+yE; arc=pass smtp.client-ip=74.125.82.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T1tNx+yE"
Received: by mail-dl1-f47.google.com with SMTP id a92af1059eb24-139aff562e1so905443c88.1
        for <linux-hardening@vger.kernel.org>; Wed, 01 Jul 2026 07:34:14 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782916454; cv=none;
        d=google.com; s=arc-20260327;
        b=QrqclKZNCagLLbFEsU1tDphEnYA5lsgOo4PGwCvPGZLgJxJPddQtLVbu5FKWpVMDF4
         CXVL8+x6vaWOtEd8GlSULuUy2rNSsoa2UBSDa9kkG+xHpEDlSnLvSmuYRt0Q82RgfePY
         zmAf4QLSEKsdDfZN+GbvlX0o9vXumR0UpbkkNAkoH2nUg/QBV70FAxXfTBMdvPk8e8Cz
         saWRzcDrRBkCPsHM9U81iJO1eneUZOJQ5PXPOzOsRg7LF/GTr4WiOP991d5uFoTjQYz5
         mZnIEj4Sd/gdbHBrlxMj9815dSmkgaIbBnf8fsfNAtXV9hwzjXh9y4RwfMIiocwl5fI8
         TwLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=iwVYZrdp3pBufrtH9uIwN+HSbNCrXKXub0G6eGVamA4=;
        fh=6IhV8ZoaqqSV3U+BQ4UUzkP1A5fcK7LK+P/QZurKIIg=;
        b=WK8FBv+vaKgy/Yw3wFCEbtuIw++lZQcdBahca/tFstgGvcrNLAjrCnXAAJ1+gR8sgL
         Y9Z3D9Mdzk6+nlVxshyg967plp7+TB1N96hdzt5nqErqsOlJ3bvZDKugPqMxpmV0d3xX
         VKfhR0Lax6LABWjOVnnbvutSeMJmYBLaJZK0ugy2FMTVjuo29QIy3Zn9qnr7z5wz8ZEY
         ZfcDzXtHCKLp2aPvfbBEPWJor2sOIfISc+7MFnuqid3N8HbxMmbb3C1Gbk8HXXVYofCw
         MNgm3r6YVMgCY5cYDD/jF3+vEjq8MLz14adK4SVxZbQv84cEJefZF8vU7vSkuXma0qQO
         M4lA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782916454; x=1783521254; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iwVYZrdp3pBufrtH9uIwN+HSbNCrXKXub0G6eGVamA4=;
        b=T1tNx+yENEh3x37rJHzN8+Vmv/LwdAZ9cw6neYGvMByiftZi33PpK+HDp8N6vNxyGr
         bEKxaASGPW3jQ9QtjKBL+uHJtXd5NOTldBEHOXmlItohKI0lu00pELB3aybaP8IctN+6
         0/IPPmmyKJuNzOwp5k0YxrhBiIYVD/SeVGmQnqq9DnZ+XNvtc0wdvZc/ct1X9n52Xw3v
         2jDMtq7FNuxAXexbCG3oMDeuaUxyqZme7W8HWoFjw7IM939mOMDYaMBwx5cNcYOPRpFB
         XH/zwDdy+HPRHNJgBv7vdDvXAbzPMl0gBMneNicJu5enj2ehV6YvK21uQgG1CgIcA5Nu
         m2Iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782916454; x=1783521254;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=iwVYZrdp3pBufrtH9uIwN+HSbNCrXKXub0G6eGVamA4=;
        b=FQNnT1YLRpk9LTx6ZQNfQiuzF+HlArvyfQQxXYLByCIIbAVvARvAxlXk+jX4bWc/+a
         KnxB6vLNMDF7Gt5eXmu1tABY2JVznMhOw93lD+3rF87Yd6ZZGiP9mQVQeq1xREbx5SgH
         lwVz7E9k2zAvbC6sKn56edPm0pBvm4YK704tQw4E8cIFHJ97sfc83kw5RnY/80wZoENP
         xVL2tM90KfWMLT5mvwYoy7xXAMgM422gwPiVQJC3ak1MPzRCRWdxWGnEOai0E6+rRLtl
         Lsh7ae6iv7VSrKsHJlof7fbqwwgEtWSFY2bde5eyEU5ckd6x8NAaY300rzLvJ8Fwjs9B
         lRDA==
X-Forwarded-Encrypted: i=1; AFNElJ+AXoebw+qgTWcRKEuB2jYlsfZngA2Kam2N1mFRANpJPQPm5bGZIXryoa/cfenpKZl3y8Zle35my1qbPmnS570=@vger.kernel.org
X-Gm-Message-State: AOJu0YzfpH/qcNp/0ZKjv6rrIBBTzrVsBRX/1Zp6I9/BDh0cWB+a9S0w
	8axpIMxD3HUESd73x7gzAbyY9yM9kc7dhzfftTk2nh7PaMdcFom/FDWFOqoSU5HYVvAtuDtx9OK
	JXbtnOnIdFo0t7uQWO3lwUuYr3SHQMzLNUNSQWu4=
X-Gm-Gg: AfdE7clko8yGX7wLXMRa3inY3CHTbb0pkS0EqaYijMY3PctK9yK73PeDQEtaY5zFxrV
	u1IPL1jVzF8PV/My5CCjHmmD3q3QscKJqUdI4662OrYKSgtvuDoXa+HaoPm7LL4hw9+xoKEDbN9
	v3mOH0Vv5OG+gSluJmCn+SAFOy9NtAYL6ezEMB+Msrrt37zL2nsRXyxCDX+HGhsZMSAnsRanBaV
	iZFlVO/CBum4F2KhWaMaFuthU4mrumnrK/I3wOnKVYOB+tG4xMWxKWMmplGEy5HkJNhKiNqrXkp
	SdKTNbXV/N67TkH+UMPD2rOGT0K8
X-Received: by 2002:a05:7022:41a3:b0:139:f42b:312a with SMTP id
 a92af1059eb24-13b36e15beemr1742401c88.47.1782916453970; Wed, 01 Jul 2026
 07:34:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260624073921.11037-1-harshal24.chavan@gmail.com>
 <20260624124019.4521-1-harshal24.chavan@gmail.com> <87fr2auzq3.fsf@mailhost.krisman.be>
In-Reply-To: <87fr2auzq3.fsf@mailhost.krisman.be>
From: Harshal Chavan <harshal24.chavan@gmail.com>
Date: Wed, 1 Jul 2026 20:04:01 +0530
X-Gm-Features: AVVi8Cd54HdvfcZK3ijCUjZXZJ4rdeAEo9_ckhBzjXUfbmwuFveHh4ESAyr6KSM
Message-ID: <CADCAkb6wuR7vT3chfFtBL0qma+gx-2mJM7v+JJLS00W3oyb5dg@mail.gmail.com>
Subject: Re: [PATCH v6] io_uring/register: add IORING_REGISTER_CLONE_FILES opcode
To: Gabriel Krisman Bertazi <krisman@suse.de>
Cc: axboe@kernel.dk, gregkh@linuxfoundation.org, gustavoars@kernel.org, 
	io-uring@vger.kernel.org, kees@kernel.org, linux-hardening@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

>> +     file =3D io_slot_file(src_node);
>> +     get_file(file);
>> +     io_fixed_file_set(dst_node, file);

> don't you need to copy the src_node->tag here as well?

Yes, sorry for the silly mistakes, thanks for catching this!

> I didn't get a chance to run it yet, sorry.  I'd suggest you wait for
> Jens feedback before pushing the v7 too, so you don't need to keep
> iterating drop by drop :)

Okay, Yes I will wait for feedback from Jens and send the changes together
Thanks for the review.

Regards,
Harshal Chavan

On Fri, Jun 26, 2026 at 2:03=E2=80=AFAM Gabriel Krisman Bertazi <krisman@su=
se.de> wrote:
>
> Harshal Chavan <harshal24.chavan@gmail.com> writes:
>
> > Currently, if an application wants to duplicate registered file
> > descriptors from one io_uring instance to another, it must manually
> > unregister and re-register them, incurring unnecessary overhead.
> >
> > Add IORING_REGISTER_CLONE_FILES to allow direct cloning of the file
> > table from a source ring to a destination ring. This implementation
> > strictly mirrors the io_clone_buffers UAPI, supporting partial offsets
> > and the IORING_REGISTER_DST_REPLACE flag.
> >
> > To ensure lock synchronization safety, destination nodes are strictly
> > allocated as new, private io_rsrc_nodes rather than sharing references
> > across rings.
> >
> > Signed-off-by: Harshal Chavan <harshal24.chavan@gmail.com>
> >
> > ---
> > Sorry for the noise on the previous email! I accidentally sent the patc=
h
> > before running checkpatch and missed a whitespace error. This v6 correc=
ts it.
> >
> > v6:
> >   - Fixed trailing whitespace checkpatch error.
> > v5:
> >   - Added missing spacing in comment (Gabriel).
> >   - Removed ctx->user and mm_account checks (Gabriel).
> >   - Used !! for boolean conversion (Gabriel).
> >   - Moved mutex_unlock unconditionally above the out label (Gabriel).
> >   - liburing implementation and tests: https://github.com/axboe/liburin=
g/pull/1606
> > v4:
> >   - Updated Signed-off-by to use real name and moved above the scissors=
 line (Greg KH).
> > v3:
> >   - Rewrote the cloning loop to allocate private destination nodes via =
io_rsrc_node_alloc to fix non-atomic ref lock synchronization (Jens).
> >   - Maintained partial offset/copy support to mirror io_clone_buffers U=
API (Jens).
> >   - Gated the replacement free check on ctx->file_table.data.nr (Gabrie=
l).
> >   - Prevented self-cloning by checking ctx =3D=3D src_ctx (Gabriel).
> >   - Removed submitter_task check to allow cross-thread pooling setups (=
Gabriel).
> > v2:
> >   - Dropped unrelated whitespace formatting changes from v1
>
> > +static int io_clone_file_node(struct io_ring_ctx *ctx,
> > +                           struct io_rsrc_node *src_node,
> > +                           int dst_index,
> > +                           struct io_file_table *new_table)
> > +{
> > +     struct io_rsrc_node *dst_node;
> > +     struct file *file;
> > +
> > +     dst_node =3D io_rsrc_node_alloc(ctx, IORING_RSRC_FILE);
> > +     if (!dst_node)
> > +             return -ENOMEM;
> > +
> > +     file =3D io_slot_file(src_node);
> > +     get_file(file);
> > +     io_fixed_file_set(dst_node, file);
>
> don't you need to copy the src_node->tag here as well?
>
> I didn't get a chance to run it yet, sorry.  I'd suggest you wait for
> Jens feedback before pushing the v7 too, so you don't need to keep
> iterating drop by drop :)
>
> > +
> > +     new_table->data.nodes[dst_index] =3D dst_node;
> > +     io_file_bitmap_set(new_table, dst_index);
> > +
> > +     return 0;
> > +}
> > +
> > +static int io_clone_files(struct io_ring_ctx *ctx, struct io_ring_ctx =
*src_ctx,
> > +                       struct io_uring_clone_files *arg)
> > +{
> > +     struct io_file_table new_file_table;
> > +     unsigned int dst_nr =3D ctx->file_table.data.nr;
> > +     unsigned int src_nr =3D src_ctx->file_table.data.nr;
> > +     unsigned int new_nr, i;
> > +
> > +     lockdep_assert_held(&ctx->uring_lock);
> > +     lockdep_assert_held(&src_ctx->uring_lock);
> > +
> > +     if (dst_nr && !(arg->flags & IORING_REGISTER_DST_REPLACE))
> > +             return -EBUSY;
> > +
> > +     if (!src_nr)
> > +             return -ENXIO;
> > +
> > +     if (!arg->nr)
> > +             arg->nr =3D src_nr;
> > +     else if (arg->nr > src_nr)
> > +             return -EINVAL;
> > +
> > +     if (check_add_overflow(arg->src_off, arg->nr, &i) || i > src_nr)
> > +             return -EINVAL;
> > +     if (check_add_overflow(arg->dst_off, arg->nr, &i))
> > +             return -EINVAL;
> > +
> > +     new_nr =3D max(dst_nr, arg->dst_off + arg->nr);
> > +     if (new_nr > IORING_MAX_FIXED_FILES)
> > +             return -EINVAL;
> > +
> > +     memset(&new_file_table, 0, sizeof(new_file_table));
> > +     if (!io_alloc_file_tables(ctx, &new_file_table, new_nr))
> > +             return -ENOMEM;
> > +
> > +     /* Copy original nodes from before the cloned range */
> > +     for (i =3D 0; i < min(arg->dst_off, dst_nr); i++) {
> > +             struct io_rsrc_node *src_node =3D io_rsrc_node_lookup(&ct=
x->file_table.data, i);
> > +
> > +             if (!src_node)
> > +                     continue;
> > +             if (io_clone_file_node(ctx, src_node, i, &new_file_table)=
)
> > +                     goto out;
> > +     }
> > +
> > +     /* Copy the actual cloned range from the source ring */
> > +     for (i =3D 0; i < arg->nr; i++) {
> > +             struct io_rsrc_node *src_node =3D io_rsrc_node_lookup(&sr=
c_ctx->file_table.data,
> > +                             arg->src_off + i);
> > +
> > +             if (!src_node)
> > +                     continue;
> > +             if (io_clone_file_node(ctx, src_node, arg->dst_off + i, &=
new_file_table))
> > +                     goto out;
> > +     }
> > +
> > +     /* Copy original nodes from after the cloned range */
> > +     for (i =3D arg->dst_off + arg->nr; i < dst_nr; i++) {
> > +             struct io_rsrc_node *src_node =3D io_rsrc_node_lookup(&ct=
x->file_table.data, i);
> > +
> > +             if (!src_node)
> > +                     continue;
> > +             if (io_clone_file_node(ctx, src_node, i, &new_file_table)=
)
> > +                     goto out;
> > +     }
> > +
> > +     /* free the old file table if there is any data present */
> > +     if (dst_nr)
> > +             io_free_file_tables(ctx, &ctx->file_table);
> > +
> > +     WARN_ON_ONCE(ctx->file_table.data.nr);
> > +     ctx->file_table =3D new_file_table;
> > +     io_file_table_set_alloc_range(ctx, 0, ctx->file_table.data.nr);
> > +     return 0;
> > +
> > +out:
> > +     /* Error Path: Safely destroy whatever we partially built */
> > +     io_free_file_tables(ctx, &new_file_table);
> > +     return -ENOMEM;
> > +}
> > +
> > +int io_register_clone_files(struct io_ring_ctx *ctx, void __user *arg)
> > +{
> > +     struct io_uring_clone_files clone_arg;
> > +     struct io_ring_ctx *src_ctx;
> > +     bool registered_src;
> > +     struct file *file;
> > +     int ret;
> > +
> > +     if (copy_from_user(&clone_arg, arg, sizeof(clone_arg)))
> > +             return -EFAULT;
> > +     if (clone_arg.flags &
> > +         ~(IORING_REGISTER_SRC_REGISTERED | IORING_REGISTER_DST_REPLAC=
E))
> > +             return -EINVAL;
> > +
> > +     if (memchr_inv(clone_arg.pad, 0, sizeof(clone_arg.pad)))
> > +             return -EINVAL;
> > +
> > +     registered_src =3D !!(clone_arg.flags & IORING_REGISTER_SRC_REGIS=
TERED);
> > +     file =3D io_uring_ctx_get_file(clone_arg.src_fd, registered_src);
> > +     if (IS_ERR(file))
> > +             return PTR_ERR(file);
> > +
> > +     src_ctx =3D file->private_data;
> > +     /* Same ring clone is not allowed */
> > +     if (src_ctx =3D=3D ctx) {
> > +             ret =3D -EINVAL;
> > +             goto out;
> > +     }
> > +
> > +     mutex_unlock(&ctx->uring_lock);
> > +     lock_two_rings(ctx, src_ctx);
> > +
> > +     ret =3D io_clone_files(ctx, src_ctx, &clone_arg);
> > +
> > +     mutex_unlock(&src_ctx->uring_lock);
> > +
> > +out:
> > +     if (!registered_src)
> > +             fput(file);
> > +     return ret;
> > +}
> > +
> >  void io_vec_free(struct iou_vec *iv)
> >  {
> >       if (!iv->iovec)
> > diff --git a/io_uring/rsrc.h b/io_uring/rsrc.h
> > index 44e3386f7c1c..32f5c47c46af 100644
> > --- a/io_uring/rsrc.h
> > +++ b/io_uring/rsrc.h
> > @@ -75,6 +75,7 @@ int io_prep_reg_iovec(struct io_kiocb *req, struct io=
u_vec *iv,
> >                       const struct iovec __user *uvec, size_t uvec_segs=
);
> >
> >  int io_register_clone_buffers(struct io_ring_ctx *ctx, void __user *ar=
g);
> > +int io_register_clone_files(struct io_ring_ctx *ctx, void __user *arg)=
;
> >  int io_sqe_buffers_unregister(struct io_ring_ctx *ctx);
> >  int io_sqe_buffers_register(struct io_ring_ctx *ctx, void __user *arg,
> >                           unsigned int nr_args, u64 __user *tags);
> > --
> > 2.54.0
> >
>
> --
> Gabriel Krisman Bertazi
