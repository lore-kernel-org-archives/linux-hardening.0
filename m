Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=91.218.175.175
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795149101;
	b=g/ipYVXnJ3TBOIofhQ+hSU+NICX4E0eN1AhPvw+iT70BC2AxvkiC7kh5oeI+NbRzlHgS
	 fCvL0ubCY0Z2bhNu1GcJri9BZMuZh2Z1sftqeSG827eqkvIMS31AkLXJr2gCETM/9gWsT
	 lLofS96K7JwjYRmFPz9mUHsXfjLD3YpeDm8sRGfM3TIN3zOeirzKNKF/eXjVEAlyqAttE
	 zpjH2q7xfyYnXd9Ulflong7MYtrUMVQcwF/y1n/M/zvUskSrj6g+yNV2PMMrETCg8BOad
	 rElELTg6pq9oIBzdiw3viC1BFgd+MYR/YNsn63VFbsDxl7KYH1IQ4kzCenYl9Zxp02w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795149101;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:MIME-Version:Date:Content-Type:
	 Content-Transfer-Encoding:From:Message-ID:TLS-Required:Subject:To:Cc:
	 In-Reply-To:References;
	bh=n2iV8ZgTwYQrd03h4K8/zYSLB89pwsCsAcFgWAxm3fg=;
	b=In7rBTqdw5vlKFwj72esulZMi5YemYMhV1LpI+kExLLa/N9ww89+rQomvgG+ZGh+XoHV
	 Jspp2PtL2zubkuOTmbG+IGzX6PkgN60NJp5e1541yuDypb+N3wp1f1N7LTrA2/cZVu+jD
	 l7eSxi03PE4Q5LKMElc9T/WOxwIQVPSxxNGimHIQeN0NLz++g3oLb/wjlQxxvX2PzBL13
	 nXfdJXe1P2CXVGXNY22LqFhL0efjZ67Uix+zzTsnd/cnYKbRgnActT6J9GO2qCkShEpQa
	 sl3M7ABlP+QObdXOgCMdZ5rSpyMdgnrdV1XfOG6yYJJHeW3fYmgxfdl4+5cAqeo5jVw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=gtNrT3EC;
	arc=none smtp.remote-ip=91.218.175.175
Received: from mta0.migadu.com (out-175.mta0.migadu.com [91.218.175.175])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F50B606A326
	for <linux-hardening@vger.kernel.org>; Fri, 20 Nov 2026 04:31:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5F50B606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=gtNrT3EC
X-Envelope-To: linux-hardening@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=1NiiVip/IU0AhZJGu+tv3Ejl1IrHJ+s9jKpO+x/649s=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1795149098; v=1; x=1795753898;
 b=gtNrT3ECKcBVjHQc7VpSjj3d/h9Bbr9V5CepW3aAlYM5lSsm/b7d2yI1zNWPPttRTq/2NYZU
 9QDuMlOOIc4wW+cINVpqPzvfZLhv9k+QxsZw4aMHhOVGFsohyY6EsyJDBZQ6AX83axPq7QBwp8G
 2dkc7nszuOwckvi2efsXZEW4=
X-Envelope-To: linux-hardening@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id f904e1aeb506fb66;
	Fri, 20 Nov 2026 04:31:38 +0000
X-Mizu-Trace-ID: f904e1aeb506fb66
X-Migadu-Flow: FLOW_OUT
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Post: <mailto:linux-hardening@vger.kernel.org>
List-Help: <mailto:linux-hardening+help@vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-hardening+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Date: Fri, 20 Nov 2026 04:31:33 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
From: "Kunwu Chan" <kunwu.chan@linux.dev>
Message-ID: <b4a389b8d71b5e0fd9eb56af50f4bf6dce245532@linux.dev>
TLS-Required: No
Subject: Re: [RFC PATCH v4 09/18] mm/swap: avoid direct reclaim when
 populating swap cluster metadata
To: "Lian Wang" <lianux.mm@gmail.com>, linux-mm@kvack.org
Cc: linux-kernel@vger.kernel.org, "Andrew Morton"
 <akpm@linux-foundation.org>, "Chris Li" <chrisl@kernel.org>, "Nhat Pham"
 <nphamcs@gmail.com>, "Baoquan He" <baoquan.he@linux.dev>, "Barry Song"
 <baohua@kernel.org>, "Youngjun Park" <youngjun.park@lge.com>, "Kemeng
 Shi" <shikemeng@huaweicloud.com>, "Kairui Song" <kasong@tencent.com>,
 "Jihan LIN" <linjh22s@gmail.com>, "Kees Cook" <kees@kernel.org>, "Gustavo
 A. R. Silva" <gustavoars@kernel.org>, "Thomas Gleixner"
 <tglx@kernel.org>, linux-hardening@vger.kernel.org
