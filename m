Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8D6A286881
	for <linux-hardening@vger.kernel.org>; Wed, 11 Feb 2026 01:29:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770773373; cv=pass; b=cPO2xkwMhYb9n27efmkOjr2zZyEeY8rV9WOhp4PVXnCwi4bIA3N7GRfkipniPzm50ySfwyIqalWJHVj6j1NBJG/HHc5TyxkzyytzouWd3LGr2/a5BtZ4kOQGaYtguCdJHxYJv7TWRrNsdTJ0IxzMvyHSh7JYhjWGLPUbe8HFGW0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770773373; c=relaxed/simple;
	bh=qPcsPEFBNihehnPF+Cns71ACRy30CkK7Nd4hn+r9XP8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mH4egQooi0ODfyqlP/XzXzaf00dgnn/hhFbEvtnpzj5KT17sfsdhEPkYQMjZEFDeFh7cHRNtyeoTTYiuCLHh6WreRXEVGFtz7d49tRiwNlQiPJR9ZwpW2vA/2Tri4/QIX07AVHaGc5UTcISL+FBN9Im0sMgwQEDTn7t+nAPSOQ0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=xkAXTK6F; arc=pass smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="xkAXTK6F"
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-65a38c42037so3110a12.0
        for <linux-hardening@vger.kernel.org>; Tue, 10 Feb 2026 17:29:31 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770773370; cv=none;
        d=google.com; s=arc-20240605;
        b=Hc9nSc6BMIOaWD5BQ8gDHRW+qY+F0xHsn1fkRLkmBd/agXCj6/xWDFFVHUURtdH4LX
         Jc3QWJ59dUBRSOhu/s3b7w2cT8RgQBpLZXodOuXdZwV4T8W3nemUboghIibeKvh/CkKx
         8dlY6KnDD09/dKntc03hwTjKbC8jxVgM7gKeFZ/WdXy3imAnwZ9kS7WmGbot4ZGSzEqV
         70ZQBERgHSIR69MsPdjcmyXs2Um2A03/QF31++VRb1QxOn7Ye0rN2DGZVd/qVS9WXoO1
         mEL1nVmN/N9DxjFmLBjLM17Y/BpfjYeMYtJ85bI1KRM3N23tm2bUWx85tS57+6BexlCa
         J6Vw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=8ImABGGp9PxKOWR+p+P+PfGguTUlRP81TAKub83SFos=;
        fh=baJTuOwHBLl6y76SO+BJsI1/qGXVzDDn0nPtjjSNOm8=;
        b=N1BU1KT/KnkXyQ7u1fM5YbHjZg0JQw35y+zmEYb4G0REdq1Dgbx0oYgMspkM4MSI28
         8QodMf7USpfl4gjh+zYGufcpVwy5vmgIL0jEah5FcE2BaxoCj1Athy4WhE3CBbG+heE2
         Sq/vC4louzrWKOmdO8NnVpsLVVfGIbcXjVCCMSjA9D4/QxZdVpFLdkVdI0FiRQVIobEw
         HcDgJpiuVCIVSqDdUreX6FRadPlP7NqvMJVSt27cCGQKmPiIP7Dwc//aESlRqMWTaMW0
         3pa8eGfxfuMe7xGwXLJImoAGsuym91+8+maAkmQKK6PuM3dJge9NSNjNwMRBUtn3DJvE
         dHOw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1770773370; x=1771378170; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8ImABGGp9PxKOWR+p+P+PfGguTUlRP81TAKub83SFos=;
        b=xkAXTK6FExNpSywfGt3ShJ6WS2Msw+YDL1p25lLvi/J1HSeauJS1qCD9hK8kd+Axgb
         st4wN4VPtSb31zdQfvTeaoguJeRMiQPRb+SmtIm/qMU0YyYh5H7AP3LL49RGwhsgxxOL
         Djd012HMkkdZ+e80BDEgELdtdluAZ1limUuxuMZAzO+iExqbbohj5xFEcKfogsem6qxZ
         vd4GWkctt0sMJfxL2V///ws1OOkGxn4QjFWWfu51+70aLXpVUGEcEyM1x8TMT2YGvIcC
         SToVhk6hejwQVPH34BlVo87Tdku7VRwT/vrrY40LTkaeTGWf413RQX6UQbCcuGYum0bj
         hOJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770773370; x=1771378170;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=8ImABGGp9PxKOWR+p+P+PfGguTUlRP81TAKub83SFos=;
        b=IJy4JGnf4p3ikDcktm1SFfg2xoTOLWtA/UfAOj0Yz3cDl6fjOcaAwlkkU+u07u0GoY
         U+wJGzjSmVGse/JysVPz+Rkvbe1tIphddaOssEQiY93YqSMTm653L0Bxff3zEBEyOTJb
         a3d+dAhYZ+jxx1hY0UMxWulCADKIe0nQB5J27e0V/QgeqUVIYlf/399JIYpJFgFPxubW
         EH1yCgJzQpe19myBs2/BsFLyMPVkZtqP22UA5t2oUmW49+i1u56S6i00ydSS4l5RQmLT
         1UXdJB6skMAYrUbRtK0UgoDHnJ6fiNLVZ90dFgZQwaPG3gm9vczle3JmfdGsN7Vi0B4/
         FLHA==
