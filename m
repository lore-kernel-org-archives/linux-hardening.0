Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.174
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794559945;
	b=AXRWe640ubNIGwWbQML+xP/PgKYwEZm2hZtFOV6TyZqNEihzJOF4WQ8lUnBtKM8eo+2S
	 LbUw2EJYZAmTauYzP+QiLwP05pjaezBDdJbYCqBtj5T65pAKTboFrToTh7uLoDvgvQSnC
	 wdBuT0NynngH5w4a+UPuEA7JRK7kTFLaoKagfs07O1cP8pkuLBz1sxWFpMRSsoylbPZ2G
	 oO2NLtx9ncIQvpU9Zw/0PT88ojxTos29oDE70Nzlp/eZEteulU4IinpAyrqw1hdrAxf25
	 hjL23BprywhhwRm+hrnILNJKqapCl5AQJ7qR1jp5kwqeiV6kz2i2GW3BJD6y/mxQWwQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794559945;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:In-Reply-To:References:MIME-Version:
	 Content-Type:Content-Disposition:Message-ID:User-Agent;
	bh=sQBXOWZ0Jeg9Kyjo2fd5tVPCdhkMAv0V+YCAjxLdw8k=;
	b=PqTpjhxt/vbduoGOc1TkMS6iVj/m9i7ichYHjIvOw360lwRFlc0MctEZK1+0ZIKW/nFc
	 /tuoKTBDVkpSDJdti3UBD14tw1JfsnmpogmEHfwjJvyxcy21RuBpHss56ubG6Oso1Gdzd
	 Bv08ofrYtB5gj5zn7WmrfmsQllOWe2Q0H4H3VArKr897bib0fztqyvRXFfnrdwb7OzrLv
	 7qdwwZ58HvHnoz7UwRcNyTBga0fyMSmFJ0wv8Fao+fux9xs2dDdm+lo7dgJjNTHg6Cia8
	 VPJs4LBC5XAY8xsUrGk+8PNKHQHFWyJFXWGBxfzqcBaugca8XEUlH260uXaDowD6tCQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=chrisdown.name;
	spf=pass smtp.mailfrom=chrisdown.name;
	dkim=pass header.d=chrisdown.name header.i=@chrisdown.name header.a=rsa-sha256 header.s=google header.b=O8X3S6sy;
	arc=none smtp.remote-ip=209.85.214.174
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EDF9606B344
	for <linux-hardening@vger.kernel.org>; Fri, 13 Nov 2026 08:52:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7EDF9606B344
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=chrisdown.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chrisdown.name
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chrisdown.name header.i=@chrisdown.name header.a=rsa-sha256 header.s=google header.b=O8X3S6sy
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2ed1414df17so5128415ad.2
        for <linux-hardening@vger.kernel.org>; Fri, 13 Nov 2026 00:52:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chrisdown.name; s=google; t=1794559945; x=1795164745; darn=vger.kernel.org;
        h=user-agent:message-id:content-disposition:content-type:mime-version
         :references:in-reply-to:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=sQBXOWZ0Jeg9Kyjo2fd5tVPCdhkMAv0V+YCAjxLdw8k=;
        b=O8X3S6syhCVWEmK/y18DRmSh2jQdYWheWlQ71KHRscZ8aeplgfQxyAKE7u1N//3Ldl
         E2y1zEk0rsic2g9snxMDHaNdDwQ4rZvAsvfE/wjiUJJwY5ErnbFbOmq2HtfdLZTKhtCo
         vi25f5Lo+4mSsRe7z+QSfxIGK+A3M5hsA0ws8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794559945; x=1795164745;
        h=user-agent:message-id:content-disposition:content-type:mime-version
         :references:in-reply-to:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=sQBXOWZ0Jeg9Kyjo2fd5tVPCdhkMAv0V+YCAjxLdw8k=;
        b=IhewNCHRZ8YgnK9Ik00htv4oGMcuswhp+5dPbE7JA2HCM0i4EIrT9vVmc58pJ5hR49
         AeaLrW1EU06AtaukZSrpDJCToEQ3Qn5MEAyEHqk7q53lPn8xC+Oh+7K6SQgYrK9LfHEK
         tVsPAPGm7iycM1UacW14+otUJhnwtL46AESl+Ytzoa8H9LgY7ZqOf8Mes99m39lPtV/A
         JStTdQd3OwCh6EIo4lSxtT6AFeCI+/nI7/6CTF30b5/QAA4eHZcn4jaV0h8D7iOluA37
         mEf+pZi1NMi7ZsnF0TdIEJXyj0ULgmvg2IyvutEoB9KlKfRf6U2dtA2pG86ySZ/l6Pt0
         qF8w==
