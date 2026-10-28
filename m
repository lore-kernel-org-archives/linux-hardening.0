Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.160.176
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793201766;
	b=idFTBgjiv2kOMYRO7Xpjc0DO1R2egRddshj0ZNdSxfNNaphZWAeoLa8HMuIx4jCceMqQ
	 Nv4AnIiBAwn2FEbJ6UBODMuK/FyvpevGdjFo/i4lKz4fW/uPYimf5mjl3lZoC+BMz5EF3
	 jb0Ih7Goett/YuJHm4XXOObUcwFd7ED9CgFMS2tDxgRlP0QA9UGMI/Bsqmkty23S7rFOm
	 /DrYj6X4Wb/hqMmV9UQyiSZeh6ZTqiCqrHbuxkq40pC9hC4wKssxZrLlB0FL23ukRMh5F
	 eyUPHg+4dC3dFxKvljrw58VZG1zu7laJ5XrTr3vX/udvyh+nrVjkDDLPKjEiGaalkqg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793201766;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=IMDYK1ZjnbIiPQHcJc7SpOjyQ4Wy/ZaG15fuBEkM+6c=;
	b=VnqS6RU1hvOJ1tFH4Ll50omwD9rTluR+xi3xAUoLc6ccP8A6lcOIuBx1Nmp/jxPIhKMd
	 g4KEQrjPpkbxtYz5QXL47lKHgCAMJF2SsaKISeGzst3Vu+V8W+VGqtsPCuAYIKVReCIss
	 cjpJHsSlYDCWqUrFUvAIZqgKRyfgws6p6Yq7uw3mzWvcJL/hQuikmkOXJydLW8hMUbHub
	 55JeNOsYqAzIpDFcYiHz3x5lS1MnvfI/MSzxWWjvMALrbjgiaJ23/mTRkceFK2p+5f+CD
	 7GQK1KIjfFnIaUPjXDxkUeN1N5DAK5gHfSNzvjWVum2O1RtAEoqBjbeYxkFS959wPsA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=iyuv9E6o;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.160.176
Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BAE4606A324
	for <linux-hardening@vger.kernel.org>; Wed, 28 Oct 2026 15:36:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2BAE4606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=iyuv9E6o
