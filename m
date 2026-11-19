Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.160.176
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795067159;
	b=oSMi4ss+TvTf+vnAqR1x8jsqHr6SXNoL6YqtAHyIwx1PU8gjn9v25Fm/cMQZ0Omt8lka
	 dS7gBBSC/2+sgspW5UEGjWA3LRU2onuWEDi+4STKfYIZr92mgkhvkL6B0yB3vCy8qmJIl
	 hmAD/4iL3C7eRXxyywmmktf9nCYRuRDBWIFAauvJgn5Vuyw28oNnwZ+KaWdNrfdf3AiM/
	 0fc5Kw6fzpTwinJDNNgBTOHu2tzXu8+CXdC+ek2f2vH5IYg15SZtgBzivr11b+YXp4gf6
	 Fjse6zpjUviACGbALbqX7RSC3OMyddfCeOaWhq3Xvvxii/hZnXUODkJw3ycsD0A7RsQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795067159;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=cIkoHsOVRZS7gIowPl6xkao6tH+bfcK9X/Z+HF8PGU0=;
	b=zdN6BvI7ttFU1KgEUIlE1wrzT9AWyvb8955yEsPqnIz4uTpNcwDka76yIW/TdQltPp8a
	 w4qR13xZw8cbD62NCwK2KXHcNlwFzX3lEWqV7183sQa2UEZIYjM5vpAfu3nArDYxY9PYF
	 4I/w16/UUtN8XWWSUGdy9SfFjLF7XANdEIdrYLmgqUlseUyOznyssz+ypRMkmOgYxcHTj
	 ZH9cN9owbrrE1DQd9Q4GG0MPmMk2RmRGvbS/skFp0Sk8LBZlsAvBccHAnm0le36wYJHaC
	 jsRf240ldWSzSfwzvFTwTvSnlO5BOpm101AmCIqpsquO+0DB0zzVPVUfIktX3smLFjA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=G9sTcZLh;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.160.176
Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2461060A2611
	for <linux-hardening@vger.kernel.org>; Thu, 19 Nov 2026 05:45:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2461060A2611
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=G9sTcZLh
Received: by mail-qt1-f176.google.com with SMTP id d75a77b69052e-55be673e029so117301cf.1
        for <linux-hardening@vger.kernel.org>; Wed, 18 Nov 2026 21:45:58 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795067158; cv=none;
        d=google.com; s=arc-20260327;
        b=fBvXolJh54I/NFjnhK/+vhw87agccQMCBvFTgxqgTfkWQcgcVXOuXtzngSqNkB1n07
         1SkwJPwpUSCFIHHYSFeudI/2RkEYApE0N9YHs+YqJYS+LucErGtyLkaKYyH6/oiDOclO
         u+6dkD0aJhntD+E9XYK99W3qOQBgJEe5fvanuzZVlsNPhLU9XaxuYAzjUrWZUdxLV6+u
         myPmxhdMFJPTyasjpcvDoFhmL8NsaVf+nhb9f3yCuMNhhZeY+PouPCmuz3B856n21xFa
         z4RSKvy0RdC3SeGEjg6jMKEgqlSJ2UtkYodGiRZ4Iwc98delPbDV1xYoZfJLitVC6+29
         DjLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=cIkoHsOVRZS7gIowPl6xkao6tH+bfcK9X/Z+HF8PGU0=;
        fh=RNhLd/WSg7rQOE25+ptghdSqP3NpJstCbfCj9VxW8dM=;
        b=S4inI2COYnc9aqZdAMomdZXfD5gdwmD8pKE2ElO9UdDkhcJgNFvSfS2o8vf3rQcpWh
         1jOYBXDubS+reb3uBGcUuzXLQF56p34CFVIugkUOu12CMblJaGprPhGluq2UCbppyNgH
         gwEloWUmsQinNbz8nzvVCAdJmUOhASDUAf4BzpSBijjc/4K1d6jUATdlV43/7Df3O5Ig
         gj9thFO5J/uLbVj2FUXBLFqEIVxJMYE+0UCDHSeiV12WqG/sGMT9EiCJTyJ742YJgt4W
         0pnGYWcqAN0su7vE0SKtfjdcDuBx+SlhyD6RiL1ZQw+Zl7zYvLMHX/7Dqa5fhT0ApM/O
         VSHw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1795067158; x=1795671958; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=cIkoHsOVRZS7gIowPl6xkao6tH+bfcK9X/Z+HF8PGU0=;
        b=G9sTcZLhDZovHsgCx5Yv7CDMxJM8G5FDawL5JBd36y8NAy88YZsvFaSPGxL2OJDQWl
         D8l1zhaslplXpC+LH5CUyVM6fiya54hKkm3044CoRWwH6cYkMSxwEs9IE4R9vJJik3G9
         PaGymfho5RIhVhS+d5TUg18WON8Y60WBZxMM5gYyXKhy/KCwkwn+iT9No3gldijeO5tx
         xp5Gg8oePFUL/bdSJWKKtm4OA3cKKfEuUGn9FzCr/u57K1nN+6BjTy/XuUfYpf49AuBU
         GF3mrNTIV4ZWpGu4KegbuhUlLkOSriAaKH7KHmdnomUVdJlrrfe8QiZH1hsMd7fqVOCf
         HQmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795067158; x=1795671958;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=cIkoHsOVRZS7gIowPl6xkao6tH+bfcK9X/Z+HF8PGU0=;
        b=k8MVlFaBPBoidjVNnRLDBVBJYIOBARcc+5KlcT966HG4tg42q2UBcmv9kcBWYTXlfo
         RBAusg7Fi99zyRrj25VXCDWMRj7eUs7bUFMONK4gJ6iij+napBRR3Mox87Dz6yC7gLbI
         mK7J1bArRz2OIgBxgwQxCTpF2RApP0JZwPDpuV4VtiwJKvKMK68IpG3VaFM4ZPkwU1nS
         8rEi0p4mgFI4xnVV0G0fvaIpl1lybTHaKpehywOqTNQY17nVqo4jXlgHvd9gleTTsuTq
         nIuZ22bYQQ73YA2svi+LiO4WtSezuLu30RDmZbK8V3WYhEOe7ZVz4nOxq29TM0F+IevH
         yglg==
