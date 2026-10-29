Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.173
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793254033;
	b=a/+pSmjNJEM0Wx4ZsnrHftnZGPWyu3OwSIm0Q2s+74nXfhum7R+Sqphs9vx11nH+x4B6
	 gmS0UK0slo7/CXkAcdMJ0x60PeKBenRLO/otqvoXJWGCjc2/bvU7D84Ysojkqydjfthte
	 uRJHp/oaZ+BHv1sjegz2gvExTPmeo1BBQ6NmtaVyUrzCtExAitkqnoxCNARD8PJjmTe/N
	 fxjthV3pMDIH+5w2BWSiA86gaCHQzjb6KcSqAmPPv7dPSEW/zCu84I2s8e0Mcq32kGzBg
	 XG0idbXo4f3A6PvUBC6GwLrFA2VrwYoeRW5dscp2+J3x6FcqEXSUD1w+HH9P8r4m4gQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793254033;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:User-Agent;
	bh=UNSxvxACDv6rV+hh5v7KUi83+vs01nWTUXRQ2PYQNxU=;
	b=i9/NrVZbzWceVV7Ltqhdvb6gJM3+DEBlkJTGD0/dLzHcCNS4lEs/vTp+t5MkhIu8X1iE
	 VW94wb1w8Jr7ti+9hpCV66Tk5S89G8OLS34X495fU4U2rjogf/pBrYgd6gaQvF7Eex3P4
	 367cp53nz3/Y/NJpW56UJEM/7kGbIsEPfHEcgUxD75n1lf2FaGXzn2Gb70eKArp3JZ4do
	 aqYEyaW1tAh7U1D3MgrD2QTyHNhOmNh5aUodgXmGdbaXfjxnnhEfE9Rqa/czLXTKvioZo
	 M1Bkc2U3FdDOkS/LnkMTyXq3qe6XiCCwU3Ij4fyrwWZPnDzDXAHMSRDZzms11JnkLaw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=chrisdown.name;
	spf=pass smtp.mailfrom=chrisdown.name;
	dkim=pass header.d=chrisdown.name header.i=@chrisdown.name header.a=rsa-sha256 header.s=google header.b="ho8P/1C5";
	arc=none smtp.remote-ip=209.85.214.173
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06A15606A31E
	for <linux-hardening@vger.kernel.org>; Thu, 29 Oct 2026 06:07:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 06A15606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=chrisdown.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chrisdown.name
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=chrisdown.name header.i=@chrisdown.name header.a=rsa-sha256 header.s=google header.b=ho8P/1C5
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2e5fb79ce82so10998165ad.0
        for <linux-hardening@vger.kernel.org>; Wed, 28 Oct 2026 23:07:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chrisdown.name; s=google; t=1793254032; x=1793858832; darn=vger.kernel.org;
        h=user-agent:content-disposition:content-type:mime-version:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=UNSxvxACDv6rV+hh5v7KUi83+vs01nWTUXRQ2PYQNxU=;
        b=ho8P/1C58VDquswjb3GmuApdin+fY+YgGO7SBCZ/wPMbXdQrudpzDuUrJH4S6ZUrvR
         T+OrvnuItCtqAf9/RUcf12PyjpkM12hnNS1Uv8BrIkA1VkPRwhFjpCW1PEJNrcsRQyCj
         2zfDeWx/VJ8ci2CjCPmBrruNDmJ1NV5pvIeRc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793254032; x=1793858832;
        h=user-agent:content-disposition:content-type:mime-version:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=UNSxvxACDv6rV+hh5v7KUi83+vs01nWTUXRQ2PYQNxU=;
        b=EqtESIQNgCw71fdn0sCasttb6UplpT0M8kRuTuOSl2WH+Tw63ef+4r1FIgh8eSexpK
         Y4Ec4p0rP58ic9Uwg32sQFtxKdJ1g232Gch/8Q2BIWaFEyk6MSUqX+PL+pR1eB4cJloy
         JfPLuAn/YqwwSbqorL0ms2nh6Mlrxd0dzsVKkyjXa8i/zpTF+slosOf8Cwn1PAadK+xj
         3iplw0a55mlvekhI2Fu8qoP5GVlY3Wqv3oXMWY2U9FfAcRWF/pEuWp8UF58nMWGB96fO
         XjaJ1CgfJ1B0Zv9n5i1jjhOZWpdsHPkDNU2uy1a1iCZQMJBLovaCRv3AbT6+wUuKzSdJ
         JNWA==
X-Forwarded-Encrypted: i=1; AKwUvBybLuwndznKlonzVp+PciPb3gM9egryXdRikgVF6nWZ4v1OT8nBtO5I5nCbE9o9o7MNEu5G4R9/6E2P+2z+A3I=@vger.kernel.org
X-Gm-Message-State: AFq9FYI3RJP+G0xEnWYwhp1uCCNK2TnLPH+sM/+c2nrjc5WvSO3Ap1eR
	O3rpNxMMCnerzj5XxK7TdkEDN3cypEl3mOKq3bM7MkzWHiDfEqavDWCNyppibzZWb68=
