Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7F85230BD5;
	Tue, 27 Jan 2026 17:03:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769533397; cv=none; b=r8ZUBJuhC558CT9J/ntod5xynG0+tIg9b9YwSVlu6UpzI+zGa+oK99Lnl5/UyFZTA0i7JBHjT5HP/x7cARy2Uy//hpDoWi1okkBWbpvJ0UfaBbvQraOwKba0F817YOI4xrS/0hy/yOPV1O/Ab5zW8DJo2g+RZMwe7WDow9mkJCc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769533397; c=relaxed/simple;
	bh=+y+UVV/LwdxlwL5XB1uN8chfCtNJUlF5mrCJCR25qck=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=Cxs+85GdiYKj0IuJg2CrkmSdmreIfdgKPL2Kvv+bUlRMgKmuwTa6xacxmbXTO52oCc9qqxDvDnXx4eJ9Wd9COU97n6wkKTVD4EzugU0PLcY31iA/ItCj7iBO106AuS66tsuefIusbQ+D94qcJ3lD+iivqWv5cWNnUlrMyhF36iQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZEFqoGVW; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZEFqoGVW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1725BC116C6;
	Tue, 27 Jan 2026 17:03:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769533397;
	bh=+y+UVV/LwdxlwL5XB1uN8chfCtNJUlF5mrCJCR25qck=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=ZEFqoGVWxjp3gi0y/0vYOYB+5L11LIoaR9zo5xT736giZ/dYZ2Z5giSKckUZGwmzC
	 1wJDhOhLtPhQHvcriWI0Bahm2pbfeCigR/5CDVDDJc3d3RUlHSvL4TY6cqi5LkrgRW
	 OqV9pyy06pV8Ocsg5aRGTmDBjR4uTxpTzrih6TuOQzVi4aUhXxd+rVDKwr9cipx64Z
	 tE7r55sWpLaM/dF1Pk73lKhcQrAhc+CJHM1IbPQXHiKbqGIG2Ef55a2anRZHOKoLtg
	 uzwYSJLc2x4sHI1Dcv5hyKGlldy/qWE+cbvx8YS/u3lCZQs2Wx91KktXVaOaggnAtd
	 Z201GRrm+f1eA==
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfauth.phl.internal (Postfix) with ESMTP id 01AF2F4008E;
	Tue, 27 Jan 2026 12:03:15 -0500 (EST)
Received: from phl-imap-02 ([10.202.2.81])
  by phl-compute-01.internal (MEProxy); Tue, 27 Jan 2026 12:03:16 -0500
X-ME-Sender: <xms:0-94aezHKNnT_oG6n_Sk9_dBizDKCEMrCBuqMYzeGo6VFdYXz13T6A>
    <xme:0-94aVH7Geshs5w1BeTxI8JhQL3f9SI_6fhKWf01uN9pP6tS3QyOiLPkqFk-Z77ht
    0A4N4mEFZ2JLWFQDKResKyPor4TMM4g0crnk8-TPBdRjyUV7HooYt6z>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdduiedutdegucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepofggfffhvfevkfgjfhfutgfgsehtjeertdertddtnecuhfhrohhmpedftehrugcu
    uehivghshhgvuhhvvghlfdcuoegrrhgusgeskhgvrhhnvghlrdhorhhgqeenucggtffrrg
    htthgvrhhnpedvueehiedtvedtleekuddutefgffdtleetfeetveejveejieehfefhjeei
    jeefudenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    grrhguodhmvghsmhhtphgruhhthhhpvghrshhonhgrlhhithihqdduieejtdehtddtjeel
    qdeffedvudeigeduhedqrghruggspeepkhgvrhhnvghlrdhorhhgseifohhrkhhofhgrrh
    gurdgtohhmpdhnsggprhgtphhtthhopeduuddpmhhouggvpehsmhhtphhouhhtpdhrtghp
    thhtoheprghnshhhuhhmrghnrdhkhhgrnhguuhgrlhesrghrmhdrtghomhdprhgtphhtth
    hopegtrghtrghlihhnrdhmrghrihhnrghssegrrhhmrdgtohhmpdhrtghpthhtohepmhgr
    rhhkrdhruhhtlhgrnhgusegrrhhmrdgtohhmpdhrtghpthhtoheprhihrghnrdhrohgsvg
    hrthhssegrrhhmrdgtohhmpdhrtghpthhtoheplhhiiihprhhutghkrgesghhoohhglhgv
    rdgtohhmpdhrtghpthhtohepshgvthhhjhgvnhhkihhnshesghhoohhglhgvrdgtohhmpd
    hrtghpthhtohepkhgvvghssehkvghrnhgvlhdrohhrghdprhgtphhtthhopeifihhllhes
    khgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqrghrmhdqkhgvrhhnvghlse
    hlihhsthhsrdhinhhfrhgruggvrggurdhorhhg