X-Forwarded-Encrypted: i=1; AL+hErF1vmkcswztAxKFCRNCw+2qX3tFLZf/QmmHZezhcRv7qloLi7cDsJd57vKkHvsHxe8bI6FjigDcEY0xf0e6hZ4=@vger.kernel.org
X-Gm-Message-State: APuU4Z8g7cfvyxLasOduZFdq/o9KwEmufrMiE3FCtYZSm09LJqHAn5FT
	4HsTd6lbdAQn4IId98z8/JYabWsFvkqFjQQv7YApW/NDSRPm24AcYk8eJNpU0syaqa2wvFJAf89
	NDU2Yd6l4XKhp1VxUe5ZmMj2TcbAPVVl+EVmHrPJO/uqhWDGaupuSpQvkw+Q=
X-Gm-Gg: AYBFou0qpX5s1YcKqiCZzIN1ZZnMEnMqaEDLD3IwahdFu229jmmScW00dhFGfqUofxZ
	IK4x+4MVJ+bG7qKWbjpt7mZ3oweCsXPq6wJaCP0T1z1Bdr6VDQW3FdBC6BCrwACyjCUIP3fA3xQ
	pXeEa/ZvPdLE/bsZSLJ/15xJQkJuhhhRsYoUf8L7tc7vcAr7sMt77WNYs9eL6r5NOxndxNK35le
	mvFafZ6Z6JS3ezFamLiwE6iwmLEzAEvPqhqTw4rFBQldRiQqWLqygTfLW+YQ1iOVh1RW2IiAWno
	GuctSaQAZz41ZRKv5SMbkj1XjIiVWzwNYlB7ExqemTcbD4RGEoEjxvgwbnJeAoGGLswuJ10Ak/a
	K/vLIgp8Va2d1h1ogBarYeCHIFr4/ZWv0htHz
X-Received: by 2002:a05:622a:4808:b0:536:934f:7da2 with SMTP id
 d75a77b69052e-55d6c7995f9mr6557911cf.2.1795067157461; Wed, 18 Nov 2026
 21:45:57 -0800 (PST)
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Post: <mailto:linux-hardening@vger.kernel.org>
List-Help: <mailto:linux-hardening+help@vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-hardening+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261108223913.3624571-1-irogers@google.com> <20261108223913.3624571-10-irogers@google.com>
 <DMYN979QJFNV.LM3T6O68OHW6@kernel.org>
