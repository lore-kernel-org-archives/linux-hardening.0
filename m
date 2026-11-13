Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.227.137
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794559927;
	b=oNOEMpUIKDvqIHExe/0G/vBraGmQdupAYvu1PAt5LAubmY8IVOrL6MifkgPxw9ROdPMC
	 6vBn1AccL+qrbIptn2/GaVJtyx8ahrtyu/ZJaLRbFwRBZJNOJjgELVUtgkaIEFgUwRJp8
	 TlNc84tqfhh/5/exZK3XJ/lxBhD1KyKDU6Vs4ShWCTu9tQ3ZOnKSL/rYMvT2CiTk0bS8r
	 HeRtJ+mgHbFU4jyUN9Ek30hgrf+uWo/8a6HacBAjbV1fWkqQe224imvMYJiLIkgr+KuAu
	 7w7r4pVo/FHLmXQen3lvEyd+uVXB2UUGINIYx1vgJnsG3KV99RZ9CmD7zYx3rszKPZA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794559927;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:In-Reply-To:References:MIME-Version:
	 Content-Type:Content-Disposition:Message-ID:User-Agent;
	bh=bwUDB2KW6o606MZkDo/fjGb0dXbOTwa5lnzMBFGM+38=;
	b=xwAjPr/bPvA0lHdEn5JiwS1pjJnRpHdlzUMdvXFYAMveTvMzUCVv2xIxS9o5Sv19ytMJ
	 pv9jrbnrnFH9X9rd/Lu5/qjO7CBHVH+OWod6BoT/w9ZjQ2fDWT4i/S25uslf4GT85dxLR
	 IxlFOJt46HcPt2VAGEN+UkNntVm5FQxXZpK7553qeYy6wXyb5EEpjzO8asINJWaj4Pf1Q
	 7mi5XMfgWkBpXhBG+vQ5IPckmAteqgQNhMCpC9IY4+I1bd3v1lV96ah1KNgMO440bmKJ+
	 TBZAm06Jfe7whnw7KhOxwD8pJDFK75nPURu0HPfhiWvqf/rNP5aY0kZLb+iJgd3cJNw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=chrisdown.name;
	spf=pass smtp.mailfrom=chrisdown.name;
	dkim=pass header.d=chrisdown.name header.i=@chrisdown.name header.a=rsa-sha256 header.s=google header.b=qfYTAkPa;
	arc=none smtp.remote-ip=74.125.227.137
Received: from mail-pj2-f9.google.com (mail-pj2-f9.google.com [74.125.227.137])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAF73606A891
	for <linux-hardening@vger.kernel.org>; Fri, 13 Nov 2026 08:52:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BAF73606A891
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=chrisdown.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chrisdown.name
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chrisdown.name header.i=@chrisdown.name header.a=rsa-sha256 header.s=google header.b=qfYTAkPa
Received: by mail-pj2-f9.google.com with SMTP id 98e67ed59e1d1-3b1a38a5088so195952a91.1
        for <linux-hardening@vger.kernel.org>; Fri, 13 Nov 2026 00:52:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chrisdown.name; s=google; t=1794559926; x=1795164726; darn=vger.kernel.org;
        h=user-agent:message-id:content-disposition:content-type:mime-version
         :references:in-reply-to:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=bwUDB2KW6o606MZkDo/fjGb0dXbOTwa5lnzMBFGM+38=;
        b=qfYTAkPaHlJoKZndJ1amhv8QdpihkbMCquLcZkhGlKDUylG8GW0BZvSAikFffhjx0t
         ii9EpRoXoEVeVC9qma7452DsMHJMLibW+zE9u831VDMGj9Z9IWM/6pd+uf+2NLS0IVgc
         ZwzONvdSovIkb4u/wurJ2rUTWJNcZZjBVVUVY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794559926; x=1795164726;
        h=user-agent:message-id:content-disposition:content-type:mime-version
         :references:in-reply-to:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=bwUDB2KW6o606MZkDo/fjGb0dXbOTwa5lnzMBFGM+38=;
        b=MoZtVzL5cRqfICCsBTmDh3RbmGqnlThjPh5GAbOZXSB0YO5Ruy60Wg6aP8k9ApUHcB
         8P2Cu18v1Aek3MnZpAPg4Eu0JCzadpBLboMX9RsBGGRrG6Tgxl4g0+U6A5MA2dLbFkt/
         yzdXBskqBREN9hV3htsFBhpycclXiHaEsuAPh2jsMKs3KAYMlaiQVx+1SkLNB41VDrT1
         ykikW7QJPR553Zp47KYuCQXNl3F1BgIwV1Ej2szAugPy2JH1umdzabPCk+vIlLZP4puj
         D9xQdytYZ5dVSd39zrmdZfYzxeZb+eNUjSCMkzHfDJuAw84DupEusn0Mc4NsLQI7DOZH
         bGFg==
X-Forwarded-Encrypted: i=1; AL+hErEKTPpxXAw6HhN4vhr5tObdi239LQdLbx2e7SoAFyZyqIyTk7/KRDduDy8Y6ouMHt6A4UUoyUxTx0x48F2gtBk=@vger.kernel.org
X-Gm-Message-State: APuU4Z8iur3cD+lcICbfnjJSrttENlNc8grTvjb+jEPyxDozwLtAn8bn
	K3qI2cbz0/zzjnY2Ppir2vEGXtIWGiuD5DtoVkefBUtOtwRjDfiG/AYTQ5LAVYkn8bw=
