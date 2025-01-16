Received: from mail-vs1-f45.google.com (mail-vs1-f45.google.com [209.85.217.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E09B1917F1;
	Thu, 16 Jan 2025 17:18:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737047910; cv=none; b=CcMImBhwJkB/mhhGVddHviuLEfz1sTDqxBCHdGvtfc3zSG6FPC7JHmxFYxqR1sK7UHBFDxDukj3a5t1snVDITDHpFVJ96aTEOAkY+Hf0HEtJ6upID4x+f8S31J6Z9r5kfcA3Y5mdVZUDAvXcTMlwg6K0HNX/HN1Izip79uFFhb0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737047910; c=relaxed/simple;
	bh=1DKZWVz4/CaomlyOtZI5eKUKClAQQKtoiGYz9yjl+sM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Rxet0zGdDrzL8yiTzFMbFRyC84C1bhcabRt3mHsINTEdwFlEMrOE/k/8zJNDFtUzrocyETx8qIit1ribmz6jbvG8usnuMnBot7YR3dnV9kRVTP0ZKYWfNyCHHpAvc8wJqW81HpnmF9jF3I+yPhTD3x8a2xj2YyJ6Wi27qI28uqk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bkpHY/vt; arc=none smtp.client-ip=209.85.217.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bkpHY/vt"
Received: by mail-vs1-f45.google.com with SMTP id ada2fe7eead31-4aff5b3845eso256096137.2;
        Thu, 16 Jan 2025 09:18:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737047908; x=1737652708; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NIb1wl7rZ3beW2GNNrOqyUi3HQyIhkAMG063uoHeVxk=;
        b=bkpHY/vtpippXuc4pelcML8oZX/tUwo7ZUjpHyjcdOX+tYfyh8eYhKmev6pVZZkRCJ
         bEItOzkpYtHah2sdrs93yKWXwquBTr1X4l+4mp4Bzx7HEkhkWRlWrom1whBOlZMMGGwN
         N0qsbSJKiPjuN36lwJV7+JRg2WFeF2KrzEM7xNJZyTzXbEtfsQ/w4tNSKS1WHSYP5WuC
         wzS/AK61DMVlysW7HcuKq/hy9IUA5nKsxSZRz904wgy7Q2Rbj9Dl3mH8Cwmj0Jnrg5sX
         GJ+6y7o5F3ynI1DiGrv3hdqWTnkilzV6HBA6SST5kj3rcJFB6gQCr6IxYt39sobLJu7F
         9Xlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737047908; x=1737652708;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NIb1wl7rZ3beW2GNNrOqyUi3HQyIhkAMG063uoHeVxk=;
        b=a4dztar8U3rMsNoIz8QtcI0zR/4xQO5/gWOTopu/5l1zHKNgHO61++4Im1aBGBVMod
         ZbgsUaPwHUeAo+7oHHVY61862wYhBP9HRJp8DtVbVzsWchfBh/jn21EA+x7ddR2je/RT
         R1Gc1Hci5pHZBSqpDMpFJyYwtc6k+imxLZPG3owl7BBplLIkQDxi7wtSGqpLcEwHDArk
         TcQfjqzcHciilCr2YaQcZ74BEmv8YTearfEGySK6G/srleVG61ThTO5IQK1hCEzcwRmr
         3UknR2QcxaEVddUpsFevdS8eMWSbqLORwJrAsHHb8omTgG8D+Z7SG232x4vohN3HypcN
         Msyg==
X-Forwarded-Encrypted: i=1; AJvYcCVxOPTub0rapM/EfiUJSqlfR0GpqUyTt91G8RdBE4zriy1fDnH4USal3axRzf5AqD4JkZH7cZXwcAnIe0dTjSQ=@vger.kernel.org, AJvYcCXZSoDDxggMd/RM1YM/f2EgL96f0srR3XA/9sCUiV7gkIhJ3gEEDZ6Z6Yivh38LtmVBuJCIFP4VLNvu5xkQ@vger.kernel.org
X-Gm-Message-State: AOJu0Yw1BGnz8igbIb0AnUg8yeF+uLii7EJkoh2VxQ22dYG80TYqpTxW
	tTTJx/MqkRQvldOsoeKedZ3EcHj/yOD+gnPTsdA9NUTFo+X/bXII8W/QUWwWY8FTKl/VqTF9cic
	zVOtQ+PHZJ+AxZ8z8hkHe5A8U5q8=
X-Gm-Gg: ASbGncufb0Vpc7+zdpHl+G0D+L3rLPMHLXmZ0lrKkzyU7RA9FR88e4S1XTvh22UC8mq
	gWlX/G3V5BTSQUdygE61c5Dr6DwyHJP/RmjuCV0Z3CNNYTCkNzhTyfMjbrcFuKd9r4GjNgw==
X-Google-Smtp-Source: AGHT+IGX+jGuDD23RFL3nsTA1kL7lcKnOBfgvlGI+womNk0s9t15qFzK++xtH4xhdlRhm2ifQuE4QMXDNgbJR5ot5JM=
X-Received: by 2002:a05:6122:3d04:b0:518:6286:87a4 with SMTP id
 71dfb90a1353d-51c6c46cf5cmr29833446e0c.4.1737047907748; Thu, 16 Jan 2025
 09:18:27 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241125202021.3684919-1-jeffxu@google.com> <20241125202021.3684919-2-jeffxu@google.com>
 <202412171248.409B10D@keescook> <a0a3b26b-2222-478c-a1cb-56514ec8d6ff@lucifer.local>
 <202501061647.6C8F34CB1A@keescook> <CABi2SkUfAoCbsknnXnyoFbCPOFRahDx+Vqz3ohnyf_G1p4eszA@mail.gmail.com>
 <CABi2SkXS9OOwP2BZGQOa=Pn+NoL1VmOJBJEn-6tWBBQwLtpYiw@mail.gmail.com>
 <5cf1601b-70c3-45bb-81ef-416d89c415c2@lucifer.local> <CABi2SkX--gf8XtzBd1G7wS6E=F51rFckP62V0GrONuXs1TCOcQ@mail.gmail.com>
 <7071878c-7857-4acd-ac27-f049cbc84de2@lucifer.local> <2e5de601da34342d8eb0d8319dcf81ff213c7ef0.camel@sipsolutions.net>
In-Reply-To: <2e5de601da34342d8eb0d8319dcf81ff213c7ef0.camel@sipsolutions.net>
From: Pedro Falcato <pedro.falcato@gmail.com>
Date: Thu, 16 Jan 2025 17:18:16 +0000
X-Gm-Features: AbW1kvb2icL8t-nMNbmK_a5xHlHYzrBc3Ijc7KF3gMPnlQvD5I3msU-Bte2Tok0
Message-ID: <CAKbZUD1btTbeEht6W5MmhgtEJk3dg55cBpBtoDL0ieaL=23qeQ@mail.gmail.com>
Subject: Re: [PATCH v4 1/1] exec: seal system mappings
To: Benjamin Berg <benjamin@sipsolutions.net>
Cc: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, Jeff Xu <jeffxu@chromium.org>, 
	Kees Cook <kees@kernel.org>, akpm@linux-foundation.org, jannh@google.com, 
	torvalds@linux-foundation.org, adhemerval.zanella@linaro.org, oleg@redhat.com, 
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org, 
	linux-mm@kvack.org, jorgelo@chromium.org, sroettger@google.com, 
	ojeda@kernel.org, adobriyan@gmail.com, anna-maria@linutronix.de, 
	mark.rutland@arm.com, linus.walleij@linaro.org, Jason@zx2c4.com, 
	deller@gmx.de, rdunlap@infradead.org, davem@davemloft.net, hch@lst.de, 
	peterx@redhat.com, hca@linux.ibm.com, f.fainelli@gmail.com, gerg@kernel.org, 
	dave.hansen@linux.intel.com, mingo@kernel.org, ardb@kernel.org, 
	Liam.Howlett@oracle.com, mhocko@suse.com, 42.hyeyoo@gmail.com, 
	peterz@infradead.org, ardb@google.com, enh@google.com, rientjes@google.com, 
	groeck@chromium.org, mpe@ellerman.id.au, Vlastimil Babka <vbabka@suse.cz>, 
	Andrei Vagin <avagin@gmail.com>, Dmitry Safonov <0x7f454c46@gmail.com>, 
	Mike Rapoport <mike.rapoport@gmail.com>, 
	Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 16, 2025 at 5:02=E2=80=AFPM Benjamin Berg <benjamin@sipsolution=
s.net> wrote:
>
> Hi Lorenzo,
>
> On Thu, 2025-01-16 at 15:48 +0000, Lorenzo Stoakes wrote:
> > On Wed, Jan 15, 2025 at 12:20:59PM -0800, Jeff Xu wrote:
> > > On Wed, Jan 15, 2025 at 11:46=E2=80=AFAM Lorenzo Stoakes
> > > <lorenzo.stoakes@oracle.com> wrote:
> >
> > [SNIP]
> > >
> > > > I've made it abundantly clear that this (NACKed) series cannot allo=
w the
> > > > kernel to be in a broken state even if a user sets flags to do so.
> > > >
> > > > This is because users might lack context to make this decision and
> > > > incorrectly do so, and now we ship a known-broken kernel.
> > > >
> > > > You are now suggesting disabling the !CRIU requirement. Which viola=
tes my
> > > > _requirements_ (not optional features).
> > > >
> > > Sure, I can add CRIU back.
> > >
> > > Are you fine with UML and gViso not working under this CONFIG ?
> > > UML/gViso doesn't use any KCONFIG like CRIU does.
> >
> > Yeah this is a concern, wouldn't we be able to catch UML with a flag?
> >
> > Apologies my fault for maybe not being totally up to date with this, bu=
t what
> > exactly was the gViso (is it gVisor actually?)
>
> UML is a separate architecture. It is a Linux kernel running as a
> userspace application on top of an unmodified host kernel.
>
> So really, UML is a mostly weird userspace program for the purpose of
> this discussion. And a pretty buggy one too--it got broken by rseq
> already.
>
> What UML now does is:
>  * Execute a tiny static binary
>  * map special "stub" code/data pages at the topmost userspace address
>    (replacing its stack)
>  * continue execution inside the "stub" pages
>  * unmap everything below the "stub" pages
>  * use the unmap'ed area for userspace application mappings
>
> I believe that the "unmap everything" step will fail with this feature.
>
>
> Now, I am sure one can come up with solutions, e.g.:
>    1. Simply print an explanation if the unmap() fails
>    2. Find an address that is guaranteed to be below the VDSO and use a
>       smaller address space for the UML userspace.
>    3. Somehow tell the host kernel to not install the VDSO mappings
>    4. Add the host VDSO pages as a sealed VMA within UML to guard them
>
> UML is a bit of a niche and I am not sure it is worth worrying about it
> too much.

I've been absent from this patch series in general, but this gave me
an idea: what if we let userspace seal these mappings itself? Since
glibc is already sealing things, it might as well seal these?
And then systems that _do_ care about this would set the glibc tunable
and deal with the breakage.

Is there something seriously wrong with this approach? Besides maybe
not having a super easy way to discover these mappings atm, I feel
like it would solve all of the policy issues people have been talking
about in these threads.

--=20
Pedro
