Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.182
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794559894;
	b=3fRzxMZB/CrOB4xAUi0skcPLr356rKQviEodoEUNfKcfED2vcdtw68nBMOzlwTClO8F7
	 PPf/6HMM9Nbea4A58k2JJJ66a/tDlRQxxLpNlWx61Cp5Kzl0eeIGLKjW8LPyYGv6AsR4i
	 z0EOxvzvg9Sw+3CP8RED2tsPCAT07sPlPvrb8RBh+EvIZkVxX3/Er0GVdOZ0D/UsptoWd
	 EF/0jDOcZUrY3KcVlU+sfAbp/Sl0+V52C4t7OUhlxor04y6+xBMqnWglK0LNphOR0WL/B
	 2xFP8LcjpATezz2pOUX2AXzyPFMkRtnUDxLTsaXNSofLfmYnFC6VUlALL/f7TW7fcTg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794559894;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:Message-ID:In-Reply-To:References:From:Subject:To:Cc:
	 MIME-Version:Content-Type:Content-Disposition:User-Agent;
	bh=CiBcy7QaND7m5s9DJlixmA3xnrmmNcQJ7o62g9gNxcQ=;
	b=NS/kUzolICdp0r+SotjaPTr0pPq9GIWafVscu9pJng2Zt2Hk4EGFpfH0jMsBaZUciEKt
	 XGcYiOB3BNJKjrFMqlzhciKINSYrKVP1RUsD0/UugmCgLA0x7jarevn5R+PuERmGCKFQa
	 rbF2E9xm9cjwkSxdUVQyQLfZlhe1pBE479trSK2SL7CXdaQtt+wdm/MB8UKFslZdokEzz
	 +GI/Vnhh6Y8gL/XijEeeqh2g5Erkez/yHC9ONGXAEUaNWkTd/YGgc6TXDd7vG/Pi60p/a
	 a4JeKBGNYZyh+h7UWjbdfDUfqTA9QBLfADWQUBRDaXUqXbwDiuyzfu2pMQd+glgtH4g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=chrisdown.name;
	spf=pass smtp.mailfrom=chrisdown.name;
	dkim=pass header.d=chrisdown.name header.i=@chrisdown.name header.a=rsa-sha256 header.s=google header.b=OWzVGAhZ;
	arc=none smtp.remote-ip=209.85.214.182
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34950606CB12
	for <linux-hardening@vger.kernel.org>; Fri, 13 Nov 2026 08:51:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 34950606CB12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=chrisdown.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chrisdown.name
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chrisdown.name header.i=@chrisdown.name header.a=rsa-sha256 header.s=google header.b=OWzVGAhZ
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2e946155442so11185965ad.3
        for <linux-hardening@vger.kernel.org>; Fri, 13 Nov 2026 00:51:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chrisdown.name; s=google; t=1794559892; x=1795164692; darn=vger.kernel.org;
        h=user-agent:content-disposition:content-type:mime-version:cc:to
         :subject:from:references:in-reply-to:message-id:date:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=CiBcy7QaND7m5s9DJlixmA3xnrmmNcQJ7o62g9gNxcQ=;
        b=OWzVGAhZZqhqY+Spa7MkZScWhtIfbQ+aCSE6Lg/k9BiTi/UqSdMuDH414YT7SoWnBU
         icDhs5dGXh6uSyGJFVapKIdGKkEft5ilfsXqHJqdPxXbNCR0faK7cI7N5Ds77uGb9ZrW
         cTJIi/vFsuC+LrCXv8kYgAR+zcqcuDghVWplY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794559892; x=1795164692;
        h=user-agent:content-disposition:content-type:mime-version:cc:to
         :subject:from:references:in-reply-to:message-id:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=CiBcy7QaND7m5s9DJlixmA3xnrmmNcQJ7o62g9gNxcQ=;
        b=Ts6chZe4I8T/YDn0S9zxCHbJT7uujhZBWf6Cesg7vQzQcDv487y7Zfvg96PCMSVJet
         2/jTIWZIdjjHs3NhO/iz0XDBaf32D/BCHWbGv1IRoImYNjs9CXMoxUIPWWP0wK8MLyg5
         iHGLwdrGG6Luonvcfuj0eBB3TDSx+8H9Slx4bENCarXx4/roX2N58QqeRsjzo7n4lqD6
         D75Yowh/OXQBxvvncsSwjKbYnMirnNMoTLugwANTLTUjSXc/GoUhLO/BPdy0jbvUcV4d
         TIo2G8szt3wmBPaZodKJdGb+po0KEAvLs2HV8Ah92a7jZ9igcDCNz00IJQLCpdeuAnam
         oaww==
X-Forwarded-Encrypted: i=1; AL+hErEu+Kd7NwH+V93jm8EJ7DDtTTHg1KRSjEPZDyPdLeESv1bKEmdwc7pKKSUAsq3O/yjMX/ntqNodwNU9rFYBnqw=@vger.kernel.org
X-Gm-Message-State: APuU4Z/YvfAYGehI0HyReFeq1eaKE35sOCfXbqA901Ar4joTPk/IOncn
	SJeFglkQXjHac5w5V4cZoVjUJ6TtJZ7dqjQtzWlj5FeB8Subyj9+hzIPELSeV5eB6Uk=
