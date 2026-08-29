Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABE3A311C2A
	for <linux-hardening@vger.kernel.org>; Sat, 29 Aug 2026 07:44:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787989457; cv=none; b=hlBtX6Si/xY87CGB3PXRo5KMTU/f7AAdF/DVjw55/32gy6/4sqEgYQo/zln0ZrVChAn/KiqWGkQUYTx3ML3f/aLq0UVcxZamgffxwVj0LyX4XW+2ZFI4z+DTYKKKUIA2AgeppKec0/mjWkXg2OkfRcZx3j5Mrf9yWU5xPjr4h2E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787989457; c=relaxed/simple;
	bh=wz4ZCvFD8HzIoq/yQc+tMPMFDhPr6LFbhvp5jqGO6Yk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=HYwDZhC02WuY23hzzrJJgwHlzAva7w33Foq2XGjVh6R4RFoGHS4HLOdoX/GaAtlY7gWuCofCix9eYLKObUTTjpM2i+ToY6Bhbeqp5VbtyA/011slkATtvQD7sKy+yYSr4G/k13qX0mr6KRU5KO6Tr2c3pK0MCwReDvTNLUR4wDA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=duEx5FlT; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="duEx5FlT"
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2ceab75934dso19656535ad.2
        for <linux-hardening@vger.kernel.org>; Sat, 29 Aug 2026 00:44:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787989455; x=1788594255; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=lsqWf+/1tDSOdv/lJYj0i1KUGSvqW9WqoCLbT3SwEuY=;
        b=duEx5FlT2rwNsmOsu16REn0t3kcPBj5dqLbg64QycPjBrvs5+/zn8LvDnksUkHvpTl
         vc5gsoIFVtvrfD9hMLVTqQSC3K2KL2/V06vO6Zaue39xDYMWyupf/LkwDTNYhVeLGrLv
         MCPm+gwqvUwHBPylEBf/Hnkjr9MdPP9Db4hmM6oq/LWp1UDcOCbVHstBJn98VbenJI9h
         97L1Jq9DHxYgI1qxDUtIrK2XuT15EKmE+v/s6fPnWZevXOAae9z6GIyB0gAjkBvbR1r/
         4HkPUOaiu1bNVpINGDPTPGsFmJvmygqaxr9DyEY5oaMmyhtOHifdCePzgyMncvF0fdoU
         PuyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787989455; x=1788594255;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=lsqWf+/1tDSOdv/lJYj0i1KUGSvqW9WqoCLbT3SwEuY=;
        b=laUYXoeOhzabn3FDWKGt2Yq7c5z4wfk41llSjxsSSX5igGnUHXckE2Lik/hXTQTTdq
         V/z0Ut6coMz9FhvrNVXmzy2ENfKJIssLn53XZu6h0mlexKk6dJS7K3G/c2ZL6jJdFdKF
         ghWx+874bV7txnfpjoE8dccDKX6Ec1JQAkQRcbTX5fnRaBZ5ChlW+PYt6n9WNy2II3v+
         DoGzfPZwvWwHcW6nDQTJHxm/xnT/J7HQCkCBABI6tCvNEiVHqS4GyMwT1ba5Gymj4Nqi
         KOG9hrIj4rid2Bc13boHUYXXxaqtfDtph1rg9iSbFBbPOhiR4y4sr3ZQdGW8Ppe1T8Jj
         Badg==
X-Forwarded-Encrypted: i=1; AKwUvBwy7rn45H3oCKnKwB0mL+Jpr7dkts+FcXMQylgl7E7Vu9RhaG+oaqJZVPS90NniUScMBH/CT5pdhcKW/sfAwL8=@vger.kernel.org
X-Gm-Message-State: AFuF++lKheSoz5Avm0MBl5bZZCFtTEjiqUix+bw6xs94u0n+2RT1IPrS
	ZiMM/nJdPIWALLGG6/NyOqhKNdXU14Z0ougaCjDXgj3FyaBE9Hok02XL
X-Gm-Gg: AYBFou22CSe33npoz6jyFzwxvziy7urKZy4hDrk1EJkVn4FCFjSCndezKK5QrA7CrMI
	qTkf1aA8xIPePvUfi7yN+EaZYw/ZvD9wysWxVi1Hd71IctxOsJk2667u5HWpBJmU30OQ1EIZhfq
	ly3Zb2reZWPfWlNjZ8Ah6kqNyeVUwzLHLc084NGICTbjBAR3LNGfptBjmGQVtC9EwEXBCiyTyy2
	TLn+tjdiq6No2L5F6ZaaI1henypsWBDVn3A2wPbigkc9IwiOb3UNNCv+97iNWybE2DM1XvNDYfW
	z9PyMsLzmIiSLxmvWA6JVfuX9+syLndJNN74n9YCNCgsQ9UpjlZ/5CyCYSUq2Uwnc0Pd33T5rJ3
	4AVHKLDX3qyU8nHlnL+KrHwHx69bwkoUY840Z2kn7fATd426hgS+9A5EzXZQ43Rps6k4hi9troF
	P9YLwzLt8/rEycQ9Y1J9p4IvzkonOXshejw9A0l5tpoN6iWNAxc+W4aphoAyoULtsOM83VszCnF
	qOrqTR1f+jCl3f/qLrYZRNWDUFo
