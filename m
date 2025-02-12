Received: from mail-vs1-f44.google.com (mail-vs1-f44.google.com [209.85.217.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D8782063EF;
	Wed, 12 Feb 2025 12:38:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739363885; cv=none; b=eUhE7gClbbxyw0vs81wlqakihshd5+IU0TM12G6euCBO3mh1KIIveDasqdsh6w8f4UOvGg51nX6YHMT+Iiq6dUgMI8BzknL00z7aEx2sCXwbIOecb4clwIuocbcUMY9nfq+6pEcz65jkocB8sdmYzHKtvHT1n2HEopoxcfSJ3ps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739363885; c=relaxed/simple;
	bh=/MhxCCG8L68ap4Fb8sC1sFWzMKosheiocSWTxAlfbUw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=llKAEkZ3npeOSjIjK1IqBI2xL90ixNoG2zWze7Txi6Wj0+BYCtw6z7io56tfPnA0s5dMAlpBvnT4/frREtTRf5hDdKrKlE2gFtS5dItZOE81TTaP5ui6G7R44QzpybXhsdk9HaKol8HqdzZjCvfkVrg6O5DDq1tmEdXtVDW92EE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eC+1PBjn; arc=none smtp.client-ip=209.85.217.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eC+1PBjn"
Received: by mail-vs1-f44.google.com with SMTP id ada2fe7eead31-4bbc406499fso972725137.1;
        Wed, 12 Feb 2025 04:38:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739363883; x=1739968683; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/MhxCCG8L68ap4Fb8sC1sFWzMKosheiocSWTxAlfbUw=;
        b=eC+1PBjnz0v6KvjfFu/OHv5r5eqolf51sjD1WA2dCA5whzAp82p9HzpI3BiXnxyFXl
         jexe/VVFJWtf2e4s2bWmRpidCeRuZ0Ma0BHUZPa4uGrtwtxNjY2RcwMBiSf+ZskIJPMH
         Hnsc4VDBLMNxC4FFPvoSj5iaOTds2MVdx4WpQ/Uqf8B79zNnUxncPqlwJKcSbNePVl6A
         10SwW/kVzIWt6LV4YsojYnspn4DgTtuDmWkQa6hDh4nmkBCzvKyZHCUncpRRt8rH6Pkk
         TXHo8Mar0MFTvzHEqBZhDw+9xfkcBfRZ7PXGuUWC/NI5Ydu64Mu091dpzFhV4xyRXV0u
         ytdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739363883; x=1739968683;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/MhxCCG8L68ap4Fb8sC1sFWzMKosheiocSWTxAlfbUw=;
        b=UgH+tDEghOq4G5snuLleUGDxwPhlyJdf8DQTKJ6Gep2pVqbpLZxvH9FCAkvwrHZg1N
         smkntbsDF1dwaueOikRLRy/tmCiy0Ob79dmOVy8Rr0TjHfNqZU3rXzlteGReLT/q6UWq
         V7NlYblsW2j8G3Cjga8mx7nJWYMHPu6AHMGM4LCgwaLHZVrrQto46W3kmTXbDE+KmQSy
         JEWZBSnxC6TXiieYgfTqDX/H79YORhXBwDHjYRP3N7cgbZg9ZkVvYpD6h9LGBlA1rGFh
         0aIVmgewsyTPbRCKH/FFHBTwDpykVGDhfNn9yL3ryjImFhtNdYi3qV10g9+P2xyPDjhO
         nwkw==
X-Forwarded-Encrypted: i=1; AJvYcCUygoWG826FuKe0MNtQDtcPsfDhtiNbmRkUJtSH1GoDjw9tLjY/QJfnxFEb6dDBUuUKnnRBywwiTftCq0eN@vger.kernel.org, AJvYcCXKmVc63C8/mXD/yNpwF6mezQk167sZsd4PTmTdux1z8X87MlHOT/RgOfGjM6fAf1Zw0wPeWTe2BNrQHYIsPYg=@vger.kernel.org
X-Gm-Message-State: AOJu0YyNpS4tSFTRA6hCId6Mg5/YcfUHaI+H/6lpzbJF5Y3OaxnFOPq4
	6kY6ihmRZ1nmMwX7EDthzn7PLoI2xIdu6R+EqqJJJUrrb3y8SToCTxezMmYRG9/I9zVmXe06JYO
	ay65KlPZb3JwxCrsWcNFE4gAgjLA=
X-Gm-Gg: ASbGncuMB4t18C32KUaiC5ZQUT97It61dgs795beQncd7ckPbj3ZiBrJYDF5qLEl4PY
	YPj0Vo96yO4SSRhWdkwXZDM146l7u32476qPxxI37OsyscZ+RBQ7pl5t3RWTKa4llYy02l+apPV
	3Z931HqdYrY4LN8PhBybCAfqs4pfNT
X-Google-Smtp-Source: AGHT+IHxyI5V68yTiQpSCeRuL0DAoHMUWm5WYwDLhddhFWBZhhZWrHpYNg+VdgNISZba43fqOAs1Dgr3VTvCPaVwAd0=
X-Received: by 2002:a05:6102:26d2:b0:4b6:d600:a35f with SMTP id
 ada2fe7eead31-4bbf5494ef9mr1382286137.4.1739363883129; Wed, 12 Feb 2025
 04:38:03 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250212032155.1276806-1-jeffxu@google.com> <b114f48a-a485-4ebd-9278-6c62a1f33d9c@lucifer.local>
In-Reply-To: <b114f48a-a485-4ebd-9278-6c62a1f33d9c@lucifer.local>
From: Pedro Falcato <pedro.falcato@gmail.com>
Date: Wed, 12 Feb 2025 12:37:50 +0000
X-Gm-Features: AWEUYZkK5vY4SQpUupnNrhKNiAtngdUasab79fM1w6vCVdGz__atvD0Ojr1vOwU
Message-ID: <CAKbZUD0TAX8F9kDCEEvGSbcegDD4GLyra3ewtxncBbs45WJZ3g@mail.gmail.com>
Subject: Re: [RFC PATCH v5 0/7] mseal system mappings
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: jeffxu@chromium.org, akpm@linux-foundation.org, keescook@chromium.org, 
	jannh@google.com, torvalds@linux-foundation.org, vbabka@suse.cz, 
	Liam.Howlett@oracle.com, adhemerval.zanella@linaro.org, oleg@redhat.com, 
	avagin@gmail.com, benjamin@sipsolutions.net, linux-kernel@vger.kernel.org, 
	linux-hardening@vger.kernel.org, linux-mm@kvack.org, jorgelo@chromium.org, 
	sroettger@google.com, hch@lst.de, ojeda@kernel.org, 
	thomas.weissschuh@linutronix.de, adobriyan@gmail.com, 
	johannes@sipsolutions.net, hca@linux.ibm.com, willy@infradead.org, 
	anna-maria@linutronix.de, mark.rutland@arm.com, linus.walleij@linaro.org, 
	Jason@zx2c4.com, deller@gmx.de, rdunlap@infradead.org, davem@davemloft.net, 
	peterx@redhat.com, f.fainelli@gmail.com, gerg@kernel.org, 
	dave.hansen@linux.intel.com, mingo@kernel.org, ardb@kernel.org, 
	mhocko@suse.com, 42.hyeyoo@gmail.com, peterz@infradead.org, ardb@google.com, 
	enh@google.com, rientjes@google.com, groeck@chromium.org, mpe@ellerman.id.au, 
	aleksandr.mikhalitsyn@canonical.com, mike.rapoport@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 12, 2025 at 11:25=E2=80=AFAM Lorenzo Stoakes
<lorenzo.stoakes@oracle.com> wrote:
>
> On Wed, Feb 12, 2025 at 03:21:48AM +0000, jeffxu@chromium.org wrote:
> > From: Jeff Xu <jeffxu@chromium.org>
> >
> > The commit message in the first patch contains the full description of
> > this series.
>
> Sorry to nit, but it'd be useful to reproduce in the cover letter too! Bu=
t
> this obviously isn't urgent, just be nice when we un-RFC.
>
> Thanks for sending as RFC, appreciated, keen to figure out a way forward
> with this series and this gives us space to discuss.
>
> One thing that came up recently with the LWN article (...!) was that rr i=
s
> also impacted by this [0].
>
> I think with this behind a config flag we're fine (this refers to my
> 'opt-in' comment in the reply on LWN) as my concerns about this being
> enabled in a broken way without an explicit kernel configuration are
> addressed, and actually we do expose a means by which a user can detect i=
f
> the VDSO for instance is sealed via /proc/$pid/[s]maps.
>
> So tools like rr and such can be updated to check for this. I wonder if w=
e
> ought to try to liaise with the known problematic ones?
>
> It'd be nice to update the documentation to have a list of 'known
> problematic userland software with sealed VDSO' so we make people aware.
>
> Hopefully we are acheiving the opt-in nature of the thing here, but it
> makes me wonder whether we need a prctl() interface to optionally disable
> even if the system has it enabled as a whole.

Just noting that (as we discussed off-list) doing prctl() would not
work, because that would effectively be an munseal for those vdso
regions.
Possibly something like a personality() flag (that's *not* inherited
when AT_SECURE/secureexec). But personalities have other issues...

FWIW, although it would (at the moment) be hard to pull off in the
libc, I still much prefer it to playing these weird games with CONFIG
options and kernel command line options and prctl and personality and
whatnot. It seems to me like we're trying to stick policy where it
doesn't belong.

--=20
Pedro
