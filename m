Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.44
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794801190;
	b=QSOzESwI1QgPnUYGTbas3PJKRN2o1azP+RLsD+rQbmz6M0Sxio5oOSCSSppPe1hLKIoy
	 ASI2oz07G6RsgmbgWYRL7bGABBgeTSpQ0Bqzp3Vxw00XJ+CEdjEz3xQp8vqEe23m5PMp+
	 3D3r1t4ez+nFxEUJ1EmKCnMjZQ7BHkLxjYVlu7+p5oDOGp8+YB+YHwuTAT2mvsZXKNZ+y
	 ddAuhm5MaYJGBaPrcOv0lMgcAwDpInAJRvvBUnctI97yR3BI0PFwlrW+Z7y7YhkDs3QH/
	 XflTdZDJ6g/UTFovD11o5mGcgb0VwhCK8oTAaW28NZDM1wGskt2/2dRmaI3DfMbNnlA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794801190;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=4TL7rU67dcCsld58oJYx+NVlFE0fH5IBsAjLGvpEK3U=;
	b=WoJC/A/C6zXAXh+oETMTQu4bvFRIgil6Xz7ky0XpbTN6+cOwusdQIbultTaOdx0YeQz2
	 M+B1osFbqLIaR9hNDmjQLq7hC82k3xmC3nqVgrhb5qbRFKZVD02lW1B724JTnbEtx+fgS
	 p7iehTsd6HVuCbfdweFGxrs7Y51cY/Zb1ssMqVFYPKs7F2jX+OJAozs5D2sbZvpbdBxPj
	 UGPUCd2BeMsxPO/C/rFkj0QdsuJmVdeEnNKYuPzUZZ/g/ResdQtXERjRwBQeucfJdPNlQ
	 An0HgNf7hnyEkt2yvuOMRz5CGgzBd5g8kbyyL0ytLhVbwL/hEmCxCmdZKwCNOazTe/g==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=GlzZcYad;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.44
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA1F6606A31F
	for <linux-hardening@vger.kernel.org>; Mon, 16 Nov 2026 03:53:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EA1F6606A31F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=GlzZcYad
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-6b7efd3bc26so1266135a12.1
        for <linux-hardening@vger.kernel.org>; Sun, 15 Nov 2026 19:53:09 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794801188; cv=none;
        d=google.com; s=arc-20260327;
        b=EVE75RIvFoWwECngRt/5ogISIdgpAgk83QRhCcET5bUC3te6xot9SilWJXg7fR1Jmp
         rSJQKa+75xCHyp2UN/zF89eRHLvGDuGSzxiGeFoXZT2bCZ1Q8KPtLpbdVOOgwlp15c9L
         x0Wk5ln+C4+tKxap8mIjznPpBYKlWkJGoTK+mNtnxAxp5rSeVi9T0OvULp923AVh+E9C
         cDpRv7U8jCexNMGKdUdBbchQ96kXGzxL9fxF11mk7uc/yUQd9KMAhpfHClz+qRevvQyV
         4AzLTxjqlnkcFG/C2J/Eiki8cdPF2cYCxigDv9yKvm1j2zVSe9ZvWIDEyrKviA709xq+
         1Vxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=4TL7rU67dcCsld58oJYx+NVlFE0fH5IBsAjLGvpEK3U=;
        fh=HUSiElBfE43Q1SZc0Gr4sTODONgkoCBG4IOLxo4p8WQ=;
        b=LttGsBOXyRhgkIcC9ejfxYq1hfc7S8GJ79NY4OYSdT/dGr4ALvB/6qg6biEv+z3RtL
         IzhS7ie05MkunIroxYHmCfpUQpY5XLRUqGaclA9Qv9tlDHmnZHMvZzclASjUdFhaEUx7
         K8UXFanxLqUnE/iInZbjGUeX9XLty5HclUEuUQuSuh3hhKLtXxlNV/uSZgCBwj5dLCiw
         ZaqgN48zKz4axD5vTL1tQCvWON8j2qr4nJcEHHrXKBOYE5jSeHQL0J65J3j0tC2KDODA
         f3HL8Qae8+OZ1y7Fnen6CA2qPIuRaa2Cj7xEO8CXiduK1DmFcU9Tzobob8bKKcVRZ84D
         IQ6w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794801188; x=1795405988; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=4TL7rU67dcCsld58oJYx+NVlFE0fH5IBsAjLGvpEK3U=;
        b=GlzZcYad9U2QnRZPbzhrgqtyZrXsxohqUj/SM0uSbG1TpsUABZ5fJPAYjVegWFbAIp
         +8qwgSPtsBd3piM4aZXoo0K68A1rwmhwqPripIdONynDYwTCrgGI93lPrOH0zm5BEU7g
         b4O5CYPelNA5FDBudn6KbWt29SuVgkavIogy5/uwGa68mJ7jVOa03pgEB/DXETu1ag9i
         mat2ly6GJ32hGzwZH/7mFTMcskfoFbHbrDlwnGAJCuDw+v0f+Aei/GDfSJmOY0v/qj34
         bUz+R2+4f6f5s8nx3RbDtVV6z20QuGY0EzMpFO3Gs0XvgtHlKEG+pg/Epdw5mEomaYUj
         H6dQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794801188; x=1795405988;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=4TL7rU67dcCsld58oJYx+NVlFE0fH5IBsAjLGvpEK3U=;
        b=Oovym3hhJWe6hFNqEjcqk3SZkkC+vRP63XDEBfWQC00c7/iyTYcByG2TeBVXXjRZzF
         l3jux+UCP5BJ1z4AfUhPbCkt4qcz90i1iTj8aQT48OLPMu03eyJUEmCM5lyI/cnQN+rL
         VO9ppFJ2MJKPa1s8QK6thwnq5WfZXGc8RN1iizKcBUMwE8eZmtK2LTQB7FZGmBM0y/DF
         2QFOHkjmSCvteQhaoMuQKQXhwElq/ogC+Iz5a2hkrCe4GObw0C5YkvmMuNx4eNHTRxd/
         FZ/u4nqwXETz34uTO0WyrP8E3vtWw5o4Itfb79mfrfKpRXolQJm0KbK5+Ww1l37D7NWu
         kC6A==