X-Gm-Gg: AYBFou3cAvJ3RW2Sql+gd07kNlzIonH0Xht/9soHvQH9NpJXU9aaNsB93KtPSewrclN
	UE8oNJAyYVYqgkmVW//6f6pWTSkR2pq1cwhIP3piwY9vwpuzFNYGwPm2qw1iNQe34qnWV/MSSaB
	dRzKvMy/ko60hg+1/jIhuDx3gDQi+EtgqEazN+k/47KkGBBygJI9aYbXe6pc6mp0pKlYGlmzYjX
	PnSjQRIDm+2dBnYJFhuDZWogOD1sScABj2OIPb8E+oGQVoIt+XXEuSTo7OWRcYYR9m1Ymra4Fby
	TePgq8xW3xn91kMvsCh4vr60cKZ1zOH+rV9Osw4NyyUxvwXIw+eL88+jA+E4rpFKdMW0k4eEuDb
	OBjdtlRMc2pJTTdRvvsPLjMWKa2cNplJt7VZeUck25yyiPvWEygo1lSvO0WUKvg88TctNlAKDJw
	VtB5tFdUMo6eRFh719BWlDyRZJwNfelnMZgCVU0OWwn84uK7FFv21hVk7bHLhtUMNFuUAYamCY0
	aZNnH6tbN4WYoJhzX28hJ+8M2E6PceYQEAt2tql3fZ/afkF4R31GGzo6ZIZEsgbr70xyBG/8f0S
	QEmSkHo4LcyCHwCBShqho2HEl6cBLqa7syYVNUKZrdDWN8ARakxxWC+R+BgFTDNgFwgwx35SuK1
	6VZqko3TLPVYBn+oMCHOgtAtukmtBwjjfSneZRAW0Kf/C9mK2rsLqbheY/PQChkPCfaGeAlVoRa
	U57gj7RVdVlVDUPauq+kmGlrbgrWiAlO9RFDSbdYmPMPwWfc/uuQNkzglC+WA=
X-Received: by 2002:a17:90b:3148:b0:3ab:2d17:51c5 with SMTP id 98e67ed59e1d1-3b1b07ff58amr1597563a91.6.1794559926135;
        Fri, 13 Nov 2026 00:52:06 -0800 (PST)
Received: from [172.22.0.2] ([50.175.87.158])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b197d0f497sm8791005a91.8.2026.11.13.00.52.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Nov 2026 00:52:05 -0800 (PST)
Date: Fri, 13 Nov 2026 00:51:59 -0800
From: Chris Down <chris@chrisdown.name>
To: Kees Cook <kees@kernel.org>
Cc: Vlastimil Babka <vbabka@kernel.org>, Harry Yoo <harry@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, Hao Li <hao.li@linux.dev>, Christoph Lameter <cl@gentwo.org>, David Rientjes <rientjes@google.com>, Roman Gushchin <roman.gushchin@linux.dev>, Marco Elver <elver@google.com>, GONG Ruiqi <gongruiqi@huaweicloud.com>, Jonathan Corbet <corbet@lwn.net>, linux-mm@kvack.org, linux-hardening@vger.kernel.org, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, kernel-team@meta.com
Subject: Re: [PATCH v2 3/6] mm/slab: Support disabling SLAB_BUCKETS at boot
In-Reply-To: <202610302115.8C7AD110@keescook>
References: <cover.1793253633.git.chris@chrisdown.name> <9a68a4d95830352ad3821437c2e22c30a673055b.1793253633.git.chris@chrisdown.name> <202610302115.8C7AD110@keescook>
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
Message-ID: <20261113005159.840c7b1a6049a81b@chrisdown.name>
User-Agent: Mutt/2.4.3 (cc9e3943) (2026-10-09)

Hi Kees,

Kees Cook writes:
>I thought the issue here was about calling convention (i.e. with
>CONFIG_SLAB_BUCKETS Vlastimil had suggested making the argument lists
>for the call chain shorter by dropping the bucket argument entirely).

I think you might be thinking of Harry's kmalloc_params idea from the
slab_alloc_context thread [1], which would fold the bucket and token
arguments into one struct. That's a separate thing. This patch can't
change the calling convention: with slab_buckets=0 the kmem_buckets
argument is still passed down, it's just NULL, so kmalloc_slab() picks
the normal caches.

What this patch is about is being able to build one image with
CONFIG_SLAB_BUCKETS=y and not pay for the separate caches on hosts which
don't want them. Harry measured that at about 1 MiB after boot [2], so
it's the smaller of the two, but it's the same "needs a separate kernel"
problem as kmalloc_partition=.

>Regardless, I still prefer this being a static branch so we don't end
>up with a needless rodata global check.

The flag is only read in kmem_buckets_create() and
create_kmalloc_caches(), when a set of buckets is created. It isn't read
on the allocation path. Allocations never look at it: they just get the
NULL that kmem_buckets_create() returned. So a static key wouldn't save
anything at runtime. Also, some architectures (arm, for example) parse
early params before jump_label_init(). So we'd still need the bool, and
would have to flip the key later as init_on_alloc does.

Is there somewhere else you had in mind for it?

[1] https://lore.kernel.org/r/e650e125-5f6c-4de7-88b5-9da666bb0a4e@kernel.org
[2] https://lore.kernel.org/r/179312451613.474906.1475329637924619088@kernel.org

Thanks!

Chris
