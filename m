Received: from mail-oa1-f49.google.com (mail-oa1-f49.google.com [209.85.160.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EFC014A8B
	for <linux-hardening@vger.kernel.org>; Wed, 26 Feb 2025 00:01:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740528069; cv=none; b=UlTPMGNLNndrfMfWqhScaGHBLdLUg9sM9T+mWREOLbRKiQLwjBfBC79egMt3UMyPcR5Xa/SF9sQU38ecKAEg4y0dJnhRtG+//M2a/7RpoIoQ/E++eEzmMrpUWYh6uTE0/o4l5JZuiPQ/mKvKt8Ligsukhe/zFwvcJ0JlBJUxu9o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740528069; c=relaxed/simple;
	bh=RTanE6XR/JH9Zoq0uVHYD+TayIsyzXrlsJ6Fo1TDNp8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PkTfp6eBAZ7emy2NIZB9DU54YGoauWh2FBFQj+qj+ni2WVb425SQ6easwGSBg3GpgXGKPnxJJ6Vr1ut0RwzGUWRtyf2hroRreltAh65AswlITWLpyZK/BPMLbtONpWAs+XMEhSH4HUP/k3vujFsC6fpg5k9Ejn+eA0hmYD4vvRE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=WqK1sGl9; arc=none smtp.client-ip=209.85.160.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="WqK1sGl9"
Received: by mail-oa1-f49.google.com with SMTP id 586e51a60fabf-2b840c17e9eso573971fac.2
        for <linux-hardening@vger.kernel.org>; Tue, 25 Feb 2025 16:01:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1740528067; x=1741132867; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RTanE6XR/JH9Zoq0uVHYD+TayIsyzXrlsJ6Fo1TDNp8=;
        b=WqK1sGl93/qP+yYF7Cz4DUxr6998pqkq52h+W428HJRZY5Dl2l2Mjo+7aWr0j8Iq9m
         dt4gEYsurUqJDBcRGoxFo2fZ32p5xhlL1yV1ohyoAF1uJp5UIaHsi/TXO2EtaVulo/nz
         2zyi1cIPZdoRtjlDrRQD7Hy6Ohd4ILmAWXKOw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740528067; x=1741132867;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RTanE6XR/JH9Zoq0uVHYD+TayIsyzXrlsJ6Fo1TDNp8=;
        b=nwHpfkS/wpz/IHcxgCbYxBHObjcNAmlmybToM/hFURhJTIfXWFrbfOM26p4nwrXRJF
         d++v8wSHeqbehXikIEan5pexJ1MLMpRAp1YkR3a3kkj211oVqcIU0YyCx2Rdgrp2wj4g
         xBZAWbKntXa70gdld97Nz2FfXV/pM732r2+GZ5w1sZn8p07Wz+AH8ZVaYAXJaPdz45/Q
         4dOxbAXdJC3LNZ3A/xKVskcpjyOpjzfChnJllALO5voSjEt4hMIe5bYk6bQjDujN1YqD
         Ltqg+e26XEwLxhRjkIIcd4kAiAH5/PdEtFhRni9bsNkWsP6c0/uAOlMFHEAdGCqmBtQT
         sQow==
X-Forwarded-Encrypted: i=1; AJvYcCU4gQAycoRO3rdj59ZkxD2wLvQpcUE9XC7w7p8pM9VfyTSSRbohxWuADMqFnL4+HJKpXGDqR+6TUD9fDyGJ79k=@vger.kernel.org
X-Gm-Message-State: AOJu0YwfMjtenJTzPvhxaQqV+jZ+hEpRZrJCS5xdi0g/dsHoKcHd5l6u
	3lGqNzZ+So2OK59pD4QaiejBbvjimWlIABhybbH8dyNsFijmg9mp6UsEmerwaauD9I4by8D9VFY
	18k8MBpUccQ1ivf8VohsCmFBz3DkwSo8yQrgU
X-Gm-Gg: ASbGncurKujCccCiI7ZgVa4eqRL4ILAWrnCqbcwavNEH71kyNVKHHSxISVQOpsqYWp/
	bXyRGu1hsoT7B9JLAsKaDwsmVYKp5dpJaK/5dPdONnvLBlzG07KpbG9/uYg2xN5dWRUaQY/DMFV
	HV90a9QtgEWcJoQFMUDUMOweoQ79Rb1siB1ho=
X-Google-Smtp-Source: AGHT+IELe7Q/6O2YWMjS8MjKjcw3APoXgNJtjGq0cBBtTsKkJH0j3uRuC98gBF3d5jfK8A9Ni6bYgLWT/E0p/bexzIM=
X-Received: by 2002:a05:6808:2109:b0:3f4:159d:a27e with SMTP id
 5614622812f47-3f4247df7a0mr5817242b6e.8.1740528067182; Tue, 25 Feb 2025
 16:01:07 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250224225246.3712295-1-jeffxu@google.com> <20250224225246.3712295-6-jeffxu@google.com>
 <c5d3927e-06e3-49e7-a1d6-f4c9e817def4@lucifer.local> <96ebddf3fe31353c89f6a4680eaeb2793c25cd09.camel@intel.com>
 <d2aeeb56-ba8c-49f3-957d-1ac790522233@lucifer.local> <DC169C8C-BF10-4125-AA91-29E48BB1AD6A@kernel.org>
 <de5577b5-5d9d-4173-99f7-8c156c53f175@lucifer.local> <202502251035.239B85A93@keescook>
In-Reply-To: <202502251035.239B85A93@keescook>
From: Jeff Xu <jeffxu@chromium.org>
Date: Tue, 25 Feb 2025 16:00:55 -0800
X-Gm-Features: AQ5f1JqrFo-3TKx0ZH5FJxQSLMaaUHg4v6Oj3trpyca3fo9xG6lTeqBiqur_uik
Message-ID: <CABi2SkXiBv5nEu4cHBdW2GUrJUFNSEuY_OVwEp6af0hGD-U4VQ@mail.gmail.com>
Subject: Re: [PATCH v7 5/7] mseal, system mappings: enable uml architecture
To: Kees Cook <kees@kernel.org>
Cc: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, "Berg, Benjamin" <benjamin.berg@intel.com>, 
	"Jason@zx2c4.com" <Jason@zx2c4.com>, "adobriyan@gmail.com" <adobriyan@gmail.com>, "deller@gmx.de" <deller@gmx.de>, 
	"gerg@kernel.org" <gerg@kernel.org>, "anna-maria@linutronix.de" <anna-maria@linutronix.de>, 
	"davem@davemloft.net" <davem@davemloft.net>, "avagin@gmail.com" <avagin@gmail.com>, 
	"mhocko@suse.com" <mhocko@suse.com>, "enh@google.com" <enh@google.com>, 
	"thomas.weissschuh@linutronix.de" <thomas.weissschuh@linutronix.de>, "hch@lst.de" <hch@lst.de>, 
	"hca@linux.ibm.com" <hca@linux.ibm.com>, "peterz@infradead.org" <peterz@infradead.org>, 
	"adhemerval.zanella@linaro.org" <adhemerval.zanella@linaro.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "ojeda@kernel.org" <ojeda@kernel.org>, 
	"jannh@google.com" <jannh@google.com>, "f.fainelli@gmail.com" <f.fainelli@gmail.com>, 
	"sroettger@google.com" <sroettger@google.com>, "ardb@google.com" <ardb@google.com>, 
	"jorgelo@chromium.org" <jorgelo@chromium.org>, "rdunlap@infradead.org" <rdunlap@infradead.org>, 
	"mark.rutland@arm.com" <mark.rutland@arm.com>, "Liam.Howlett@oracle.com" <Liam.Howlett@oracle.com>, 
	"vbabka@suse.cz" <vbabka@suse.cz>, "mpe@ellerman.id.au" <mpe@ellerman.id.au>, "oleg@redhat.com" <oleg@redhat.com>, 
	"willy@infradead.org" <willy@infradead.org>, "peterx@redhat.com" <peterx@redhat.com>, 
	"mike.rapoport@gmail.com" <mike.rapoport@gmail.com>, "mingo@kernel.org" <mingo@kernel.org>, 
	"rientjes@google.com" <rientjes@google.com>, "groeck@chromium.org" <groeck@chromium.org>, 
	"linus.walleij@linaro.org" <linus.walleij@linaro.org>, 
	"pedro.falcato@gmail.com" <pedro.falcato@gmail.com>, "ardb@kernel.org" <ardb@kernel.org>, 
	"42.hyeyoo@gmail.com" <42.hyeyoo@gmail.com>, "linux-mm@kvack.org" <linux-mm@kvack.org>, 
	"johannes@sipsolutions.net" <johannes@sipsolutions.net>, 
	"linux-hardening@vger.kernel.org" <linux-hardening@vger.kernel.org>, 
	"torvalds@linux-foundation.org" <torvalds@linux-foundation.org>, 
	"akpm@linux-foundation.org" <akpm@linux-foundation.org>, 
	"dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>, 
	"aleksandr.mikhalitsyn@canonical.com" <aleksandr.mikhalitsyn@canonical.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 25, 2025 at 10:38=E2=80=AFAM Kees Cook <kees@kernel.org> wrote:
>
> On Tue, Feb 25, 2025 at 03:31:06PM +0000, Lorenzo Stoakes wrote:
> > On Tue, Feb 25, 2025 at 07:06:13AM -0800, Kees Cook wrote:
> > >
> > >
> > > On February 25, 2025 2:37:11 AM PST, Lorenzo Stoakes <lorenzo.stoakes=
@oracle.com> wrote:
> > > >On Tue, Feb 25, 2025 at 08:45:21AM +0000, Berg, Benjamin wrote:
> > > >> Hi,
> > > >>
> > > >> On Tue, 2025-02-25 at 06:22 +0000, Lorenzo Stoakes wrote:
> > > >> > On Mon, Feb 24, 2025 at 10:52:44PM +0000, jeffxu@chromium.org wr=
ote:
> > > >> > > From: Jeff Xu <jeffxu@chromium.org>
> > > >> > >
> > > >> > > Provide support for CONFIG_MSEAL_SYSTEM_MAPPINGS on UML, cover=
ing
> > > >> > > the vdso.
> > > >> > >
> > > >> > > Testing passes on UML.
> > > >> >
> > > >> > Maybe expand on this by stating that it has been confirmed by Be=
njamin (I
> > > >> > _believe_) that UML has no need for problematic relocation so th=
is is known to
> > > >> > be good.
> > > >>
> > > >> I may well be misreading this message, but this sounds to me that =
this
> > > >> is a misinterpretation. So, just to clarify in case that is needed=
.
> > > >>
> > > >> CONFIG_MSEAL_SYSTEM_MAPPINGS does work fine for the UML kernel.
> > > >> However, the UML kernel is a normal userspace application itself a=
nd
> > > >> for this application to run, the host kernel must have the feature
> > > >> disabled.
> > > >>
> > > >> So, UML supports the feature. But it still *cannot* run on a host
> > > >> machine that has the feature enabled.
> > > >
> > > >Sigh ok. Apologies if I misunderstood.
> > > >
> > > >Is there any point having this for the 'guest' system? I mean securi=
ty wise are
> > > >we concerned about sealing of system mappings?
> > >
> > > UML guests are used for testing. For example, it's the default target=
 for KUnit's scripts. Having sealing working in the guest seems generally u=
seful to me.
> > >
> >
> > 'Having sealing working' you mean system sealing? Because mseal works f=
ine
> > (presumably in UML, not tried myself!)
>
> Sorry, yes, I mean "system mapping msealing".
>
> >
> > System msealing lacks any test in this series (I did ask for them...), =
certainly
> > no kunit tests, so this seems a bit theoretical? Unless you're talking =
about the
> > theoretical interaction of kunit tests and VDSO sealing?
>
> Right, I meant theoretical interaction, but it would be useful for
> future KUnit tests of system mapping msealing too.
>
> > I mean can't we just introduce this at the time if we believe this'd be=
 useful?
>
> Perhaps adding it as part of adding some KUnit tests that exercise the
> system mapping msealing would be the most sensible.
>
> > Generally I'm not a fan of adding features mid-way through a series, th=
e
> > revisions are meant to be refinements of the original, not an evolving =
thing.
> >
> > So in general I'd prefer this to be added if + when we need it for some=
thing.
>
> Yup, makes sense. And it may be that KUnit tests need to exercise more
> than what UML can support, so even the KUnit idea may be invalid.
>
> Jeff, let's leave off UML for this initial "minimum viable feature"
> series, unless there is a strong reason to keep it.
>
Sure.
It will be removed unless someone raises a strong reason to keep it.
UML can be added when future KUnit tests need it.

Thanks
-Jeff


> --
> Kees Cook
