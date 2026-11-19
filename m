Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=95.215.58.146
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795103782;
	b=iKIF01gzceE5BiRhh3iAhV+Cz3YdEb03WIFfZXP9vaxkw/J+3SZF1y6C9AJHfTzuM7oL
	 bb/Fp69ZOUEggmC3BXogyLl/Pnw+WjZtWgCpYvEJSOfK4uKHVTtdpNGK3AOI0ghES/3cU
	 NIbaRqptG3AfxtZdK0rQz7518hh4qerAA+JO4CCiJKUiLZ0Qca461cqkQBQMvnGXAwy0p
	 Mbdt7LeuzCjmhoHBYR03UpVfiEj0VyKKhOY5cCFWsAG4LdohRd5Gh0kuksQyr94MMuR20
	 mSI0ghMYvsQ3tVR+2CM5Jql6CQ18KkgxiHvhmWQkpO16A30Pq+8WqMhCZ88BC/YAtwQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795103782;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:MIME-Version:Date:Content-Type:
	 Content-Transfer-Encoding:From:Message-ID:TLS-Required:Subject:To:Cc:
	 In-Reply-To:References;
	bh=n+k74e9867nRhb8ulyLRle75AgKH2rav4a8VKiRxz7g=;
	b=3Fa85cnGfllCJJ3eLpZSafo0q2Qfn3RyPcGhEnSZTJTu1bJ6n1QU5I6TB/64rV6WXiuH
	 RKVyBCAscKByoOFaRLy+4eQivAHKpvRQ1pni0OAO/TNaBWLYe1F3JP25qK9Gq91/Jz2CF
	 euZUoxdEV+DKVKMf0hnUJPz4IvVjOUM/935Ka7eh3Dj88H8JUNtKmMXq/NxNSrG3AnkDY
	 ZHP5p6k8Wpeat5vKpXe4/DpIWec6/ntbhiLBUmMTjtXbVqWGagF5d3Ldq0AMP1E4VyHsv
	 9wMzr6aCUQIFxW2K+x3b/DtzXikfkkIdIf6Z6o5846gqYc7wGSbFRViGzWHAGY3gMIA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=klsxY4PJ;
	arc=none smtp.remote-ip=95.215.58.146
Received: from mta1.migadu.com (out-146.mta1.migadu.com [95.215.58.146])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E91E606A324
	for <linux-hardening@vger.kernel.org>; Thu, 19 Nov 2026 15:56:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1E91E606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=klsxY4PJ
X-Envelope-To: linux-hardening@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=ccsxT6du60e05bc+5yqFYQ0nZGJ4mi0+0AzsLneGKZo=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1795103780; v=1; x=1795708580;
 b=klsxY4PJMl4Ikgo+XQKCm7RtgIevP/q/v5kRoZWFqtjJ092Y0vbMrBbA4cCeHgEKgUd9+Co0
 gn/CVJdvsGwuro+UMNi/q5MOuM8fZtlc5G9qjm2CclVAVNTd+IbEtXxN5xDT1EMSJ8GbFB+TIVu
 E3LrltzHOAK3lrK3ZXJABywA=
X-Envelope-To: linux-hardening@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 4a01da6eccbc7804;
	Thu, 19 Nov 2026 15:56:20 +0000
X-Mizu-Trace-ID: 4a01da6eccbc7804
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
Date: Thu, 19 Nov 2026 15:56:19 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
From: "Kunwu Chan" <kunwu.chan@linux.dev>
Message-ID: <6e04aec6ca71cd754ace7ccae8284edb472b6528@linux.dev>
TLS-Required: No
Subject: Re: [RFC PATCH v4 01/18] mm/swap: remove unused parameter for
 reading swap header
To: "Lian Wang" <lianux.mm@gmail.com>, linux-mm@kvack.org
Cc: linux-kernel@vger.kernel.org, "Andrew Morton"
 <akpm@linux-foundation.org>, "Chris Li" <chrisl@kernel.org>, "Nhat Pham"
 <nphamcs@gmail.com>, "Baoquan He" <baoquan.he@linux.dev>, "Barry Song"
 <baohua@kernel.org>, "Youngjun Park" <youngjun.park@lge.com>, "Kemeng
 Shi" <shikemeng@huaweicloud.com>, "Kairui Song" <kasong@tencent.com>,
 "Jihan LIN" <linjh22s@gmail.com>, "Kees Cook" <kees@kernel.org>, "Gustavo
 A. R. Silva" <gustavoars@kernel.org>, "Thomas Gleixner"
 <tglx@kernel.org>, linux-hardening@vger.kernel.org
In-Reply-To: <f42af36d7ec66fb36fb7024966f4a7114f338a77.1794666741.git.lianux.mm@gmail.com>
References: <cover.1794666741.git.lianux.mm@gmail.com>
 <f42af36d7ec66fb36fb7024966f4a7114f338a77.1794666741.git.lianux.mm@gmail.com>

>=20
>=20From: Kairui Song <kasong@tencent.com>
>=20
>=20The swap_info_struct argument to read_swap_header() is unused. Remove=
 it
> and update the swapon() call site.
>=20
>=20No functional change.
>=20
>=20Signed-off-by: Kairui Song <kasong@tencent.com>
> Signed-off-by: Lian Wang <lianux.mm@gmail.com>
> ---
>  mm/swapfile.c | 7 +++----
>  1 file changed, 3 insertions(+), 4 deletions(-)
>=20
>=20diff --git a/mm/swapfile.c b/mm/swapfile.c
> index fcda5eba1714..c41c4d26a7e6 100644
> --- a/mm/swapfile.c
> +++ b/mm/swapfile.c
> @@ -3630,9 +3630,8 @@ __weak unsigned long arch_max_swapfile_size(void)
>  return generic_max_swapfile_size();
>  }
>=20=20
>=20-static unsigned long read_swap_header(struct swap_info_struct *si,
> - union swap_header *swap_header,
> - struct inode *inode)
> +static unsigned long read_swap_header(union swap_header *swap_header,
> + struct inode *inode)
>  {
>  int i;
>  unsigned long maxpages;
> @@ -3863,7 +3862,7 @@ SYSCALL_DEFINE2(swapon, const char __user *, spec=
ialfile, int, swap_flags)
>  }
>  swap_header =3D kmap_local_folio(folio, 0);
>=20=20
>=20- maxpages =3D read_swap_header(si, swap_header, inode);
> + maxpages =3D read_swap_header(swap_header, inode);
>  if (unlikely(!maxpages)) {
>  error =3D -EINVAL;
>  goto bad_swap_unlock_inode;
>

Looks good, thanks!

Reviewed-by: Kunwu Chan <kunwu.chan@gmail.com>
