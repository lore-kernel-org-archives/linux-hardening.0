Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26ABA336885
	for <linux-hardening@vger.kernel.org>; Wed, 10 Jun 2026 23:53:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.216.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781135606; cv=pass; b=QXV0jJSz2Itj3lvIvHZ0PS4A7fcXw9VhttditMwku7e+nri4l2yAKvdnDeyd5xlvWaz/eeOL5xR/ATeV9V9P8diIadqcrUW1lX+8zeiTitGk5Sa5wzDg+A5/PevaP+2AOUBHBNiWrDGEaxdl7/ByH4r4Dftb6dBKd+tAdJgjmdo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781135606; c=relaxed/simple;
	bh=GzqYRdAmyRinDIbNNPgcUhS0qYvCzRmkXn2WfVxMh+Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HS0W0TBhVctXEaFjLkRPOhF8N1eb8iwiI2Zd8aO+lB+gHwJOzAKwHNzEx8OXlVg5WZARGkbgGQexqBXnj1eHlbNCPRxjWPqO4THPZyZGE06CxLGs4dbEqqEwAeBUVuqkV97Pjij9U0fhpcJucwKza7VzbBu/dvTPQtPiruvG3Nk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=N2nMlXdN; arc=pass smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="N2nMlXdN"
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-37474afe908so1805767a91.1
        for <linux-hardening@vger.kernel.org>; Wed, 10 Jun 2026 16:53:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781135604; cv=none;
        d=google.com; s=arc-20240605;
        b=RaRzyCCPGr/1OtbXTxMdfFzsrkbMUGm4bC4JzIuPc25fwNmb/TChU2mET4oNW6ZtA8
         xfhvNVNug7mCJ/s9SCFVl73kOHpPrFmuKMA0bjryDHbcuiSW02ZEbzYoKcm4btXO9Tkg
         hjXA39SLtwZ5/mvqtO+NkErbofwRhLiOUDg8fnDW91gAGRRXkPAkmere+D5TeMqH1r5D
         HyC3vTrX2gtiKSx0nmBphtH8OtcXfmsS+0LmBCLhk1Js4mk3OLbpHi6ygaExMCe+oTir
         Hlqajr87Dtrq2t5RIcvppPT0INN1LSbiWuYBMaRIYUq5zyN1uwZdyJ5KCRYItQj9DtkC
         wxLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=GzqYRdAmyRinDIbNNPgcUhS0qYvCzRmkXn2WfVxMh+Y=;
        fh=tmwJeSMVvU9A1DAr9h2ueka+GXizA0u/nZaMlUIuwqs=;
        b=CSaxJX1OU5g/yDGDd1/laju1Dbye5B8NVnIzLwVGYz8KGhV0cEln7rxp+VyNYTTKaP
         xSLO5scova9fScmh3eBQ4esr4vPPaoGz+nhA8Vh0W+21d/iwiPh/oyNe+oDJ3ILho11b
         ZQ22l/CaG9iwUoasy7qZ1e7Mm24U/fCVvgjBLWFJwtcMmWXA7zgAqfC4lgMLI+usvfzA
         5SiKHJm6z7X16mSGar6kYXN+yHxbEzAjIc93KPGVYWjSg0e8bE93OKSvxBrA1k45vyrZ
         a4YdvDkyb+QMveWt8GYz1/8kltpzUlrUC9jqNZNlxLRsUedjIdT85yjUXEnSwd8G6vHQ
         xz/w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1781135604; x=1781740404; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GzqYRdAmyRinDIbNNPgcUhS0qYvCzRmkXn2WfVxMh+Y=;
        b=N2nMlXdNNsHpZGpD1vL3fKsW/gzyHSalppG23OiDdGPJTz7MMhcB52njuEdpwl5Em1
         XGW2+2Ju9CWrgZ0JdejqFvBNYqc+xVo/B8nKVjekgE9eZAz/zFFUvrBJn36kEtHsxJ9a
         Y3bOlrCvYx2IE5L11UMMC0T0+z/AzAQriA9q3nl0qbH6kqkeTDdTHmEaZT1zTLUaYPZ8
         YrMCeZWi0V/5wWaSazcKVr1L+8s3k8YqYwoAk6Yy05WB9PmlM9xKIPLfN4wc7gi18vTV
         lWH8B+8UIOnZx1IwVCfFxEoPDZD8ACFi5c+uwX1N3CFW8RxOeuFTwy25w+A8Cxv4+IFs
         uc9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781135604; x=1781740404;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=GzqYRdAmyRinDIbNNPgcUhS0qYvCzRmkXn2WfVxMh+Y=;
        b=WC23eda2BXFsPDRyBtRNOop9eaAxd09aGxPm41V1ARpt8fylptTCziJDs4Nf7Vk3SH
         zw3BBzs3rUrif0h8L1l3dV/zpvkPHrf/oj568fEsCR991W0aFND5mAaoaIk95Zruea2y
         uBt3XBFx1UqLXlJcDzYcwkIdMPZXtVrKSwfZQfa2v1gS+ZECLAkdXY7+EcZnEr9fFjKG
         59a3FmXHfK+tyQ8K8KxQ1uU2194cFjit2onmullail990O0yfofJuegt4cxTmbJY3Ib7
         RZo6kmWp/5d+1BXWDmuiArWICeIai75tUEul7+XW7eBprTwtU2eSh49xfdN0R1D6Laia
         ux8A==
