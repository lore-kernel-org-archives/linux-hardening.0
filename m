Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E753B239E9D
	for <linux-hardening@vger.kernel.org>; Wed, 11 Feb 2026 02:07:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770775647; cv=pass; b=H2f8nGbsd5fo8Wg1sYhi2dfA6QQKlPefWa1EqoRy6xcyYBFg9AGXXQHNG/Yb23zp2MLQY0OruAzh+2Rm5EWfp8uxoGTetztTMBsR5McD4m7jsC2Q6Kny4qb2kBSqjqOGNIeiLIBN/g29gRZxbeFGNiQsxt1d1LytMl3gRbfvmNI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770775647; c=relaxed/simple;
	bh=AxBXb5SCGivO3xfe6IfaEGDChh6p7TOiflwqConeq6I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LlygmGaJPkiQqBwtLJHkbvjbClFxQUBZ5KPXiUZfeeNRFsNCU615H6Ve0PmZgKDdq5RhmBD+/xhNyzYCzJfM0AFKfjjxPhy513FYh/uaBsbQlrskD1X1Mcw6l3JBazh1brzD0BJO4m1fKgVv8BqwVy9zprtg7qTmgUQaNmoTtPM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=kwMQgQTm; arc=pass smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="kwMQgQTm"
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-65821afe680so2688a12.1
        for <linux-hardening@vger.kernel.org>; Tue, 10 Feb 2026 18:07:25 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770775644; cv=none;
        d=google.com; s=arc-20240605;
        b=ZFJMPy8rAGBirqT1xioA/5twwwRf6JM69CQPrhaKKvlaixOSPXh51YakaZVirSTnqG
         IXM26R0CHdyqSnukEQhg0ambwzKyL6dqVISjL6nTYp2+b/8pWxNC4nzy8F07vBqJFt/G
         w7TqYavLwF91mkJ9H/qrjviYv6DPfAOQWanEsNf2LnYouZl8c7ml0wqWTpb1DsZEFTEL
         tmQfGIquMGtUKM8okJV6e1jUEylIy5EXYnKoLX1eGcQqj0E/tTRPMPsfSIDPjAp4UM9t
         FEZ7xkHQgyFY5AyXkJmgrSWY6qSEZjiuGM0CH9WQ3Xxn8eMuanNlqANuaQvqZwnFy1oN
         DjMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=mJabroHKALl1X22f8hKKr+ilxhz+jnb/D5nxpOzqNdI=;
        fh=AJnz78mAwRnb8GyiZkLjB6Or81X8R7hhqy6h8MOPBWs=;
        b=hlu+sRGm6Tkf3oP5DvmJy18/xSzeddk5TQCUKukuuZwUqAqMr4WywaxMwFbbs4zS22
         2U5fmBUrtHJU2tFT+EgxsiQBZVglZkH3Zv1crooqxnTGc/XUIJGm832wJmhhYhDkYA7X
         p6SIDYUj6frGzDipu22x4huTASQI/7yTCckGZmJOVO2B85jSYcVNyg9yFsHq1yHP4hs2
         O+FdVOqL+I0xUBQFjbQloJ8rrI67lINwdC6taRBAUVv4mH5IY7KU7Hb31cYpi+AJfgEB
         QzDH96+GCtw+ulpnlKyIfP/wEFBjrgrTjMZLrySN9abD1dyKHOErsum4cZ22kkwlXAA6
         7lRg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1770775644; x=1771380444; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mJabroHKALl1X22f8hKKr+ilxhz+jnb/D5nxpOzqNdI=;
        b=kwMQgQTmJfN9PVA0aEgm0CgVfM1+JON/K003EM+EmfGKnX72epEWd0CHvjFm/s0kOm
         gOwJE+ZrG4mZ2h31ZZ7mOqL/ekc6sMFLMDOxWWm7s9SqI7kXMSIpaCiCGA4uaXeRRyaB
         zMr3zgEESWKn/rBW4m6EJRocF/tvnEBkVECRkZOKceEM7ValV1cID9IwzQC/MqvUsPgR
         DOGzkulQmvWaTHxpfi/jxiST5gVDCws0t6gzbNcDcbnwGJ2ii+90mcaCKblH/g+4hIwW
         omXaBMNImLI0Uj4GeNp6ec3fAIM+YIkEndhIR1v1whfctqlWMjoJgRyWLWnnWK/rMf0X
         wF3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770775644; x=1771380444;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=mJabroHKALl1X22f8hKKr+ilxhz+jnb/D5nxpOzqNdI=;
        b=vMYil9FOpjssCFc4rMeRIG1xbjZ2PccUmT4kdoGquIfor7HpH9uEV6C0Te6iRIQncE
         scUBcGLjMmp7g5dL8JSOMYbbvWCVeCq3lo1hZ1+hfmhm1Li/+jCItW1Dc/3Yomw+OyFx
         OydN1OWU4mreOiBIiFsMMdWLI3DYHEtWjh95IjWH0HEV0Fx75r3munQfbzxUHNVs5m92
         VVg05E15ccvHse3F9H6I6/ImFxjQ+QuwaD9YRgAHgpjC5k9TUJzGt19fdkFWCwmRg55f
         LJcC5eUqNbTLU6+vyxHE4dq02CLOWY7xAt/fu492FL5YqUnofxvOefXdFVUx0iC5F/NK
         13cQ==
