Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.227.129
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794559887;
	b=XZ10zEgNnxHS9LTYnNjTNc0Q5w9su4A+sNwc3+VgmX/K5EYStKKTSJPDNBT24O1bqgkY
	 4LsdRzaoceOYxAOAAdoo58injzpFTHFDco7WSfErYU5Ip1K7cHBm6lVDx53dbUapvhLeJ
	 YKZj4fNgbM+DXZBbSw01lygnjcEeniU0Ghe9Ly6WTVHTLkB7uJtOGRtoY3/Gkkg2+6G/c
	 DsBmIFly14bIVkJrBJ1KkXyQTt5Bz7qhsa19OFZsIUuDgpR/fO3wxkK7U2vV+DpaJq1Ly
	 xRun7CTZFd5glCZYQtwRPXGyjciNQ6ppExtboo/2K0vXqGxJd2Z1eC1VH6bkWimcvGw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794559887;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:Message-ID:From:Subject:To:Cc:MIME-Version:Content-Type:
	 Content-Disposition:User-Agent;
	bh=77Y95W/UaJg257+QBwzQ+4jh+bph1WESxo/Gei8xe2A=;
	b=ObPMcCNniRMDmtDA1fGEkEmd8O7TZvxZxH0ri0GhlcL+qE+GhutxjRIJFo8AUQPgpCJT
	 446n8uG8/OicP2jQ6h8C3VuGc1Op+bB4+SzY31UesbOqQedgGG+e8MMBtk3NUJAy408f7
	 StYgA8wS8L+V5KTxQHz7oPKvVktD+MLQr7Db60D7OrPUkfKFGZsQJI4jqxyscPwKi5rZt
	 j3N9l4qjcz4ctKC+v6vCOJCNRWXF3B20zw2+JP/4LwySPtdsSKZXbd6TUsWz6lb+qJlMw
	 pTMlWDROwTe+UBPdFCB1YMAWsk/Pnu+75NWjWQx0/GSreUmdKnQ+bYMGASAVsTQuJpA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=chrisdown.name;
	spf=pass smtp.mailfrom=chrisdown.name;
	dkim=pass header.d=chrisdown.name header.i=@chrisdown.name header.a=rsa-sha256 header.s=google header.b=brVck6GD;
	arc=none smtp.remote-ip=74.125.227.129
Received: from mail-pj2-f1.google.com (mail-pj2-f1.google.com [74.125.227.129])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7FDF606A882
	for <linux-hardening@vger.kernel.org>; Fri, 13 Nov 2026 08:51:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E7FDF606A882
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=chrisdown.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chrisdown.name
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chrisdown.name header.i=@chrisdown.name header.a=rsa-sha256 header.s=google header.b=brVck6GD
Received: by mail-pj2-f1.google.com with SMTP id 98e67ed59e1d1-3b10718b387so479700a91.1
        for <linux-hardening@vger.kernel.org>; Fri, 13 Nov 2026 00:51:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chrisdown.name; s=google; t=1794559886; x=1795164686; darn=vger.kernel.org;
        h=user-agent:content-disposition:content-type:mime-version:cc:to
         :subject:from:message-id:date:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=77Y95W/UaJg257+QBwzQ+4jh+bph1WESxo/Gei8xe2A=;
        b=brVck6GDzg2l9Hd8ZDcj7od0ctXW1NWDQ5vZNcZ5RAm0ytXk7uT52keYCAc8GFvT6O
         GSPdgCSfKoXH3VE87n3N6oGbCcW3OxvcNkSKdFIp1YMUORZjeuqOlgzSJTKq/tH76O0s
         jGmzt6oEd1lV0VvBndnX0dNHhw2bU0tZhMa8E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794559886; x=1795164686;
        h=user-agent:content-disposition:content-type:mime-version:cc:to
         :subject:from:message-id:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=77Y95W/UaJg257+QBwzQ+4jh+bph1WESxo/Gei8xe2A=;
        b=mPk3er9jBCs2lhj5qqDipAqw24PKjgfXPeLUAVsVIWSBu1tjRmaJ/S07o3J2vzqsgW
         ecpGivKMuhnvOZVP02PztdDwx1bXwGYAmZSg04s7IyMXviiKpE1phMC54yqmPA2InBnM
         L2fQdcritEBNnRoNS3aaIZiaqATk+zIoZGezW/ZPCpn3R4QqyWD7i5Cx82RW6ouxJgfR
         CXLKF+xCNWZQY3lWLdX7HNzh3sXASKkfDoh4WaSaRpM5CMl3WO+R80UNLzcDUpIQdeR+
         sUoCUUXYkM9Gxtsf1Z5+GqLBZt3MF4rryv3wbleb3L6+5MK7K3yvfpu5fZ7i2gc9jetO
         5Ftw==
X-Forwarded-Encrypted: i=1; AL+hErGPG8rGjnYsRR4FvBCz7805F4INnWr4OUVXER67Vb4x791Rtay+lkgptkoZloRDPWvLqT9vA0c/TIsl0/LI5sU=@vger.kernel.org
X-Gm-Message-State: APuU4Z9TuQ6TrYb5gyjY65OU8vfzV8rpvlSF1jq813XKrmH1mBg+mmwb
	6e/OIOkISTbFwpWDbD4RZSFfTW5mg/XNpnnAnZIIjGznOuq632ijWiUBLMz9razupq4=
