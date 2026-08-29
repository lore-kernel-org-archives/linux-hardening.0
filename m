Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87363324B20
	for <linux-hardening@vger.kernel.org>; Sat, 29 Aug 2026 07:38:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787989110; cv=none; b=j8Wp1xOk+pMMQSA2RoGP5xxRytE0PAOIUCTO8mmM1ANT9CVTpt0iuLcXsoAtVFNJqM9uIObuG4FjbLAQe04dVd/Uw+CZ7PhS67Hqd2fWHlBt8mMXByDqeCngOmkNyeoQD1KkVrHSiUYhqOWjIsEgPkJnB3dF6gnIJCKm6rkOVNk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787989110; c=relaxed/simple;
	bh=wX9ZihvakbhGqPB1UdM4iWTzVGFQowBUA9bRDFMSJEg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=mkkb7EPtyxi1UCQ3DcTY16V45DREUODzSPhC0QmTm294ncBnFmXZ4a9bDsNeO6/YZ3/CJS/wo2ydeNxpL0uzyVD3gl3Eg2IzAPS0zPsWHHcuiXuqbvMX8G7GdXDCbjzs4vPlJmfa2awVq+1U+qTsyH4s73ainyHlvcfY44fpxdM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JhdxXLfv; arc=none smtp.client-ip=209.85.215.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JhdxXLfv"
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-cbedbaba5fdso1280506a12.0
        for <linux-hardening@vger.kernel.org>; Sat, 29 Aug 2026 00:38:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787989108; x=1788593908; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=AygLwoJ1AVtSpfiyYiWc6BhU8FQ//SlXkeaxEkXuQqo=;
        b=JhdxXLfvySUJT1RtxHnS2RIg2LeLck/PuK25GRCy7gORbIjAaQ3BZWUFcXuzbafmHy
         rs0InyP3hLyLZ79bbQo+bbCkWRyI1D0VrBVs3NHFfT5O/PGhXfEWUNaA0qOlUwa3pO/C
         5qc499leOtl091a28TYvkkyzFyGLcocGoMcO1uY9hlQ+fGX8ZNYkUv9+slV6hdWFxl/w
         y1PxnVLII8zBr37YWtKH+5ME4wP3BQlllyuxlTBnr0e1e8miTF42aO2Nus1oOgtCDQDD
         uujwxMDISCPOKPYPj+hSYxOafIPqAgLcqD2rTsQduDjaP+8jeN4n53jezcG4fGUS4pfw
         Gj/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787989108; x=1788593908;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=AygLwoJ1AVtSpfiyYiWc6BhU8FQ//SlXkeaxEkXuQqo=;
        b=UlUwGwiwim7XFrr4SVmQjInkID6o/W29jssUrfwCEFQkPYZUGv5qwo+Vd8O4rRsHvt
         yMFVJ6UD25yH7md7RCm/N8JFVm0Ql2/Lt1Wx9lR+2ZpsA3x8u/JlJGMOOzHvTodX391Q
         Qvu86Pvldd+mZXy6oJYPHw8XBvqMjYmS1TsrLSZGn75/9LJVXcRJcBvvFr45Eh/nSRnp
         MuxNKEs5LrFEMytxgposE/apHgZ1fZTh9wPs1NPYxtRwL1cTQ3SZj5qHrdHm/SX+EN/s
         I5AxX//VDaGb4D97mYB7FS8+SXqNe6w3yRNue0gpaNt4dx4OkqRcVT62ecV//5rttfTb
         H3XQ==
X-Forwarded-Encrypted: i=1; AKwUvByEEWfNF+VwR1J6SCExl82SODhHJDaxSVbbp2seN5D0Yp9a3sa4proavX6jSa5hebv0c2nasc9hncXWm2H1Hos=@vger.kernel.org
X-Gm-Message-State: AFuF++nYrgz0BYLQgQXdDmWQ/z0av8C69rPUIlRFflnrWOceDCjBP8rR
	nDTJkkMjeqoOFNG4IATAhD976YJBoPlFsPVSwj7d+gsQrd+XRAOA95/yhkSWmg==
X-Gm-Gg: AYBFou13IZfpkyWODHiQaLGoFOfjIZACgUhB7tiOUBFUrAdHz3Z7Ki+6sp4JoKOoUHN
	2TmlzzPS99knU2Jjfe2bs+7bcnOjG3+YSL23vrAEuE0V4VlWLNyCKUkmpDdqosjcdnV1EYYCYFK
	I0fYjV9Zz/1g5xIzDyYiuo41SpMN8ClUv1vZEwkQDAraTcKBZruc+e0UdwnVLG7QM/UW3rPN6hU
	htUwrr4gRlCLz8mDL9QgIG360MY9GUrDJcaHhZTigG9UeegnGclsbhDMbhnyWnVXza+qDPGwTy1
	l3rLRvmVhsCIctMteA5D4J3Kg5sV46id+kmnTBUKKF09WAkIDAMkuOJth9yeiEW2gaI5xA/Nos2
	MDRtnttxJ5LtJIq25JRBs/FEzHWTisARBAYA6is7mQ+qJlItBtTVWMema3lXf8JNO0KNBs0+DFV
	LsUVp69hsDJm9WMwUHOelxsrO/id3RTsKjbvB1ZehLZQykG2t343nbe8Qp7cSD/DCBrld3Wwk5C
	Cyb41DSlBOk5ri5YtQPrRsN1J7l
X-Received: by 2002:a17:903:3b85:b0:2d8:d4d3:da4c with SMTP id d9443c01a7336-2d8d4d3db71mr79800865ad.16.1787989107667;
        Sat, 29 Aug 2026 00:38:27 -0700 (PDT)
Received: from localhost.localdomain (vmi2317720.contaboserver.net. [84.247.152.65])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2d8dad3ddeesm5987615ad.61.2026.08.29.00.38.21
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sat, 29 Aug 2026 00:38:27 -0700 (PDT)
From: Lian Wang <lianux.mm@gmail.com>
To: linux-mm@kvack.org
Cc: "Lian Wang (ProcessMission)" <lianux.mm@gmail.com>,
	linux-kernel@vger.kernel.org,
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
Subject: [RFC PATCH v2 00/13] mm/swap: introduce per-priority allocation queues
Date: Sat, 29 Aug 2026 15:38:02 +0800
Message-ID: <20260829-swap-pcp-priq-v2-0-68d3d925578c@gmail.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Lian Wang (ProcessMission)" <lianux.mm@gmail.com>

Hi all,

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