Received: by mail-qt1-f176.google.com with SMTP id d75a77b69052e-533202fe429so405301cf.0
        for <linux-hardening@vger.kernel.org>; Wed, 28 Oct 2026 08:36:05 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793201764; cv=none;
        d=google.com; s=arc-20260327;
        b=QvtWofH0NXrlHrKygcqXizt4BSzdtBiBJmsr21RX2Ladb0EfOdoHWIN4fIxhQM3WVq
         leW7egtsJGUe4MEJc0uQZBL8OETGQPtZKTRIdWRPYT2Z+Cjp9PI83rEusmZRpukxvypA
         GOzYGJPoqB/j7628A8RUNlF1fD6cRfvOiAHgckTWizPCY8TMD3UMzDl1sGclc5U4k3Oq
         Cth8+iVyeusIJpvtleMo3YTbkrAPY3YxhAwJE6p2gCim/HEAbBZF4UoR1bmoPHUFcvHD
         Qm0T9dbV0Y7KD1FqOuz0hJ0nwwS1yWo4RYwbx+qlbTmySwdks3eT+DKmR4qxANuE3HUu
         QYNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=IMDYK1ZjnbIiPQHcJc7SpOjyQ4Wy/ZaG15fuBEkM+6c=;
        fh=LJmBjklg8UnRtNyXT4crqVLRrhz+x7AitEvijVO+Zqg=;
        b=SruGZa4fVrm9IeDlC0gM8k1CQwMcya4qL/nSVG8zaM8gcRIjL5532ahrTUy5Ts8Jnd
         FQtnvodYkA6aIJdrxjBeZTeCh8gTffJdxRJIRO5rv3bjjt5Ar9wImufYW+Otx+g0sf0l
         Q7QSzHAM9RJYeaMAFPnCZRAXZZWwziuNi4O1EaBcCEEGD0ZNQ7w9iFGpOZzB8/t2Gf2Q
         HhLfbuC2o4XngfVPJcH+7/X3B5pb8TE6ez9YXkhgnY47qetMQXhffVMgbEA37qhNUlAK
         YgySqPLobjr4dNlOXK1oEIcohLlp8aFm8rZr1/tGLxdp3RkT0IQJjIatsWuxWO/Q02lK
         gd1w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1793201764; x=1793806564; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=IMDYK1ZjnbIiPQHcJc7SpOjyQ4Wy/ZaG15fuBEkM+6c=;
        b=iyuv9E6ogXiaYB/Kf9bGMjc5uDovw1VYZpmRLrRXT+kN2fxJMnJdnor+qZvLAhWzf5
         5ZpgEidLwgoDr/m7PqAQNgkvMJs1jQGMfEjgDsfaqWJdA0ll7UHpSzdRyuFyqOtcPvQf
         74bwXpyLamSNVYlWo12Hkt8sY/BkzbtDkw3FeAjFHel30AzWVvD9K5nLau0ciJ6j7CSK
         ZH4qBM8JvT2aPZPJYm3XwzxSYHZi04WkjIZrQEfBjgxa7Wsg9Sh5hAk/6QBMmPYkwRlc
         e+Xy3nhgo0JAgGmpn+QnHGzm1VxXA8IyWASy4/EEGYKtjCnWmnqGfUf8AjkGoqR/opbF
         W1VA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793201764; x=1793806564;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=IMDYK1ZjnbIiPQHcJc7SpOjyQ4Wy/ZaG15fuBEkM+6c=;
        b=Sij2aW+RejlH+wRQYFPhT1ivNu+WFiN/KQx6sGY2dCkGrmExZ5p+VlKJn38unF63Je
         NlqLhTqXG+UUOxB6BMWDA9uFkk6okfOTjYlGxmfd00YKJGbH/OcfEnziZkAFZDZVmqM1
         NlfP/bQcmxjiBR1D6nWy3iKMQtqzXvEVVAoRcx6RCL5IptIVf7tHc/XA5lHt5EFDje9D
         KKcrSGIpW8vb0eHqep5NDAkylfng+wMt836L9Uu6UIq3CnvD9yiWZf8jNMsUAPtkjfxH
         p3ChH9l6By2DaLXFILGCGTSNT9Z9Wjw97/Jt5izK5w+M57lXzIcGCbOjHWAYpjGPJYhO
         4fYg==
X-Forwarded-Encrypted: i=1; AKwUvBzntmNXl6F8iW7/FjcGbonXRo7bAawz8xvCg6HORrv2Gji/DWOXIukgSLGSNp/ytZkYoxmrXsQve6rBSM/3Ack=@vger.kernel.org
X-Gm-Message-State: AFq9FYIxusDobYAvL/m9OlRMjls8yazwExM/hq+d9almHW92FY6Ts+FD
	FU9yRztCa4/Z9z+gYJBSFznffsEdb/jwsnC3VGOo/81I9ozvH3b7WltogYiR3vDdOAWb4/diK9C
	DZBMiYzoZ7HVmyrydMBLKXZFcnTxKoJMqH14pJR8f
X-Gm-Gg: AYBFou0zB2Qs1+FA9KA1db9jzXByi3tdDPkS0n4tcplULw9aoA2sger8zpb04/NPS04
	l35swF7w8QJUU/m1vyq6vHg4+juK6+IgI31HM6BDTlshImVOqw7OJnyEURroOhBoFwGRJfcnULk
	1zy9S0ZuA6moQnMe/jjlVkeJrC0nZ+A0/5A6Hc7nOZH2UDit1GXVTLWL1bAMpVCg3YUDBwmE+Ym
	o19AeZnS9IvkDI4+DeyNiMLPiu6UwSxWytL5/N+uP9FAZWqmym5ugtchJ4VfIG7ucdXV5RuvqoW
	LRB4uKAp43sh4lRPy+4p7qQ4edBsd2/XQl2nr/3Ai7FtW9+KxvjaG1HMmcs+1nFguB2FSJ18Iaz
	D1KqM03DMKID+A52pRrSgZMSHxJWQL9LJUOeKYKSPBHzudZiEPQhquO2k4w4=
X-Received: by 2002:a05:622a:22a9:b0:536:97c0:dcd0 with SMTP id
 d75a77b69052e-53fc2aa1fa2mr21345071cf.4.1793201763129; Wed, 28 Oct 2026
 08:36:03 -0700 (PDT)
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Post: <mailto:linux-hardening@vger.kernel.org>
List-Help: <mailto:linux-hardening+help@vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-hardening+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261027223847.652884-1-irogers@google.com> <20261027223847.652884-5-irogers@google.com>
 <CAJZ5v0juvZ2ZVRBkY6FxBM=NhPt9vMA3+yRugXc5u=U1jO9AXg@mail.gmail.com>