X-Forwarded-Encrypted: i=1; AJvYcCUGfXS1GH15ZqOJQwMvv7XNXkZ5TcsXwRUNrzio5t7DA4ro3saSUgspiOywOiy+TR+kni6fsaf+oFl2Du84OoY=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywwtt7cUiPRnE0wpH3WynJg4DiHjl0gwE1P8UPx4FH1K4fGWTCi
	UJrIdUUNvEtT7oB+jprY74oGsO2iByfwiFzfk2cMcSxgOXU7ljd+SauZ96rq1U+2hjkWV99rWWO
	Xae9DFHYJxl2CPlWJiRW+qWytztAiyK+B454A7gHH
X-Gm-Gg: AZuq6aJcSnI4fol5mGNdOYc74Xl+WUY24IMGCTgtuUd0167ZGj3/pY75l+tEB7khkRj
	uwDQD1kR8CTY4p3tXSIlEKd+dfNhvGjxluVInb1v+zwKiKTVBsMO2SwWcJ6zGX6i4zvFfs7Zn1u
	VqJjhcXpR5yCfQ5WZPZoNwoOiUZhysv/GFn3t/ylqzOxHRAt3s0gaeVkHBuVfX4WODH83BGu2JO
	8yrk4u97HipnCLgVJGQNNMgAve5nsQgIEC+9/maYNx4jT/D0KpgWqDg6wnVxNXYnaiuear3VdGy
	1Vne2cXjRY9LfGU/Qf4GFA02sY5rKObhzryG
X-Received: by 2002:aa7:d6cd:0:b0:658:bd2d:929c with SMTP id
 4fb4d7f45d1cf-65a39098edbmr15157a12.12.1770773369847; Tue, 10 Feb 2026
 17:29:29 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260211004811.work.981-kees@kernel.org>
