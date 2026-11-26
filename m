Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795710733;
	b=pF9D5hEpEgdNs5blwHPFLq1uQT1cKMTjRDICe5JWsNZ28jcl/TYR/0v4i2y1jUmP8TlF
	 usJZ3/o2/9GG4Cs+iKP7sqfsIBdFDATIiVDkISiF7U24BxSP671tE8L/geF8vwQoDPWkW
	 sxQVddwLmriQ+RMK0TvOKUathL5yRzwNGKg5WdZJLJzOTukUfunu6HceVECeVQwZJvBUg
	 jU/EyuZt4GfFNZ2qMzzOfWKb56T6C5DpKObJvlThmZyO33HfjNoo1dYtVbF/fxzFfOMeN
	 iO2aqOkQcRqa8WE1SYSoRV5/cNUwb0fj5WGbXVybyplDO7HfSWgg4cqwuuZMjYgmaKA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795710733;
	h=Received:DKIM-Signature:Received:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Received:MIME-Version:References:In-Reply-To:
	 From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:Message-ID:
	 Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=yWELNjBi8fRHqO8McS7d6ElBX905qlw81apnZMTYqHM=;
	b=NYBHef5NKg2Hf5zY5hJop8V19MIDiloz5E4F1cP4TNfJ8pgF3rWY1QevcpPV+Ze+6K2R
	 j7h5vlohZKtf5fZ12Ay9hfpXwTMJuB/dryLRISunoxsABT5pNv3FzLC4QP5hMxhH3lA7e
	 9yEqeMCBi8BsYiuLZYtunM19dwdZkJlv9DO5RMFHCnDVdCTNTGmi7POW+uQoCYqjaNwoT
	 7q/7QNirUr9i0kCHXV6U5ciZdZeI22x/PRRsrYH7AzxVvF4NoDmw68fHcrcIJ3sdbi9TY
	 K5OANsZXfihbyXoD5OafIuVE7+kKVtNo0SDLvUp6i5BkeDzPmf0NbPBdiiLPist5Qrg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=csWSJoEs;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A55D8606A321
	for <linux-hardening@vger.kernel.org>; Thu, 26 Nov 2026 16:32:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=csWSJoEs
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EBD941F000D0
	for <linux-hardening@vger.kernel.org>; Thu, 26 Nov 2026 16:32:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795710733;
	bh=yWELNjBi8fRHqO8McS7d6ElBX905qlw81apnZMTYqHM=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=csWSJoEsx0ftuDT3T0VtXF8mpeIX3E9mdWEXd32YBSIGfEAAObLj+/tdG/0geZM+j
	 sKD+mtuTQdGPHnhgKOAnk2Gf9D/VbKJjwBmPrwONkxL0JCwIltFxdsmkkOaur5as7X
	 N/wgHhB5Zqgef1uKQsBmjItPhMxcTzlv8EsinDdTtd96zPEIs5cwc7BA0d6rCwwRbt
	 GAZApm7GOcjWU4YcZFtg2/hEHcduJsQq1GsJ0CEcpQ/vT3Q4sC1yle+Qit8GSqTHMb
	 cad2ruQi09poWBSd8TWvT35/s+05m/aZdUp4Dq2JGGAF7gjLdYpmXnVFXXRri0aM4F
	 SirmRYqFZis9Q==
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-c4d28f75d62so1179971466b.0
        for <linux-hardening@vger.kernel.org>; Thu, 26 Nov 2026 08:32:12 -0800 (PST)
X-Forwarded-Encrypted: i=1; AL+hErF/mj6lbhlR9qqULdB9YnJanjkfaVrUSX/E0prSTSKiB30fpkAA7Rfx2fZlH15glp0aVWeCLKg+xwHexvlRl84=@vger.kernel.org
X-Gm-Message-State: APuU4Z/3mtB9KDWmTbCNmLcB6sCgD8VnQdUSWqmbfsvpmTyyonp6nJuh
	te90MAeIC6LAwiLXVR7krcDx6knJldigJnOjjkA5DY7TxwiJuSqGB2ovK5Alv+ZusLpCzzEZTCa
	bHlWDwnJGXmkOqUPq05Sr6WbrE2ZOr8dOId5aze9pgw==
X-Received: by 2002:a17:906:b758:b0:c2d:bd87:7fa7 with SMTP id
 a640c23a62f3a-c513ab0c35fmr1245547966b.24.1795710731802; Thu, 26 Nov 2026
 08:32:11 -0800 (PST)
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
 <CACePvbWzE6AvbLzNFe=J5Vid8iy6FFQh0RBgr+V_jJJ4p=OEVw@mail.gmail.com> <179569520640.49764.510050912247709774@gmail.com>
In-Reply-To: <179569520640.49764.510050912247709774@gmail.com>
From: Chris Li <chrisl@kernel.org>
Date: Thu, 26 Nov 2026 08:31:59 -0800
X-Gmail-Original-Message-ID: <CACePvbUYpze2_nLGAPCohXtkk+=3owoaZSk4qu-EOOm1Z0doTQ@mail.gmail.com>
X-Gm-Features: Aa3M54rUcN0v8lXSRmI54HK_pacToG9AbpguWY-LEOeAOOQtuw7uYO3f90lN5Cc
Message-ID: <CACePvbUYpze2_nLGAPCohXtkk+=3owoaZSk4qu-EOOm1Z0doTQ@mail.gmail.com>
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

On Thu, Nov 26, 2026 at 4:15=E2=80=AFAM Lian Wang <lianux.mm@gmail.com> wro=
te:
>
> Hi Chris,
>
> Thanks for the careful review.
>
> > Nitpick: Here "ret" only carries error code. Maybe we can call it "err"=
.
>
> I'd keep "ret" here since it holds the swap type on success and a
> negative errno on failure.

Ah, thanks for pointing that out. I missed that part. It doesn't only
hold the error code. We can keep it as "ret".

Chris