X-Received: by 2002:a17:90b:5443:b0:395:4de0:b78f with SMTP id 98e67ed59e1d1-396d0d4cf4emr21803112a91.1.1787989454783;
        Sat, 29 Aug 2026 00:44:14 -0700 (PDT)
Received: from localhost.localdomain (vmi2317720.contaboserver.net. [84.247.152.65])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-396ddc58f3dsm6090933a91.16.2026.08.29.00.44.08
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sat, 29 Aug 2026 00:44:14 -0700 (PDT)
From: "Lian Wang (ProcessMission)" <lianux.mm@gmail.com>
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
Subject: [RESEND RFC PATCH v2 00/13] mm/swap: introduce per-priority allocation queues
Date: Sat, 29 Aug 2026 15:43:50 +0800
Message-ID: <20260829-swap-pcp-priq-v2-resend-0-68d3d925578c@gmail.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi all,

RESEND: Only the first cover letter was sent, with an outdated sender
display name.  No patches from the series were sent.  This resend uses
the corrected sender identity and starts the complete thread.  There are
no code or content changes from the previously reviewed v2 draft.

This is v2 of Kairui's swap priority queue RFC [1].  With Kairui's
agreement, I am carrying this revision while preserving the original
authorship of his patches and Youngjun's per-device percpu-cluster patch.

My substantive code changes are concentrated in patches 3, 9 and 11.
Patches 5, 10 and 12 contain the dependent adaptations needed to keep
the stack coherent and bisectable.  The code patch-ids of patches 1, 2,
4, 6, 7, 8 and 13 are unchanged from v1.  My Signed-off-by on the full
series records the handoff and DCO chain; Co-developed-by is limited to
the three patches with substantive changes.

The current swap allocator rotates swap_avail_head with plist_requeue()
when it moves between devices of the same priority.  That couples device
selection to the global cluster cache and serializes cluster transitions
on swap_avail_lock.

This series first restores per-device percpu clusters, then replaces the
allocation-time plist rotation with a priority-ordered queue.  Each
priority has a mostly immutable ring of devices.  Per-CPU readers rotate
within a ring after a fixed allocation quota, so the allocator preserves
strict priority ordering without contending on one global rotation point.

The queue is also intended to separate device selection policy from the
per-device cluster allocator.  Youngjun's swap-tier series [2] remains
under separate review.  This RFC does not introduce a tier ABI or assume
that the tier series has landed: a ring is keyed by the existing swap
priority.  If tiers land first, the same queue can become an in-tier
allocation policy rather than a competing tier definition.

Changes since v1
================

The core allocator and lifetime changes are:

- keep a task-local cursor stable across retries, so a retry walk visits
  each same-priority peer exactly once even if another task rotates the
  shared per-CPU reader;
- disable task migration across the queue walk, keeping queue accounting
  and per-CPU cluster allocation on the same CPU while leaving the loop
  sleepable;
- retry every same-priority peer for a large folio before returning
  -E2BIG, without falling through to a lower priority merely because one
  device is fragmented;
- initialize the per-CPU quota consistently;
- represent full/disabled devices with tagged ring entries, serialize tag
  writers, and use READ_ONCE()/WRITE_ONCE() for lockless readers;
- publish swap_file, the live percpu reference, queue membership and
  SWP_WRITEOK in one swapon writer section, and tighten swapoff disable
  and teardown ordering;
- fix the transitional available-list locking and publication issues
  reported by Jihan;
- bound allocation-path synchronous discard to one cluster, while the
  background worker can continue draining the list; and
- remove the transitional available/active plists and the now-unused
  plist_requeue() API after the queue becomes authoritative.

These changes address the public review on patch 9 from Youngjun and
Jihan [3][4].

Open questions
==============

Two performance-policy questions from the v1 discussion remain open:

- A one-device ring, which is likely the most common configuration,
  still follows the common reader path and takes the local lock.  A
  size-one fast path could return ring->dev[0] directly while
  swapon_rwsem keeps the ring stable.  This revision keeps the tested
  common path unchanged; feedback on whether the special case is worth
  adding would be welcome.
- Full devices remain as masked entries in the static ring.  Readers skip
  them rather than rebuilding the ring on each full/available transition.
  This keeps writers simple, but a workload with many full devices in a
  higher-priority ring still pays the masked-entry checks before falling
  through.  It is not clear that extra per-ring availability state would
  justify its synchronization complexity.

Testing
=======

Kunwu ran an A/B/C/D/E matrix on a Kunpeng 920 server with 256 CPUs,
249 GiB RAM and an aarch64 kernel.  The workload built a fixed kernel
source with "make -j96 defconfig Image modules" under 2 GiB and 3 GiB
memory cgroups, using eight equal-priority ZRAM devices.  Every arm used
one warm-up followed by 12 measured runs.

