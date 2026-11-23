Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.45
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795443361;
	b=IxcOpsp9YJhdKOFnpuD9p8j0iE1ASrcSMHxTN3v5+OSpIBWbdJfxGB8Ulmq1Up1otOpH
	 7WHn44n9059BqdlGTbp/TLnGDa4hcfssDjfs01VjFw+eINrQ+YLh5CuPGvOOyl8FA9cay
	 ic0RiDLxCVT3pqNV5fgmknmw8haU7zs/04zCizJKaDd3cqLgwFvCOZJY7riNkFJVx1rVi
	 MQ/iH0Ha9UW3aRjeB4NIGrgNt82qakxMobRlBPQTJKBSqjJGNrhFBYfBpJ2hZ0a+4QKb7
	 dIxNq7FbV3fzXBbJ3FW8oU99FZ8lQFw/Jlqqp/p1Tl2XXb/t6mQa2J6ZRy7aSC2sCTg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795443361;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=PjRuNUOgfB3Fg1Fm9BbnbhhqY+ZgAzXM9O/HQJjsyY0=;
	b=Lcv0nd53SbRLKOE/R+6FygpclAf6JQzF7Gkgm50DLI5fAh7GQyDUKFOEHuCQYpdwiH9z
	 q7ekmlKCOg/f+Ie4xcmqkgLG+l4NE+Bcy+U/H9w0HttcTGfJdQYaa4RQVmJg2VxC0bTlz
	 a3U/P2tfDjVdTid33pbcqKkrSMU7lTb56Hkr+tvdCpYtUm42iqZQ1WL7ho7xnAEit8pOX
	 Cz/AujcHatR1StLQ/5bVrGigUgQ5O6BamdlLwfi/Jq9LcvEfLgZOdgGpik1AQhdU0iPFh
	 tXN8ZnT6m/qWwelSsdRgoRRok1NUud7fibEkIlRlPsgs+HUtP2XHomoOXNhh6fYBojg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=JSP+Znqb;
	arc=none smtp.remote-ip=74.125.82.45