In-Reply-To: <DMYN979QJFNV.LM3T6O68OHW6@kernel.org>
From: Ian Rogers <irogers@google.com>
Date: Wed, 18 Nov 2026 21:45:45 -0800
X-Gm-Features: Aa3M54p8GzPfKDPQ_HJcPbdLHGq3vwK7n9VGnVvnVB1ODjbFHeHwrlgOfVCaaEo
Message-ID: <CAP-5=fXrMyfLFXq6CiqwWMSbtYVRNESxuDo-ddqNwDmq5Nm4SA@mail.gmail.com>
Subject: Re: [PATCH v3 9/9] kobject: Require explicit initialization of struct kobj_type::release
To: Danilo Krummrich <dakr@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Kees Cook <kees@kernel.org>, 
	Miguel Ojeda <ojeda@kernel.org>, "Rafael J . Wysocki" <rafael@kernel.org>, 
	Madhavan Srinivasan <maddy@linux.ibm.com>, Michael Ellerman <mpe@ellerman.id.au>, 
	Nicholas Piggin <npiggin@gmail.com>, Christophe Leroy <chleroy@kernel.org>, Nayna Jain <nayna@linux.ibm.com>, 
	Srish Srinivasan <ssrish@linux.ibm.com>, Mimi Zohar <zohar@linux.ibm.com>, 
	Yoshinori Sato <ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>, 
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>, Juergen Gross <jgross@suse.com>, 
	Stefano Stabellini <sstabellini@kernel.org>, 
	Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>, Nathan Chancellor <nathan@kernel.org>, 
	Nick Desaulniers <ndesaulniers@google.com>, Viresh Kumar <viresh.kumar@linaro.org>, 
	Zhongqiu Han <zhongqiu.han@oss.qualcomm.com>, Alexander Aring <aahringo@redhat.com>, 
	Felix Kuehling <felix.kuehling@amd.com>, =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
	Zhihao Cheng <chengzhihao1@huawei.com>, Sumanth Korikkar <sumanthk@linux.ibm.com>, 
	Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>, driver-core@lists.linux.dev, 
	llvm@lists.linux.dev, linux-hardening@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-acpi@vger.kernel.org, linux-pm@vger.kernel.org, 
	linuxppc-dev@lists.ozlabs.org, linux-sh@vger.kernel.org, 
	linux-s390@vger.kernel.org, gfs2@lists.linux.dev, 
	xen-devel@lists.xenproject.org, linux-mtd@lists.infradead.org, 
	amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 18, 2026 at 1:11=E2=80=AFPM Danilo Krummrich <dakr@kernel.org> =
wrote:
>
> On Sun Nov 8, 2026 at 11:39 PM CET, Ian Rogers wrote:
> >  static const struct kobj_type cpuregs_kobj_type =3D {
> > +     /*
> > +      * Pre-existing: info->kobj is embedded in per-CPU cpu_data;
> > +      * cpuid_cpu_offline() only calls kobject_del().
> > +      */
>
> All of these comments carry a =E2=80=9CPre-existing:=E2=80=9D prefix, but=
 that doesn=E2=80=99t
> distinguish cases with broken lifetime management from those where the st=
orage
> remains valid despite the API misuse.
>
> For example:
>
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.c b/drivers/gpu/drm/=
amd/amdgpu/amdgpu_xcp.c
> > index ab14079d1c42..0847134a1391 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.c
> > @@ -797,6 +797,11 @@ static const struct sysfs_ops xcp_cfg_res_sysfs_op=
s =3D {
> >  };
> >
> >  static const struct kobj_type xcp_cfg_res_sysfs_ktype =3D {
> > +     /*
> > +      * Pre-existing: xcp_res is embedded in struct amdgpu_xcp_cfg
> > +      * rather than freed individually by kobject_put().
> > +      */
> > +     .release =3D NULL,
>
> Being embedded in another structure doesn't explain what guarantees that =
the
> enclosing allocation outlives the kobject=E2=80=99s final cleanup.
>
> Could you please drop the =E2=80=9CPre-existing:=E2=80=9D prefix and make=
 that distinction
> explicit? For broken cases, describe the lifetime problem and mark it as =
needing
> a follow-up fix. For cases where the lifetime is safe, explain what guara=
ntees
> that safety, while acknowledging that omitting release() still violates t=
he
> documented API contract.
>
> Also, do you plan to follow up on those cases?

Makes complete sense, thanks Danilo!

Auditing all 17 files in patch 9 with that distinction in mind:
- Only 3 built-in sites (arm64 cpuinfo, ACPI hotplug profiles, and
s390 sclp_mem) have backing storage that genuinely remains valid for
the lifetime of the kernel.
- The other 14 files either free/zero an enclosing dynamic or devm
allocation without waiting for final kobject cleanup, or are tristate
modules that unregister static kobjects/ksets on module_exit and can
unmap module memory before delayed cleanup finishes.

I've dropped the "Pre-existing:" prefix, documented the specific
guarantee or FIXME lifetime hazard at each site in v4, and yes, I plan
to send follow-up fixes to the respective subsystems once __must_init
is in place.

Thanks,
Ian

> Thanks,
> Danilo
>
