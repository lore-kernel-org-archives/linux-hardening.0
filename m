Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.52
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794559933;
	b=KGZlCCHshr2l/4XyLxyZ4F/chtS5DcurAfGEcPJYO1JVGBk2mjlbzIyLLyHLStZRz1pn
	 +kerZuB7I8AjfO3Ot81YYCZPnAG13SxjpNLkfOnYUvETa7+F4tosQULX/215ASkf8WSGV
	 CPLhjvL0muEwZt1+yHJXmt4NuyVpmt0edtqm33nr+4apjcmkqPXthJBqwOQMC8msZFuCv
	 S+U62lJcLhD2+zZXr480kDgTpCQdMlqHygvZp0ijRHwqh8LoDBP/UkAehPSHaKbqVqPBa
	 yY7PmrL0PMXfLaUfNefDQINc0twxUzXtu7cXIfNdikRFdaDFtql3Pf1CrdjHIHDkYqw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794559933;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:In-Reply-To:References:MIME-Version:
	 Content-Type:Content-Disposition:Message-ID:User-Agent;
	bh=J3YUrGXSXKZY/bSJltCtfezd+TfrIG0RukF4uztH5NA=;
	b=KKiNn8NHAZwN5j9lzBb7eNDHkYFlm5umzYirrzAgwTIHI7a8fUgAK+amjcZZQJpJfTu2
	 Eachcl0FkvHG9r8Sb+CA1DKitgr40gN+iaNDwoP+ZXBi1T9k5aiA+9anvB7Bb8zqJPxak
	 XlFPh/mY9mO0Z1/9Ugd081g0NFnwJzRaZjt2rMARf36VYYxZ+zblsosxJce/gACrbvXwI
	 VQEw9MwnRQx8nVr4okhWvlI4htOtFUbcNwH6s0R9GASe3NJd8IF92r3KhiV+03cNzTDuh
	 WfXKLJIU+bS3+Uh+A08ywMXMdoCdQG08IRVXGMDQ8ziSpq9KPzHB14oY7KcD0bcHR4A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=chrisdown.name;
	spf=pass smtp.mailfrom=chrisdown.name;
	dkim=pass header.d=chrisdown.name header.i=@chrisdown.name header.a=rsa-sha256 header.s=google header.b=DU0YJExw;
	arc=none smtp.remote-ip=209.85.216.52
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6152606A8A5
	for <linux-hardening@vger.kernel.org>; Fri, 13 Nov 2026 08:52:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E6152606A8A5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=chrisdown.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chrisdown.name
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chrisdown.name header.i=@chrisdown.name header.a=rsa-sha256 header.s=google header.b=DU0YJExw
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-3acb11973c3so1110852a91.3
        for <linux-hardening@vger.kernel.org>; Fri, 13 Nov 2026 00:52:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chrisdown.name; s=google; t=1794559932; x=1795164732; darn=vger.kernel.org;
        h=user-agent:message-id:content-disposition:content-type:mime-version
         :references:in-reply-to:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=J3YUrGXSXKZY/bSJltCtfezd+TfrIG0RukF4uztH5NA=;
        b=DU0YJExwNevdhs6jAs9ShP2CJMProdbfeav9l6bUjM7bIAtefanOcvB6eUeDSeSTIq
         5Bz1qdkBoTenUY2OTXvyOTfz1KOzqRDpQm5Mz2ii1Ndj+0tdudboRxF7Q70u01fn5VhR
         m2xCVGR4ZYPlAa3Yfbpx0rYR21V0KzkxSxbcU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794559932; x=1795164732;
        h=user-agent:message-id:content-disposition:content-type:mime-version
         :references:in-reply-to:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=J3YUrGXSXKZY/bSJltCtfezd+TfrIG0RukF4uztH5NA=;
        b=Q0bRSITs0qzLNUqzbPytohXBakjo0fCILCx12fhA3tE7fCE6tWw8jLLFHuHkmN04Fq
         0nUK3A3ShlgGOw8aeZc34hRjQ4PZ5fgPlMpYz+Klu2wdrxfR3eDhCVtHcR1fT5qQK1Xb
         lWNPH5p6/OjGF1uJMKNhED8zBGgD7Z8d0XrlSAK3sVYpQ7zXhMe/FeEr+KIcZzUPzS2Z
         gmbq2z3vI7CWkbY6rQea/BQQvSKnB3PvdDXS6AH0mzJ5DPya5Y6YpghXPxgxARW0eM83
         atOvAm6aibEgbOKi8XmDD70y7uyA77Z22KPdT+GH6fOoyXHJ2iDBgnD07fMHCjmAQNVF
         xDeQ==
