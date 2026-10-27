Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793116842;
	b=hwwefwsiVFFeNtCROoWYx+xqWLKSPKQ5jmwTc1PK5G7q+rrM1wa8HbyNFEcLfqYYjolB
	 H1420lBeoVvjQDkk51zUXmvzE/fTlguIy/d8ykkkDyOH0gX2ktBDgFcdWqY8mmZf0fXB2
	 /2m2+qnCKLLijgHgW6O9DtfXA5nhUY891JdQEfz1KpPxBH4kDEhljEO0q4hPYGuEbUieC
	 jeYF3aZr0fskmIkBrxvdT/+H/31Tph9clHkiJOt1OVdOcKAfXDyHjmlNso2jvHVDWftE7
	 T+Q44/zVVbzH9szN4xAYWSvtq2/O8/i7pgXbsY1ddHsmINJyrzaTuiKq5Z8wsGEJZgQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793116842;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:MIME-Version:
	 Content-Transfer-Encoding;
	bh=lUFPvWUhnbq1nlKdj+4iPr3v7FCFuq1r2DJKFXSbd2o=;
	b=IsUVI6qDXMFrLONCNvMa/jm1TzN0SP03MiQPB8Z71SkqT1xN6v9Z2+81dY8oz/rBG/OX
	 rpY3ORD1ziJxaN3X+pqa35IetJskbSvKdKrAiMLLTKQngmZ8nkCwDBuYYrDWyHr29bq+R
	 3YeXLxaDLet4lA7+7UQTXA92DwLXu+HmaiYKKsQQX4NSe8LNeWGZNkuoo/SfzcX52+8dL
	 xZC5aYKHm17uq23x27nosEO6Jbnu+HYVJRR0dNtT94HEKhlbHpELYdq89a7IHD/7W+8PH
	 fhvyFcZ5LbjdmTj8xD08MDRWOWjVsLv01OkaVxMZ4K4Vpwmx3lRrGooDuvLvpuoisvQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=UP4I+lit;
	arc=none smtp.remote-ip=209.85.215.172
Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C99F606A31D
	for <linux-hardening@vger.kernel.org>; Tue, 27 Oct 2026 16:00:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7C99F606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=UP4I+lit
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-cd6acc50b8dso57678a12.3
        for <linux-hardening@vger.kernel.org>; Tue, 27 Oct 2026 09:00:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793116842; x=1793721642; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=lUFPvWUhnbq1nlKdj+4iPr3v7FCFuq1r2DJKFXSbd2o=;
        b=UP4I+lity2OJEUV3qsO7bHkzdbX35UzOsi9Z1qCPcLXNwsd3PIO15GMKJGPsJSKswz
         +8swA9mTq4HBrCHMrOoXwpfrfddCukMbyU+XJWL2farluTgk1ZO9u+SKEThV2MTNTTGD
         mr7imid/fvgWdKEMEcCPeAaQgoV1RoKsx7Z7F5rqlS/5zaHOSF0rjchIJLLImzuoGPju
         2SuLSLfDJ3yh+GVnVYcm+jv9CUjc6kvadeQ7GO2PUbxh/Ylp+zntQTvFXC2+RBN3PkdW
         r8SYMwqTC5OnUm7aTTZOG33G+owpRGu3Zm6PERP2xmdnnCCLsd/d9St/EjfWn2AnQnMa
         XZ0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793116842; x=1793721642;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=lUFPvWUhnbq1nlKdj+4iPr3v7FCFuq1r2DJKFXSbd2o=;
        b=xoCBUS3W8/EhaTA+bHEMoMbYpeEdc31NqtZC+3w6qkQ9Iktl/Oq55JEdF7BhXD52ia
         rS3/jpZjgfibkdswoHOCd3wye+Fo+598PVxnK6ZpX4YM/lsWVkFS6Iko1VBwSF4+Nkh6
         lIH72AjXYwPWtPrmM/IFQ/gtMded6eb8ycV56yNzj90+W8p0Ut9K+2c//YVL7CwPD90u
         H76i4OVGxLtkXcV2B4p6mWuz11sCdEPDV3xMDANpAJSAGvmK7sTQy5WL6WEAUNg2QO7b
         +BGG8ToiRoF2KxYOnd2kVhtIqywWxD+0gYBaTlsnXbgeAB7K6xOVORU9QPjRAvTpwR88
         lReA==
