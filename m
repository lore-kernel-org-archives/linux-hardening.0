Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795672773;
	b=Cj3y/ltA7hstPyYk1kLsfGfWTX0/9Th5uiibYowW9FdRIJRDid5k2XLrMH3emYs/Acmt
	 ZeNp3qarRRO3dy+8bgO6YOo3vBY/YvFBCq/qRdjijo4Yg2ytVGAomaVOGrfmHCIQa9eWY
	 hijbl+/l2BlEsT8m+wka02QE0dxVNKYkLymHoqoMrxDDfcn15zBcQsV/zvqSjCoSCQHvG
	 ajoJdz20aXZfnf+E4UxqwgIf3QKrnUhwcYL7L/jwi0qBMRNADxzmSYOcN0rUcaeUPzi6Y
	 PxHnH9tUSaViSb9Pa3xOtcMgpmd8H7hIV7T7X8BrMkv8ituogcmw+6CFFt9Pi0j5WLQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795672773;
	h=Received:DKIM-Signature:Received:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Received:MIME-Version:References:In-Reply-To:
	 From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:Message-ID:
	 Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=VsisjEdAcEQoikyIb1phqdw1n0JZDLyJ/MLeqYyqG0E=;
	b=Q0agDEVC1wShpo3GqGADkaHn6QDIKNMW4XkvJMrPYDhvMtw3z0kPnGuYXyfAbckeIsG2
	 YoG96YGGUWrMkhx+GBxDXrPpDMRykAThCA2s/nIKnPe5hmhUI9sbn9IQ1Snabumw+id2i
	 RiCVz0/6M9epAK4xuLob0cg/UajQcW6LIX9dTfT8jpg+eHV44hpw0yYK6hR8x2Yq5RLU6
	 oryir9GN9jTsL1nOVT2mNENozoQdXpOrW+tkIEoX9nDsCxm22SfwR5FH5aGeR9+E6ATbp
	 RRYRBSoxaGp6G1ZsRNmJflnX2J5fmYSF5qUQji6vp0oUkChnQLYdj2JfvMZdtF5fWHw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jX5gf0s3;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97F1D606A31E
	for <linux-hardening@vger.kernel.org>; Thu, 26 Nov 2026 05:59:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jX5gf0s3
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B734A1F000D3
	for <linux-hardening@vger.kernel.org>; Thu, 26 Nov 2026 05:59:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795672772;
	bh=VsisjEdAcEQoikyIb1phqdw1n0JZDLyJ/MLeqYyqG0E=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=jX5gf0s3CFTwpoga7V0Jihxldl3viYJ63kjPyV3ognxDwWErcdcRKbm3bvkVNtBU2
	 /gBef46Y9q6v5yjRZPQ5ERn7s96pnEvbPHj/hsqaTrZDKdlNtjs/gOGFRJorIPII/H
	 bDslLOelA2fmLqD+NzeCFSf8kKgIx6SCvT2EoImDnO8WdBVabWYTR6y2F6VyiiEzEG
	 wealsmoaZV/QngF7f+H4i4hMppmO1Rh2P8k0w1RBuuNxkQUc3JY6P68T4ZFZeXYM5s
	 xmYP6BvFaraGVv3bDpSb8IAuF9frERxVKFq2lXAXG8hrQVNDyqe3GCwOhmIOvfFLV4
	 6eJDSJLvk/EgA==
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-c515319dd89so187663266b.1
        for <linux-hardening@vger.kernel.org>; Wed, 25 Nov 2026 21:59:32 -0800 (PST)
X-Forwarded-Encrypted: i=1; AL+hErFHy9g8Zl41+3A7J7r1AEc0dhTd+i7YmHVRe2omdbkQ5ThMttyLGvj8sdg9fh6f4nZmcsZL5sc9bpakt9eAe+s=@vger.kernel.org
X-Gm-Message-State: APuU4Z+D04DuC/ohv3IDMKcwa3cFmqeDBCn/m42L6l8zcUS1QcXq7yOG
	1R532J2wSzVEOiSCbc2xzt9k5FtLUuciccEYFPxigSwq10lgQKGGHUFz7J0gX96J108mdvEOPV3
	qOwU9/cx+mq+31HNK1qAOUNeotPR4RFzRVi8xLCVBBw==