X-Forwarded-Encrypted: i=1; AJvYcCUDvkVFL5M6Vs4k8IxubK3gARAxk6B4PE74yZSwW4yRcNLsfYOoyO/HrMlGNTWk388XO9NCa9nYDfwCzTEXlvc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwbX2xM+nq8xD1/Y4mIvd75e/50J0c7i7westkWlj2UKD2iKdoy
	2L38OlMW0WQEMUNCKDpUkVx1Nq6og71SbZMam2HZIJ/jDfcMLQIDNJ4hycT5ojxJiOLeIpK2uE2
	qBhvKP7bQ2YLJtphvhoWNl9M3qH88YATDSyzD3TXE
X-Gm-Gg: AZuq6aIW3YX2rUrc4/yAZ5PZcVlQRz5zvyfWxSyKy8pNJPBGPRfWwsf34w9tnxlmbPt
	O0KrPuJlHzNWFtwOAo/ShXOC0UYHqzDHOgM2WD6hnrH2bmirFbj17Ln7R1C0Ak+NiF1EqLvXMgF
	u6xTrhtOO+QUr2ztxiOn5xUlukTG2mMidmyZWZiuacK7UEYXj1ykM9lMOcbaJHExkGxn8PCmiC5
	VgZp51kHwfOd4oT2glynxwFX5tD0HrYHGj8Gy2INrgAMP8kzHnvoZJPlmN+9KrQalkMJY1ItUME
	MzM7qu/KRGSExcyPNSP4p+xdx1xoWxBvBsEamG/nCfczKsE=
X-Received: by 2002:aa7:cf01:0:b0:65a:14a1:b1b9 with SMTP id
 4fb4d7f45d1cf-65a3c82019emr9271a12.7.1770775643972; Tue, 10 Feb 2026 18:07:23
 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260211004811.work.981-kees@kernel.org> <CAG48ez1GYR+6kZHDmy4CTZvEfdyUySCxhZaXRo1S=YyN=Fsp8Q@mail.gmail.com>
 <202602101736.80F1783@keescook>
In-Reply-To: <202602101736.80F1783@keescook>
From: Jann Horn <jannh@google.com>
Date: Wed, 11 Feb 2026 03:06:47 +0100
X-Gm-Features: AZwV_QjPTRHY7ecu-LGBz6_R6c4vMFqAvHTO5CIG3USeS7WeOghwX1xpcWJ5bfc
Message-ID: <CAG48ez1wxj5uxuMXQLV+yxfT4gumNSoK8UX2+K=5aCLAKg+VPg@mail.gmail.com>
Subject: Re: [PATCH] fs: Keep long filenames in isolated slab buckets
To: Kees Cook <kees@kernel.org>
Cc: Al Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 11, 2026 at 2:41=E2=80=AFAM Kees Cook <kees@kernel.org> wrote:
> On Wed, Feb 11, 2026 at 02:28:53AM +0100, Jann Horn wrote:
> > On Wed, Feb 11, 2026 at 1:48=E2=80=AFAM Kees Cook <kees@kernel.org> wro=
te:
> > > A building block of Use-After-Free heap memory corruption attacks is
> > > using userspace controllable kernel allocations to fill specifically =
sized
> > > kmalloc regions with specific contents. The most powerful of these ki=
nds
> > > of primitives is arbitrarily controllable contents with arbitrary siz=
e.
> > > Keeping these kinds of allocations out of the general kmalloc buckets=
 is
> > > needed to harden the kernel against such manipulations, so this is wh=
y
> > > these sorts of "copy data from userspace into kernel heap" situations=
 are