A/B/C share the v1 base and reproduce the progression reported in v1:

  A: before the series
  B: after patch 8, with per-device percpu clusters but the old plist
  C: after patch 13, with the complete priority queue

D/E share the tested v2 base and isolate the current series:

  D: before the series
  E: after all 13 v2 patches

1. Reproducing the v1 performance shape

Average system time over 12 measured kernel builds:

                              2 GiB       3 GiB
  Before (A)                40899.14s    22621.86s
  After patch 8 (B)         88712.52s    53244.70s
  After patch 13 (C)        41140.76s    22925.48s

Patch 8 alone increased system time by 116.9% in the 2 GiB workload
and 135.4% in the 3 GiB workload.  Adding the priority queue returned
system time to within 0.59% and 1.34% of A, respectively.  The absolute
times differ from the v1 machine, but the expected performance shape is
reproduced: moving the cluster cache back to device scope is expensive
while allocation still rotates the plist, and the queue removes that
contention.

2. Isolating the v2 delta

Average system time over 12 measured runs:

                              2 GiB       3 GiB
  Base (D)                  39643.77s    22139.66s
  Full v2 (E)              40336.91s    22984.62s
  Delta                       +1.75%       +3.82%

Average elapsed time, with sample standard deviation:

                              2 GiB       3 GiB
  Base (D)              518.97 +/- 5.87s  334.07 +/- 4.01s
  Full v2 (E)           527.24 +/- 5.21s  342.98 +/- 2.78s
  Delta                       +1.59%       +2.67%

The arms were run sequentially rather than interleaved, so these small
D/E deltas may include temporal drift.  They are reported as observed
instead of being described as zero regression.

3. Correctness and stress

All 120 measured builds completed with build_exit=0, oom_kill=0,
pswpout>0 and a clean dmesg delta.  Arm E also passed tests covering:

- same-priority distribution and lower-priority isolation;
- concurrent swapon/swapoff and /proc/swaps readers;
- full-device mask, unmask and peer refill;
- same-ring large-folio peer retry without fallback; and
- dmesg cleanliness and complete cleanup.

A 600-second stress run concurrently migrated the memory-pressure tasks
across CPUs and inserted and removed a device from the priority ring.  It
completed with live workers, swapout progress and a clean dmesg delta.

For the 48 D/E measured runs, all eight ZRAM devices had nonzero recorded
peak usage.  On E, the per-sample largest/smallest peak ratio averaged
1.021 for 2 GiB and 1.031 for 3 GiB; the worst observed ratio was 1.049.

4. Scope and posting base

The full server matrix was run from commit 94f9b3980dd4
("mm/page_reporting: Add page_reporting_delay_ms module parameter") to
commit d5c8964cf19f ("lib/plist.c: remove requeue function").  The series
below is rebased onto current mm-unstable; range-diff shows all 13 patches
are patch-identical.

The original 48 GiB BRD workload and a real multi-SSD workload were not
rerun, so this revision makes no BRD or hardware-scaling claim.

Link: https://lore.kernel.org/20260714-swap-pcp-priq-v1-0-de9b164ed419@tencent.com [1]
Link: https://lore.kernel.org/20260713025644.170839-1-youngjun.park@lge.com [2]
Link: https://lore.kernel.org/alZ7UBXweuuOX4qz@yjaykim-PowerEdge-T330 [3]
Link: https://lore.kernel.org/77d6da3d-10af-49a1-a356-72aa8b462e85@gmail.com [4]

Thanks to Kairui for the original design and handoff, Youngjun and Jihan
for the v1 review, and Kunwu for the server validation.

Signed-off-by: Lian Wang (ProcessMission) <lianux.mm@gmail.com>
---

Kairui Song (12):
  mm/swap: remove unused parameter for reading swap header
  mm/swap: slightly cleanup the code for hibernation error handling
  mm/swap: cleanup and document swap device availability flag usage
  mm/swap: introduce swap device iteration helper
  mm/swap: change the swapon lock into a percpu rwsem
  mm/swap: remove swapon mutex and update proc reader
  mm/swap: consolidate swap inuse accounting helpers
  mm/swap: add priority queue for swap device allocation
  mm/swap: remove available list
  mm/swap: bound synchronous discard during allocation
  mm/swap: drop swap active plist
  lib/plist.c: remove requeue function

Youngjun Park (1):
  mm/swap: change back to use each swap device's percpu cluster

 include/linux/plist.h |    2 -
 include/linux/swap.h  |   43 +-
 lib/plist.c           |   64 --
 mm/swap.h             |   12 +-
 mm/swapfile.c         | 1301 +++++++++++++++++++++++++----------------
 5 files changed, 817 insertions(+), 605 deletions(-)


base-commit: aeddb4d52acfcc5ce5e988acd48f2906fe966ca3
-- 
2.55.0