X-Forwarded-Encrypted: i=1; AL+hErEnvHt5zKJq2Grjlu9LXzBdlXlkk5NRE791vceKEUBzGVSRDJ45cne4c4ox4/no0R1BTVrEpRstjxVeStnJqZ4=@vger.kernel.org
X-Gm-Message-State: APuU4Z+S5HpkAA20asrGOKW1yTeoN1UVx0t3ezeD6CxLE8aZtN8eP3Y+
	LegAekjFWUIf7sEIySWjRIzlHjDNaj+f7m5k34zbX5DqAwUJKJjb8u4hHaXEFm08fakhrgr7e6d
	uFH5XTPkRYjqsD9LHhlZVyrq9fQ2Ezh+GYWZh4E4=
X-Gm-Gg: AYBFou1QsdoiR+89s5KTmg3MLF0H88yELtprBcLRT43839ZO8icnnY5FHI1DE3OhuSb
	WZKiP9DybnpMWYmwZzVpjDnXzz3Bs9bGsvgNpoe8bOBEz3HFPL7EI2W4LlcJEP4K7kl2/pwEHql
	3hg+++qUie9u3jaMBGxvFgsnfyshWm8v9WHgMTGo8knwjJfMNIywiPsGxkW0ahabLFZeSRLYIIe
	74gOsJsA/IXCIHVA/e2YUfJVy8Qhbx9FVlThtPnyo9/A9e5IabSoDeN9Lmte4LK7+zKvFMbwSC7
	QqWZLo/ecolb4/juJpbMIXkgiAMaiy1JZ2k2V4R8G4napTtlu45TwYnsAV3E0fmPEKqOne/WmKw
	0N8v0eZUDSvzIzbdTA6Pw04/ohJe9csO7fZqFDAJK6BMhtEXsBa/qBT++NjUzkB8PqM+/+Q==