X-Gm-Gg: AYBFou3u8I9nsX3Kndn3rZdFy4JpBU8lhDfsMJNo/idgJJxe1Axt+t+TcEu0IBxucDL
	D0gjFKSucyrZxW7Te0nU416jIwU8/tnbG8dHrszfDoL9xUE4gwAlohJ0Tv1ZcCLoaw0JFat07m6
	gdih9z9q3giNm3ZKXBlhyMACvyf5z1WqeGiAsOpbwqu/IcpR5elkZrJfQtr6InBDZ919kGZj5lF
	6HPevnDYw1UenxgmIH5VegEhgLV7xR9jI+XywiXzleMoELaFccEAzfZ32QUDywan2kORy6Bre1L
	eWwWEbVkt0GDTiI77L+MtlpBTaX3Gs5bopB2b1K5OBOb+qCtD5k507nZIetOn1orXeybKv6BhbO
	j6HwJ8iRM0Qx4/whl4up8mNvC9wnAxyeoz/1qOXnpQEsthWfO/a+iAoJ3if8x+yo0JbnQmTmq26
	6BL+0AEqQj2DbVkX3Cy1fDK3N+OCv/aFOxgQRmW+uH7OinsiRPlNq1+DAXYk48GYUBq0yuAighH
	7iqf26AB5sAWgEmq3JdZblHlUkCAmO/x2QAOn6dWnvk5iFQFwneCCaKEWDRKwm3y+osBSvW/VQN
	WMIJRP6k+k7OsxvD9NylkUOP4r+ac2NPGD20v6hvviKUDl3AXCTUkBiIhPBW4vkgOR3SLGRmwIJ
	W48qqyob92GEI3vdQZXWuOrOCyaq+th4bqE0iWXD9H4631Gsg+qLWBx1oFi6543pUdZ+pauf87u
	l1O+qBUY/Vkxpe5AnXmxM3zetYEu1h5nZ5729lhxSQadsxsl+vQvo2p1pVWT8=
X-Received: by 2002:a17:90b:53d0:b0:3ac:b2e6:317d with SMTP id 98e67ed59e1d1-3b1b0a10840mr1664527a91.35.1794559886175;
        Fri, 13 Nov 2026 00:51:26 -0800 (PST)
Received: from [172.22.0.2] ([50.175.87.158])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b1aec63b9bsm3619209a91.12.2026.11.13.00.51.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Nov 2026 00:51:24 -0800 (PST)
Date: Fri, 13 Nov 2026 00:51:22 -0800
Message-ID: <cover.1794506262.git.chris@chrisdown.name>
From: Chris Down <chris@chrisdown.name>
Subject: [PATCH v3 0/6] mm/slab: Support selecting slab hardening features at boot
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

Slab hardening settings are currently all build time choices. This means
that, unfortunately, hosts with different requirements end up needing
separate kernel images. At Meta, for example, some hosts are built with
these options and the rest of the fleet isn't, and that's one of the
things that keeps those kernels apart.

This series does two things:

- SLAB_FREELIST_HARDENED and SLAB_FREELIST_RANDOM are cheap enough with
  sheaves that it makes more sense to just enable them by default than
  to make them switchable. With both on, system level benchmarks didn't
  change measurably, only slowpath heavy microbenchmarks did [1].

- SLAB_BUCKETS and KMALLOC_PARTITION_CACHES cost memory (Harry measured
  about 1 MiB and 18 MiB respectively after boot on a 64 CPU VM [2]), so
  they get slab_buckets= and kmalloc_partition= boot parameters, which
  default to on when the option is built in.

Whether those two should be folded into a single slab_hardening= is
still open [3].

v3:

- Rebase onto slab/for-next.
- Always build the slab_buckets and kmalloc_partition tests and skip them
  at runtime when the option isn't built in, instead of leaving them out
  with #ifdef (Kees).
- Declare slab_buckets_enabled and kmalloc_partition_enabled in
  mm/slab.h without any #if (Kees).
- Drop the remaining #ifdefs around slab_buckets= and
  kmalloc_partition=. Both are now always registered and ignored when
  the option isn't built in (Kees).
- Keep both flags as plain __ro_after_init bools rather than static
  keys, since they're only read when caches are created and not on the
  allocation path.

v2:

- Make SLAB_FREELIST_HARDENED and SLAB_FREELIST_RANDOM default y instead
  of adding boot parameters for them (Vlastimil).
- Skip the memdup_user() part of the slab_buckets test on !MMU
  (Sashiko).
- Keep slab_buckets= and kmalloc_partition= separate for now. We can
  discuss whether to merge them into slab_hardening= or similar, as
  Harry suggested.

v2: https://lore.kernel.org/r/cover.1793253633.git.chris@chrisdown.name
v1: https://lore.kernel.org/r/cover.1793086056.git.chris@chrisdown.name

[1] https://lore.kernel.org/r/auITixAJMfLtfa7i@chrisdown.name
[2] https://lore.kernel.org/r/179312451613.474906.1475329637924619088@kernel.org
[3] https://lore.kernel.org/r/aud4gPOUzvHtLYnJ@thinkstation

Chris Down (6):
  mm/slab: Enable SLAB_FREELIST_HARDENED by default
  mm/slab: Enable SLAB_FREELIST_RANDOM by default
  mm/slab: Support disabling SLAB_BUCKETS at boot
  slub_kunit: Add a test for the slab_buckets boot parameter
  mm/slab: Support disabling KMALLOC_PARTITION_CACHES at boot
  slub_kunit: Add a test for the kmalloc_partition boot parameter

 .../admin-guide/kernel-parameters.txt         | 15 ++++
 lib/tests/slub_kunit.c                        | 85 +++++++++++++++++++
 mm/Kconfig                                    | 11 +++
 mm/slab.h                                     |  3 +
 mm/slab_common.c                              | 52 ++++++++++--
 5 files changed, 157 insertions(+), 9 deletions(-)


base-commit: ce6518e61e3b4bf4f97f7ac6204049b9eba7eb75
-- 
2.56.1