In-Reply-To: <CAJZ5v0juvZ2ZVRBkY6FxBM=NhPt9vMA3+yRugXc5u=U1jO9AXg@mail.gmail.com>
From: Ian Rogers <irogers@google.com>
Date: Wed, 28 Oct 2026 08:35:50 -0700
X-Gm-Features: AclHuK8Z1SdNi4k8-UQceLsnqDJD6d9aTo0cl8IQ7vlO1Fmucv2n8goL0VFX4iw
Message-ID: <CAP-5=fWVZ=7-qDRODiEQzRzhpQqribv9Morj=OoAXW_6uaW2dA@mail.gmail.com>
Subject: Re: [PATCH v2 4/9] cpufreq: governor: Initialize kobj_type release
 callback statically
To: "Rafael J. Wysocki (Intel)" <rafael@kernel.org>
Cc: Kees Cook <kees@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Miguel Ojeda <ojeda@kernel.org>, Danilo Krummrich <dakr@kernel.org>, 
	Nathan Chancellor <nathan@kernel.org>, Nick Desaulniers <ndesaulniers@google.com>, 
	Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>, 
	=?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
	Zhihao Cheng <chengzhihao1@huawei.com>, Zhongqiu Han <zhongqiu.han@oss.qualcomm.com>, 
	Sumanth Korikkar <sumanthk@linux.ibm.com>, Bill Wendling <morbo@google.com>, 
	Justin Stitt <justinstitt@google.com>, driver-core@lists.linux.dev, llvm@lists.linux.dev, 
	linux-hardening@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-acpi@vger.kernel.org, 
	linux-pm@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, 
	linux-sh@vger.kernel.org, linux-s390@vger.kernel.org, gfs2@lists.linux.dev, 
	xen-devel@lists.xenproject.org, linux-mtd@lists.infradead.org, 
	amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org, 
	linux-kernel@vger.kernel.org, Viresh Kumar <viresh.kumar@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 28, 2026 at 4:39=E2=80=AFAM Rafael J. Wysocki (Intel)
<rafael@kernel.org> wrote:
>
> On Tue, Oct 27, 2026 at 11:39=E2=80=AFPM Ian Rogers <irogers@google.com> =
wrote:
> >
> > Export cpufreq_dbs_data_release() and set .kobj_type.release statically
> > in the ondemand and conservative governors so their gov_attr_set
> > kobjects have a valid release callback statically initialized, matching
> > cpufreq_governor_dbs. Remove the redundant runtime assignment in
> > cpufreq_dbs_governor_init().
> >
> > This prepares for annotating struct kobj_type::release with
> > __must_init.
> >
> > Signed-off-by: Ian Rogers <irogers@google.com>
>
> Do you want stuff to be picked up by maintainers, or do you want to
> route it yourself?

Hi Rafael,

Just a quick note: I agree with Zhongqiu's feedback and the commit
message needs a fix.

Regarding merging the patches, the issue with maintainers picking up
fixes is that the series will break the clang/llvm build without them.
So the maintainers need to either merge the patches (and the series be
rebased on top of them) or merge the series as a unit. Perhaps since
the patches align, merge conflicts won't happen, so maintainers
merging and landing the series is okay. I don't have the experience to
know.

Thanks,
Ian