In-Reply-To: <20260211004811.work.981-kees@kernel.org>
From: Jann Horn <jannh@google.com>
Date: Wed, 11 Feb 2026 02:28:53 +0100
X-Gm-Features: AZwV_QiEeWNUD9mWTR7Guj5j0lA9jpO168ZbrB-HNmoh1488VBqbWniAqGrwDtc
Message-ID: <CAG48ez1GYR+6kZHDmy4CTZvEfdyUySCxhZaXRo1S=YyN=Fsp8Q@mail.gmail.com>
Subject: Re: [PATCH] fs: Keep long filenames in isolated slab buckets
To: Kees Cook <kees@kernel.org>
Cc: Al Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 11, 2026 at 1:48=E2=80=AFAM Kees Cook <kees@kernel.org> wrote:
> A building block of Use-After-Free heap memory corruption attacks is
> using userspace controllable kernel allocations to fill specifically size=
d
> kmalloc regions with specific contents. The most powerful of these kinds
> of primitives is arbitrarily controllable contents with arbitrary size.
> Keeping these kinds of allocations out of the general kmalloc buckets is
> needed to harden the kernel against such manipulations, so this is why
> these sorts of "copy data from userspace into kernel heap" situations are
> expected to use things like memdup_user(), which keeps the allocations
> in their own set of slab buckets. However, using memdup_user() is not
> always appropriate, so in those cases, kmem_buckets can used directly.
>
> Filenames used to be isolated in their own (fixed size) slab cache so
> they would not end up in the general kmalloc buckets (which made them
> unusable for the heap grooming method described above). After commit
> 8c888b31903c ("struct filename: saner handling of long names"), filenames
> were being copied into arbitrarily sized kmalloc regions in the general
> kmalloc buckets. Instead, like memdup_user(), use a dedicated set of
> kmem buckets for long filenames so we do not introduce a new way for
> attackers to place arbitrary contents into the general kmalloc buckets.
>
> Fixes: 8c888b31903c ("struct filename: saner handling of long names")
> Signed-off-by: Kees Cook <kees@kernel.org>
> ---
> Also, from the same commit, is the loss of SLAB_HWCACHE_ALIGN|SLAB_PANIC
> for filename allocations relavant at all? It could be added back for
> these buckets if desired, but I left it default in this patch.
>
> Cc: Al Viro <viro@zeniv.linux.org.uk>
> Cc: Christian Brauner <brauner@kernel.org>
> Cc: Jan Kara <jack@suse.cz>
> Cc: <linux-fsdevel@vger.kernel.org>
> ---
>  fs/namei.c | 10 +++++++---
>  1 file changed, 7 insertions(+), 3 deletions(-)
>
> diff --git a/fs/namei.c b/fs/namei.c
> index 8e7792de0000..a901733380cd 100644
> --- a/fs/namei.c
> +++ b/fs/namei.c
> @@ -128,6 +128,8 @@
>  /* SLAB cache for struct filename instances */
>  static struct kmem_cache *__names_cache __ro_after_init;
>  #define names_cache    runtime_const_ptr(__names_cache)
> +/* SLAB buckets for long names */
> +static kmem_buckets *names_buckets __ro_after_init;
>
>  void __init filename_init(void)
>  {
> @@ -135,6 +137,8 @@ void __init filename_init(void)
>                          SLAB_HWCACHE_ALIGN|SLAB_PANIC, offsetof(struct f=
ilename, iname),
>                          EMBEDDED_NAME_MAX, NULL);
>         runtime_const_init(ptr, __names_cache);
> +
> +       names_buckets =3D kmem_buckets_create("names_bucket", 0, 0, PATH_=
MAX, NULL);
>  }
>
>  static inline struct filename *alloc_filename(void)
> @@ -156,7 +160,7 @@ static inline void initname(struct filename *name)
>  static int getname_long(struct filename *name, const char __user *filena=
me)
>  {
>         int len;
> -       char *p __free(kfree) =3D kmalloc(PATH_MAX, GFP_KERNEL);
> +       char *p __free(kfree) =3D kmem_buckets_alloc(names_buckets, PATH_=
MAX, GFP_KERNEL);
>         if (unlikely(!p))
>                 return -ENOMEM;

I think this path, where we always do maximally-sized allocations, is
the normal case where we're handling paths coming from userspace...

> @@ -264,14 +268,14 @@ static struct filename *do_getname_kernel(const cha=
r *filename, bool incomplete)
>
>         if (len <=3D EMBEDDED_NAME_MAX) {
>                 p =3D (char *)result->iname;
> -               memcpy(p, filename, len);
>         } else {
> -               p =3D kmemdup(filename, len, GFP_KERNEL);
> +               p =3D kmem_buckets_alloc(names_buckets, len, GFP_KERNEL);

... while this is kind of the exceptional case, where paths are coming
from kernelspace.

So you might want to get rid of the bucketing and instead just create
a single kmem_cache for long paths.


By the way, did you know that "struct filename" is only used for
storing fairly-temporary stuff like paths supplied to open(), but not
for storing the names of directory entries in the dentry cache (which
are more long-lived)? My understanding is that this is also why the
kernel doesn't really try to optimize the size of "struct filename" -
almost all instances of it only exist for the duration of a syscall or
something like that.

The dentry cache allocates long names as "struct external_name" in
reclaimable kmalloc slabs, see __d_alloc().
