Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.180
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794667715;
	b=D7/6eLFuuk7HQSrtl5NeKojHPJ5htHgeL7bNRIo4STQKX97yPQ6CLKMdsy+HpglwnL1G
	 vbP6EhWFVIARgO77g166OfANJDJyiaEuZNLYyonLeg+hO+jZPhZp4rZE4fonrYOry6X0D
	 jm74KIA2i0K2q9ublIdNRobyYoppHhhhG6RT+pPtS6feqKyMGRgyx58nxKACkd0Cu1Yo0
	 6pjmnUDQGdxYwlhPdzxNsrFLg3HEastv5PnxFYmO1PtUmK1wy6vIE1XzVdS9YidWevSG7
	 +0/eQw+KYWFi9FdkzSbLnPE/H37NrYF3vsCZbzKLh1dndsb1mazrMHrQ0qzyGY3NkGA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794667715;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=QVDUL1mI78xGFf+VUdARrYw26JD1qxiuS2EpsS6yLDI=;
	b=eHFgPiYPgFg6pDrTnIcnnx9ajd0zl27LJwt2DhIumiEQxX/8cc3XVtbWPFOPAuq/Hhg2
	 MFAjynsFOuyzKmBaLgIYr/W/GZuakn62kSJdlDQqB+DhZoXq0qoj2PKVILBcn/166KO1u
	 RgFcpTKJEGSSzWfc6nOXMhzSI3QDuiYDYKCOK6aXoqHa2YMrU5jxyDPbVzGiAd8Z9FGpe
	 l40Pz9BOG8HTBdeOYzGGUvGDuRMaO37fG1ndvRtWMr4+DZgofEj1SblOLGnXzwADtukaA
	 YUXG5ym2n3cabsTY+QUjASUz4EKfpWvN5KcNgy4LHqLzqTgd5tsipwRHEEyRbiMXaxg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=AHba3tTe;
	arc=none smtp.remote-ip=209.85.210.180
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DD08606A323
	for <linux-hardening@vger.kernel.org>; Sat, 14 Nov 2026 14:48:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7DD08606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=AHba3tTe
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-8a070755c8cso1208305b3a.0
        for <linux-hardening@vger.kernel.org>; Sat, 14 Nov 2026 06:48:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794667715; x=1795272515; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=QVDUL1mI78xGFf+VUdARrYw26JD1qxiuS2EpsS6yLDI=;
        b=AHba3tTedrxNv/iq802iaYpwMw080/aty2R8KL4wkMVEeYVRIukGY1dHXI47IkZPtC
         rW8O1O4tGYE1dPHwMrC8UIfB93jccKRQRQIOS3qp1cQW21MRBEO4hlKj5XjiBRbcIpL4
         GbHHxB3ttk8LFJPebEgffZVieNYm3MkEfMCG53jijWNerHhAC+G+gtb/HtCsIqmXr4SF
         gpSbo/aYJdDYjXFCTw70MphZw6Sbxm4kDpI8l3Ya7eh8OaMa+8ZR9LiY+Zz+LYcLVu8w
         RV9egILPAQ6WbYqseFPHfxEm4g54ji5LaT7MAtxHMjkjuIHpjfOXpoiNVBT/22yIHlNx
         x51Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794667715; x=1795272515;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=QVDUL1mI78xGFf+VUdARrYw26JD1qxiuS2EpsS6yLDI=;
        b=pxmr+ERGL9JV263BFjew8ZcqdBqHNpjpkgmXdDWIDoqXpnE7zElJ3xYQWPW0CjQRbK
         PtOg9htogWQZiyqX4qQmLrXhh63IaN72mwybgJ/VnJOaZYATCuRckEhbi7MDDTjRj+rT
         emuI5A/FRzbBBVCoJkjmGGw7y/nIh/lJLeZ5fTME6Ylw8T5Do1dRa2nnkhcTYVWaapYN
         GvLRTESG0uVJ/MGCHZ8Jaz/Dh37VkufFDcdWXGGT4NJ1VboWACqI7pDZ7ThbsmRsFEng
         o8sJtMa0dsh4XZhPDHYai7+wOvgCrvodWyYPZj4xWA1R6Eec6fBMMu3CKkr8bO3I2khE
         xeFQ==
X-Forwarded-Encrypted: i=1; AL+hErEOrdlonCX69mMxUiehGegCHqo6tfBzHcUQYeM2UwpAn/odNKNhRmtVmqPznoGk9iYSCgSQdye3NUYLkXf2Mbs=@vger.kernel.org
X-Gm-Message-State: APuU4Z91aTNOXAfRBonQ8AaAk3uGVLj39nxpuageu32CbdfZV/ZH0lGo
	96zDymB+ZbApY6yDfa55AU+S10ldXyAcMnyQlcxkElsl/fviGk7Axz/U
