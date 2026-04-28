Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9013333C536
	for <linux-hardening@vger.kernel.org>; Tue, 28 Apr 2026 16:24:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777393452; cv=none; b=J95Hf7Up0BTqSGOlArRi2bjspdD0cA+zS2za8ek4ZLtZaROwsBv8ev5TTSp/+rr7zJvUB8C1eBdaZWbPkhG6nc4a8O8jRrempaOWV8gubpVW2THnoIzPZnx8NttSuDJQVv61Oz2kDR0rr5TUZnSCghSr4jCi4S38/fSsS7piNG4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777393452; c=relaxed/simple;
	bh=1bsBBNqxiKFL3r8pzOvOev7yw0CjKM3t1BUQ0CdvGx0=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=MEHlOxG1TDJWxRGpA+9ezDd+rBMPSr0F9i2gbaEh2k2bvTfd57u+SiPY5z4zrr8Kf2pmUi6c8UwMc/IgQylg/V0bMsUJESmV/B5PKiSmDm5F7QQ10Mpd2JUV9nfxPlsiUAqLAYNsNtZXT/105PEL1tjWp0mabzv+q86+C4sCtAE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XVmistFN; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XVmistFN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 44BCBC2BCAF;
	Tue, 28 Apr 2026 16:24:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777393451;
	bh=1bsBBNqxiKFL3r8pzOvOev7yw0CjKM3t1BUQ0CdvGx0=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=XVmistFN8/AEghX6pffM/5j7riai3DZFfdo5awvBluU0b3251iGl8B0WTcJyuNogY
	 3jiKfKocsbCoPVKBs6st/fHY1C7DaXzOCKX8LXoLM4CEwmvWanRfaZHAxJlnjHYU8O
	 dJo71n/3wQIzbDVxCS10z9e5KGQlSrW7XGompGKeN1zuJ7TeFo5gRqFvxFkLoPZrKG
	 GRkZu4Wup4H2+cnHuZpXiuix1m0SjMQzruSCVVhn7mx2mEOZkHNIunY9qt5gZneGME
	 yoXUa6l4HsixTCw50S1CGwbRXlu0qlE8ah3pjclS4QgyfJlWSq5FgJ9L8KDXL547CB
	 9nfMbgQkWqNIg==
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfauth.phl.internal (Postfix) with ESMTP id 420E4F4006B;
	Tue, 28 Apr 2026 12:24:10 -0400 (EDT)
Received: from phl-imap-02 ([10.202.2.81])
  by phl-compute-01.internal (MEProxy); Tue, 28 Apr 2026 12:24:10 -0400
X-ME-Sender: <xms:Kd_waTM-YpeIRzy6D8hDAAt6tG8XpwJacDqOgicev-Z2qTgRv44aGA>
    <xme:Kd_waYwhSSVNBP78OasJTegpNlbyZaVG9bMbGJfUfL-mwJqvhkcePIwgGLvB3IgtX
    uWdXMW7Nn4z9cEV3njTHAWlN0IpeO2AKTZ9LhSGUtAuoElV8mPr_DM>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdekvddtfecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefoggffhffvvefkjghfufgtgfesthhqredtredtjeenucfhrhhomhepfdetrhguuceu
    ihgvshhhvghuvhgvlhdfuceorghruggssehkvghrnhgvlhdrohhrgheqnecuggftrfgrth
    htvghrnhepueetieduieegkeejvdehudeiheettefgtdeugffhjefghfeftdelhedvheff
    hfdvnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprg
    hrugdomhgvshhmthhprghuthhhphgvrhhsohhnrghlihhthidqudeijedthedttdejledq
    feefvdduieegudehqdgrrhgusgeppehkvghrnhgvlhdrohhrghesfihorhhkohhfrghrug
    drtghomhdpnhgspghrtghpthhtohepudejpdhmohguvgepshhmthhpohhuthdprhgtphht
    thhopegrnhhshhhumhgrnhdrkhhhrghnughurghlsegrrhhmrdgtohhmpdhrtghpthhtoh
    eptggrthgrlhhinhdrmhgrrhhinhgrshesrghrmhdrtghomhdprhgtphhtthhopehkvghv
    ihhnrdgsrhhoughskhihsegrrhhmrdgtohhmpdhrtghpthhtohepmhgrrhhkrdhruhhtlh
    grnhgusegrrhhmrdgtohhmpdhrtghpthhtoheprhihrghnrdhrohgsvghrthhssegrrhhm
    rdgtohhmpdhrtghpthhtoheprghruggsodhgihhtsehgohhoghhlvgdrtghomhdprhgtph
    htthhopehlihiiphhruhgtkhgrsehgohhoghhlvgdrtghomhdprhgtphhtthhopehsvght
    hhhjvghnkhhinhhssehgohhoghhlvgdrtghomhdprhgtphhtthhopegurghvihgusehkvg
    hrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:Kt_waetmYIlefUPzV8DLJtcXoLyndaR0qgHSXePM5t-l1I6k7WeH_Q>
    <xmx:Kt_wafy9qHJBlVvot4VmPvKrB1oLabolvskFZjhEuHfBCd8ye4MdnQ>
    <xmx:Kt_wabbuztJ0Wj6nXCkW5OdQ5qtgvzpA30rGIbmCNeR4Z5FwwmerCw>
    <xmx:Kt_waWXmn9nmIyXPgk4Tmqxgiwfc-GzV_MBAadTlVGA9CktWULE_Vw>
    <xmx:Kt_waUFzERDSXIWNL7VNTwX1AjlL5laOfDG61W-HqteEpSf5IwAdRQtM>