> > > expected to use things like memdup_user(), which keeps the allocation=
s
> > > in their own set of slab buckets. However, using memdup_user() is not
> > > always appropriate, so in those cases, kmem_buckets can used directly=
.
> > >
> > > Filenames used to be isolated in their own (fixed size) slab cache so
> > > they would not end up in the general kmalloc buckets (which made them
> > > unusable for the heap grooming method described above). After commit
> > > 8c888b31903c ("struct filename: saner handling of long names"), filen=
ames
> > > were being copied into arbitrarily sized kmalloc regions in the gener=
al
> > > kmalloc buckets. Instead, like memdup_user(), use a dedicated set of
> > > kmem buckets for long filenames so we do not introduce a new way for
> > > attackers to place arbitrary contents into the general kmalloc bucket=
s.
> > >
> > > Fixes: 8c888b31903c ("struct filename: saner handling of long names")
> > > Signed-off-by: Kees Cook <kees@kernel.org>
> > > ---
> > > Also, from the same commit, is the loss of SLAB_HWCACHE_ALIGN|SLAB_PA=
NIC
> > > for filename allocations relavant at all? It could be added back for
> > > these buckets if desired, but I left it default in this patch.
> > >
> > > Cc: Al Viro <viro@zeniv.linux.org.uk>
> > > Cc: Christian Brauner <brauner@kernel.org>
> > > Cc: Jan Kara <jack@suse.cz>
> > > Cc: <linux-fsdevel@vger.kernel.org>
> > > ---
> > >  fs/namei.c | 10 +++++++---
> > >  1 file changed, 7 insertions(+), 3 deletions(-)
> > >
> > > diff --git a/fs/namei.c b/fs/namei.c
> > > index 8e7792de0000..a901733380cd 100644
> > > --- a/fs/namei.c
> > > +++ b/fs/namei.c
> > > @@ -128,6 +128,8 @@
> > >  /* SLAB cache for struct filename instances */
> > >  static struct kmem_cache *__names_cache __ro_after_init;
> > >  #define names_cache    runtime_const_ptr(__names_cache)
> > > +/* SLAB buckets for long names */
> > > +static kmem_buckets *names_buckets __ro_after_init;
> > >
> > >  void __init filename_init(void)
> > >  {
> > > @@ -135,6 +137,8 @@ void __init filename_init(void)
> > >                          SLAB_HWCACHE_ALIGN|SLAB_PANIC, offsetof(stru=
ct filename, iname),
> > >                          EMBEDDED_NAME_MAX, NULL);
> > >         runtime_const_init(ptr, __names_cache);
> > > +
> > > +       names_buckets =3D kmem_buckets_create("names_bucket", 0, 0, P=
ATH_MAX, NULL);
> > >  }
> > >
> > >  static inline struct filename *alloc_filename(void)
> > > @@ -156,7 +160,7 @@ static inline void initname(struct filename *name=
)
> > >  static int getname_long(struct filename *name, const char __user *fi=
lename)
> > >  {
> > >         int len;
> > > -       char *p __free(kfree) =3D kmalloc(PATH_MAX, GFP_KERNEL);
> > > +       char *p __free(kfree) =3D kmem_buckets_alloc(names_buckets, P=
ATH_MAX, GFP_KERNEL);
> > >         if (unlikely(!p))
> > >                 return -ENOMEM;
> >
> > I think this path, where we always do maximally-sized allocations, is
> > the normal case where we're handling paths coming from userspace...
>
> Actually, is there any reason we can't use strnlen_user() in
> do_getname(), and then just use strndup_user() in the long case?

I'm not an expert, but as far as I know, this path is supposed to be
really fast (because pretty much every syscall that operates on a path
will hit it), and doesn't care how much memory it allocates (because
these allocations are normally only alive for the duration of a
syscall). strnlen_user() would add another pass over the userspace
buffer, which I think would probably have negative performance impact?

> > > @@ -264,14 +268,14 @@ static struct filename *do_getname_kernel(const=
 char *filename, bool incomplete)
> > >
> > >         if (len <=3D EMBEDDED_NAME_MAX) {
> > >                 p =3D (char *)result->iname;
> > > -               memcpy(p, filename, len);
> > >         } else {
> > > -               p =3D kmemdup(filename, len, GFP_KERNEL);
> > > +               p =3D kmem_buckets_alloc(names_buckets, len, GFP_KERN=
EL);
> >
> > ... while this is kind of the exceptional case, where paths are coming
> > from kernelspace.
> >
> > So you might want to get rid of the bucketing and instead just create
> > a single kmem_cache for long paths.
>
> I wasn't sure if there was a controllable way to reach this case or not.

I don't understand your point. I'm suggesting that in both of these
two cases, you can just allocate from the same dedicated slab.

But yes, you can get controlled data into the filename passed to
do_getname_kernel() - for example, when you execute a script (a file
that starts with "#!"), the interpreter path after "#!" is passed from
load_script() to open_exec(), which uses CLASS(filename_kernel, ...).

> > By the way, did you know that "struct filename" is only used for
> > storing fairly-temporary stuff like paths supplied to open(), but not
> > for storing the names of directory entries in the dentry cache (which
> > are more long-lived)? My understanding is that this is also why the
> > kernel doesn't really try to optimize the size of "struct filename" -
> > almost all instances of it only exist for the duration of a syscall or
> > something like that.
>
> Right, but it was enough of a location change that I felt like it was
> worth fixing it up.
>
> > The dentry cache allocates long names as "struct external_name" in
> > reclaimable kmalloc slabs, see __d_alloc().
>
> Oh hey, look at that!
>
>                 struct external_name *p =3D kmalloc(size + name->len,
>                                                   GFP_KERNEL_ACCOUNT |
>                                                   __GFP_RECLAIMABLE);
>
> Yeah, let's put that into dedicated buckets instead?

Actually, looking around a bit, there really aren't that many
allocations with __GFP_RECLAIMABLE, so this probably isn't all that
useful for same-cache attacks. (To be clear: Anything with
__GFP_RECLAIMABLE goes in the special kmalloc-rcl-* slabs.) Looking
around, the only other kmalloc users of __GFP_RECLAIMABLE I see are:

 - alloc_buffer_data() in drivers/md/dm-bufio.c
 - fuse_dentry_init()

So I don't think there's anything to be done here, this is already
using quasi-dedicated buckets. Sorry for the distraction.