X-Forwarded-Encrypted: i=1; AL+hErGmyM9qMIoUMBPFshzs0qCVkiu3WkCMTuAep9rIQj/Z9aicKERtcg7Hog1U7MY5gyyvEg0D0GftsldGP+NZVXM=@vger.kernel.org
X-Gm-Message-State: APuU4Z+hZcEOfkO1p+4usLFTfc3nuejbNYkIHOnWDm3cic8n8t5CJRq5
	MxGL4zSKAlMf7I9EzxQoN0+5ZRe4Whj15u7nNMsAP3rY8MC6VB95XagTIFDhXS1BqSg=
X-Gm-Gg: AYBFou0/FHZb8I3Qk8w+RL7nHzS+zek1doIsqOlyuQyxJVqV/yKJiMeEFlA1fUgTpzS
	4N4dik/GtsTJfbxDRKgJGPZpWTbXvj6mmkwZl1NOE03yvoWx1uH3h/5skYyjJzNrzN9qPAfCW7q
	NQPzwZpTKj8d7Dpk21kFVDMV+UtopHVwerks0Rn04HQV9TYcgYL+CNOUGPpZElQfPsu+oEBl/ds
	6gJ/jjKxYODz+m4u6qnI0ou5pQOMUIBeoAAABY6d1BrUj69dfhEl9BJhjG935iSvy46nu2RV4DK
	nZLbCYPPu/VXHmoaG24bslWDpqDimEilhX0LawEvf/G6EqqSQGu/i8bXHnu4dcQ2C40Hw3ylI5j
	MIh9LE3iQKSofTONXkhqn+Ozp16sQX8G6hAZLLvY03oghwssgt0qFubQY0btryZCtDuUNMd2nGx
	a28b8B+BvC5OjHmaRRAZpqOIYf6y3MbcC0KSoSRdGLy6GFV4ixcehlUlYniubREUvAE6JhXFPDF
	g+OecYKh/VZb3eXqZM2U6LuAeWUaWwnSFi1uRNMtoqFOHFtLDVsnarKimo5fLEhkItViJxFxxOt
	Ie9IljrllNDhrimeFZxgsnQYlrb7GvpBdMVjCny567PduLJ9ruceqR0WTFmUD5lagpREpYtslxF
	oHd+KJ2kgWqEA8ikfco/pKKzfGBNJKssN3PTMG02v5TPX0wvVW65lTafYluk37dDeFD2Ioji+Ig
	XTbwqVo1dD4FbS5W9hAAgaP7S1uvLPZjF9i/guqPWM5n4IF8Waq5k2rlAzQZA=
X-Received: by 2002:a17:903:8cd:b0:2e9:5714:608b with SMTP id d9443c01a7336-2ee0df40edemr17713825ad.34.1794559944843;
        Fri, 13 Nov 2026 00:52:24 -0800 (PST)
Received: from [172.22.0.2] ([50.175.87.158])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ee0f75b472sm6940845ad.19.2026.11.13.00.52.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Nov 2026 00:52:24 -0800 (PST)
Date: Fri, 13 Nov 2026 00:52:19 -0800
From: Chris Down <chris@chrisdown.name>
To: Harry Yoo <harry@kernel.org>
Cc: Kees Cook <kees@kernel.org>, Vlastimil Babka <vbabka@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, Hao Li <hao.li@linux.dev>, Christoph Lameter <cl@gentwo.org>, David Rientjes <rientjes@google.com>, Roman Gushchin <roman.gushchin@linux.dev>, Marco Elver <elver@google.com>, GONG Ruiqi <gongruiqi@huaweicloud.com>, Jonathan Corbet <corbet@lwn.net>, linux-mm@kvack.org, linux-hardening@vger.kernel.org, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, kernel-team@meta.com
Subject: Re: [PATCH v2 3/6] mm/slab: Support disabling SLAB_BUCKETS at boot
In-Reply-To: <aud4gPOUzvHtLYnJ@thinkstation>
References: <cover.1793253633.git.chris@chrisdown.name> <9a68a4d95830352ad3821437c2e22c30a673055b.1793253633.git.chris@chrisdown.name> <202610302115.8C7AD110@keescook> <aud4gPOUzvHtLYnJ@thinkstation>
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Post: <mailto:linux-hardening@vger.kernel.org>
List-Help: <mailto:linux-hardening+help@vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-hardening+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
Message-ID: <20261113005219.f954ab03e886b1c3@chrisdown.name>
User-Agent: Mutt/2.4.3 (cc9e3943) (2026-10-09)

Hi Harry,

Harry Yoo writes:
>A gentle ping to Kees to hear his thoughts on having a bit more
>coarse grained boot parameter e.g.) `slab_hardening=` to specify
>how much performance/memory is worth sacrificing for enhanced security.

For what it's worth, I'd still prefer to keep slab_buckets= and
kmalloc_partition= as they are. Each one maps onto one config option and
one cost that you can reason about on its own (about 1 MiB vs 18 MiB in
your numbers). If we want slab_hardening= as well, it seems easy enough
to add later on top, as a way to set the defaults for the individual
parameters. So I don't think it needs to block this.

I'd like to hear what Kees and Marco think too, though.

Thanks!

Chris