X-Received: by 2002:aa7:d94d:0:b0:6b6:ef7f:600d with SMTP id
 4fb4d7f45d1cf-6b7c0bdfeb9mr4989199a12.21.1794801187760; Sun, 15 Nov 2026
 19:53:07 -0800 (PST)
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Post: <mailto:linux-hardening@vger.kernel.org>
List-Help: <mailto:linux-hardening+help@vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-hardening+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <cover.1794666741.git.lianux.mm@gmail.com>
In-Reply-To: <cover.1794666741.git.lianux.mm@gmail.com>
From: Kairui Song <ryncsn@gmail.com>
Date: Mon, 16 Nov 2026 11:52:30 +0800
X-Gm-Features: AclHuK-rF5dWOJJFyqz4l7zmtSSFEl92bKNMjIKJVssyOdhF23YiFc9B9U-bN9Y
Message-ID: <CAMgjq7Cq5OQWdompBbEpyJTG3PhtdSLFUdb_Dtht3qH+u5HVhw@mail.gmail.com>
Subject: Re: [RFC PATCH v4 00/18] mm/swap: introduce priority queues for swap
 device allocation
To: Lian Wang <lianux.mm@gmail.com>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	Andrew Morton <akpm@linux-foundation.org>, Chris Li <chrisl@kernel.org>, 
	Nhat Pham <nphamcs@gmail.com>, Baoquan He <baoquan.he@linux.dev>, Barry Song <baohua@kernel.org>, 
	Youngjun Park <youngjun.park@lge.com>, Kemeng Shi <shikemeng@huaweicloud.com>, 
	Jihan LIN <linjh22s@gmail.com>, Kunwu Chan <kunwu.chan@linux.dev>, Kees Cook <kees@kernel.org>, 
	"Gustavo A. R. Silva" <gustavoars@kernel.org>, Thomas Gleixner <tglx@kernel.org>, linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Nov 14, 2026 at 10:48=E2=80=AFPM Lian Wang <lianux.mm@gmail.com> wr=
ote:
>
> Hi all,
>
> This is v4 of Kairui's swap priority queue RFC [1, 2], retaining the
> original authorship. It separates device selection from device-local
> cluster allocation to support integration with the ongoing swap tier
> work, while preserving existing swap priorities, the swapon interface,
> and memcg swap accounting and limits.
>
> The global per-CPU cluster cache couples device choice to cluster
> locality. Moving that cache below device selection gives each device its
> own allocation hints. The available plist's shared rotation is then
> replaced by a priority-ordered array of same-priority device rings, with
> per-CPU starting offsets and quotas. A task-local cursor keeps each retry
> walk stable. Rotational devices retain per-device sequential hints shared
> across CPUs.
>
> This remains an RFC. The current scope is global device selection under
> existing priorities; no tier ABI or per-memcg device-selection control
> is introduced.
>
> The series is organized as follows:
>
>   01-04: Parameter/error-path cleanup, device-state boundaries and
>          iteration helpers.
>   05-07: Locking, writer-serialized publication and accounting.
>   08:    Restore per-device per-CPU cluster locality.
>   09:    Keep cluster metadata population out of direct reclaim.
>   10-11: Introduce the safely published queue and remove the avail plist.
>   12:    Bound order-0 synchronous discard outside the allocation reader.
>   13-14: Preserve priority-aware throttle selection while removing the
>          active plist and unused plist_requeue API.
>   15-18: Reuse reader capacity, advance cursors directly, bypass singleto=
n
>          rotation and redistribute reader phases on membership changes.
>
> Changes in v4
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> The device-disable and discard paths have been revised following the
> review of v3 [4], including Sashiko feedback [5, 6]:
>
> - Complete writable/off-list/availability transitions before releasing
>   the management lock or topology writer, including intermediate patches.
> - Run bounded order-0 synchronous discard outside the allocation reader,
>   holding a live device reference across I/O, then restart selection with
>   a fresh cursor.
> - Handle discard queued by late reclaim scans, with at most one
>   synchronous cluster discard per swap type for each order-0 request.
>   Preserve large-folio same-priority retry and split handling without
>   foreground synchronous discard.

