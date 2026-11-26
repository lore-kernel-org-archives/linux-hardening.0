Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795723776;
	b=zBdVCuNpMG4MS/fcBDjauBeFWw9UY65nqkdVpFjq0Iw6f0OfohcdWUvMQiduRjoVN50t
	 oqIl8EyhiTgKSgg4v9yd8huBlyuCc+61WCOwl87h0LjifjggeqOdKjy8gM2T/TZM/sDnz
	 3EoUHwGIo4OfbXJztXldNHkKoi9NyaFkTcOhexUtoCAeSaXJ/qUs5hbrO4w8abdPEFNp/
	 dY+zTdz5UWT2A3Iarrn7B+OWBurHcZWf+6gxg+qYtMZ2EsV3CIL4fB27UyRD7y8m3+25N
	 RBfjk/YPgMl7UBVPkx6iSUOt+6cPSIdePmazy5Bwgv2mb2QyXXaWxQjlVGs9WJrNS1g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795723776;
	h=Received:DKIM-Signature:Received:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Received:MIME-Version:References:In-Reply-To:
	 From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:Message-ID:
	 Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=QhqV5yNTeb/bGSfEg8Z4WR9+47g1ctbrNRf+rLB0iJI=;
	b=dJnu2SeAbeMcMCFDH5Nb2fUKe75VRHJu1ZhH7nI87QeKr3Q4uRciaAD3sFPoNYasX0+S
	 wybPRDJIuyceur90gqFQtbzjAJoOkC8BJDaRo29wBsVDrbqozVaD0nztubYi9jnPHRWth
	 Qwv6vq15vl8PaQDn90x76yVRb5cnoNV1qlCR5IttW2OozpHSOTiNOC3zntqu0F6OlTfNg
	 08zs/m6OKPBFkPkzr/DBRnGlXvAw/AvyRTIBVpDrW1I4N/Itakciirq+6P5EcKfxDQAho
	 XizQUSDvfRSEFQYB7h7yDb4qf0B0unNIL+GJPIxZXGZVKzTrfTpiRTM3rbgd7KWK0xA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=lV8hE1XL;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31514606A31C
	for <linux-hardening@vger.kernel.org>; Thu, 26 Nov 2026 20:09:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=lV8hE1XL
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A8B521F000CA
	for <linux-hardening@vger.kernel.org>; Thu, 26 Nov 2026 20:09:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795723775;
	bh=QhqV5yNTeb/bGSfEg8Z4WR9+47g1ctbrNRf+rLB0iJI=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=lV8hE1XLfBuin3LiFGTjhaTowSIa2OI3cPxF+o+uzy6D80GJI2/E3K0FcV8BjOLXJ
	 WqXD9UrZb5CcqDxSKDrXvaOgbsgGOzqaiO0gbCD65XR/0M9IzRhzvC7FpwXMs7jbTh
	 NZTtqpTcYjrS+VObwY8O88I+2iz54j6fdCujBLvGol8rbMwDjvcYyeWcVXa+Gv+uBU
	 KXzs8EL9E/WMevAtsPo63sKno2xnGrLs1kmZ2BuqAc7XPvJ7tl56ZuGl2vBapDZ1j9
	 idrmovlNezujhDZ5CrtQ4aP1DGY+xIh4R1ksf6PCYrTWpgCOJOSog8Yi6BoapF9OV+
	 ALvD3cXI+LPmg==
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-6b596afb4c5so8660233a12.1
        for <linux-hardening@vger.kernel.org>; Thu, 26 Nov 2026 12:09:35 -0800 (PST)
X-Forwarded-Encrypted: i=1; AL+hErEs6f1PseribDQq8kDfgxSjkFu/lSCSr47h9XFvSD/nOg3oO1VIez7P3WRrPFD51C6r3EtWh+7atcZAXrCETJg=@vger.kernel.org
X-Gm-Message-State: APuU4Z9uEYCYVhO6vkQwW/gZjiFLy8mIGAf4R9G+mw4EGfFnntpVZKvk
	cZiJf8KKig8NJZHF1iy6z95w+OZ2YEOtG8zwUInsqR1Zh0DsmjXp7LB3c9+fjMbzxndYycP0njM
	DNTwuIptFvTWSre4F2CTzeT2WTxZ4zAhhMCFc4pCTBg==
X-Received: by 2002:a17:906:f8cf:b0:c50:bf14:8ec1 with SMTP id
 a640c23a62f3a-c513ab4d93emr1278198566b.33.1795723774577; Thu, 26 Nov 2026
 12:09:34 -0800 (PST)
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Post: <mailto:linux-hardening@vger.kernel.org>
List-Help: <mailto:linux-hardening+help@vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-hardening+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <cover.1795439990.git.lianux.mm@gmail.com> <0d61898075921b05c626accfa34a60e16472b556.1795439990.git.lianux.mm@gmail.com>
In-Reply-To: <0d61898075921b05c626accfa34a60e16472b556.1795439990.git.lianux.mm@gmail.com>
From: Chris Li <chrisl@kernel.org>
Date: Thu, 26 Nov 2026 12:09:23 -0800
X-Gmail-Original-Message-ID: <CACePvbWk-TK+VtiD_0ByM_pxXzyHhZiW=C0LB_mH2FtBXH99FQ@mail.gmail.com>
X-Gm-Features: Aa3M54rfv4QAGdHBq0QdP2ylbNXUTYqxGTt5VDMad8QSONEg4H11dzsHXoWD7_M
Message-ID: <CACePvbWk-TK+VtiD_0ByM_pxXzyHhZiW=C0LB_mH2FtBXH99FQ@mail.gmail.com>
Subject: Re: [PATCH v5 10/19] mm/swap: mask the off-list bit when checking
 whether swap is full
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

On Mon, Nov 23, 2026 at 6:18=E2=80=AFAM Lian Wang <lianux.mm@gmail.com> wro=
te:
>
> add_to_avail_list() clears SWAP_USAGE_OFFLIST_BIT with an atomic
> fetch-and. The returned value is the old count, including the bit.
> If a freed slot has already been allocated again, comparing that
> value directly with si->pages misses a full device.
>
> Mask the state bit for the comparison. Keep the cmpxchg on the live
> counter so that a concurrent free can still make the device
> available. This also applies to the existing plist allocator.
>
> Fixes: b228386cf237 ("mm, swap: clean up plist removal and adding")
> Link: https://lore.kernel.org/all/f53b388e1bcf6840457fe5041e989a3c0d0cc4d=
f@linux.dev/
> Signed-off-by: Lian Wang <lianux.mm@gmail.com>

Acked-by: Chris Li <chrisl@kernel.org>

Chris

> ---
>  mm/swapfile.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/mm/swapfile.c b/mm/swapfile.c
> index 70913402a265..1ef5f1ead656 100644
> --- a/mm/swapfile.c
> +++ b/mm/swapfile.c
> @@ -1347,7 +1347,7 @@ static void add_to_avail_list(struct swap_info_stru=
ct *si)
>          * that updater happen to be here, just skip adding.
>          */
>         pages =3D si->pages;
> -       if (val =3D=3D pages) {
> +       if ((val & SWAP_USAGE_COUNTER_MASK) =3D=3D pages) {
>                 /* Just like the cmpxchg in del_from_avail_list */
>                 if (atomic_long_try_cmpxchg(&si->inuse_pages, &pages,
>                                             pages | SWAP_USAGE_OFFLIST_BI=
T))