Received: from mail-dl1-f45.google.com (mail-dl1-f45.google.com [74.125.82.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79F40606A337
	for <linux-hardening@vger.kernel.org>; Mon, 23 Nov 2026 14:16:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 79F40606A337
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=JSP+Znqb
Received: by mail-dl1-f45.google.com with SMTP id a92af1059eb24-1b3b4944a0eso2280930c88.0
        for <linux-hardening@vger.kernel.org>; Mon, 23 Nov 2026 06:16:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795443360; x=1796048160; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=PjRuNUOgfB3Fg1Fm9BbnbhhqY+ZgAzXM9O/HQJjsyY0=;
        b=JSP+ZnqbcEb0ia/ONGPICfm4AQK9TPsrfUjvnKiYqWlKjXcl13cN5zJH23WVbFMG/C
         W2PRjEze9BcTUJIZN6qyD6nAbIyDH2eGotrFkLL30X4BWuVewA40x1vHko4Wf07O2avA
         ZP9FZa8oa4Crf/SlOb1v35TtukW1Qs68Ne8s0FQvkp6TbsxVKEq28YMMUIQ78R96rTDq
         QSg72i5BTowgDycaDUjs/FHT3vYDbP7aEPJx6ywtLBJeK9g6It2W3gr/duKpLGk+Gc3M
         2HJxA2zGLfszuE+DxpaBOHkEpCBNuv21A/zmhFZPSKbiluZl02wqOVYXEoJcOY4f4a7W
         nZ6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795443360; x=1796048160;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=PjRuNUOgfB3Fg1Fm9BbnbhhqY+ZgAzXM9O/HQJjsyY0=;
        b=acocePDD+dPwrZyIXtTL45h8hRPeTOOYabrk5gvfj0yiqvomwjRnL8434e2EbrCqlf
         33hxdKHk2SufLjODE9xJtSOleD7/5zgbrQUhWVpRinfh/X/DUtVAqiikm+nt1xg2Bnh7
         3L8XjlsUanUg7/8ptzM73dARSx+xIMsO/wrMmSnT0OkWNoG7Gh3SqvgX860Bh8KupXs8
         tk77Xtb+ZaFZ/qdhJvFKCRASGbvHcStsWNLUEYuxzsU7XM9o0/+Ghz6uPJDVPkHt90t3
         D/aW+Ys6w5DLfs5IbLrNJX/sAgJYrLablWxiKxHVFTRWNZjiy3LmyIT9MIB2LTs5aaal
         4mEw==
X-Forwarded-Encrypted: i=1; AL+hErH0yHLXRCAwe1euv48g9ZuIp1B5cnVO+QPDmLSjl7NCXEdCZZ8VllsySvWgoQz6K6axGkBBFa1U7BXKQcqu/Es=@vger.kernel.org
X-Gm-Message-State: APuU4Z8ztfhtmw+a4QcwDwlKjDSkanKMwD+rqIvyQ6ZFtXLO/FTOrCGh
	H/eoc9fYhRuqpuwLIoAiObBa3FvJmbteOFOeyguX4MFsFu1jdF4PbcDwTmtp+1A6
X-Gm-Gg: AZFdTZfpuiDnsJ2Kd3bxRUi2tip6wZyMWyIWtjIyrlrT9D+4CWJcuDs82c/lz6fz4qR
	P0orj19L+q7laFogOsr5TZ1ILp3eXjpzgiyqKqPXjQtmti+JIW3elsExy4QEhebHG9uizu4XOFf
	hDk6EwqEs6VskH0doxyb68VWfUpL0vRUK1IuU5JMj0Aw+bzuhwG6k/TIR+MoG7yX9tee4YTkZ5/
	Hqs9XhoGOQDXsxzyfxIOgmniBYpaBo8XEaJcPcfvNs5i6wo+ExJ4R9xFPplT2OcszkrPsn+Z5jY
	fWOJPF0cH1D50bKIcH2fn+wgwk7e+m1Cd5Gtrst1mtFGlOVyuj1R11hjt9VexY/U+S2xK4PwVCu
	h79P5bt8q1iEWxVT36TMtG1itP7Cuss49ywGny80SKo4DibFeAxi6aCJ3iVQcxmDiMXg3Azk+QS
	8TV/bT4puGtNj2eSVdlrncn2R2hpFodTJqtbMSm2f1FqrdpTGDyEBMA/x+yM0xb2mWWOySHyrCz
	9cditF+FhwjRL1YSd3ZQFrJKaHfaVDvQYQdKFZz9Eu/MPY8DfVC7uKxmJzL2z2UNlpDwDeF9mm9
	FbRElf/wbw8ka9O91PW0mCpnqrJRmVpLaVuaJsPiNu632bOD445TXR+Jm+IUALIZutFz
X-Received: by 2002:a05:7022:f509:b0:1a4:4194:fc04 with SMTP id a92af1059eb24-1b5568e4322mr11657910c88.28.1795443360380;
        Mon, 23 Nov 2026 06:16:00 -0800 (PST)
Received: from localhost.localdomain (vmi2317719.contaboserver.net. [84.247.152.64])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b5567ff27bsm31101950c88.6.2026.11.23.06.15.54
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 23 Nov 2026 06:16:00 -0800 (PST)
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
Subject: [PATCH v5 00/19] mm/swap: introduce priority queues for swap device allocation
Date: Mon, 23 Nov 2026 22:15:50 +0800
Message-ID: <cover.1795439990.git.lianux.mm@gmail.com>
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

This is v5 of Kairui Song's swap priority queue series. Today, choosing
among swap devices of equal priority means rotating a shared plist.
With this series, each CPU advances its own position in a ring of
equal-priority devices. The allocator selects a device before looking for
slots on it. This keeps the existing global swap priorities and does not
add a tier ABI or a per-memcg device-selection policy. Memcg swap
accounting and limits are unchanged.

Thanks to Kairui and Kunwu Chan for reviewing v4. I'm dropping the RFC
tag and submitting the series for review.

Changes since v4:

- Rebased onto mm-unstable at 7d1a16abe4cc (7.4-rc3), retaining the
  upstream swap size reporting fix in swap_show() and swapon().
- Following Kairui's review, renamed swap_ring_iterator to
  swap_queue_reader_head and ring_only to no_fallback. A large folio
  can still try other devices of the same priority after an allocation
  failure, but not a lower priority.
- Following Kunwu's review, retained READ_ONCE() in the availability
  check, removed a misleading comment about slot reuse, and made both
  /proc/swaps iterators check the published swap_file under the read
  lock.
- Split the off-list bit fix into patch 10, before the queue conversion.
  The plist allocator also needs to mask that bit when checking whether
  a swap device is full.
- Revised patch 04 to distinguish all allocated descriptors from
  writable devices. drain_mmlist() needs only the usage count and no
  longer reads the flags. si_swapinfo() takes one flags snapshot when
  accounting for devices being taken offline. I have not carried the
  previous Reviewed-by on that patch.

Testing:

I ran Kairui's benchmarks on the 7.4-rc3 base (7d1a16abe4cc) before and
after applying the then-current v5 patches.

On one x86-64 host, both kernels built the same source (4dbe24720eb3)
with make -j96 and eight 8-GiB ZRAM devices. Each build used a fresh
output directory. The BRD test used twelve 8-GiB RAM disks, a 24-GiB
memcg limit and one invocation per kernel:

  usemem --init-time -O -y -x -n 32 1536M

Times are in seconds (means for kbuild).

  Workload        Runs/kernel   SYS: Before -> After      Wall: Before -> After
  kbuild, 2 GiB        12       4193.23 -> 4271.06        167.80 -> 168.80
  kbuild, 3 GiB        12       2257.60 -> 2299.63        136.29 -> 136.77
  12-BRD                1        141.16 ->  131.44          6.61 ->   6.32

Both kbuild cases used 1.86% more system CPU time; elapsed time rose by
0.60% and 0.35%, respectively. In the single BRD run, throughput
(48 GiB mapped divided by elapsed time) rose from 7436 to 7777 MiB/s
(+4.59%). There was one boot per kernel and the baseline ran first.
The BRD result alone does not establish a repeatable speedup.

v4:
https://lore.kernel.org/all/cover.1794666741.git.lianux.mm@gmail.com/
v1 and original test method:
https://lore.kernel.org/all/20260714-swap-pcp-priq-v1-0-de9b164ed419@tencent.com/
Related swap tier work:
https://lore.kernel.org/all/20260916183437.2946306-1-youngjun.park@lge.com/

Best regards,
Lian Wang

---

Kairui Song (12):
  mm/swap: remove unused parameter for reading swap header
  mm/swap: clean up hibernation error handling
  mm/swap: cleanup and document swap device availability flag usage
  mm/swap: introduce swap device iteration helper
  mm/swap: change the swapon lock into a percpu rwsem
  mm/swap: serialize swap publication before removing swapon mutex
  mm/swap: consolidate swap inuse accounting helpers
  mm/swap: add priority queue for swap device allocation
  mm/swap: remove available list
  mm/swap: bound synchronous discard outside the allocation reader
  mm/swap: drop swap active plist
  lib/plist.c: remove requeue function

Lian Wang (6):
  mm/swap: avoid direct reclaim when populating swap cluster metadata
  mm/swap: mask the off-list bit when checking whether swap is full
  mm/swap: reuse per-CPU queue readers across priority changes
  mm/swap: advance the global queue cursor directly between priority
    rings
  mm/swap: skip reader rotation for single-device priority rings
  mm/swap: redistribute queue readers after membership changes

Youngjun Park (1):
  mm/swap: change back to use each swap device's percpu cluster

 include/linux/plist.h |    2 -
 include/linux/swap.h  |   45 +-
 lib/plist.c           |   71 --
 mm/swap.h             |   12 +-
 mm/swapfile.c         | 1446 ++++++++++++++++++++++++++---------------
 5 files changed, 963 insertions(+), 613 deletions(-)


base-commit: 7d1a16abe4cc5dccd21e3d6262e44433a5885d27
