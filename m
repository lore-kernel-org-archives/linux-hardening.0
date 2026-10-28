Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.171
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793166945;
	b=JbrQmMr9b0PW7gqTtEB2pj98GUa7D6Ty7tycwASopikjwmyLApygo75m++YH92yyGlqs
	 rrFzHAVqe80rw8I4I6A2NtHyUmPBUByuqo/9cxPNLOM/IY9PHybJwH+3fSYAgmeiBazjI
	 51cWvWWIdW0BWTeD4BP24aeWGlFH+UoT+wV3QGuXK/fx9GKpdM6TpkZDLhCIjx9LFn56W
	 Up28Tar4e+7XSKdYuvABvReIkeuw3fXmOlLAt7Od1tuXQtqUsB7/TndsLtPcGZCntcsfK
	 o7DDNUo/4b17qs1EjuTVuxWuA6oQedcwgLejHw43QTAkXEywLsDPqGJ0LKLjKgLchyQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793166945;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To:User-Agent;
	bh=hLkqAi8ctPqSRIwXUevfGPv3vaKrwbjwbnl9pr4s97k=;
	b=a6IQ4Jen5bLvfVxxgymJGKdbDDv54RjqPKNdL1DEwgs7EHwiaTjXLqcylFZsz31LhxQV
	 tNeCib9mcP9PKWcqE/nOepXJyG5ZGvhXpcE7i+k5lOPTjHLc50joHCYTN33mCuFwOv0Zd
	 cogob0cPyTaio1Y+Z4TN7Usqb5zdA1K/1HCc53C2uZWCOaoHjrIQzHBbj4+aAZwuNGJp+
	 UemLZ8NmApC7HrQJydC5vR0qSwjVpK5ZUaVJx86h6fN/1mjnlTy6TPbpR/cBGN8mQg1eF
	 PCPFpHhj6vcKsghHWJNPCR/WdF3nD0Rr5T7fI0/rGCtpXJvQUV0fGVpZu7DT8N6eT+g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=chrisdown.name;
	spf=pass smtp.mailfrom=chrisdown.name;
	dkim=pass header.d=chrisdown.name header.i=@chrisdown.name header.a=rsa-sha256 header.s=google header.b=S1bmZhe5;
	arc=none smtp.remote-ip=209.85.214.171
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5FAF606A320
	for <linux-hardening@vger.kernel.org>; Wed, 28 Oct 2026 05:55:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B5FAF606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=chrisdown.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chrisdown.name
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=chrisdown.name header.i=@chrisdown.name header.a=rsa-sha256 header.s=google header.b=S1bmZhe5
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2e9d7791b00so3719745ad.0
        for <linux-hardening@vger.kernel.org>; Tue, 27 Oct 2026 22:55:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chrisdown.name; s=google; t=1793166944; x=1793771744; darn=vger.kernel.org;
        h=user-agent:in-reply-to:content-disposition:content-type
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=hLkqAi8ctPqSRIwXUevfGPv3vaKrwbjwbnl9pr4s97k=;
        b=S1bmZhe5omygstKNn+fR4XNnXR8jlOAug6FHViW62htHZqlaaV3C+husILnE2vlUDF
         qUlYJF3FxNHUTl83dYgzukZI/bHzvwRlNtWH7gR8fWpMpq/83wx9L/j3lJilHpU9YOHo
         cfLpDdCxwOCvGatK4hqkL/OtX/o2+WygsNxRs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793166944; x=1793771744;
        h=user-agent:in-reply-to:content-disposition:content-type
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=hLkqAi8ctPqSRIwXUevfGPv3vaKrwbjwbnl9pr4s97k=;
        b=yURGemaebkJM2Rz66fcXrdMHziuau5EdnF5qrZna5QwGVgnyMSIo7IYl8Z7BS1LOnh
         hl3pocQ8LCpuAsJYnyN/KkxG6WKkvgmmAmT0ktqgQlRsqU/qaKFsSOULZQ28B3Ed3SG7
         0p59f+LVtP00My6il5s63Ke/oNjKlgXLjHx8rIdFd2/TE1dOr1P9z5ImNHlGSAerLmes
         3S9iTCYwOdXK1EbKfAMRwQJ2A7/tEmuqQSnzaW90L8ugs52Zm5seOCY1kgrTOjXBF/TM
         DRiUMBrJUZVimfpAI7AF9PuGSrU1iwBAUgUHQKMSpVNWRqUuwjfFaRlp5Fe1BSgpSjpS
         QeGQ==
X-Forwarded-Encrypted: i=1; AKwUvBziQhztK/kqyybWPW436aqK+EsX6w2bx3tp+5w0XFM1cbVfF2aaCuM8diy80JWO5l3fjJZwJZBwUiHjgPR6Xt0=@vger.kernel.org
X-Gm-Message-State: AFq9FYLIV7wUj+hIVviBcCwpIWCKDhKMNWtXARStq2cvHtzbCcrDhm8R
	vc+6Wdq6fXIqLEsaGiQoXvyqZGD0sa4jEdEw8KI1pyTcluVHlfEi9n/GYuTBkaraZ1Y=