X-Forwarded-Encrypted: i=1; AL+hErEklpmkbGQQTiavvEttdE2KjzyxOlaBMG0/NLx4Aibi6CR0BRD9r9sq8D2ZVp4OnGGf1EhxG6X1JI3CWaNp5AI=@vger.kernel.org
X-Gm-Message-State: APuU4Z9KX2bSaXd6uzakKa3gcNKaIiW6Hv1gdUlz8ZUJKUaH0Pvw/f4D
	vPfK5cmxWzSlFmIjaQlon5EJXQzdaLo5ASvM38mrw4T7rB7ULLTYDeDMwZ+lL29Jifw=
X-Gm-Gg: AYBFou24AOxA6DGURMxJ/DDrlhlNrmOQClTzVRc6hcCx2NzssGQ6WadYhUxHC8XqNH9
	WN4HChX9NiBlh+Mk6Co6nsePFCsLzBm6YZlDp8qRBlyrHdF5b0XD8/UE/v1sfvak2agdgLn9bl+
	R92zBOKWsWVBlyWEI6jhCIHiJ7iYTIRAz8C9SdZrKN7I5IGJHmMK7h4uQXo4poPPiyGf8YoKygT
	K9+EA1/75siSbx13LowdT5i7ABNJCOQosCxQJkL3KHITGdwE0/YjNMiyv6ATGzwTTVZQaxq+ZTR
	mIf70ca+F8WPws45hDImpIHqljfKxzbYkYZWiL36xkLbGi25p8OIp/jpjIE0K7JailmKjhBn+ll
	t7iZeJSb+rxCoQLqog4B5QYcaHySAWArxh8k6QImtF9wkmdhYEsBNPWv1tLuLgVc4mV/uUFuZCn
	+ahhrPvV7jf1WCEI+oXGRrUPzv1xW3vG0MZvvFhRqkAoZl+nJGfR/T7TBLFzr0j+httjLAOnFa1
	/xwJAcnR31tMYKMJT8SHHy9mPBly6m4uGhp/u03bApbZHuenA8PuDg0PW2jh93j+JC+TjilP59y
	7irLl3Ug8S5a5lVMttQTEp0ncjQ0UG0FnqVraB8sro5oEFTP3c2WpQuIboYEA3h9/dtzuueZ7/t
	03NSadOIhJ5fyR1+zDmgbG2b/HvusITFWRi4vSgJ8W8oLmDZsbRAt0vQWelLm6buPfsXkxXW53l
	G3JV9NEyewj/cD6MBC1yFo0qb2WlaV4fzIoriR6dVxbzNhN2lBGJdnF9umP0KWE7HyyFrTnRQVW
	K+xle9d
X-Received: by 2002:a17:90b:48ce:b0:3ae:5572:c4e2 with SMTP id 98e67ed59e1d1-3b1b0a4e8aemr1576928a91.57.1794559932319;
        Fri, 13 Nov 2026 00:52:12 -0800 (PST)
Received: from [172.22.0.2] ([50.175.87.158])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b197d35525sm8662027a91.16.2026.11.13.00.52.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Nov 2026 00:52:11 -0800 (PST)
Date: Fri, 13 Nov 2026 00:52:05 -0800
From: Chris Down <chris@chrisdown.name>
To: Kees Cook <kees@kernel.org>
Cc: Vlastimil Babka <vbabka@kernel.org>, Harry Yoo <harry@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, Hao Li <hao.li@linux.dev>, Christoph Lameter <cl@gentwo.org>, David Rientjes <rientjes@google.com>, Roman Gushchin <roman.gushchin@linux.dev>, Marco Elver <elver@google.com>, GONG Ruiqi <gongruiqi@huaweicloud.com>, Jonathan Corbet <corbet@lwn.net>, linux-mm@kvack.org, linux-hardening@vger.kernel.org, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, kernel-team@meta.com
Subject: Re: [PATCH v2 4/6] slub_kunit: Add a test for the slab_buckets boot parameter
In-Reply-To: <202610302117.74D1EB1@keescook>
References: <cover.1793253633.git.chris@chrisdown.name> <47c0b11109203640122a9b5b030d3f41bfbac609.1793253633.git.chris@chrisdown.name> <202610302117.74D1EB1@keescook>
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
Message-ID: <20261113005205.440863a59b460786@chrisdown.name>
User-Agent: Mutt/2.4.3 (cc9e3943) (2026-10-09)

Hi Kees,

Kees Cook writes:
>Please don't ifdef to drop a test. If you have to do any ifdef, use it
>for test skipping instead.

Sure. In v3 the test is always built, and it calls kunit_skip() when
CONFIG_SLAB_BUCKETS isn't set. The kmalloc_partition test in 6/6 gets the
same treatment.

>This feels messy. Any reason not to just export it entirely and avoid
>all the ifdefness?

No good reason. In v3 it's a normal global, declared in mm/slab.h
without any #if. It's still only exported with EXPORT_SYMBOL_IF_KUNIT,
since nothing other than the test needs it. kmalloc_partition_enabled
gets the same change.

Thanks!

Chris