X-Gm-Gg: AYBFou3ExNnMf0eeL8eeGBR3IXNqIW2j/horwX1yL8Jg/OX3n0sgJSMelMnQ9Tt9n5J
	7RpZkHbfdgt64IurkEe/CONEuNl+G3OzDMfwTW3LWprX+Xl6p6QwkLX9McD5yGagOpCwM/Dupsv
	56VjBcQ1Kz399YFjZKsJR3E9f59OHQ1nubygPnF6pC2T7duDVOImX8XwgV13Hj3s05pf5sFBF/L
	OvDpaShYeIDlmiAcM1wFkPfMjAud8Lg4QyVbSc4+PdpdekFZAfcLkuQ73hgDpkz117XtY3dj4QY
	uE63qLSI1LYrL/INTSzPeiFmBkJf+vDdDE+bBBrK7UqjGBD4VL7KyAXWMBGu9wbyRthaPJ90xLN
	7NzY/TyeTclDQQC1JutoUTJVr2iEmMU3OpciHEOL4uhuBMYsHVSxcXuiRV0unTbew+GbVPsG0S7
	OwbGfsD1fuSu+ZH/InepcQL9UxMdfJQ1JkRJwPhI8Yc/wwMoXH+O6BSiZ9M9DRoMOQFVjE1ADeJ
	9GBDNiwLw8toyWCZWuJqc9nAPkVSdlmeq0MYXnNxCJvDpsuLkNNBRLRBMa+fDEIvKqShFheF1qh
	mD6R8N2llESWUAWdzWXGpteOcOaQSn0yLKh2/6QVMwz00qMlN/hvRG7EHiwTPQexs9/F
X-Received: by 2002:a05:6a20:4322:b0:3eb:a104:f30a with SMTP id adf61e73a8af0-3f7a70b20dbmr5602948637.12.1794667714795;
        Sat, 14 Nov 2026 06:48:34 -0800 (PST)
Received: from localhost.localdomain (vmi2317719.contaboserver.net. [84.247.152.64])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cddc18c09fesm2443837a12.26.2026.11.14.06.48.29
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sat, 14 Nov 2026 06:48:34 -0800 (PST)
From: Lian Wang <lianux.mm@gmail.com>
To: linux-mm@kvack.org
Cc: linux-kernel@vger.kernel.org,
	Andrew Morton <akpm@linux-foundation.org>,
	Chris Li <chrisl@kernel.org>,
	Nhat Pham <nphamcs@gmail.com>,
	Baoquan He <baoquan.he@linux.dev>,
	Barry Song <baohua@kernel.org>,
	Youngjun Park <youngjun.park@lge.com>,
	Kemeng Shi <shikemeng@huaweicloud.com>,
	Kairui Song <kasong@tencent.com>,
	Jihan LIN <linjh22s@gmail.com>,
	Kunwu Chan <kunwu.chan@linux.dev>,
	Kees Cook <kees@kernel.org>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	Thomas Gleixner <tglx@kernel.org>,
	linux-hardening@vger.kernel.org
Subject: [RFC PATCH v4 00/18] mm/swap: introduce priority queues for swap device allocation
Date: Sat, 14 Nov 2026 22:47:48 +0800
Message-ID: <cover.1794666741.git.lianux.mm@gmail.com>
X-Mailer: git-send-email 2.55.0
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Post: <mailto:linux-hardening@vger.kernel.org>
List-Help: <mailto:linux-hardening+help@vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-hardening+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi all,

This is v4 of Kairui's swap priority queue RFC [1, 2], retaining the
original authorship. It separates device selection from device-local
cluster allocation to support integration with the ongoing swap tier
work, while preserving existing swap priorities, the swapon interface,
and memcg swap accounting and limits.

The global per-CPU cluster cache couples device choice to cluster
locality. Moving that cache below device selection gives each device its
own allocation hints. The available plist's shared rotation is then
replaced by a priority-ordered array of same-priority device rings, with
per-CPU starting offsets and quotas. A task-local cursor keeps each retry
walk stable. Rotational devices retain per-device sequential hints shared
across CPUs.

This remains an RFC. The current scope is global device selection under
existing priorities; no tier ABI or per-memcg device-selection control
is introduced.

The series is organized as follows:

  01-04: Parameter/error-path cleanup, device-state boundaries and
         iteration helpers.
  05-07: Locking, writer-serialized publication and accounting.
  08:    Restore per-device per-CPU cluster locality.
  09:    Keep cluster metadata population out of direct reclaim.
  10-11: Introduce the safely published queue and remove the avail plist.
  12:    Bound order-0 synchronous discard outside the allocation reader.
  13-14: Preserve priority-aware throttle selection while removing the
         active plist and unused plist_requeue API.
  15-18: Reuse reader capacity, advance cursors directly, bypass singleton
         rotation and redistribute reader phases on membership changes.

