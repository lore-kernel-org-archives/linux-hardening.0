Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2764A389E02
	for <linux-hardening@vger.kernel.org>; Tue, 10 Mar 2026 11:52:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773143561; cv=none; b=iVB+2khYK7xeE27CXnvpKG1Te+Cssi4yfGV++fCkLzWezngmFqqJcd1MqLBt012lOLHH0a1OBVXjFKRS6VH3IxjNkbpMqyvTCR80iLRRs4Tm3zJZxHS2sMsgEM1x9UT0AA8keRUF/UlKaswj19ATxkNlAuaXx31d1uvZVxdD6UY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773143561; c=relaxed/simple;
	bh=6LFCZqvL3posu43TLCQlBHu1tQWOrRwNMdOPAUK1Hsw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jbA/p5aMIgu9zh8ISQt93qTWnjRforI4LEakGz+S+ye1W8YUmNfe2WLpUwYnEneunTorOcQL5e9LvYxwX0iMruBoy97QwCIZryLomgFjEOpaUCo+/dB+bUMenFSgDyVRS6pve5qZ4hYKArg3gIcKUfoBddZyxqtZ/TFu5AsOygA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cBKvcVRa; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cBKvcVRa"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E12CFC2BCB0
	for <linux-hardening@vger.kernel.org>; Tue, 10 Mar 2026 11:52:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773143560;
	bh=6LFCZqvL3posu43TLCQlBHu1tQWOrRwNMdOPAUK1Hsw=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=cBKvcVRaBVvVqwYxjm82tMvt+e/sck5zuD98LGFTHA4TVh60TbbpIuXQq/eaRtxuK
	 H7EIfRF6MbiQSmFewaxaIolZIRG9ajLgQCX7cQb7VKJ77wDP6LKZyKpwVW4MUKrvvV
	 DNcYD/5YCT7/FbcAE0oXeT1ZK1/161sqiEWjebst1RD12Ttq5S0AIod0IGeoskjmM4
	 zC5Cn6BYsdG4LVvPUR2H2pmwLmAGNaeV6/fkX1q9N5+bX/75iqf/kfrL1drC9G1m7q
	 UYTIFYNl1pojubFcY06EvyAcnWz2BTRNiio622ESheoQOB/YdkIjgcWM/vLdE8qJNW
	 SRTBDDcrdA34A==
Received: by mail-yx1-f53.google.com with SMTP id 956f58d0204a3-64c97997b0fso9021939d50.3
        for <linux-hardening@vger.kernel.org>; Tue, 10 Mar 2026 04:52:40 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXaNCkOHD4TiEhiPIgpSWEfOa8B4jYGF+lIEaVRBGpyAgGNnLDVbvdguFwW4kEJAZC3+ucmSc+tcHiuWlEeVMU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyjNbP2uUDzV6T0cRUaW5H371FZXd0OqwUJJL9SF4ChyJw0Z090
	TetKXfJJA5Zs2XJOkLSyK6UoTMsHQCpbSBKcJEl7bl01WjMQsf6LWX3nFQFDzcUBXSts8DetyJn
	9GJiMaUKTs5l4Hbw8ciLf83K/+V9thic=
X-Received: by 2002:a05:690c:4c02:b0:798:99ae:765 with SMTP id
 00721157ae682-798dd788971mr134205317b3.46.1773143560187; Tue, 10 Mar 2026
 04:52:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260308021201.47820-1-rosenp@gmail.com> <CAMRc=MfGkVpk9rBLvwxndjveXemY6t7nWOBX9wqZxc+Qe7aOCg@mail.gmail.com>
 <CAKxU2N8Zm6Hg-pr14RS9SCsOWGu2kF3gy4RVuQThMvM1CfLEtQ@mail.gmail.com>
In-Reply-To: <CAKxU2N8Zm6Hg-pr14RS9SCsOWGu2kF3gy4RVuQThMvM1CfLEtQ@mail.gmail.com>
From: Linus Walleij <linusw@kernel.org>
Date: Tue, 10 Mar 2026 12:52:28 +0100
X-Gmail-Original-Message-ID: <CAD++jLnD2Rgre+JD6VmtihW+JQ89hB-K4bd1dANWFmnCX8C2qg@mail.gmail.com>
X-Gm-Features: AaiRm51FtdF84mkYV7pgCl2oDehSOxKmBTbBBGjzPZ_i8P-wOpN6m_HDfDiO0ic
Message-ID: <CAD++jLnD2Rgre+JD6VmtihW+JQ89hB-K4bd1dANWFmnCX8C2qg@mail.gmail.com>
Subject: Re: [PATCH] gpio: ljca: reduce struct allocation
To: Rosen Penev <rosenp@gmail.com>
Cc: Bartosz Golaszewski <brgl@kernel.org>, linux-gpio@vger.kernel.org, 
	Lixu Zhang <lixu.zhang@intel.com>, linux-hardening@vger.kernel.org, 
	gustavoars@kernel.org, Sakari Ailus <sakari.ailus@linux.intel.com>, 
	open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 9, 2026 at 10:48=E2=80=AFPM Rosen Penev <rosenp@gmail.com> wrot=
e:

> > > +       u8 connect_mode[];
> >
> > Please use __counted_by().
> Counted by what?
>
> __counted_by(gpio_info->num); does not work.

As with the other patch (IIRC) just add a new member to the struct
to hold the count.

Yours,
Linus Walleij