X-Received: by 2002:a17:906:da0e:b0:c46:a72:e0c3 with SMTP id
 a640c23a62f3a-c513a84dd04mr1356707266b.16.1795672771599; Wed, 25 Nov 2026
 21:59:31 -0800 (PST)
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Post: <mailto:linux-hardening@vger.kernel.org>
List-Help: <mailto:linux-hardening+help@vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-hardening+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <cover.1795439990.git.lianux.mm@gmail.com> <3e8d55101602d5ec982ae636eaf5eb4dcaad3ba8.1795439990.git.lianux.mm@gmail.com>
In-Reply-To: <3e8d55101602d5ec982ae636eaf5eb4dcaad3ba8.1795439990.git.lianux.mm@gmail.com>
From: Chris Li <chrisl@kernel.org>
Date: Wed, 25 Nov 2026 21:59:19 -0800
X-Gmail-Original-Message-ID: <CACePvbWzE6AvbLzNFe=J5Vid8iy6FFQh0RBgr+V_jJJ4p=OEVw@mail.gmail.com>
X-Gm-Features: Aa3M54oIbvTBzc16n1b5zBCTLN35erJwZkNIaRd8dYijTduchcrgfU7gWLxR6Vs
Message-ID: <CACePvbWzE6AvbLzNFe=J5Vid8iy6FFQh0RBgr+V_jJJ4p=OEVw@mail.gmail.com>
Subject: Re: [PATCH v5 02/19] mm/swap: clean up hibernation error handling
To: Lian Wang <lianux.mm@gmail.com>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	Andrew Morton <akpm@linux-foundation.org>, Nhat Pham <nphamcs@gmail.com>, 
	Baoquan He <baoquan.he@linux.dev>, Barry Song <baohua@kernel.org>, 
	Youngjun Park <youngjun.park@lge.com>, Kemeng Shi <shikemeng@huaweicloud.com>, 
	Kairui Song <kasong@tencent.com>, Jihan LIN <linjh22s@gmail.com>, 
	Kunwu Chan <kunwu.chan@linux.dev>, Kees Cook <kees@kernel.org>, 
	"Gustavo A. R. Silva" <gustavoars@kernel.org>, Thomas Gleixner <tglx@kernel.org>, linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 23, 2026 at 6:16=E2=80=AFAM Lian Wang <lianux.mm@gmail.com> wro=
te:
>
> From: Kairui Song <kasong@tencent.com>
>
> Restructure the error paths in pin_hibernation_swap_type() using a
> goto out pattern to avoid repeated spin_unlock() calls and simplify
> the return flow.  Also simplify unpin_hibernation_swap_type() by
> making the si NULL check inline, and clean up find_first_swap() to
> avoid an early return inside the loop.
>
> Signed-off-by: Kairui Song <kasong@tencent.com>
> Reviewed-by: Kunwu Chan <kunwu.chan@gmail.com>
> Signed-off-by: Lian Wang <lianux.mm@gmail.com>

Acked-by: Chris Li <chrisl@kernel.org>

> ---
>  mm/swapfile.c | 39 +++++++++++++++++----------------------
>  1 file changed, 17 insertions(+), 22 deletions(-)
>
> diff --git a/mm/swapfile.c b/mm/swapfile.c
> index c06f9f532e74..0ae901296731 100644
> --- a/mm/swapfile.c
> +++ b/mm/swapfile.c
> @@ -2331,21 +2331,18 @@ static int __find_hibernation_swap_type(dev_t dev=
ice, sector_t offset)
>   */
>  int pin_hibernation_swap_type(dev_t device, sector_t offset)
>  {
> -       int type;
> +       int ret;

Nitpick: Here "ret" only carries error code. Maybe we can call it "err".

>         struct swap_info_struct *si;
>
>         spin_lock(&swap_lock);
> +       ret =3D __find_hibernation_swap_type(device, offset);
> +       if (ret < 0)
> +               goto out;
>
> -       type =3D __find_hibernation_swap_type(device, offset);
> -       if (type < 0) {
> -               spin_unlock(&swap_lock);
> -               return type;
> -       }
> -
> -       si =3D swap_type_to_info(type);
> +       si =3D swap_type_to_info(ret);
>         if (WARN_ON_ONCE(!si)) {
> -               spin_unlock(&swap_lock);
> -               return -ENODEV;
> +               ret =3D -ENODEV;
> +               goto out;
>         }
>
>         /*
> @@ -2354,14 +2351,15 @@ int pin_hibernation_swap_type(dev_t device, secto=
r_t offset)
>          * the same session.
>          */
>         if (WARN_ON_ONCE(si->flags & SWP_HIBERNATION)) {
> -               spin_unlock(&swap_lock);
> -               return -EBUSY;
> +               ret =3D -EBUSY;
> +               goto out;
>         }
>
>         si->flags |=3D SWP_HIBERNATION;
>
> +out:
Nitpick: Maybe "unlock"?

Chris

>         spin_unlock(&swap_lock);
> -       return type;
> +       return ret;
>  }
>
>  /**
> @@ -2441,11 +2439,8 @@ void unpin_hibernation_swap_type(int type)
>
>         spin_lock(&swap_lock);
>         si =3D swap_type_to_info(type);
> -       if (!si) {
> -               spin_unlock(&swap_lock);
> -               return;
> -       }
> -       si->flags &=3D ~SWP_HIBERNATION;
> +       if (si)
> +               si->flags &=3D ~SWP_HIBERNATION;
>         spin_unlock(&swap_lock);
>  }
>
> @@ -2480,7 +2475,7 @@ int find_hibernation_swap_type(dev_t device, sector=
_t offset)
>
>  int find_first_swap(dev_t *device)
>  {
> -       int type;
> +       int type, ret =3D -ENODEV;
>
>         spin_lock(&swap_lock);
>         for (type =3D 0; type < nr_swapfiles; type++) {
> @@ -2489,11 +2484,11 @@ int find_first_swap(dev_t *device)
>                 if (!(sis->flags & SWP_WRITEOK))
>                         continue;
>                 *device =3D sis->bdev->bd_dev;
> -               spin_unlock(&swap_lock);
> -               return type;
> +               ret =3D type;
> +               break;
>         }
>         spin_unlock(&swap_lock);
> -       return -ENODEV;
> +       return ret;
>  }
>
>  /*