X-Gm-Gg: AYBFou3DjI0KbJWWETGHfe8dPrJD7X1rBWXjF+g3Ajhz9/0XQQO3699prGoz3Lpa6KX
	qYztpgdOL83tR4IkNWea1w7teA8m70rMCIteQjsAiXPSRwiOUwsB6TGTCzBCqU4T19YnZXfSVmw
	w2ZxmUS/0FUq07yfIsZ6rNPpE2gnC6hs3ax+iQKTGnzuin6AH/FSZXYNr6FtmEfOOyCqJQ4jcfH
	df62se9wtVnhMEyNuHZyRfBXz5AWiYdddzuON6fvag652W+WCiTGdSLqAlzJvGRf03f5LkQm4wi
	kvr4KgeW8FbDd9VPlYtiE4X5u9AMWKLaSnAUiGKwBPCD0o3lb79d5SjT2Ol2ZmgVAvbxOtNrorA
	TtZWlKG4f7qVpvIFmL9+BeLua3enSOLgttR5tTxPiYr9D4UqSYz1y78nBRkXT3rRkG5K4fC1fuj
	ltlmKSbmXtsg/MKf4Y8eoUv1VSQLK/ILiy47MmSwRFhaEwLVnSeJLnF/EjxGu8IVu6iDuzIZIml
	32nJDrGDyma1uWWiEInx3C4mmoN+LvE5bfynmtUOZlULyXJ+ZxbfIoTeBXrGZDQsHxJp7AFAdE4
	mKCRoRSPSMrvrw7DPfIJIUoT0Zwi22muFsOUkBAieDxWt39W7GAetKXSVGnF6gGMMEB8G4SKsSQ
	Ja97qXP3i3+05YOeqyn3XsyTOpKGBxLRGzMq8k1X7O0qqdxK7fSzsukwK3GRdC2DN4rBNGsjy
X-Received: by 2002:a17:90b:4c47:b0:3ab:1af3:a0d with SMTP id 98e67ed59e1d1-3ae5811b551mr920591a91.33.1793166944108;
        Tue, 27 Oct 2026 22:55:44 -0700 (PDT)
Received: from localhost ([116.86.153.182])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ae5a9019a4sm1368356a91.1.2026.10.27.22.55.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Oct 2026 22:55:43 -0700 (PDT)
Date: Wed, 28 Oct 2026 13:55:40 +0800
From: Chris Down <chris@chrisdown.name>
To: Jeff Xu <jeffxu@google.com>
Cc: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	"Liam R. Howlett" <liam@infradead.org>,
	Vlastimil Babka <vbabka@kernel.org>, Jann Horn <jannh@google.com>,
	Pedro Falcato <pfalcato@suse.de>,
	David Hildenbrand <david@kernel.org>, Kees Cook <kees@kernel.org>,
	Jeff Xu <jeffxu@chromium.org>, Andrey Vagin <avagin@gmail.com>,
	Alexander Mikhalitsyn <alexander@mihalicyn.com>,
	Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>,
	"Serge E. Hallyn" <serge@hallyn.com>, Shuah Khan <shuah@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>, linux-mm@kvack.org,
	linux-hardening@vger.kernel.org,
	linux-security-module@vger.kernel.org,
	linux-kselftest@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org, kernel-team@meta.com
Subject: Re: [PATCH 1/3] mseal sysmap: Add mseal_system_mappings= boot
 parameter
Message-ID: <auGOXLB1XZFWcTfX@chrisdown.name>
References: <cover.1793094611.git.chris@chrisdown.name>
 <5bd3c89d733ad22224f296dfa8900769de937de0.1793094611.git.chris@chrisdown.name>
 <auCxjbvY3qPv1sV6@gremlin>
 <auDTMb6WMFUpxeZy@chrisdown.name>
 <auDTptDQsB4xBcz7@gremlin>
 <18e2972cb8520c2e.3137322e32382e342e3434.279dd1.0000sendgmr@google.com>
 <auGNkhSHpBRd2U_5@chrisdown.name>
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Post: <mailto:linux-hardening@vger.kernel.org>
List-Help: <mailto:linux-hardening+help@vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-hardening+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <auGNkhSHpBRd2U_5@chrisdown.name>
User-Agent: Mutt/2.3.3 (9073d26d) (2026-06-12)

Chris Down writes:
>- run_vmtests runs with -T expect_sealed when CONFIG_MSEAL_SYSTEM_MAPPINGS=y

Er, the other way around. I meant vm_runtests passes -T expect_sealed _unless_ 
CONFIG_MSEAL_SYSTEM_MAPPINGS=y.
