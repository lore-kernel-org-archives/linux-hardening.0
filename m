Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C34863E5566;
	Wed, 13 May 2026 08:53:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778662410; cv=none; b=ZtMr2ST2/0X336Ey7RfbFk631FXZ21e4wbmrLPp8+ygfhMor/idBhk7FhkRXwPvkgY4Oj1XedbmxvWZZTMPInv95i9Mn584/pOmIbv2gvpHkegps40YEFk+Olt2fuEzbs2G0FCnHNyf+PJE4btU3dNKFxY6JXBb73by95Vy26ME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778662410; c=relaxed/simple;
	bh=udpx4tAi5cV12nowkKiduLaSTNB4aDhgn4UtaDGhwjc=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=ZtOdQAn2TF8DCBmvT/QFS5PBznfmcnUhS59r9i7KXTgmPA/fMzP4wnzSc1s/94Fm8/oqxqrbQjxALLmc75MMLwTvZ3h6DCDmczR2rtHrylUmfC8wLfNR+PAInFcMH7MqjCl8g/qi+4oMx4TnQkOiCJqegtiWiQsG5UakpQAgrOI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TFLSeyIK; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TFLSeyIK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6B51CC4AF0B;
	Wed, 13 May 2026 08:53:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778662410;
	bh=udpx4tAi5cV12nowkKiduLaSTNB4aDhgn4UtaDGhwjc=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=TFLSeyIKM3nO5KtQ25NMjtAqXdTDDHhcEDTl0JmX2fDFXUxiCSzFjgYW4hiJ/kdcV
	 lTDx/Ur8cMtHJ4JFYAQvhMOO5KjjYHESzsEDcwNaq2J7nDhOPoP4ojQsW5vNM72UEP
	 mSQTuwPI7Fs3wlBcE61I1YJn+xY4ldHtMdPmBckiv7is2Kmg6c8O7hSuVMu1rB2vuE
	 pE/6n1M1+DuTGrrs5kf83NnfBMkzELv4K5v2TFLDhj9XAtvZxyIxFDyyEKgYogjBxm
	 kS1RhUgCVTGwUvMU/pFugdJ7qzcGeMbCHk8Le9p7IlVZIfKD2/87R1IWJ3VVpNDqyX
	 4V4Ck5iZaoTSQ==
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfauth.phl.internal (Postfix) with ESMTP id 7CDE2F40085;
	Wed, 13 May 2026 04:53:28 -0400 (EDT)
Received: from phl-imap-14 ([10.202.2.87])
  by phl-compute-01.internal (MEProxy); Wed, 13 May 2026 04:53:28 -0400
X-ME-Sender: <xms:CDwEakOyH6OqlreTlGvvT2Crs3Oc2Zreu7-Y5q5ti18GeFTbRP4siw>
    <xme:CDwEalzs-Tm8WR_tpsIrmFwaojRXZTlrvddgPEBnyrn7qd9Oa-XmzW17Ajb5W1rsm
    ENwQdTzAdrLZQPEASmu0GifNfjvpqY9OP_ABNVIbFtnP35Hd7w8YX0>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdduvdegvdefucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepofggfffhvfevkfgjfhfutgfgsehtqhertdertdejnecuhfhrohhmpedftehrugcu
    uehivghshhgvuhhvvghlfdcuoegrrhgusgeskhgvrhhnvghlrdhorhhgqeenucggtffrrg
    htthgvrhhnpeefhefgtefgkefhgfdvffdukeejheeuvedthfdtiefhleejhfefjeffieeu
    jeefteenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuihiivg
    eptdenucfrrghrrghmpehmrghilhhfrhhomheprghrugdomhgvshhmthhprghuthhhphgv
    rhhsohhnrghlihhthidqudeijedthedttdejledqfeefvdduieegudehqdgrrhgusgeppe
    hkvghrnhgvlhdrohhrghesfihorhhkohhfrghrugdrtghomhdpnhgspghrtghpthhtohep
    udejpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopegrnhhshhhumhgrnhdrkhhhrg
    hnughurghlsegrrhhmrdgtohhmpdhrtghpthhtoheptggrthgrlhhinhdrmhgrrhhinhgr
    shesrghrmhdrtghomhdprhgtphhtthhopehmrghrkhdrrhhuthhlrghnugesrghrmhdrtg
    homhdprhgtphhtthhopehrhigrnhdrrhhosggvrhhtshesrghrmhdrtghomhdprhgtphht
    thhopegrrhgusgdoghhithesghhoohhglhgvrdgtohhmpdhrtghpthhtohepjhgrnhhnhh
    esghhoohhglhgvrdgtohhmpdhrtghpthhtoheplhhiiihprhhutghkrgesghhoohhglhgv
    rdgtohhmpdhrtghpthhtohepshgvthhhjhgvnhhkihhnshesghhoohhglhgvrdgtohhmpd
    hrtghpthhtohepuggrvhhiugeskhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:CDwEanu0ZxvdrKWQDcCPlWGRQUZs_3Zu2ihfUq1ao8QuBRliJl_ZJA>
    <xmx:CDwEakwkNJDN5jK8LR56K91k_tsmxmY540V_2TCcSC26-5LgRKOeqA>
    <xmx:CDwEasZe1VaZQUnuPI0TcP3cnwXPrIei1cw3PCWgTVdElaZhAV0cuA>
    <xmx:CDwEajX9ywcTlL_5nyroUU_gaoxjHhgQTX7qic9mAwdpmvWY8RlFgA>
    <xmx:CDwEatEJFr18fZzdaekmfSF2cVsV5T1A9rG4sRBjctmlK2Mk6iEtPuAb>