X-Forwarded-Encrypted: i=1; AKwUvBy/GGXzuelXfE3xzRyPwecIBLrRsvoQePPdTQWSSXPTvyXFNbMgR2756b/OjHYKlGRC7U1vzS6H3PH2HYahV7Q=@vger.kernel.org
X-Gm-Message-State: AFq9FYJhq+RoiBseiOLppuIJXbmTP+VT+GVolZUskw1AOUAsvA+qbfU2
	wWwKBjyWiOJYTMasu7WVIIZerzj5jg1h5s/NVgCBxmWVEEUj+E5NJHMK
X-Gm-Gg: AYBFou0Ndtj1kHD47JNYpjhjIaItyt794RLxyMnoG13MMntBE7eubD8/MJ2j1T97+2j
	RxLI/5n5O5d6h/xWBWdZPYa0pof44qj1mIfQxe4dZmFg/erlx/3hfDtqIkhSGKOIIML1zUfYD2N
	pwscuApwdUJYiG6Jxl5FDa38c99DukKmsxwK6AAELGPBoXjnuA5ETOIUeis47WKkzfxsB/O1/Il
	n8vbysrTz2OEuGZJdJQVucuSA+LcnFhV8XA41F2P68wOOgZJaikVjjU11TvqGyaJ7XuD2P/QOtX
	0KGe0LWOEVH/yzAxJ2u0BRPIqmMFeTjEo0KISdH2ZbWsriq8Bq5LUzbGUBTbbBiAXgptFR843ij
	ctCh7kBlE9mDHpetxeI1b7IulTiQfqHNWwDrbFcX1XR4wDL1FSS6korxtRuMRsHJriud7GECMMK
	L1uhTgesYjFrBWgVto1VosKhxFb0YAt1aQX8OzoBzQcUBMIXNCDocq3oTQYMKYALICq4l4SARPf
	vfCj/Vf+foNaEkx6diSe487V6ba1N6fw9+4k8gYqgFyHIzRXL/GRueEHzk1HiNRqYYUfhtQ/pAd
	MJqsfCrk0LBGzdTQ4e4SFDJRtGsksR2MzuKBU22QslVxB/FIOreScjXfzKzkITKQamfh
X-Received: by 2002:a17:90b:528c:b0:3a0:e4ce:31fd with SMTP id 98e67ed59e1d1-3adead444ecmr8771470a91.10.1793116841476;
        Tue, 27 Oct 2026 09:00:41 -0700 (PDT)
Received: from localhost.localdomain (vmi2317719.contaboserver.net. [84.247.152.64])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ae4064f4bdsm4334209a91.11.2026.10.27.09.00.30
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 27 Oct 2026 09:00:40 -0700 (PDT)
From: Lian Wang <lianux.mm@gmail.com>
To: linux-mm@kvack.org
Cc: linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	chrisl@kernel.org,
	nphamcs@gmail.com,
	baoquan.he@linux.dev,
	baohua@kernel.org,
	youngjun.park@lge.com,
	shikemeng@huaweicloud.com,
	kasong@tencent.com,
	linjh22s@gmail.com,
	kunwu.chan@linux.dev,
	kees@kernel.org,
	gustavoars@kernel.org,
	tglx@kernel.org,
	linux-hardening@vger.kernel.org
Subject: [RFC PATCH v3 00/18] mm/swap: introduce priority queues for swap device allocation
Date: Tue, 27 Oct 2026 23:58:40 +0800
Message-ID: <cover.1793106426.git.lianux.mm@gmail.com>
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

