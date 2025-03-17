Received: from fout-a2-smtp.messagingengine.com (fout-a2-smtp.messagingengine.com [103.168.172.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 208AE2E3373;
	Mon, 17 Mar 2025 12:05:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742213150; cv=none; b=YcVyYMdDt2xfBukg6BfqwroIdGorUMGRFJo4wMvyxLfyqOQJBdNZY/2Cp+wrpIG9i/2WcqKxJNL4EaaubNsse74HXaBKMSuqzTZc7RzysLuroSQlVZD7vcwGgpkPJRsuC1E53WFSrum86XUp/gVFKLSrj5Pb+fQKGMf1rHf2LhU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742213150; c=relaxed/simple;
	bh=3inWSjEROZv7RUpkzHRVyiGH3EXYNQIryvNSxPHVJ1o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NuHlmN2JTdeNPcRlV4IxZI/vUqL2w2xtoWvFYIfhg/WY8brKXMdvgJ6OZIJkYsAyetWbHgHAhVFfs5l92HWcSqzWODTq+o6i+Yc6T0DsftAeEOL7zKODz2Z8GX0AmFQHHDzMMV8EB4ElIp94VinU5sYFWndFvQt2Az0S2thbVP8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sakamocchi.jp; spf=pass smtp.mailfrom=sakamocchi.jp; dkim=pass (2048-bit key) header.d=sakamocchi.jp header.i=@sakamocchi.jp header.b=CoAHs0q+; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=w61/GzQk; arc=none smtp.client-ip=103.168.172.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sakamocchi.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sakamocchi.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sakamocchi.jp header.i=@sakamocchi.jp header.b="CoAHs0q+";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="w61/GzQk"
Received: from phl-compute-02.internal (phl-compute-02.phl.internal [10.202.2.42])
	by mailfout.phl.internal (Postfix) with ESMTP id F370A1382CE9;
	Mon, 17 Mar 2025 08:05:46 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-02.internal (MEProxy); Mon, 17 Mar 2025 08:05:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sakamocchi.jp;
	 h=cc:cc:content-type:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm1; t=1742213146; x=
	1742299546; bh=VlE2aCu2dxScBu+S/YF4VoV7bWcPS836pUf9gH4Te88=; b=C
	oAHs0q+RRJPO2YWgoZosSIfMyU4Qso45A2junUU37g8fKEat5bmbiPEi5+H/7paz
	seE18t77/FVuVnaPcVGCORp5Tjz6ZQ67jM4iC7VnEpNG0iNinBOTkklvsw/4+LnS
	2jHcIlRSMQ0Rs6w7KM3eL90qqSKEx961m/KmzFwViJJZwjwMxJ2x9Anv2qNaFkMx
	XVc/KZwEhAncC5wzDJdmOX/1DisWr4nbcEBv+qTxvr3YSc9HyCo6fICsamVIkXN1
	3BZbBe5JDOW6hBWYRdYOztWWaPPmEoZmcWCTSxdVBYbIV2j9aAB+sz7tGryNSaDY
	WN1WVnFXOKeWpivw98xIw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1742213146; x=1742299546; bh=VlE2aCu2dxScBu+S/YF4VoV7bWcPS836pUf
	9gH4Te88=; b=w61/GzQk9h/ygcwh/I4B076fiEoJhQYMfcmWTglEeHPBgIeG4t/
	6+Vt1z/BIvCzu2/0iIYgtdruQvP+++z2zZeKMuWVceG/0Dxr300JeXfVv+7gNYMb
	JOwSnXJR9u+mQ3s/tQjDWC6mKRqmQ3YYE2qsy1CiFMjxFZOd4QlUlBasNBGI+Lam
	sumEoxR6vQRJWAZrLEVZhULyso5MRi9cnWE0gd3pKh43iPDqY1mLNDz2yFIwJXBC
	oBzVseoEf4d4pqQDTI8fXNdnOis84Ziny4QjfRrhPtdVu6i/whl/NkfRdJ2pkIuq
	07qE4lFOxbieSYiB9KibINWAKMySVI72SEA==
X-ME-Sender: <xms:GhDYZzEz6KbBo2txi4gEEm-oi1L83slCf8ZWsWX2rInvgLZfYCt_fQ>
    <xme:GhDYZwXu_aXHgvxHHhNhp7092YAUFI9rWKZmWNqD7UPYHED_wcaNyIqgVPWQy-Gij
    f-nxxkKBC7gjoLohGA>
X-ME-Received: <xmr:GhDYZ1Iu84qeOpULqdsU13vqzHDOTMl_Nh4-pDM5WfeS04CtenZhz2Y4HLItooOOOOWMc3VLIlvLnThQpV7IR3nan_zfGRZ0Dcc>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddufeelgeeiucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucenucfjughrpeffhf
    fvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpefvrghkrghshhhiucfurghk
    rghmohhtohcuoehoqdhtrghkrghshhhisehsrghkrghmohgttghhihdrjhhpqeenucggtf
    frrghtthgvrhhnpeevieelhfdukeffheekffduudevvdefudelleefgeeileejheejuedv
    gefhteevvdenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuih
    iivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepohdqthgrkhgrshhhihesshgrkhgr
    mhhotggthhhirdhjphdpnhgspghrtghpthhtohepgedpmhhouggvpehsmhhtphhouhhtpd
    hrtghpthhtohepghhushhtrghvohgrrhhssehkvghrnhgvlhdrohhrghdprhgtphhtthho
    pehlihhnuhigudefleegqdguvghvvghlsehlihhsthhsrdhsohhurhgtvghfohhrghgvrd
    hnvghtpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghl
    rdhorhhgpdhrtghpthhtoheplhhinhhugidqhhgrrhguvghnihhnghesvhhgvghrrdhkvg
    hrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:GhDYZxHRo7nWHO_ukohRWpNe9goED6A_0_2RFXs8wGPGcRKSGH4BEQ>
    <xmx:GhDYZ5UOhe7d7I675IjzPb7yU8RfyfFKQWDNvBk1YyZHKZ2CsA9iKg>
    <xmx:GhDYZ8OvA0JAxqvNUPjXF-awDYfEPWG25GHbZssFVB_B9cLImSeUHw>
    <xmx:GhDYZ42Z3P-y2Hu2Q4Gn-mIKUwi5fUyMJ2WkvGl65dQlK6NFtDFEgw>
    <xmx:GhDYZ_zsIBjfWHvqkvV3sRoPwSBb3nlzXy3ZHlaGbjDsxKlVCGhC-MjQ>
Feedback-ID: ie8e14432:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 17 Mar 2025 08:05:45 -0400 (EDT)
Date: Mon, 17 Mar 2025 21:05:41 +0900
From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
To: "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc: linux1394-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: Re: [PATCH v2][next] firewire: core: avoid
 -Wflex-array-member-not-at-end warning
Message-ID: <20250317120541.GA6070@workstation.local>
Mail-Followup-To: "Gustavo A. R. Silva" <gustavoars@kernel.org>,
	linux1394-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
References: <Z9NcB81yfPo-8o0h@kspp>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z9NcB81yfPo-8o0h@kspp>

Hi,

On Fri, Mar 14, 2025 at 08:58:23AM +1030, Gustavo A. R. Silva wrote:
> Use the `DEFINE_RAW_FLEX()` helper for an on-stack definition of
> a flexible structure where the size of the flexible-array member
> is known at compile-time, and refactor the rest of the code,
> accordingly.
> 
> So, with these changes, fix the following warning:
> 
> drivers/firewire/core-cdev.c:1141:38: warning: structure containing a flexible array member is not at the end of another structure [-Wflex-array-member-not-at-end]
> 
> Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
> ---
> Changes in v2:
>  - Adjust COUNT argument for DEFINE_RAW_FLEX() to 64. (Takashi)
> 
> v1:
>  - Link: https://lore.kernel.org/linux-hardening/Z9AA9tAbcIcz6BMO@kspp/
> 
>  drivers/firewire/core-cdev.c | 42 ++++++++++++++++--------------------
>  1 file changed, 19 insertions(+), 23 deletions(-)

Applied to for-next branch.


Thanks

Takashi Sakamoto