Feedback-ID: ice86485a:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 58AEAC4006E; Wed, 13 May 2026 04:53:28 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Wed, 13 May 2026 10:53:08 +0200
From: "Ard Biesheuvel" <ardb@kernel.org>
To: "Mike Rapoport" <rppt@kernel.org>
Cc: "Jann Horn" <jannh@google.com>, "Ard Biesheuvel" <ardb+git@google.com>,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 "Will Deacon" <will@kernel.org>, "Catalin Marinas" <catalin.marinas@arm.com>,
 "Mark Rutland" <mark.rutland@arm.com>, "Ryan Roberts" <ryan.roberts@arm.com>,
 "Anshuman Khandual" <anshuman.khandual@arm.com>,
 "Liz Prucka" <lizprucka@google.com>, "Seth Jenkins" <sethjenkins@google.com>,
 "Kees Cook" <kees@kernel.org>, "David Hildenbrand" <david@kernel.org>,
 "Andrew Morton" <akpm@linux-foundation.org>, linux-mm@kvack.org,
 linux-hardening@vger.kernel.org
Message-Id: <49d30ffe-b7e1-4b05-89e0-c3fe01348bb6@app.fastmail.com>
In-Reply-To: <agQ7RMAw51RlNUOj@kernel.org>
References: <20260427153416.2103979-17-ardb+git@google.com>
 <20260427153416.2103979-19-ardb+git@google.com>
 <CAG48ez1DJ88a0pBCE-Q0VXyDuJgng8zdunb38g4b4JPU88exww@mail.gmail.com>
 <31252c1d-a98d-4635-ab61-ce5b649e256f@app.fastmail.com>
 <CAG48ez2xJwJDgxSH0u2G==9dOQJQxQ7WsQfU14O1H5hEWic1eA@mail.gmail.com>
 <fb5749bb-bc87-4f0b-9ec9-8a1eb7ded3b5@app.fastmail.com>
 <agQ7RMAw51RlNUOj@kernel.org>
Subject: Re: [PATCH v4 02/15] mm: Make empty_zero_page __ro_after_init
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable



On Wed, 13 May 2026, at 10:50, Mike Rapoport wrote:
> On Tue, May 12, 2026 at 02:56:16PM +0200, Ard Biesheuvel wrote:
>> On Mon, 11 May 2026, at 16:40, Jann Horn wrote:
>> > On Mon, May 11, 2026 at 10:59=E2=80=AFAM Ard Biesheuvel <ardb@kerne=
l.org> wrote:
>> >> I think we should simply do something along the lines of the below,
>> >> considering that the size of a data object tends to correlate with
>> >> its minimum alignment.
>> >>
>> >> I do find it rather puzzling that the compiler emits empty_zero_pa=
ge
>> >> *after* zero_page_pfn - ideally, we'd combine the below with
>> >> -fdata-sections so that the linker sees all individual objects, but
>> >> I suspect that would create some problems elsewhere.
>> >>
>> >>
>> >> --- a/include/asm-generic/vmlinux.lds.h
>> >> +++ b/include/asm-generic/vmlinux.lds.h
>> >> @@ -452,7 +452,7 @@
>> >>  #define RO_AFTER_INIT_DATA                                   \
>> >>         . =3D ALIGN(8);                                         \
>> >>         __start_ro_after_init =3D .;                            \
>> >> -       *(.data..ro_after_init)                               \
>> >> +       *(SORT_BY_ALIGNMENT(.data..ro_after_init))            \
>> >
>> > Oh, neat, I didn't realize that's possible. That seems like a nicer
>> > approach...
>>=20
>> Neat but rather ineffective, unfortunately. (I don't see a size
>> difference with the arm64 defconfig kernel)
>>=20
>> Given that empty_zero_page only ever gets its address taken, we
>> might just move it into the linker script if that requires tweaking
>> anyway. We can just place it at the start of .rodata, which is
>> already page aligned on most architectures (and will become page
>> aligned unless EMPTY_ZERO_PAGE is #define'd by the arch linker
>> script to something else)
>>=20
>>=20
>> --- a/include/asm-generic/vmlinux.lds.h
>> +++ b/include/asm-generic/vmlinux.lds.h
>> @@ -472,6 +472,17 @@
>>  #endif
>>  #endif
>> =20
>> +#ifndef EMPTY_ZERO_PAGE
>> +#ifndef __HAVE_COLOR_ZERO_PAGE
>
> I don't think we want let architectures that don't use colored zero pa=
ges
> redefine it.
> If it will be really required we can add the ability to redefine
> EMPTY_ZERO_PAGE later.
>

I was actually intending to add use this for arm64 in the next patch. It
already has a reserved_pg_dir in .rodata which is page-sized (i.e., up
to 64k in size) and guaranteed to remain all zeroes, so empty_zero_page
could actually be an alias for that. This is what I had in a previous
revision, before you turned the empty_zero_page definition into common
code:

https://lore.kernel.org/all/20260320145934.2349881-16-ardb+git@google.co=
m/