X-Gm-Gg: AYBFou3YKM7Mdpp7K6zi/LWOh0ZjQ/W4V2f7HrkkR2E52CZ/hMJrHr5vyO70TQ3lAtw
	Kyr6OsuUeoBqUSiEp1kTvKXXlBL4cJ/OpD9x9HHHILYatuGF0j167SeKhdSNfLkWs36h42Gjwkq
	HwOgoOf6X7w12iw3wrAycsGUAfaIrn/ZozIJwOCNE4xypUFB5MNmfUKXTINdLZrym5ZRxXDmwjJ
	KNyw3/OoaimQBBlbkz7X+ziRMdvOwERo1GhcLF5fZCfJlFSP2tfgoK5d7wOc6YfkZolnne2jpNr
	5iSSFn5OyLCTzh6GnfNQDtN8oGNKA1G5iJ00J2CWmbMSCIAuFT4CIAIGCuFUAqtHrexpYFNUoYi
	B76K5ia1dTDn4JV5KaXZAx7xdIkoe23zq35UV5zBADgVNVHK4FvDUA4OaxybheASnwuFcuhMy31
	jpuIiDIv71c07VIonphAKbWF67YJ/ZdRgvUVRoi85uf1hq2Toou8lRcgeYv5UdCZ8aWFlMxpU6+
	0iqctqNSdD4WwmCdE9q+jgxdrtfqqnalMVVRp+rfEML4LCQbJrChcvRuOwpFzXQRcYkUXUhOEhh
	Tbh+4kslbu5ardfaL9996fDs8i5zliOQd6NJBrovQHrP8FV9fMq1OUeYQAjOzTHMtt3laSLH+lb
	fIhs1GMzR2b+ZFY2csF0tCVkiSVFmZoEgNAQNYdHAML/4RPgH5QVHKnPcJPBpXed0SNRZ/zyvsA
	==
X-Received: by 2002:a17:902:fc87:b0:2e2:b7b8:abc5 with SMTP id d9443c01a7336-2eb0038e312mr41423305ad.32.1793254032255;
        Wed, 28 Oct 2026 23:07:12 -0700 (PDT)
Received: from localhost ([116.86.153.182])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2eae64549dfsm29271725ad.4.2026.10.28.23.07.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Oct 2026 23:07:11 -0700 (PDT)
Date: Thu, 29 Oct 2026 14:07:06 +0800
From: Chris Down <chris@chrisdown.name>
To: Vlastimil Babka <vbabka@kernel.org>, Harry Yoo <harry@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>
Cc: Hao Li <hao.li@linux.dev>, Christoph Lameter <cl@gentwo.org>,
	David Rientjes <rientjes@google.com>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Kees Cook <kees@kernel.org>, Marco Elver <elver@google.com>,
	GONG Ruiqi <gongruiqi@huaweicloud.com>,
	Jonathan Corbet <corbet@lwn.net>, linux-mm@kvack.org,
	linux-hardening@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org, kernel-team@meta.com
Subject: [PATCH v2 0/6] mm/slab: Support selecting slab hardening features at
 boot
Message-ID: <cover.1793253633.git.chris@chrisdown.name>
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
User-Agent: Mutt/2.3.3 (9073d26d) (2026-06-12)

Slab hardening settings are currently all build time choices. This means
that, unfortunately, hosts with different requirements end up needing
separate kernel images. At Meta, for example, some hosts are built with
these options and the rest of the fleet isn't, and that's one of the
things that keeps those kernels apart.

Following the discussion on v1, this series now does two things:

- SLAB_FREELIST_HARDENED and SLAB_FREELIST_RANDOM are cheap enough with
  sheaves that it makes more sense to just enable them by default than
  to make them switchable. With both on, system level benchmarks didn't
  change measurably, only slowpath heavy microbenchmarks did [1].

- SLAB_BUCKETS and KMALLOC_PARTITION_CACHES cost memory (Harry measured
  about 1 MiB and 18 MiB respectively after boot on a 64 CPU VM [2]), so
  they get slab_buckets= and kmalloc_partition= boot parameters, which
  default to on when the option is built in.

Changes in v2:
- Make SLAB_FREELIST_HARDENED and SLAB_FREELIST_RANDOM default y instead
  of adding boot parameters for them (Vlastimil).
- Skip the memdup_user() part of the slab_buckets test on !MMU
  (Sashiko).
- Keep slab_buckets= and kmalloc_partition= separate for now. We can
  discuss whether to merge them into slab_hardening= or similar, as
  Harry suggested.

v1: https://lore.kernel.org/r/cover.1793086056.git.chris@chrisdown.name

[1] https://lore.kernel.org/r/auITixAJMfLtfa7i@chrisdown.name
[2] https://lore.kernel.org/r/179312451613.474906.1475329637924619088@kernel.org

Chris Down (6):
  mm/slab: Enable SLAB_FREELIST_HARDENED by default
  mm/slab: Enable SLAB_FREELIST_RANDOM by default
  mm/slab: Support disabling SLAB_BUCKETS at boot
  slub_kunit: Add a test for the slab_buckets boot parameter
  mm/slab: Support disabling KMALLOC_PARTITION_CACHES at boot
  slub_kunit: Add a test for the kmalloc_partition boot parameter

 .../admin-guide/kernel-parameters.txt         | 15 ++++
 lib/tests/slub_kunit.c                        | 87 +++++++++++++++++++
 mm/Kconfig                                    | 11 +++
 mm/slab.h                                     |  8 ++
 mm/slab_common.c                              | 48 ++++++++--
 5 files changed, 163 insertions(+), 6 deletions(-)


base-commit: d15d7703166daf7bd62c844a3cb1b3a6279adb4c
-- 
2.54.0