Feedback-ID: ice86485a:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id E4EF9700065; Tue, 28 Apr 2026 12:24:09 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Tue, 28 Apr 2026 18:23:48 +0200
From: "Ard Biesheuvel" <ardb@kernel.org>
To: "Kevin Brodsky" <kevin.brodsky@arm.com>,
 "Ard Biesheuvel" <ardb+git@google.com>, linux-arm-kernel@lists.infradead.org
Cc: linux-kernel@vger.kernel.org, "Will Deacon" <will@kernel.org>,
 "Catalin Marinas" <catalin.marinas@arm.com>,
 "Mark Rutland" <mark.rutland@arm.com>, "Ryan Roberts" <ryan.roberts@arm.com>,
 "Anshuman Khandual" <anshuman.khandual@arm.com>,
 "Liz Prucka" <lizprucka@google.com>, "Seth Jenkins" <sethjenkins@google.com>,
 "Kees Cook" <kees@kernel.org>, "Mike Rapoport" <rppt@kernel.org>,
 "David Hildenbrand" <david@kernel.org>,
 "Andrew Morton" <akpm@linux-foundation.org>, linux-mm@kvack.org,
 linux-hardening@vger.kernel.org
Message-Id: <6f514d91-c8ce-473f-8383-f3b9a4cc2f7a@app.fastmail.com>
In-Reply-To: <82091dd4-9d11-4054-89ec-99aadaeec7b2@arm.com>
References: <20260427153416.2103979-17-ardb+git@google.com>
 <20260427153416.2103979-18-ardb+git@google.com>
 <82091dd4-9d11-4054-89ec-99aadaeec7b2@arm.com>
Subject: Re: [PATCH v4 01/15] arm64: mm: Map the linear alias of text/rodata as tagged
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi Kevin,

On Tue, 28 Apr 2026, at 16:16, Kevin Brodsky wrote:
> On 27/04/2026 17:34, Ard Biesheuvel wrote:
>> From: Ard Biesheuvel <ardb@kernel.org>
>>
>> Before moving the empty_zero_page into the __ro_after_init section, m=
ake
>> sure it has the memory-tagged type. This is needed to ensure that
>> cpu_enable_mte() will be able to initialize the tags correctly.
>
> mark_linear_text_alias_ro() is called after all features have been
> detected and enabled, so do we actually need this?
>
> AFAICT the lines that matter for cpu_enable_mte() are those, in map_me=
m():
>
> =C2=A0 =C2=A0 __map_memblock(pgdp, kernel_start, kernel_end,
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0PAGE_KERNEL, NO=
_CONT_MAPPINGS);
>
> It is probably this call that needs to be changed to use
> pgprot_tagged(PAGE_KERNEL).
>

I see. I guess we should probably update both, no?