This is v3 of Kairui's swap priority queue RFC [1, 2], retaining the
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

This remains an RFC. I would appreciate feedback on the allocation model
and its integration with the ongoing swap tier work.

Following v1, the changes address related allocation problems:

1) A cache above device selection couples the chosen device to the cached
   cluster. Device-local ownership lets selection determine the eligible
   device before consulting its hints, which is useful for tiering.

2) Rotating the available plist changes shared state under
   swap_avail_lock. Per-CPU readers keep rotation state off that shared
   selection path, with a quota measured in base pages.

3) Device rotation was tied to cluster draining and the fast/slow split.
   Selecting a device first also lets allocation handle its pending
   discard directly, with a bounded amount of synchronous work.

The series is organized as follows:

  01-04: Cleanup, device-state boundaries and iteration helpers.
  05-07: Locking, writer-serialized publication and accounting.
  08:    Restore per-device per-CPU cluster locality.
  09:    Keep cluster metadata population out of direct reclaim.
  10-11: Introduce the safely published queue and remove the avail plist.
  12:    Bound synchronous discard to one cluster per device attempt.
  13-14: Preserve priority-aware throttle selection while removing the
         active plist and unused plist_requeue API.
  15-18: Reuse reader capacity, advance cursors directly, bypass singleton
         rotation and redistribute reader phases on membership changes.

Test results
============
The kernel-build and BRD tests follow the v1 workloads on a newer
baseline. The results below compare the unpatched baseline 4dbe24720eb3
with queue revision db66c58fac8f. The additional usemem and lock-call
results compare the same baseline with 18ec4b962755. These are
measurements of the named revisions; this posting contains revision
fdfe5fac0d5b.

Eight-ZRAM kernel build
----------------------
The workload used eight 8-GiB ZRAM devices and make -j96 in 2-GiB and
3-GiB memcgs. Each case had 12 fresh-output builds per revision, with no
warm-up. The workload source was fixed at 4dbe, using x86 defconfig and
the targets bzImage modules. The revisions ran on separate boots, Before
first; the 12 samples are within-boot repeats.

Mean system CPU time in seconds (lower is better):

                         Before       Queue (db66)       delta
  2-GiB memcg          4469.0100          4457.1575       -0.27%
  3-GiB memcg          2352.7325          2338.9325       -0.59%

Mean elapsed time changed from 170.1283 to 170.3675 s (+0.14%) at 2 GiB
and from 136.6125 to 136.6775 s (+0.05%) at 3 GiB. No clear regression
was observed in these kernel-build runs.

Twelve-BRD usemem
----------------
The same Before/db66 pair used twelve 8-GiB BRD devices and a private
memcg with 24 GiB of memory and 64 GiB of swap allowance.

  usemem --init-time -O -y -x -n 32 1536M

There was one complete invocation per revision. Mapped throughput below
is the requested 48 GiB divided by elapsed time, in MiB/s.

                         Before       Queue (db66)       delta
  elapsed time (s)          7.00                7.11       +1.57%
  mapped MiB/s           7021.71             6913.08       -1.55%

All 50 kernel-build and BRD invocations exited successfully, reported no
memcg OOM events and performed swap I/O.

Additional eight-ZRAM usemem and lock-call measurements
-----------------------------------------------------
A separate experiment used eight 8-GiB equal-priority ZRAM devices and
the same usemem command, with memory.max=24 GiB, memory.swap.max=64 GiB
and memory.zswap.max=0 in the workload's memcg. Both kernels ran on the
same x86-64 host with configs differing only in LOCALVERSION. There was
one workload timing run per revision, with no warm-up, on separate boots,
18ec first.

                         Before       Queue (18ec)       delta
  elapsed time (s)          7.97                8.59       +7.78%
  system CPU time (s)     175.13              192.39       +9.86%
  pswpout (pages)      6,317,548           6,317,684         +136

