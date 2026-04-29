Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 728C33F54AB
	for <linux-hardening@vger.kernel.org>; Wed, 29 Apr 2026 14:09:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777471750; cv=none; b=CwSAUlW6576FOtTSbpWiLQGD4aONz+GALL1fwLvzAPBpEJqAyNaTBQhVpXEs283t/eG/BGf6yyp9dZClZZ0Ndggp25RnX/2XwUM2PPiXZ82Dpwodziir4cKe5Pb63BEIfIChRtZO8x+s//tjMXxLEFyg1XRqH1F1Xr0SXF3dp4E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777471750; c=relaxed/simple;
	bh=MyPkCw4jiFzhBkwRoZCQ5vZDCBPFzZNsYDO5Ul8+pDM=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=AL/HGxNJ65ro3gHsB3Hv6EaMARlaQvlmtFYec87AuFD0IlAC2N/HbomjqklCk9fWLsJsLXy0K6N4QIsfCu/U0eGyH9dsnJ6R/paPqDgEQ3w27osk/wcyKpIxzEmxBOIAKKTykFy3wTQ8n6JG+YYMkN5MGTUyX8a+3G5Tdh3wTuU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GvkrbslP; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GvkrbslP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C4D44C4AF09;
	Wed, 29 Apr 2026 14:09:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777471750;
	bh=MyPkCw4jiFzhBkwRoZCQ5vZDCBPFzZNsYDO5Ul8+pDM=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=GvkrbslP/xhdKJvHpqOyen0INL8SLOmZNu6E4wYpQdza02dOyBb3PBmTle1kQ/33p
	 Vt919aGM/B+6kb26JcRM2kKyMjjzaZFtJB7fenpPCNK05hEmwhgWo6pw9S8DL+tBxl
	 ngFCz4B7AcO53hXHQ+qdsSRdjCJiu676D5OUIT8yZ3BvOGyDn/k/8VOic8a+Oas+Ck
	 9a6DqRZa/yUvikwYhd6028WYPsOTF5VX0OkNvv01rLSUp0mu0yv5mZdR+g9yYYNYAu
	 fmofb4WU6OVnLbR3kjAClZ/ej+ePosGPDdQbalAovib3P7c3axIb31T+05CW0Ko1OU
	 QrNulooYd/eRg==
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfauth.phl.internal (Postfix) with ESMTP id C7AF0F40072;
	Wed, 29 Apr 2026 10:09:08 -0400 (EDT)
Received: from phl-imap-02 ([10.202.2.81])
  by phl-compute-01.internal (MEProxy); Wed, 29 Apr 2026 10:09:08 -0400
X-ME-Sender: <xms:BBHyaegzIbsF-36lyYjViSyRSbWG03AfdMOlRVyxm2zRLO_jWi6maA>
    <xme:BBHyaZ1dNGfn8xUgJn5iF7rJDtBrPWiw-FGV1Vdgd4VBs3SKgQDr7rZPNFVuuzD_z
    g1AY688QHCx20U-NPxM_c4SC9ZI7n_LKFh-K2QL4WUTZl6CDT6vaRc>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdekgeeigecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefoggffhffvvefkjghfufgtgfesthejredtredttdenucfhrhhomhepfdetrhguuceu
    ihgvshhhvghuvhgvlhdfuceorghruggssehkvghrnhgvlhdrohhrgheqnecuggftrfgrth
    htvghrnhepvdeuheeitdevtdelkeduudetgffftdelteefteevjeevjeeiheefhfejieej
    fedunecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprg
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
X-ME-Proxy: <xmx:BBHyaRjbJpfo3Sp2bx_kbAgIBsznqF-7o2l8YvD3KVKbNBxsKgDoMw>
    <xmx:BBHyaSWjBLyZpyeGWlwyvH7noyRiDot0fPUFzM4D8_UA7Hm1H4OshA>
    <xmx:BBHyaStXnm6Tst5HguJgmDEkVJO6WSz_MgFXe3fHquwDnJ6GJCHxtQ>
    <xmx:BBHyaTZ-pErfCj9Z36BHMOK4XbgWHcaHgvtLC0GhgQMZfK5Wtgxvzg>
    <xmx:BBHyaT7dF4IIVlcesDLk5ihBXcH9ZhuVpxtkNa4meQGsB6_8ezuitEWf>
Feedback-ID: ice86485a:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id A10BF700069; Wed, 29 Apr 2026 10:09:08 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Wed, 29 Apr 2026 16:08:48 +0200
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
Message-Id: <5e0a87ad-50d5-420b-ad5a-c2882a619b35@app.fastmail.com>
In-Reply-To: <21a547ae-7121-4cd1-b203-4d8182eb7cc9@arm.com>
References: <20260427153416.2103979-17-ardb+git@google.com>
 <20260427153416.2103979-32-ardb+git@google.com>
 <21a547ae-7121-4cd1-b203-4d8182eb7cc9@arm.com>
Subject: Re: [PATCH v4 15/15] arm64: mm: Remap linear aliases of the fixmap page tables
 read-only
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Hi Ard,

On Wed, 29 Apr 2026, at 15:57, Kevin Brodsky wrote:
> On 27/04/2026 17:34, Ard Biesheuvel wrote:
>> [...]
>>
>> diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
>> index 84d81bae07a7..e76fe5b0c5fe 100644
>> --- a/arch/arm64/mm/mmu.c
>> +++ b/arch/arm64/mm/mmu.c
>> @@ -1076,6 +1076,11 @@ void __init mark_linear_text_alias_ro(void)
>>  			    (unsigned long)__init_begin - (unsigned long)_text,
>>  			    pgprot_tagged(PAGE_KERNEL_RO));
>>  
>> +	/* Map the fixmap PTE table at __fixmap_pgdir_start R/O in linear map too */
>> +	update_mapping_prot(__pa_symbol(__fixmap_pgdir_start),
>> +			    (unsigned long)lm_alias(__fixmap_pgdir_start),
>> +			    PAGE_SIZE, pgprot_tagged(PAGE_KERNEL_RO));
>
> Is that definitely just one page?
>

No it most definitely is not - thanks for spotting that :-)
