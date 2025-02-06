Received: from mail-oa1-f43.google.com (mail-oa1-f43.google.com [209.85.160.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51F8C3FB31
	for <linux-hardening@vger.kernel.org>; Thu,  6 Feb 2025 14:19:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738851566; cv=none; b=GSaiaqyPTPujiqj7D+jNDJd4jyOupWY/iwBt2jTqv8/C3IwGi9jZPSPb6DfqtnVTGe4frHpdT+sQ5Vz9s4JcbPEH2fVdO+RFVJBtuQiW22nMBYCzIQxnxxmZninKJRQZRYJcY5mTLl2L6RVxdXurRH1flQL6BeVj+xAd4/7KHFA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738851566; c=relaxed/simple;
	bh=4tmOaZRPX6vvDtOzYjrTsElIO1kFqWsrqkops+efmJ0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cKcsKMYHDnI+NvazaIMCubNkk2Yhn6/xkBFl53j6CIkXXdeWPr5sePFd2cdZmRFToZ1gbAFpm582VqTZVC9e5lunPGXXNZds9fAk7MKLDCgBKRg24SLKFJPGxu7RAVx4XlEHfGZsHZtyl8iboUz3qnfAs+mIAidrsUlu2QvXboc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=A0Me/iuT; arc=none smtp.client-ip=209.85.160.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="A0Me/iuT"
Received: by mail-oa1-f43.google.com with SMTP id 586e51a60fabf-2a88c7fabdeso502137fac.1
        for <linux-hardening@vger.kernel.org>; Thu, 06 Feb 2025 06:19:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1738851564; x=1739456364; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tksEl2KlAVxEf8W+lYv0ussSoMxCHLsGsx0wrvueTGs=;
        b=A0Me/iuTYtZXGsK8Tnj9MrpGPKhBlzK1kEC6XaaRwYr57jKpaSo4rDz8GUmO9ka6yG
         xd7T8VSLUeGICnsretDStFcrlZpeCRAEY8M5dGrNgCkcku01C5EvJd3SZnr6vOum/cqO
         /DZlWDTlvM402ifK2alJsW7a/XLBClB52lgPTgzr47fOqo5reUZ7n9nXYECl+oRloGex
         O5oyzCsAR4MTw+PMt/oM22MZujGRhaho17vPZKXrnOFspbmi/mv4RhnVLgX9UcrxHuaz
         GmW64J9mRkB4jaWvNOaHFQ/rbD045tvIEqE5rhQ/LOGQf0w9BiVFFwoskVwfzHIhaNXS
         fMcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738851564; x=1739456364;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tksEl2KlAVxEf8W+lYv0ussSoMxCHLsGsx0wrvueTGs=;
        b=X3HB2BXKFWsseROT9BOTEIDximVfxW8NVnsy7u12HWukK3buHfiUx2A8PM7ybfllxU
         5s1Q9Au2K4eOJTUOqp4s94bJxLP1KvFIeaj99MdZNfVn8EddVykOspvpHDFGf6rZNS01
         6/yc/PJlByH+keVMrnbSdNW/1+77/hK3EXSuHrfLSi++KGNqCsiJDtvlBdTbGn9OW2S0
         bNI0lReTD+RkXH5qU7fVWkJggqWC1gQXPgZ0OrIJvs/hBE+lWR41mkk8r2bN8kQUQcrF
         eI3zRy3eAFFKS5WdaKzeMf9ZXpc2L3NPg31Qhx2x2ZkILX5hGUZFyy+4vcRnW34Z3K/K
         y//Q==
X-Forwarded-Encrypted: i=1; AJvYcCXPrOWJmRHu4RDTywUQHrKmcyQhi9Q5r8VZ2UGkc0JyeWKOapGdqTXdUXoLoFm/RYfZJFzTMp7N6lu59eyPFBs=@vger.kernel.org
X-Gm-Message-State: AOJu0YwWeRM/sMsc5XChk3d3zSqtFfcht6qYrTBL+Cg9YcgDxzUT8F2M
	wRqbp+LPz3i4QnStjKo2Tuv/eepwoR35KA3c1xiYmQAUKBcJPncF0N6+fGyJraqL7dngmQCV5sc
	7n/TfTdk06k/HDYQMGZpIq9QCkEEDPknxVAiq
X-Gm-Gg: ASbGncv1nO38LXNGZ8nCn0J/05Bpp0oJyBPp9HlxyDABMNCXZTAu8MhUh6DBJaohu+H
	EQ+Hu86t7AMjOPsTr7c7kiYUBvwMMIziGJBCjxpflLrOaJCW1hpnpwi6OzK5V3y2y1MpTmA==
X-Google-Smtp-Source: AGHT+IEfLHpnvobMcgVrLSNbsfNw4AFRnCPQWXFAu2fq4BUPy8NoWcDtZg+st9iEyOh2nL29zJbCH2+K927euTM+iyE=
X-Received: by 2002:a05:6870:8188:b0:296:fff8:817 with SMTP id
 586e51a60fabf-2b8051adbd4mr5104149fac.35.1738851563761; Thu, 06 Feb 2025
 06:19:23 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <2e5de601da34342d8eb0d8319dcf81ff213c7ef0.camel@sipsolutions.net>
 <CAKbZUD1btTbeEht6W5MmhgtEJk3dg55cBpBtoDL0ieaL=23qeQ@mail.gmail.com>
 <CABi2SkWoNTd5sRJ7-7arPfutYZx6xi9iac0mXZyfzuVXuh1atA@mail.gmail.com>
 <CAJgzZop04=7+13jjV_zDfJF4dyJ7tp-86G8_mRe=C=sBEp+z3Q@mail.gmail.com>
 <ocstrhpyoyxzurvvxbrbnlzfqzo6hiqt7dxj7vu45ipj4min6z@ffnpao72slda>
 <CAJgzZopv+jKmDncYDJEQTymqQ1oRpy8HNpOsmcoM7Chb=uBJzg@mail.gmail.com>
 <l7pexkoo7t7p5u6gobgc46lxvpgpe2lywaqwa4b6vjddt3ccnq@mh6x72cxfhyv>
 <CAJgzZopiyhq9Wpu+gxUssoNhQT7tNjiey0JGsKPJAXjraEBRiw@mail.gmail.com>
 <881c3558-1101-496e-9ef4-5bef13f3f233@suse.cz> <CAJgzZoq29GzVsqAMrGiKoUpXFPVjPRQRO87SiagaQCVXfH90Lw@mail.gmail.com>
 <Z5LE6BkIQjgyVfvb@casper.infradead.org>
In-Reply-To: <Z5LE6BkIQjgyVfvb@casper.infradead.org>
From: enh <enh@google.com>
Date: Thu, 6 Feb 2025 09:19:12 -0500
X-Gm-Features: AWEUYZkbH44gyYIM4OSRYeiM_40wARCJ9iHWw7ukWWa1MTVZt14y_2GEShpURoo
Message-ID: <CAJgzZoovOhEFAcG93iQ2_iTLyqKf-TLzLJAX2vZnOWUC0Waq=A@mail.gmail.com>
Subject: Re: [PATCH v4 1/1] exec: seal system mappings
To: Matthew Wilcox <willy@infradead.org>
Cc: Vlastimil Babka <vbabka@suse.cz>, "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
	Jeff Xu <jeffxu@chromium.org>, Pedro Falcato <pedro.falcato@gmail.com>, 
	Benjamin Berg <benjamin@sipsolutions.net>, Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, 
	Kees Cook <kees@kernel.org>, akpm@linux-foundation.org, jannh@google.com, 
	torvalds@linux-foundation.org, adhemerval.zanella@linaro.org, oleg@redhat.com, 
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org, 
	linux-mm@kvack.org, jorgelo@chromium.org, sroettger@google.com, 
	ojeda@kernel.org, adobriyan@gmail.com, anna-maria@linutronix.de, 
	mark.rutland@arm.com, linus.walleij@linaro.org, Jason@zx2c4.com, 
	deller@gmx.de, rdunlap@infradead.org, davem@davemloft.net, hch@lst.de, 
	peterx@redhat.com, hca@linux.ibm.com, f.fainelli@gmail.com, gerg@kernel.org, 
	dave.hansen@linux.intel.com, mingo@kernel.org, ardb@kernel.org, 
	mhocko@suse.com, 42.hyeyoo@gmail.com, peterz@infradead.org, ardb@google.com, 
	rientjes@google.com, groeck@chromium.org, mpe@ellerman.id.au, 
	Andrei Vagin <avagin@gmail.com>, Dmitry Safonov <0x7f454c46@gmail.com>, 
	Mike Rapoport <mike.rapoport@gmail.com>, 
	Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>, 
	Christopher Ferris <cferris@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 23, 2025 at 5:38=E2=80=AFPM Matthew Wilcox <willy@infradead.org=
> wrote:

[heh, long time no see! haven't been on an email thread with you in a
while :-) ]

> On Thu, Jan 23, 2025 at 04:50:46PM -0500, enh wrote:
> > yeah, at this point i should (a) drag in +cferris who may have actual
> > experience of this and (b) admit that iirc i've never personally seen
> > _evidence_ of this, just claims. most famously in the chrome source...
> > if you `grep -r /proc/.*/maps` you'll find lots of examples, but
> > something like https://chromium.googlesource.com/chromium/src/+/main/ba=
se/debug/proc_maps_linux.h#61
> > is quite representative of the "folklore" in this area.
>
> That folklore is 100% based on a true story!  I'm not sure that all of
> the details are precisely correct, but it's true enough that I wouldn't
> quibble with it.
>
> In fact, we want to make it worse.  Because the mmap_lock is such a
> huge point of contention, we want to read /proc/PID/maps protected
> only by RCU.  That will relax the guarantees to:
>
> a. If a VMA existed and was not modified during the duration of the
>    read, it will definitely be returned.
> b. If a VMA was added during the call, it might be returned.
> c. If a VMA was removed during the call, it might be returned.
> d. If an address was covered by a VMA before the call and that
>    VMA was modified during the call, you might get the prior or
>    posterior state of the VMA.  And you might get both!
>
> What might be confusing:
>
> e. If VMA A is added, then VMA B is added, your call might show you VMA
>    B and not VMA A.
> f. Similarly for deleted.
> g. If you have, say, a VMA from (4000-9000) and you mprotect the region
>    (5000-6000), you might see:
>         4000-9000 oldA
>    or
>         4000-5000 newA
>         4000-9000 oldA
>    or
>         4000-5000 newA
>         5000-6000 newB
>         4000-9000 oldA
>    or
>         4000-5000 newA
>         5000-6000 newB
>         6000-9000 newC
>
> (it's possible other combinations might be visible; i'm not working on
> the details of this right now)
>
> We shouldn't be able to _skip_  a VMA.  That seems far worse than
> returning duplicates; if your maps parser sees duplicates it can either
> try to figure it out itself, or retry the whole read.

yeah, fwiw i can't think i've seen a case where a duplicate would
matter --- half the code i've seen ["tell me more about the VMA
containing this address"] would just stop at the first match anyway
(though that's exactly the case where i'd rather have "direct access"
than have to search), and the other half ["give me a snapshot of all
the VMAs for offline debugging purposes"] doesn't really bother with
interpretation and leaves that up to humans.
