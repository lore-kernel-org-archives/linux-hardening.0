Received: from mail-vs1-f47.google.com (mail-vs1-f47.google.com [209.85.217.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27BF919048F
	for <linux-hardening@vger.kernel.org>; Thu, 29 Aug 2024 11:53:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724932427; cv=none; b=h1AV2biQDQ8w/sjSQgZxPvc/qEAybAwIxxle3d3lrxOm9FHAc9tE6X2if+11dKNJbYmgF9BxjGwIutjFkJXBtRLYuc8CVNsOsAS60E89q7rFTzzDlSCFI0Uznv12+z2p4dj4THDpIWyCVmdyFrepOi9tca5vRsReug4vDg7jtHg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724932427; c=relaxed/simple;
	bh=czZ1dOQVLY8OB5JMNo/yLksck3ZTgdf6lscTaUaWhyA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=K+w+yhJ4p/g3bEoiiKpxDd6Mp8ty2ntq1ybElc87Xqt6z6vVsErfwts2DHrJaij9scyZ+UlBIsilTzqGUA9C3l/4v9tGUvlOkedtAWeuRr5ZinpFW9+Yj0k4pBNsU0BwhIJmwAAmO2EY4FB78kLt0bhA8/kakTE/pAhpsB4C4f0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VNOblFmh; arc=none smtp.client-ip=209.85.217.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VNOblFmh"
Received: by mail-vs1-f47.google.com with SMTP id ada2fe7eead31-498c4d5a912so248529137.2
        for <linux-hardening@vger.kernel.org>; Thu, 29 Aug 2024 04:53:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724932425; x=1725537225; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=u8n1UFj1Q+wM5iePo02UkDVC+29Y7BUbYM34gTWJxTE=;
        b=VNOblFmhGZIM9Zkzji6+qL6yBrf2F6zttY7GN6ss7KeAFALMiNNX1I5o+jA9GZwE46
         wpsvowz8abuhNcPUidfQZffp4SNnYS5Q7xmQDjvwCE/dJDNCRWTDFvCz1gGtAXeLSO8i
         GLUx2j1ZwXDw2mEAu0LPIlu8LYCzhzGP/jBug90qg3ebEp9+iGnXj14UbxanuoVdHvu5
         /pKNYtpR9bTsYfXMLSM1GJSfiPFCUo6KvfWe1Sa0W7Ne/3I533htwhsMxW1LYyBZBsul
         0N8RAIG4wanIMerakCbLyVnVzxwf9cF+hIslK7Xreyt19xhPP6sEZjjPpWeel58ltDXD
         naBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724932425; x=1725537225;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=u8n1UFj1Q+wM5iePo02UkDVC+29Y7BUbYM34gTWJxTE=;
        b=S60kR+V0kkVZb+09RMEpiAyzr99f0bBtqV8gCeAs69AslSek53n+vVW2pNCw4XRu29
         /A7gJLYDmHER3XA7VcTTO6i/5Ul4tZWhzvysCOoF8N+XU/nrs71CnCIwQgUoaUDgmq+M
         vwC4hlwlkC2oOKoyZBEl8hwKtDkMWPZdY5SyMaE8ueDpA7Gatq9kA9zBNFI62/2hH7Z6
         tsKvuShKd34b2v5woBblRBwiaGEHCHUjZOtskNHAmd8nzTxEbufaOVdTzX/5PlFkUEmM
         mfxPI0BHZi0oxOJEaBQcq6ambJN7sxse7CL/WGeb6DNMqdiJYHlx2az/c6kMDKJ9zgFQ
         yp4A==
X-Forwarded-Encrypted: i=1; AJvYcCW72FHLZ6HvhIvP/Qps2TulJgkKCSWkc+CHBi9S90sM75k6tiSt427aptJGoraYpXj2XauXsKlg5qCIn6t5nW8=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywv55nN7byAZRnxZ48o6G2XNJ+4BsQ0rKnNU6SCdCorOTaatiD+
	garwM2VzU1WXigB9cM+AKTrx78husmKf+pI6lpb11dSZYniyHYyor7YgbfcaxSi+KIczhxrQQBf
	ahqFDXj6sU5r+1myNar5C7WswOt0=
X-Google-Smtp-Source: AGHT+IFRqcSUwe4ES9Z3J6iwBOoWu0IKyMK1mGG/uCxzyYADeSDjgNDnl/+yRGY4XWsjM+0Q8viLj81bGzymvDCeYqw=
X-Received: by 2002:a05:6102:50a:b0:498:d3b7:be39 with SMTP id
 ada2fe7eead31-49a5af7bae1mr2287830137.29.1724932424886; Thu, 29 Aug 2024
 04:53:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAHk-=wgv2-=Bm16Gtn5XHWj9J6xiqriV56yamU+iG07YrN28SQ@mail.gmail.com>
 <CALOAHbDP9d6GNNhjB30zKiaMh_HvToKDGZ3sO9tkxRu5+HpEZQ@mail.gmail.com>
 <CAHk-=wi9Z4QmmfeYo6aynRFbCA-_+FG83HYxXz2wVWfxjPyXSA@mail.gmail.com>
 <ZsbY5pNhDqGoxJG_@tiehlicka> <CAHk-=wgmHOrhCGU=vOkcsZy5rE0rRZcH2U0zg6HkJxzxUEJgTA@mail.gmail.com>
 <CAHk-=wiNCkgsrdNii7EwEXjt_47wF7YBJYWMhdsZJS8yVFDR=Q@mail.gmail.com>
 <ZsbtGClLMtaeakdo@tiehlicka> <CAGsJ_4zM4tACW=8FrEVF6fhwke5BLHCXOb0O3xBoVsF9Rb7+9w@mail.gmail.com>
 <Zsb1rM-azd_0gFzg@tiehlicka> <bc952d89-1219-41e9-9a8b-cfe2a758d585@redhat.com>
 <ZscAtVskxgONe3gT@tiehlicka> <59e90825-4efa-4384-8286-06c0235304dc@redhat.com>
 <CAHk-=wiyq9vF-L7NXakadGdQ4TvFLrEwds-NzkByDSb2F2YUkQ@mail.gmail.com>
 <be4c9110-72d0-4749-941e-797a861d8319@suse.cz> <CAGsJ_4znRBscU8FWMZL7Z9qLUMxCPtupRcJqu+PXz260p-S6MA@mail.gmail.com>
 <c258403c-afc5-4969-b7c5-fa2a6c257371@suse.cz> <CAGsJ_4wu3theWe0iyXdBK-JvLfuBh7Qw-B+9Wztm2XyrU1Uzeg@mail.gmail.com>
 <2663352f-ecef-4e5b-bee5-e31d2b286c63@suse.cz>
In-Reply-To: <2663352f-ecef-4e5b-bee5-e31d2b286c63@suse.cz>
From: Barry Song <21cnbao@gmail.com>
Date: Thu, 29 Aug 2024 23:53:33 +1200
Message-ID: <CAGsJ_4zY5jwCsJh94OFMi1UqzFu5Ji3OeJZz91p2YKT5jxBc5A@mail.gmail.com>
Subject: Re: [PATCH v3 0/4] mm: clarify nofail memory allocation
To: Vlastimil Babka <vbabka@suse.cz>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, David Hildenbrand <david@redhat.com>, 
	Michal Hocko <mhocko@suse.com>, Yafang Shao <laoar.shao@gmail.com>, akpm@linux-foundation.org, 
	linux-mm@kvack.org, 42.hyeyoo@gmail.com, cl@linux.com, hailong.liu@oppo.com, 
	hch@infradead.org, iamjoonsoo.kim@lge.com, penberg@kernel.org, 
	rientjes@google.com, roman.gushchin@linux.dev, urezki@gmail.com, 
	v-songbaohua@oppo.com, virtualization@lists.linux.dev, 
	"linux-hardening@vger.kernel.org" <linux-hardening@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 29, 2024 at 10:24=E2=80=AFPM Vlastimil Babka <vbabka@suse.cz> w=
rote:
>
> On 8/27/24 09:50, Barry Song wrote:
> > On Tue, Aug 27, 2024 at 7:38=E2=80=AFPM Vlastimil Babka <vbabka@suse.cz=
> wrote:
> >>
> >>
> >> Ugh, wasn't aware, well spotted. So it means there at least shouldn't =
be
> >> existing users of __GFP_NOFAIL with order > 1 :)
> >>
> >> But also the check is in the hotpath, even before trying the pcplists,=
 so we
> >> could move it to __alloc_pages_slowpath() while extending it?
> >
> > Agreed. I don't think it is reasonable to check the order and flags in
> > two different places especially rmqueue() has already had
> > gfp_flags & __GFP_NOFAIL operation and order > 1
> > overhead.
> >
> > We can at least extend the current check to make some improvement
> > though I still believe Michal's suggestion of implementing OOPS_ON is a
> > better approach to pursue, as it doesn't crash the entire system
> > while ensuring the problematic process is terminated.
>
> Linus made clear it's not a mm concern. If e.g. hardening people want to
> pursuit that instead, they can.
>
> BTW I think BUG_ON already works like this, if possible only the calling
> process is terminated. panic happens in case of being in a irq context, o=
r

you are right. This is a detail I overlooked in the last discussion.
BUG_ON has already been exactly the case to only terminate the bad
process if it can
(panic_on_oops=3DN and not in irq context).

> due to panic_on_oops. Which the security people are setting to 1 anyway a=
nd
> OOPS_ON would have to observe it too. So AFAICS the only difference from
> BUG_ON would be not panic in the irq context, if panic_on_oops isn't set.

right.

> (as for "no mm locks held" I think it's already satisfied at the points w=
e
> check for __GFP_NOFAIL).

Let me summarize the discussion:

Patch 1/4, which fixes the misuse of combining gfp_nofail and atomic
in vdpa driver, is necessary.
Patch 2/4, which updates the documentation to clarify that
non-blockable gfp_nofail is not
                  supported, is needed.
Patch 3/4: We will replace BUG_ON with WARN_ON_ONCE to warn when the
size is too large,
                 where gfp_nofail will return NULL.
Patch 4/4: We will move the order > 1 check from the current fast path
to the slow path and extend
                 the check of gfp_direct_reclaim flag also in the slow path=
.

If nobody has an objection, I will prepare v4 as above.

Thanks
Barry