X-ME-Proxy: <xmx:0-94aVaLLtdkTNjLj9uguLPh8UEp_vZeGl3DE5EkWad9QJNijw90uA>
    <xmx:0-94aYMCejS51a2IcAVjfxWrzlHDO8bjAVePd-FzFhwuVMKAWfSaBA>
    <xmx:0-94aTX9SanvcD5mPDGNkdD0C4ihaYZBTr_WsbZ1cCBn9ePsEi6KNQ>
    <xmx:0-94adKqiCPjrQOktXlsZAX1cbN653gomtIqIPAct51fMCI4M5Bb1w>
    <xmx:0-94aer9y8agxQPyAJefOLv99B_AVqj400rlJx2_AS8ZGK-r_y-YHG-D>
Feedback-ID: ice86485a:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id D68CF700065; Tue, 27 Jan 2026 12:03:15 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: AnmyLpBCSM57
Date: Tue, 27 Jan 2026 18:02:55 +0100
From: "Ard Biesheuvel" <ardb@kernel.org>
To: "Ryan Roberts" <ryan.roberts@arm.com>
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 will@kernel.org, catalin.marinas@arm.com, mark.rutland@arm.com,
 "Anshuman Khandual" <anshuman.khandual@arm.com>,
 "Liz Prucka" <lizprucka@google.com>, "Seth Jenkins" <sethjenkins@google.com>,
 "Kees Cook" <kees@kernel.org>, linux-hardening@vger.kernel.org
Message-Id: <eff29cc6-29e6-4eda-8b44-aef30095252c@app.fastmail.com>
In-Reply-To: <da0b8783-590e-42a0-8937-f786a2ebcafa@arm.com>
References: <20260126092630.1800589-12-ardb+git@google.com>
 <20260126092630.1800589-15-ardb+git@google.com>
 <4965fa08-ce01-4848-bc30-5cc1b745683f@arm.com>
 <CAMj1kXFskBM-LT_ifX5HpxgQnt1E5tt2QA_5fYuxPQBiSWSDZw@mail.gmail.com>
 <da0b8783-590e-42a0-8937-f786a2ebcafa@arm.com>
Subject: Re: [PATCH v2 03/10] arm64: mm: Permit contiguous descriptors to be rewritten
Content-Type: text/plain
Content-Transfer-Encoding: 7bit



On Tue, 27 Jan 2026, at 17:59, Ryan Roberts wrote:
> On 27/01/2026 15:03, Ard Biesheuvel wrote:
>> On Tue, 27 Jan 2026 at 10:45, Ryan Roberts <ryan.roberts@arm.com> wrote:
>>>
>>> On 26/01/2026 09:26, Ard Biesheuvel wrote:
>>>> From: Ard Biesheuvel <ardb@kernel.org>
>>>>
>>>> Currently, pgattr_change_is_safe() is overly pedantic when it comes to
>>>> descriptors with the contiguous hint attribute set, as it rejects
>>>> assignments even if the old and the new value are the same.
>>>>
>>>> So relax the check to allow that.
>>>
>>> But why do we require the relaxation? Why are we re-writing a PTE in the first
>>> place? Either the caller already knows it's the same in which case it can be
>>> avoided, or it doesn't know in which case it is accidentally the same and couple
>>> probably just as easily been accidentally different? So it's better to warn
>>> regardless I would think?
>>>
>> 
>> Based on rule RJQQTC in your reply to another patch in this series, my
>> conclusion here is that we can drop this check entirely.
>
> Hmm, I don't think that would be quite right; The rule permits _some_ bits of
> the PTE to change in a live mapping as long as the CONT bit remains unchanged.
> If you change the CONT bit on a live mapping, you could end up with overlapping
> TLB entries which would not go well on a system without bbml2.

I'm not suggesting we add it to 'mask', just to remove the check that forbids any manipulation of an entry that has PTE_CONT set. So toggling PTE_CONT itself would still be caught by the check.