Changes in v4
=============
The device-disable and discard paths have been revised following the
review of v3 [4], including Sashiko feedback [5, 6]:

- Complete writable/off-list/availability transitions before releasing
  the management lock or topology writer, including intermediate patches.
- Run bounded order-0 synchronous discard outside the allocation reader,
  holding a live device reference across I/O, then restart selection with
  a fresh cursor.
- Handle discard queued by late reclaim scans, with at most one
  synchronous cluster discard per swap type for each order-0 request.
  Preserve large-folio same-priority retry and split handling without
  foreground synchronous discard.

Rebase
======
The series is now based on mm-unstable 24231596edf2 (7.4-rc1).
The base includes 53a6f71c147a ("mm, swap: stop cluster list scans once
swapoff clears SWP_WRITEOK"), so the former standalone scan fix is no
longer required as a prerequisite. Its si->lock serialization of
WRITEOK changes is preserved.

The metadata allocation paths have been adapted to the upstream
allocator-lock reacquisition and publish-after-revalidation contract,
including -EAGAIN handling and the tableless-cluster relocation guard.
The upstream free-cluster preference and hibernation-slot semantics
are retained.

Test results
============
The tests compare the unpatched baseline 24231596edf2 with the same
baseline plus all 18 patches, fbb87083afcc, on the same x86-64 host.
The kernel configurations differ only in LOCALVERSION.

The kernel-build tests follow the v1 workload: eight 8-GiB ZRAM devices,
make -j96, and 12 fresh-output builds per revision in each of the 2-GiB
and 3-GiB memcgs. Both revisions built the same workload source
(4dbe24720eb3), using x86 defconfig, bzImage/modules and a fixed toolchain.

The BRD case used twelve 8-GiB devices and a memcg with 24 GiB of memory,
64 GiB of swap allowance and memory.zswap.max=0:

  usemem --init-time -O -y -x -n 32 1536M

There was one complete BRD invocation per revision. The BRD capacity and
memcg limit are host adaptations; v1 did not specify those parameters.

Mean system CPU time, seconds:

                         n/arm       Before    Queue (v4)     change
  kbuild, 2-GiB             12     4372.4983    4417.2192     +1.02%
  kbuild, 3-GiB             12     2314.6025    2322.6550     +0.35%
  12-BRD                     1      143.5700     137.9900     -3.89%

Mean elapsed time, seconds:

                         n/arm       Before    Queue (v4)     change
  kbuild, 2-GiB             12      168.8092     169.1100     +0.18%
  kbuild, 3-GiB             12      136.0650     136.3500     +0.21%
  12-BRD                     1        6.6500       6.5100     -2.11%

For the BRD invocation, mapped throughput was 7391.28 -> 7550.23 MiB/s
(+2.15%), calculated as the requested 48 GiB divided by elapsed time,
not as a sum of worker rates.

All 50 invocations completed successfully, reported no memcg OOM events
and performed swap I/O. There were no warm-ups or profiling, and all
samples are included. Before ran first on a separate boot; the 12 builds
are within-boot repeats, and the 32 BRD workers are one invocation.

The kernel-build runs show small increases in system CPU and elapsed
time. These descriptive results do not establish equivalence, absence
of regressions or a stable performance gain.

Cooperation with swap tiers
==========================
Device-local cluster hints remain below device selection, so a future
tier policy can determine the eligible candidates before those hints
are used.

The current revision keeps the refactoring under the existing global
swap priority model. Integration with Youngjun's tier infrastructure [3]
remains follow-up work. Device membership, swapon/swapoff publication
and lifetime should have one agreed authority. Within-tier priority
semantics and reader scope need agreement with that work; this series
does not define a competing tier or memcg policy.

Youngjun and Chris, I would appreciate your feedback on the integration
boundary and ordering.

Link: https://lore.kernel.org/all/20260714-swap-pcp-priq-v1-0-de9b164ed419@tencent.com/ [1]
Link: https://lore.kernel.org/all/20260829-swap-pcp-priq-v2-resend-0-68d3d925578c@gmail.com/ [2]
Link: https://lore.kernel.org/all/20260916183437.2946306-1-youngjun.park@lge.com/ [3]
Link: https://lore.kernel.org/all/cover.1793106426.git.lianux.mm@gmail.com/ [4]
Link: https://lore.kernel.org/all/sashiko-outbox-188132@kernel.org/ [5]
Link: https://lore.kernel.org/all/sashiko-outbox-188141@kernel.org/ [6]

base-commit: 24231596edf2c9d5269d8efbc7007512026672f5

Best regards,
Lian Wang
