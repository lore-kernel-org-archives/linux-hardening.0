Received: from mail-qk1-f181.google.com (mail-qk1-f181.google.com [209.85.222.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 066D41F4285
	for <linux-hardening@vger.kernel.org>; Tue, 21 Jan 2025 15:38:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737473926; cv=none; b=UYVO2TVhAmZDGbYaaYamBkmTbEvS8q+Ul2K2eedGSbE0d1WnVwnmTL+MaxYdetGJedBVpBM+fSuAm6T1SJm4mqykp7s/Y/mkTdFeHX9KoK/p9jxReNO4QzKjrchN/wSQvCDW+Nj5OzJ+gqGhWVR1oQZ6WpOl+SwGDb33WaJ17Tw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737473926; c=relaxed/simple;
	bh=wXbPtfG6OX/fZzo5GBygwakP/GK7OIf7vQ5InWG+iYk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=MkEkrB3LNwAOdA+5p0g9vx8mOkzsX6KjNwbSSfAfZDuBXRIBPfHoKraVzu5jp9N8NyUubyt3sGohhsu9yT7jtxpNMH6XGNSGrCsceGmSkQTxyCena1RQbbugPoPRan7eFGmOJQa70Sm2mUKDe8OWxoxOWr7NbEwQF4EwGyETwag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=DqMyETBq; arc=none smtp.client-ip=209.85.222.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="DqMyETBq"
Received: by mail-qk1-f181.google.com with SMTP id af79cd13be357-7bcf33f698dso518949785a.2
        for <linux-hardening@vger.kernel.org>; Tue, 21 Jan 2025 07:38:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1737473924; x=1738078724; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wXbPtfG6OX/fZzo5GBygwakP/GK7OIf7vQ5InWG+iYk=;
        b=DqMyETBqYcvu0mEl8kuz6ZS3T9y2mr5Y33iN76kpqxL52PjLWeUvJrA7c4C4Y5mhWN
         f3kR/LvDCrO3m9HC0qEyWBNICx9SZM3hE+653Q7cVSc2OsEex6IpGWeyZ7HHerss+DKT
         qwPcAHrNLLIAEasuCkxcoW/N4Mf0IV2sx0ZIc8y8HsxyHNB1YKU95XRoHsOPvujpRn/y
         SIDf5NRhxq3FXWoguq5Q5eDKqWnBjrQaehEnxxQpxgirSPRCEjPpdRUFYFkKDzOxHQ6+
         ypEm9CKFLPjOq8vQKkGrWKVZVmNbYwFcpAM6WAEAcT/IzAKStkSm+Y5/W/mJRENWYooA
         LP4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737473924; x=1738078724;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wXbPtfG6OX/fZzo5GBygwakP/GK7OIf7vQ5InWG+iYk=;
        b=luLYRc3WPRvrTyCtqYRg5I5QCkigqgRDHNmXtr+raEQd6VJyK76/R2q+pVWe0zDqJW
         9+Kt0cFF8NIf0c12NKCvDCOesb4mQrJtlCBBcZeriL0vM3a7ASmWnxkrnSfsSY1Js/Ia
         QBhZFj6fvs5HqwQ15h84RLDANnls1JwofGkg6b7GNYXbjeNPf8Ctt99wovaPl4Wn+baM
         wxpddBPwMajwZPeO7xM9z50Nwi7wK8IYhvL1GouA7ZkkgsbRbzv33YrqUIvPLJKjpwW3
         nzXo5Jt3G1S04jZgFAJSK5zxTtZJrcJWU2xvzVR7ZQqlKt4E3STi/3Q8Paf2mx+ObfwR
         ZJvQ==
X-Forwarded-Encrypted: i=1; AJvYcCUPSrw5RBPzOdErEIdvuCJlx0Xx/KsykBa8W/aYoYnJKMAybPqgZv6p5gY8IXd2cxA3Xf89O27zaM3Pdmzgw/Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YwIf38RkOzDRdsR6LwvyOzU1aJA/bj31SC67JfPOTW+EMrEI3o9
	LDyBV/aQ/WI6KprHI1sfvLKQyXRbRpQsNUc5NBuJ16J5mMVL5DCQ7DYVJOel01jEtdKUPe0oQUi
	OZFdpEgHQhqDsTVx1tSk1mpFTeKOmL2xPA5lw
X-Gm-Gg: ASbGncuJq6ppwtpnoc8GusWYvwLkm8HQ5am+kODybSMWYTmTu5p0w/w/ZMdL5UBWaG7
	H9wnqyAcyzl2aRqbHvI/ircJ+lqccGnq/qp6DbaMYayvIlENC
X-Google-Smtp-Source: AGHT+IH2AKLBa2Z32l2lWnfu4E9pnovaAlVvU+CDW8xr+dDGVb09CiGZaH6ORsIC+VXBLZx4gmt9UFmfU+yhnig/Ur0=
X-Received: by 2002:a05:6214:2466:b0:6d8:b115:76a6 with SMTP id
 6a1803df08f44-6e1b1b26187mr321560316d6.0.1737473923655; Tue, 21 Jan 2025
 07:38:43 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <202501061647.6C8F34CB1A@keescook> <CABi2SkUfAoCbsknnXnyoFbCPOFRahDx+Vqz3ohnyf_G1p4eszA@mail.gmail.com>
 <CABi2SkXS9OOwP2BZGQOa=Pn+NoL1VmOJBJEn-6tWBBQwLtpYiw@mail.gmail.com>
 <5cf1601b-70c3-45bb-81ef-416d89c415c2@lucifer.local> <CABi2SkX--gf8XtzBd1G7wS6E=F51rFckP62V0GrONuXs1TCOcQ@mail.gmail.com>
 <7071878c-7857-4acd-ac27-f049cbc84de2@lucifer.local> <2e5de601da34342d8eb0d8319dcf81ff213c7ef0.camel@sipsolutions.net>
 <CAKbZUD1btTbeEht6W5MmhgtEJk3dg55cBpBtoDL0ieaL=23qeQ@mail.gmail.com>
 <CABi2SkWoNTd5sRJ7-7arPfutYZx6xi9iac0mXZyfzuVXuh1atA@mail.gmail.com>
 <CAJgzZop04=7+13jjV_zDfJF4dyJ7tp-86G8_mRe=C=sBEp+z3Q@mail.gmail.com> <ocstrhpyoyxzurvvxbrbnlzfqzo6hiqt7dxj7vu45ipj4min6z@ffnpao72slda>
In-Reply-To: <ocstrhpyoyxzurvvxbrbnlzfqzo6hiqt7dxj7vu45ipj4min6z@ffnpao72slda>
From: enh <enh@google.com>
Date: Tue, 21 Jan 2025 10:38:32 -0500
X-Gm-Features: AbW1kvbpVP0FEwwCGd_2Q54HtfoIbYiStsGFG684toRNN56zCqOwNktD1Uc_TOk
Message-ID: <CAJgzZopv+jKmDncYDJEQTymqQ1oRpy8HNpOsmcoM7Chb=uBJzg@mail.gmail.com>
Subject: Re: [PATCH v4 1/1] exec: seal system mappings
To: "Liam R. Howlett" <Liam.Howlett@oracle.com>, enh <enh@google.com>, 
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
	Vlastimil Babka <vbabka@suse.cz>, Andrei Vagin <avagin@gmail.com>, Dmitry Safonov <0x7f454c46@gmail.com>, 
	Mike Rapoport <mike.rapoport@gmail.com>, 
	Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 17, 2025 at 5:08=E2=80=AFPM Liam R. Howlett <Liam.Howlett@oracl=
e.com> wrote:
>
> * enh <enh@google.com> [250117 14:35]:
> ...
>
> >
> > as a maintainer of a different linux libc, i've long wanted a "tell me
> > everything there is to know about this vma" syscall rather than having
> > to parse /proc/maps...
> >
>
> You mean an ioctl()-based API to query VMAs from /proc/<pid>/maps?

i wasn't imagining an ioctl(), no, just a regular syscall, but that
would work too.

> Andrii had something like that [1], check out ed5d583a88a92 ("fs/procfs:
> implement efficient VMA querying API for /proc/<pid>/maps")

yeah, that would work for the use cases i've seen too (some of which
are similar to the ones mentioned in the patch description, but other
ones too).

the other motivation we've had that i didn't notice mentioned there is
avoiding the awkward /proc/<pid>/maps behavior when you have too many
vmas to fit all the output into a page.

i'd definitely use this in Android's libc, and several of our
profiling/unwinding libraries.

> Regards,
> Liam
>
> [1]. https://lore.kernel.org/linux-mm/20240627170900.1672542-1-andrii@ker=
nel.org/