Both runs exited successfully and completed 32 workers, with no memcg
OOM events. The times increased in this single-sample comparison; the
cause has not been established.

Separate sampled runs recorded 12,451 swap_avail_lock acquisitions at
the selected allocation callsites in Before. Source and binary inspection
confirmed that these calls are absent from the 18ec allocation reader
path. Availability-update callsites recorded zero acquisitions during
both sampled workload windows. This shows removal of the shared
selection-lock calls, rather than an end-to-end speedup.

Current revision checks
-----------------------
All 18 patches in fdfe replay to their expected intermediate trees and
pass checkpatch. Static review and userspace checks of the actual helper
code with ASan/UBSan cover publication, ownership, rollback, selector
progression and throttle priority selection. These checks use userspace
shims and do not constitute kernel runtime testing.

Cooperation with swap tiers
==========================
Device-local cluster hints remain below device selection, so a future
tier policy can determine the eligible candidates before those hints are
used.

V1 proposed taking tiering first and rebasing this queue onto it as an
optimization [1]. I am happy to follow that route. Another option, if
reviewers agree, is to take the refactoring under the existing swap
priority model first, then work with Youngjun on adapting the queue and
reader scope to the tier infrastructure [3].

Youngjun, which ordering would fit your current work better? Are there
constraints we should preserve to make a later rebase straightforward?

The integration should have one authority for device membership,
swapon/swapoff publication and lifetime. Tier policy would determine the
eligible candidates before any device-local hint is used. Within-tier
priority semantics need agreement with that work; this series adds no
tier ABI or per-memcg device-selection control.

Link: https://lore.kernel.org/all/20260714-swap-pcp-priq-v1-0-de9b164ed419@tencent.com/ [1]
Link: https://lore.kernel.org/all/20260829-swap-pcp-priq-v2-resend-0-68d3d925578c@gmail.com/ [2]
Link: https://lore.kernel.org/all/20260916183437.2946306-1-youngjun.park@lge.com/ [3]

---
Changes in v3:
- Serialize file/ref/writable publication when removing swapon_mutex.
- Establish metadata and writer allocation safety at their first use.
- Preserve priority-aware blkcg throttling when removing the active list.
- Add reader-capacity reuse, direct cursor advancement, singleton
  selection and membership redistribution.
- Present the completed ZRAM/BRD results with their tested revisions and
  sample counts, including the observed time increases.
- Add measurements of shared selection-lock calls.

---
Kairui Song (12):
  mm/swap: remove unused parameter for reading swap header
  mm/swap: slightly cleanup the code for hibernation error handling
  mm/swap: cleanup and document swap device availability flag usage
  mm/swap: introduce swap device iteration helper
  mm/swap: change the swapon lock into a percpu rwsem
  mm/swap: serialize swap publication before removing swapon mutex
  mm/swap: consolidate swap inuse accounting helpers
  mm/swap: add priority queue for swap device allocation
  mm/swap: remove available list
  mm/swap: bound synchronous discard during allocation
  mm/swap: drop swap active plist
  lib/plist.c: remove requeue function

Lian Wang (5):
  mm/swap: avoid direct reclaim when populating swap cluster metadata
  mm/swap: reuse per-CPU queue readers across priority changes
  mm/swap: advance the global queue cursor directly between priority
    rings
  mm/swap: skip reader rotation for single-device priority rings
  mm/swap: redistribute queue readers after membership changes

Youngjun Park (1):
  mm/swap: change back to use each swap device's percpu cluster

 include/linux/plist.h |    2 -
 include/linux/swap.h  |   43 +-
 lib/plist.c           |   64 --
 mm/swap.h             |   12 +-
 mm/swapfile.c         | 1421 ++++++++++++++++++++++++++---------------
 5 files changed, 926 insertions(+), 616 deletions(-)
---
base-commit: 4dbe24720eb3811563cd56b35d87ddf3f9beed2a

Best regards,
-- 
Lian Wang <lianux.mm@gmail.com>
