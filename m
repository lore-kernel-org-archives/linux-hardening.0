Received: from lgeamrelo12.lge.com (lgeamrelo12.lge.com [156.147.23.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0407427AC45
	for <linux-hardening@vger.kernel.org>; Fri,  4 Sep 2026 07:13:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.147.23.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788505996; cv=none; b=HQNynaJ4zCsVayScVgRBg+Rs7fMRtBw5AlW0G+TKTBnTz8D9W3jG2OO4oMjAPThWtqY3BeHP2M9ZnkwqJuDqEyt1i8kNGLVXklu/5vq23nPjqhMwdGNA4SeyltmOjT22+nlTas+jKymWN9nTnCRL2NtpbgLziObWNI7CaabUgLY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788505996; c=relaxed/simple;
	bh=LeajCw2QYWhAwDYwOMkw/5LY+k7XA6DJHG8oQycXjtE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=i1NaNN0nB329zMkRFOvcXnIhdKuvy44KlgyxSuXL6yeLxPI0lHRcWRZj2XtNxRjKwCREFoxi4f0yyMhFdmMpAL2E0H6jgXnTsFXOMLMvLObJhNlemkmP0SiCKFf9NZUkHhTkil2m8S71qWLdNBJu6dWiGQAPza+6ILfHPojU00Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lge.com; spf=pass smtp.mailfrom=lge.com; arc=none smtp.client-ip=156.147.23.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lge.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lge.com
Received: from unknown (HELO lgeamrelo04.lge.com) (156.147.1.127)
	by 156.147.23.52 with ESMTP; 4 Sep 2026 16:13:10 +0900
X-Original-SENDERIP: 156.147.1.127
X-Original-MAILFROM: youngjun.park@lge.com
Received: from unknown (HELO yjaykim-PowerEdge-T330) (10.177.112.156)
	by 156.147.1.127 with ESMTP; 4 Sep 2026 16:13:10 +0900
X-Original-SENDERIP: 10.177.112.156
X-Original-MAILFROM: youngjun.park@lge.com
Date: Fri, 4 Sep 2026 16:13:10 +0900
From: Youngjun Park <youngjun.park@lge.com>
To: "Lian Wang (ProcessMission)" <lianux.mm@gmail.com>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org,
	Andrew Morton <akpm@linux-foundation.org>,
	Chris Li <chrisl@kernel.org>, Nhat Pham <nphamcs@gmail.com>,
	Baoquan He <baoquan.he@linux.dev>, Barry Song <baohua@kernel.org>,
	Kemeng Shi <shikemeng@huaweicloud.com>,
	Kairui Song <kasong@tencent.com>, Jihan LIN <linjh22s@gmail.com>,
	Kunwu Chan <kunwu.chan@linux.dev>, Kees Cook <kees@kernel.org>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	Thomas Gleixner <tglx@kernel.org>, linux-hardening@vger.kernel.org
Subject: Re: [RESEND RFC PATCH v2 00/13] mm/swap: introduce per-priority
 allocation queues
Message-ID: <appvhlPleahTRklV@yjaykim-PowerEdge-T330>
References: <20260829-swap-pcp-priq-v2-resend-0-68d3d925578c@gmail.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260829-swap-pcp-priq-v2-resend-0-68d3d925578c@gmail.com>

On Sat, Aug 29, 2026 at 03:43:50PM +0800, Lian Wang (ProcessMission) wrote:
> Hi all,
>
> RESEND: Only the first cover letter was sent, with an outdated sender
> display name.  No patches from the series were sent.  This resend uses
> the corrected sender identity and starts the complete thread.  There are
> no code or content changes from the previously reviewed v2 draft.
>
> This is v2 of Kairui's swap priority queue RFC [1].  With Kairui's
> agreement, I am carrying this revision while preserving the original
> authorship of his patches and Youngjun's per-device percpu-cluster patch.

Hi Lian,
Thank you for work!

Since tiers come up further down, I'd like to raise a point about the
patch subject line too. As Kairui mentioned in RFC v1 that we would
stay aligned with tiers, would it make sense to frame this RFC as a
per-tier allocation policy (or something along those lines)? Kairui,
what's your opinion?

Devices assigned to the same tier already share the same priority, so
I don't think the allocation policy needs more than one option for
that case (I can't think of a use case that would need it).

1. For legacy swap with no tier configured, define it as a single
   priority treated as one tier.
2. When priorities match, allocation naturally falls to a single
   policy (not a queue). the concrete policy here is this
   queue-based scheme.
3. When tiers are enabled, devices previously assigned under legacy
   swap are reassigned to tiers at runtime.
   (This means different swap device on same tier handled like same priority device)

Point 3 reflects my thinking based on the current tier implementation.
Current tier concept is good enough, but I keep thinking how to improve...
(This means I don't think we need runtime tier enablement with
 ability to change swap tier number range. swap device on/off & priority change not that dynamic? right?)

There's an alternative tier-assignment approach that might fit this
series better, and I'd like your thoughts on it.

a. Fix the tier as a boot-time parameter.
   (This way, legacy swap without tiers never hits case 3 at all. On
   kernels with tiers enabled, swap devices are assigned per their
   tier, and devices in the same tier follow the same policy even if
   their priorities differ. plus ther is no swaptier interface management
   add, remove, etc)

b. If boot time isn't preferred, define tiers at compile time by
   grouping equal priorities, or by splitting the priority range into
   1/n buckets based on the number of tiers.
   - The tier interface would then only allow naming (or should this
     also be fixed at compile time?)
   - grouping equal priorities strategy has some limit like

I think this direction aligns well with this patch and, in some
ways, leads to a cleaner architecture. But, both (a) and (b)
have rough edges once I try to work them through in practice, and
each would need to be resolved one at a time with agreement before
introducing it. I'd like to hear other opinions, and if this
is acceptable, I'll introduce original and this idea.

> My substantive code changes are concentrated in patches 3, 9 and 11.
> Patches 5, 10 and 12 contain the dependent adaptations needed to keep
> the stack coherent and bisectable.  The code patch-ids of patches 1, 2,
> 4, 6, 7, 8 and 13 are unchanged from v1.  My Signed-off-by on the full
> series records the handoff and DCO chain; Co-developed-by is limited to
> the three patches with substantive changes.
>
> The current swap allocator rotates swap_avail_head with plist_requeue()
> when it moves between devices of the same priority.  That couples device
> selection to the global cluster cache and serializes cluster transitions
> on swap_avail_lock.

> This series first restores per-device percpu clusters, then replaces the
> allocation-time plist rotation with a priority-ordered queue.  Each
> priority has a mostly immutable ring of devices.  Per-CPU readers rotate

I think this feature will also be needed on the virtualized swap side,
which makes me wonder whether this patch should go back into the swap
tier series instead. Kairui, Lian, what do you think? (Or separately?)

I've also been thinking about how to move the tier series forward
since v10. I'll prepare v11 shortly.

> within a ring after a fixed allocation quota, so the allocator preserves
> strict priority ordering without contending on one global rotation point.
>
> The queue is also intended to separate device selection policy from the
> per-device cluster allocator.  Youngjun's swap-tier series [2] remains

FYI, the thing I've been hesitating over since v10 is that there was
feedback that going through the memcg interface needs more swap code matureness (backend transfer)
and discussion,
so I needed to settle on a direction first.

This patch itself looks like it could align well with the swap-tier
use case (see my note on the interface below). As mentioned above,
I'll follow up with the tier series soon.

> under separate review. This RFC does not introduce a tier ABI or assume
> that the tier series has landed: a ring is keyed by the existing swap
> priority.  If tiers land first, the same queue can become an in-tier
> allocation policy rather than a competing tier definition.

This is the direction I was hoping for. (TBD)

Within a tier. /sys/kernel/mm/swap/tiers/<tier name>/<policy name>

- Across tiers: allocation follows priority based on speed
  differences.
- Within a tier: a selectable policy applies.
  - The default policy is this series' scheme.
  - Priority-based distribution should also be possible within a
    tier.
  - If xswap is introduced, its allocation should be selectable based
    on memcg.
  - Other custom allocation methods (round-robin, etc.).

...

> Testing
> =======
>
> Kunwu ran an A/B/C/D/E matrix on a Kunpeng 920 server with 256 CPUs,
> 249 GiB RAM and an aarch64 kernel.  The workload built a fixed kernel
> source with "make -j96 defconfig Image modules" under 2 GiB and 3 GiB
> memory cgroups, using eight equal-priority ZRAM devices.  Every arm used
> one warm-up followed by 12 measured runs.
>
> A/B/C share the v1 base and reproduce the progression reported in v1:
>
>   A: before the series
>   B: after patch 8, with per-device percpu clusters but the old plist
>   C: after patch 13, with the complete priority queue
>
> D/E share the tested v2 base and isolate the current series:
>
>   D: before the series
>   E: after all 13 v2 patches
>
> 1. Reproducing the v1 performance shape
>
> Average system time over 12 measured kernel builds:
>
>                               2 GiB       3 GiB
>   Before (A)                40899.14s    22621.86s
>   After patch 8 (B)         88712.52s    53244.70s
>   After patch 13 (C)        41140.76s    22925.48s
>
> Patch 8 alone increased system time by 116.9% in the 2 GiB workload
> and 135.4% in the 3 GiB workload.  Adding the priority queue returned
> system time to within 0.59% and 1.34% of A, respectively.  The absolute
> times differ from the v1 machine, but the expected performance shape is
> reproduced: moving the cluster cache back to device scope is expensive
> while allocation still rotates the plist, and the queue removes that
> contention.
>
> 2. Isolating the v2 delta
>
> Average system time over 12 measured runs:
>
>                               2 GiB       3 GiB
>   Base (D)                  39643.77s    22139.66s
>   Full v2 (E)              40336.91s    22984.62s
>   Delta                       +1.75%       +3.82%
>
> Average elapsed time, with sample standard deviation:
>
>                               2 GiB       3 GiB
>   Base (D)              518.97 +/- 5.87s  334.07 +/- 4.01s
>   Full v2 (E)           527.24 +/- 5.21s  342.98 +/- 2.78s
>   Delta                       +1.59%       +2.67%
>
> The arms were run sequentially rather than interleaved, so these small
> D/E deltas may include temporal drift.  They are reported as observed
> instead of being described as zero regression.

No regression is great news. the plist refactor is valuable on its
own merits.

That said, could you also share data on other angles, such as lock-
contention benefits, or advantages in other use-case scenarios? (I'll
also think about what would be worth testing here.)

I've done an initial pass and given my review. I'll keep providing
feedback as I go through the patch contents. :)

Youngjun