> > ---
> >  drivers/cpufreq/cpufreq_conservative.c | 5 ++++-
> >  drivers/cpufreq/cpufreq_governor.c     | 4 ++--
> >  drivers/cpufreq/cpufreq_governor.h     | 1 +
> >  drivers/cpufreq/cpufreq_ondemand.c     | 5 ++++-
> >  4 files changed, 11 insertions(+), 4 deletions(-)
> >
> > diff --git a/drivers/cpufreq/cpufreq_conservative.c b/drivers/cpufreq/c=
pufreq_conservative.c
> > index 02bfd46543e9..146a2353b1a2 100644
> > --- a/drivers/cpufreq/cpufreq_conservative.c
> > +++ b/drivers/cpufreq/cpufreq_conservative.c
> > @@ -318,7 +318,10 @@ static void cs_limits(struct cpufreq_policy *polic=
y)
> >
> >  static struct dbs_governor cs_governor =3D {
> >         .gov =3D CPUFREQ_DBS_GOVERNOR_INITIALIZER("conservative"),
> > -       .kobj_type =3D { .default_groups =3D cs_groups },
> > +       .kobj_type =3D {
> > +               .release =3D cpufreq_dbs_data_release,
> > +               .default_groups =3D cs_groups,
> > +       },
> >         .gov_dbs_update =3D cs_dbs_update,
> >         .alloc =3D cs_alloc,
> >         .free =3D cs_free,
> > diff --git a/drivers/cpufreq/cpufreq_governor.c b/drivers/cpufreq/cpufr=
eq_governor.c
> > index f3bd3dbe7c41..f8b5aca09b6b 100644
> > --- a/drivers/cpufreq/cpufreq_governor.c
> > +++ b/drivers/cpufreq/cpufreq_governor.c
> > @@ -419,7 +419,7 @@ static void free_policy_dbs_info(struct policy_dbs_=
info *policy_dbs,
> >         gov->free(policy_dbs);
> >  }
> >
> > -static void cpufreq_dbs_data_release(struct kobject *kobj)
> > +void cpufreq_dbs_data_release(struct kobject *kobj)
> >  {
> >         struct dbs_data *dbs_data =3D to_dbs_data(to_gov_attr_set(kobj)=
);
> >         struct dbs_governor *gov =3D dbs_data->gov;
> > @@ -427,6 +427,7 @@ static void cpufreq_dbs_data_release(struct kobject=
 *kobj)
> >         gov->exit(dbs_data);
> >         kfree(dbs_data);
> >  }
> > +EXPORT_SYMBOL_GPL(cpufreq_dbs_data_release);
> >
> >  int cpufreq_dbs_governor_init(struct cpufreq_policy *policy)
> >  {
> > @@ -488,7 +489,6 @@ int cpufreq_dbs_governor_init(struct cpufreq_policy=
 *policy)
> >         policy->governor_data =3D policy_dbs;
> >
> >         gov->kobj_type.sysfs_ops =3D &governor_sysfs_ops;
> > -       gov->kobj_type.release =3D cpufreq_dbs_data_release;
> >         ret =3D kobject_init_and_add(&dbs_data->attr_set.kobj, &gov->ko=
bj_type,
> >                                    get_governor_parent_kobj(policy),
> >                                    "%s", gov->gov.name);
> > diff --git a/drivers/cpufreq/cpufreq_governor.h b/drivers/cpufreq/cpufr=
eq_governor.h
> > index 806d8fb4dff1..1026712bb79b 100644
> > --- a/drivers/cpufreq/cpufreq_governor.h
> > +++ b/drivers/cpufreq/cpufreq_governor.h
> > @@ -150,6 +150,7 @@ static inline struct dbs_governor *dbs_governor_of(=
struct cpufreq_policy *policy
> >  }
> >
> >  /* Governor callback routines */
> > +void cpufreq_dbs_data_release(struct kobject *kobj);
> >  int cpufreq_dbs_governor_init(struct cpufreq_policy *policy);
> >  void cpufreq_dbs_governor_exit(struct cpufreq_policy *policy);
> >  int cpufreq_dbs_governor_start(struct cpufreq_policy *policy);
> > diff --git a/drivers/cpufreq/cpufreq_ondemand.c b/drivers/cpufreq/cpufr=
eq_ondemand.c
> > index 9942dbb38dae..7386d043c665 100644
> > --- a/drivers/cpufreq/cpufreq_ondemand.c
> > +++ b/drivers/cpufreq/cpufreq_ondemand.c
> > @@ -374,7 +374,10 @@ static struct od_ops od_ops =3D {
> >
> >  static struct dbs_governor od_dbs_gov =3D {
> >         .gov =3D CPUFREQ_DBS_GOVERNOR_INITIALIZER("ondemand"),
> > -       .kobj_type =3D { .default_groups =3D od_groups },
> > +       .kobj_type =3D {
> > +               .release =3D cpufreq_dbs_data_release,
> > +               .default_groups =3D od_groups,
> > +       },
> >         .gov_dbs_update =3D od_dbs_update,
> >         .alloc =3D od_alloc,
> >         .free =3D od_free,
> > --
> > 2.56.0.313.g2479322e68-goog
> >
> >