X-Gm-Gg: AYBFou0Bb8Gewux9x6dCShy3KzgZyfYzAc7n9+Ct0nssF1iwCtfs/Oeafhnjmb50YWU
	JSLgBm1ybjNOhp6ANLuC9Yu6qrsyasPhuVbaqGWQ+A/5cJXEELAj61F7deQ039HnCU7RtNHm2Jz
	7holvMnwBynwlhSfkVPBRiuIjShALbyU/Cjxnk4zwmXyDpMS/NqyD3Mwr+zWeRmOjjc/o/2dwP1
	nYD1zGgzS7cMYc/vx+vKeyZzt9X7TnPHTeI6+0X9sitFD0VSfNsNnP5cW/s68CeGUx/7txZPb2v
	k1+uIRCZdLIMUzx0CiAc3hPv9sXX3+jm5xwtJhEWRCYqeD+lzyh0UyX09QZwd6QOxNdmDcVN6Rm
	Souh6IbSs4NFNO7dJGrKK8YVSny0hcQRg9WK5cdDhcgyCwmMuF/FESZgCJ7MekIp3Sm32HKrtEh
	BS2Z8ook5g29Z2CPjQvzS8Gjxvwau6GyUYCptUkr+1fb8p4EfzGKTeyS9fDhikKuyoTpvcqVOY0
	dOpCVx7gdC+moyATGcI+mh+05Je75w2LO8NKc+G9gTEAcKqgOGW+PEeFNkE/OtcpeOh04Mryg9Z
	ZoY1MJkyKvCDtUTIPMHQ9DyUJ7J7lAs21YrxcVjHarZsV0iXXpVuyFxUBS4I472gn+CKO7qz051
	o0gt8+7BWxVGT0130Ni6d6S8i3as/rNrgCz/IW4j0o+7PTxYoyGS/Dakif15N/x2jdKsjKBgYIQ
	rbZ+WcCncCbcYy4kFJ86TLaiPGhvnv6FDsWl2O1R7WA/AsCqx2ZYtQSAQXOxA=
X-Received: by 2002:a17:902:b414:b0:2ed:e0a:1138 with SMTP id d9443c01a7336-2ee0d66682emr16000605ad.4.1794559892624;
        Fri, 13 Nov 2026 00:51:32 -0800 (PST)
Received: from [172.22.0.2] ([50.175.87.158])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ee0f7e48e2sm6970455ad.36.2026.11.13.00.51.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Nov 2026 00:51:31 -0800 (PST)
Date: Fri, 13 Nov 2026 00:51:28 -0800
Message-ID: <5e66c6e1fb0514242c89504ce624773ad54f50bc.1794506262.git.chris@chrisdown.name>
In-Reply-To: <cover.1794506262.git.chris@chrisdown.name>
References: <cover.1794506262.git.chris@chrisdown.name>
From: Chris Down <chris@chrisdown.name>
Subject: [PATCH v3 2/6] mm/slab: Enable SLAB_FREELIST_RANDOM by default
To: Vlastimil Babka <vbabka@kernel.org>,
    Harry Yoo <harry@kernel.org>,
    Andrew Morton <akpm@linux-foundation.org>
Cc: Hao Li <hao.li@linux.dev>,
    Christoph Lameter <cl@gentwo.org>,
    David Rientjes <rientjes@google.com>,
    Roman Gushchin <roman.gushchin@linux.dev>,
    Kees Cook <kees@kernel.org>,
    Marco Elver <elver@google.com>,
    GONG Ruiqi <gongruiqi@huaweicloud.com>,
    Jonathan Corbet <corbet@lwn.net>,
    linux-mm@kvack.org,
    linux-hardening@vger.kernel.org,
    linux-doc@vger.kernel.org,
    linux-kernel@vger.kernel.org,
    kernel-team@meta.com
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Post: <mailto:linux-hardening@vger.kernel.org>
List-Help: <mailto:linux-hardening+help@vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-hardening+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/2.4.3 (cc9e3943) (2026-10-09)

SLAB_FREELIST_RANDOM randomises the order in which the objects in a new
slab are handed out. Like SLAB_FREELIST_HARDENED, most distros already
enable it, and its cost is only paid when a new slab is set up.

With it on, the same system level benchmarks didn't change measurably.
Allocating from new slabs does get slower, by up to about 30% per object
in a microbenchmark which does little else.

So let's enable it by default too. SHUFFLE_PAGE_ALLOCATOR defaults to
SLAB_FREELIST_RANDOM && ACPI_NUMA, so it's now built in by default on
those systems, but page shuffling itself stays off unless it's enabled
with page_alloc.shuffle.

Suggested-by: Vlastimil Babka <vbabka@kernel.org>
Reviewed-by: Kees Cook <kees@kernel.org>
Signed-off-by: Chris Down <chris@chrisdown.name>
---
 mm/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/mm/Kconfig b/mm/Kconfig
index f330c2c29fd2..d174537d941e 100644
--- a/mm/Kconfig
+++ b/mm/Kconfig
@@ -200,6 +200,7 @@ config SLAB_MERGE_DEFAULT
 config SLAB_FREELIST_RANDOM
 	bool "Randomize slab freelist"
 	depends on !SLUB_TINY
+	default y
 	help
 	  Randomizes the freelist order used on creating new pages. This
 	  security feature reduces the predictability of the kernel slab
-- 
2.56.1