Thanks for the updates!

>
> Rebase
> =3D=3D=3D=3D=3D=3D
> The series is now based on mm-unstable 24231596edf2 (7.4-rc1).
> The base includes 53a6f71c147a ("mm, swap: stop cluster list scans once
> swapoff clears SWP_WRITEOK"), so the former standalone scan fix is no
> longer required as a prerequisite. Its si->lock serialization of
> WRITEOK changes is preserved.
>
> The metadata allocation paths have been adapted to the upstream
> allocator-lock reacquisition and publish-after-revalidation contract,
> including -EAGAIN handling and the tableless-cluster relocation guard.
> The upstream free-cluster preference and hibernation-slot semantics
> are retained.
>
> Test results
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> The tests compare the unpatched baseline 24231596edf2 with the same
> baseline plus all 18 patches, fbb87083afcc, on the same x86-64 host.
> The kernel configurations differ only in LOCALVERSION.
>
> The kernel-build tests follow the v1 workload: eight 8-GiB ZRAM devices,
> make -j96, and 12 fresh-output builds per revision in each of the 2-GiB
> and 3-GiB memcgs. Both revisions built the same workload source
> (4dbe24720eb3), using x86 defconfig, bzImage/modules and a fixed toolchai=
n.
>
> The BRD case used twelve 8-GiB devices and a memcg with 24 GiB of memory,
> 64 GiB of swap allowance and memory.zswap.max=3D0:
>
>   usemem --init-time -O -y -x -n 32 1536M
>
> There was one complete BRD invocation per revision. The BRD capacity and
> memcg limit are host adaptations; v1 did not specify those parameters.
>
> Mean system CPU time, seconds:
>
>                          n/arm       Before    Queue (v4)     change
>   kbuild, 2-GiB             12     4372.4983    4417.2192     +1.02%
>   kbuild, 3-GiB             12     2314.6025    2322.6550     +0.35%
>   12-BRD                     1      143.5700     137.9900     -3.89%

Nice, but what does n/arm mean?

>
> Mean elapsed time, seconds:
>
>                          n/arm       Before    Queue (v4)     change
>   kbuild, 2-GiB             12      168.8092     169.1100     +0.18%
>   kbuild, 3-GiB             12      136.0650     136.3500     +0.21%
>   12-BRD                     1        6.6500       6.5100     -2.11%
>
> For the BRD invocation, mapped throughput was 7391.28 -> 7550.23 MiB/s
> (+2.15%), calculated as the requested 48 GiB divided by elapsed time,
> not as a sum of worker rates.
>
> All 50 invocations completed successfully, reported no memcg OOM events
> and performed swap I/O. There were no warm-ups or profiling, and all
> samples are included. Before ran first on a separate boot; the 12 builds
> are within-boot repeats, and the 32 BRD workers are one invocation.
>
> The kernel-build runs show small increases in system CPU and elapsed
> time. These descriptive results do not establish equivalence, absence
> of regressions or a stable performance gain.

It's worth mentioning that the global cluster cache is gone, so tiered
allocation will have a much better performance.

>
> Cooperation with swap tiers
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D
> Device-local cluster hints remain below device selection, so a future
> tier policy can determine the eligible candidates before those hints
> are used.
>
> The current revision keeps the refactoring under the existing global
> swap priority model. Integration with Youngjun's tier infrastructure [3]
> remains follow-up work. Device membership, swapon/swapoff publication
> and lifetime should have one agreed authority. Within-tier priority
> semantics and reader scope need agreement with that work; this series
> does not define a competing tier or memcg policy.
>
> Youngjun and Chris, I would appreciate your feedback on the integration
> boundary and ordering.

It seems the sashiko review is all green, which is great, let's hear
what the others think about this.