In-Reply-To: <88057ceeb0228fd33f42637a3c9647eea74d5d95.1794666741.git.lianux.mm@gmail.com>
References: <cover.1794666741.git.lianux.mm@gmail.com>
 <88057ceeb0228fd33f42637a3c9647eea74d5d95.1794666741.git.lianux.mm@gmail.com>

Reviewed-by: Kunwu Chan <kunwu.chan@gmail.com>

Thanks,
Kunwu

>=20
>=20Swap cluster population is entered from swap allocation and may itsel=
f
> need memory for slot metadata. Its fallback drops the device and cluste=
r
> locks before allocating with GFP_KERNEL, which can reenter swap
> allocation through direct reclaim.
>=20
>=20Make this allocation boundary explicitly non-reclaiming so callers ca=
n
> retain outer synchronization without a recursive swap allocation.
> Clear __GFP_DIRECT_RECLAIM from the fallback request while retaining
> __GFP_HIGH and __GFP_NOMEMALLOC. The retry can still wake kswapd, but
> fails without direct reclaim when memory is unavailable.
>=20
>=20This can make metadata allocation fail earlier under memory pressure.
> Keep the existing isolated-cluster rollback and restrict this request
> without adding a task-wide PF_MEMALLOC scope.
>=20
>=20Signed-off-by: Lian Wang <lianux.mm@gmail.com>
> ---
>  mm/swapfile.c | 23 +++++++++++++----------
>  1 file changed, 13 insertions(+), 10 deletions(-)
>=20
>=20diff --git a/mm/swapfile.c b/mm/swapfile.c
> index c46b43414bf4..fae862fc873c 100644
> --- a/mm/swapfile.c
> +++ b/mm/swapfile.c
> @@ -586,13 +586,14 @@ static void swap_cluster_assert_empty(struct swap=
_cluster_info *ci,
>  }
>=20=20
>=20 /*
> - * Allocate swap table for one cluster. Attempt an atomic allocation f=
irst,
> - * then fallback to sleeping allocation.
> + * Allocate swap table for one cluster. Attempt allocation under the l=
ocks
> + * first, then retry with the locks dropped without entering direct re=
claim.
>  */
>  static struct swap_cluster_info *
>  swap_cluster_populate(struct swap_info_struct *si,
>  struct swap_cluster_info *ci)
>  {
> + gfp_t gfp;
>  int ret;
>=20=20
>=20 /*
> @@ -610,9 +611,11 @@ swap_cluster_populate(struct swap_info_struct *si,
>  return ci;
>=20=20
>=20 /*
> - * Try a sleep allocation. Each isolated free cluster may cause
> - * a sleep allocation, but there is a limited number of them, so
> - * the potential recursive allocation is limited.
> + * Drop the device and cluster locks before retrying. Metadata allocat=
ion
> + * must not recurse into swap allocation through direct reclaim: calle=
rs
> + * can retain outer synchronization across cluster population. Restric=
t
> + * this request instead of granting the task PF_MEMALLOC, which could
> + * give allocator hooks and failure cleanup reserve access.
>  */
>  spin_unlock(&ci->lock);
>  if (si->flags & SWP_SOLIDSTATE)
> @@ -620,8 +623,9 @@ swap_cluster_populate(struct swap_info_struct *si,
>  else
>  spin_unlock(&si->global_cluster->lock);
>=20=20
>=20- ret =3D swap_cluster_alloc_table(si, ci, __GFP_HIGH | __GFP_NOMEMAL=
LOC |
> - GFP_KERNEL, false);
> + gfp =3D (GFP_KERNEL | __GFP_HIGH | __GFP_NOMEMALLOC) &
> + ~__GFP_DIRECT_RECLAIM;
> + ret =3D swap_cluster_alloc_table(si, ci, gfp, false);
>=20=20
>=20 /*
>  * Back to atomic context. We might have migrated to a new CPU with a
> @@ -3160,9 +3164,8 @@ static int swap_device_disable(struct address_spa=
ce *mapping,
>  return err;
>=20=20
>=20 /*
> - * The swap allocator doesn't take swapon_rwsem. Looping through every
> - * cluster lock after clearing SWP_WRITEOK ensures that allocators see
> - * the updated flag and that no allocation remains in flight.
> + * Drain cluster-lock users after clearing SWP_WRITEOK, so swapoff
> + * does not race with operations that started before the transition.
>  */
>  for (offset =3D 0; offset < end; offset +=3D SWAPFILE_CLUSTER) {
>  ci =3D swap_cluster_lock(si, offset);
>