X-Forwarded-Encrypted: i=1; AFNElJ/phbqWeX7EN+DLPTILXoY+Y4NEfzKWdDzLmtcLjbL5hyuBpNDPUI6h+vyiap4/H9d28k3sqHif+I7hyQyIJ+o=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy8TSY9rZVbpR5Ebu+R+2hBx/KfnruulkN9iHJpHKgy1x3iARyd
	IelK9lKSaPlTzz0RH+VK1LFu2MmN8c8Pi6DkuP36A5mQywNxklnkgup5cpEKDt0VOzllHYK/Um5
	p9e4wTibenMSHXNVbqPuW+elw/koBgE79WrMY6WDd
X-Gm-Gg: Acq92OEp/LTvKZFwsjQsewado7jcgSdHPSx4HyjXRd3UdCvlZX6R9GsFAgv9Hb2IB3V
	hdJ/rSdtcjUJbSgPc2pIynUX5thelKRBlGax3h70ZcDZaPRhrjM4m3H0IsT8H+pb51OH5OGzb7x
	lhRDyYYG9n4LMuVuLaUE+XMYWTBS/48K2MSyQODCHP/uh+JKzBT5ycPalBt1JucpRLUkZs10cpa
	FJlmptM8WwIKah6OcmXgbYi6UHUUnjLWIQhNTfzRG/asoeBPaRqqemtt7s/0g+tKUGABXJt+mHa
	BCww4gMH8zpVifQi7Q==
X-Received: by 2002:a17:90a:e7ce:b0:36a:3176:ad08 with SMTP id
 98e67ed59e1d1-377a88f36f7mr462729a91.25.1781135604415; Wed, 10 Jun 2026
 16:53:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260606142558.13809-1-med08elkadiri@gmail.com>
 <202606101345.D1BDA8BBE2@keescook> <CAAMeuQSZdNiCaAMYOnQE3q-Y9325PAbwVsJmTmKSS9a=NG7wcQ@mail.gmail.com>
 <202606101510.7F6F4118@keescook>
In-Reply-To: <202606101510.7F6F4118@keescook>
From: Paul Moore <paul@paul-moore.com>
Date: Wed, 10 Jun 2026 19:53:10 -0400
X-Gm-Features: AVVi8CeOOqdcqGiFd33pM820VoFXm9ZxQxdj69FsQwoNu813yloEA_3c0GRimBA
Message-ID: <CAHC9VhTnPK8rkoCtNuvSG+nteGc_Cg4DgnyWyRnUb5h_o7ic5A@mail.gmail.com>
Subject: Re: [PATCH] cred: prevent slab cache merging for cred_jar
To: Mohammed EL Kadiri <med08elkadiri@gmail.com>, Kees Cook <kees@kernel.org>
Cc: Serge Hallyn <sergeh@kernel.org>, Vlastimil Babka <vbabka@suse.cz>, 
	linux-security-module@vger.kernel.org, linux-hardening@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 10, 2026 at 6:11=E2=80=AFPM Kees Cook <kees@kernel.org> wrote:
> On Wed, Jun 10, 2026 at 10:07:24PM +0100, Mohammed EL Kadiri wrote:
> > Hi Kees,
> >
> > Thanks for the review!
> > Following Vlastimil and Jarkko's feedback on the key_jar patch, should
> > I send a v2 here as well with similar commit message modification:
> > removing CVE references, dropping the skbuff comparison, and framing
> > it as hardening?
>
> It wouldn't hurt, yeah. I have that kind of already in my head while I
> read these patches, but it would be better for other folks to see it
> framed more accurately.

Just as an FYI, the patch seems reasonable to me, but considering
where we are in the dev cycle I figured it best to wait until after
the upcoming merge window to do anything with it.

> > On Wed, Jun 10, 2026 at 9:45=E2=80=AFPM Kees Cook <kees@kernel.org> wro=
te:
> > >
> > > On Sat, Jun 06, 2026 at 03:25:58PM +0100, Mohammed EL Kadiri wrote:
> > > > The cred_jar slab cache holds struct cred objects, which contain
> > > > process credentials: uid, gid, euid, egid, and capability sets.
> > > > Overwriting any of these fields is sufficient for privilege escalat=
ion.
> > > >
> > > > On a default Ubuntu 6.17.0-23-generic system, cred_jar (named "cred=
"
> > > > in sysfs) has 2 aliases, meaning 2 unrelated object types share its
> > > > slab pages (object_size=3D184, objs_per_slab=3D42).
> > > >
> > > > Cross-cache heap exploitation relies on slab cache merging to achie=
ve
> > > > type confusion between unrelated kernel objects. CVE-2022-29582
> > > > demonstrates this technique: an io_uring use-after-free is leverage=
d
> > > > across cache boundaries through page-level reallocation, ultimately
> > > > achieving root. struct cred is a primary target in this class of
> > > > attacks due to the direct privilege escalation that results from
> > > > corrupting any of its identity or capability fields.
> > > >
> > > > Add SLAB_NO_MERGE to ensure cred_jar receives dedicated slab pages,
> > > > so that freed credential slots can only be reallocated as struct cr=
ed
> > > > objects. The memory overhead is minimal: one struct cred exists per
> > > > task, and with 42 objects per slab page, the cost of dedicated page=
s
> > > > is negligible. There is zero performance impact on the allocation
> > > > hot path.
> > > >
> > > > This follows the precedent set by skbuff_head_cache (net/core/skbuf=
f.c)
> > > > and key_jar (security/keys/key.c) which use SLAB_NO_MERGE for simil=
ar
> > > > isolation requirements.
> > > >
> > > > Signed-off-by: Mohammed EL Kadiri <med08elkadiri@gmail.com>
> > >
> > > Yes please. :)
> > >
> > > Reviewed-by: Kees Cook <kees@kernel.org>

--=20
paul-moore.com
