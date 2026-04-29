Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72AF63A7F66;
	Wed, 29 Apr 2026 07:58:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777449519; cv=none; b=o6d/6hes8dsakbOND9vw4+YHpugvXBeZSm6IxivDBMesuBh692tCNRJwBdJUbTiItKd3yqRt97HcOBqLh69qgsCDkF/sRLMsyCi1FTLkEY57zufYhmMHHyRGYVrvIDoIimebCC4mQUdUr2Uws0SQrCgfwKgQ1LcpndU+768Yy/E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777449519; c=relaxed/simple;
	bh=kTK3qGUH+aUg0IddMUS22SwIVSfAhQliFGGy5MXuCIA=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=kfm9rLiqHM++yoIU8yEciDZwBey1WFdB99dYiPFfM/P3PEqhN/bZ/0VdajM0m+6jy2j1WEwGRiOuWQLQgxJYEcctBtdMES1L2Ok09BStG9Lo0vRbmSBnxK6cxmHA7aki1oHh2HLnED5TkNkTMOWFCZDCQfPtS1APEQ9Qa93gRT0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=B/9DmbHe; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="B/9DmbHe"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8C462C19425;
	Wed, 29 Apr 2026 07:58:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777449519;
	bh=kTK3qGUH+aUg0IddMUS22SwIVSfAhQliFGGy5MXuCIA=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=B/9DmbHe9Zx3tx4XoFCLnlVKMDd5o3tkJbuhE+zeQksaqLVZhAkAGI/sqJiERpslr
	 lnbMnYoUKe68v+IIY+uCqJTykHJmuRiU9c2//F/nKax1RGdwnqVSxNLJKthyDljx1M
	 +DGloNRAxTzgSaHb7C12gqPiW04yftfesGO5neQC3iCgfMOAY+eX4EAnEXUWdHTXJ0
	 QOFW45zX0nzYI5Wwc+jKwjpNqpVqPku6ACup69zrRhgkiHO/qSbr5CyNU95diMEZEw
	 FoiT9p6QeLPHjB0nykiMdfXnMyeidkoioVRDol7NOI33gqnxMOgxl524EaW/kGtNa2
	 3F717YoAZ3RWA==
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfauth.phl.internal (Postfix) with ESMTP id 90CB5F40068;
	Wed, 29 Apr 2026 03:58:37 -0400 (EDT)
Received: from phl-imap-02 ([10.202.2.81])
  by phl-compute-01.internal (MEProxy); Wed, 29 Apr 2026 03:58:37 -0400
X-ME-Sender: <xms:LbrxaRqGdWmZ1tX1KnyB6z_EAWRwBySpqD3hiG1Lo4ytAygqDaNxsA>
    <xme:LbrxaedIDIWTyrLDlpTj5w2tFIbr_WTR4bhpVqHPO1DIj8Fa15tZsSDe2hf12-5bw
    UjwiBKB7JN4GUcSRRzXK1zE0RcZKJ59uMLNRxH6b5BLlovsKmZkd1Y0>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdekfeeltdcutefuodetggdotefrod
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
X-ME-Proxy: <xmx:Lbrxafro3OLUJNn86b6FPikqswzxctD_qpKHOBFuA9DZhcKtzOUQ_w>
    <xmx:LbrxaV-YWVHHjDOZlHgCdDgRvlcSeqdJVX_MH-xN6eHuRh5wuIuzOQ>
    <xmx:Lbrxad3clLUDIPOx5_C_ayrmhCBYPJ4hIbqjYZRoneS28njVdlaMZA>
    <xmx:LbrxaQBX0Zm3uKvCFB7fkOXwyBIPWXewzXr4On1MI0BtIGYvq9iYyg>
    <xmx:LbrxaUCnLYkPVEumERG95cJ0uQUbH1yPaoNj4X0h-KiukPgc15xcscqs>
Feedback-ID: ice86485a:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 6D702700069; Wed, 29 Apr 2026 03:58:37 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Wed, 29 Apr 2026 09:58:17 +0200
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
Message-Id: <e0f0052b-b28c-41ad-8a82-18cebe5141e4@app.fastmail.com>
In-Reply-To: <1ba0b6ce-3e71-45f7-a3c8-cdc5aadcaf27@arm.com>
References: <20260427153416.2103979-17-ardb+git@google.com>
 <20260427153416.2103979-18-ardb+git@google.com>
 <82091dd4-9d11-4054-89ec-99aadaeec7b2@arm.com>
 <6f514d91-c8ce-473f-8383-f3b9a4cc2f7a@app.fastmail.com>
 <1ba0b6ce-3e71-45f7-a3c8-cdc5aadcaf27@arm.com>
Subject: Re: [PATCH v4 01/15] arm64: mm: Map the linear alias of text/rodata as tagged
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable



On Wed, 29 Apr 2026, at 09:57, Kevin Brodsky wrote:
> On 28/04/2026 18:23, Ard Biesheuvel wrote:
>> Hi Kevin,
>>
>> On Tue, 28 Apr 2026, at 16:16, Kevin Brodsky wrote:
>>> On 27/04/2026 17:34, Ard Biesheuvel wrote:
>>>> From: Ard Biesheuvel <ardb@kernel.org>
>>>>
>>>> Before moving the empty_zero_page into the __ro_after_init section,=
 make
>>>> sure it has the memory-tagged type. This is needed to ensure that
>>>> cpu_enable_mte() will be able to initialize the tags correctly.
>>> mark_linear_text_alias_ro() is called after all features have been
>>> detected and enabled, so do we actually need this?
>>>
>>> AFAICT the lines that matter for cpu_enable_mte() are those, in map_=
mem():
>>>
>>> =C2=A0 =C2=A0 __map_memblock(pgdp, kernel_start, kernel_end,
>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0PAGE_KERNEL, =
NO_CONT_MAPPINGS);
>>>
>>> It is probably this call that needs to be changed to use
>>> pgprot_tagged(PAGE_KERNEL).
>>>
>> I see. I guess we should probably update both, no?
>
> We could, but would we ever access the tags in data mapped read-only?
> cpu_enable_mte() needs tag access to zero them, but AFAIU it's really a
> special case that is only relevant to the situation where the data is =
RW.
>

Right, that makes sense.

