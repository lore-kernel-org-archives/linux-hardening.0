Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 995923C3443
	for <linux-hardening@vger.kernel.org>; Thu,  1 Oct 2026 07:56:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790841417; cv=none; b=D7i/77MBO98MLLQagHSfChVc5eWC8UwA3lbjZE4RAsu6t1aM4StLcY2UExjV9WhNIbqy4ztkoElGiDpTT6rR8cfaY/O25VW2Fe5Nu/3RD87KkF/umRzulArYZZbUT07bTs0R3wFtSphtZgqgDhNUi79Kz9p+ed4Uk6q+xsTNpEg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790841417; c=relaxed/simple;
	bh=A/Xpv/Ld+mjY+s1jwjSTwM7Z2N6DMmA39ET1qM/P03U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jxrFrhUbRK8N+/EcPtqWgeW2IHjJRctpfxtzFNgoRcWlJprbEnYll1ofLMQHpj6bTnYiOCXvaAyPpFV1Li/VJ+iGMOC64yZNsGbVgex4JnYj3AvuLK01uRrsBPsEjToLKOvQTr/e3rx9wcfblhsBdN4ozxMQbozvQ6eBQXxFa+0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Fany3a8H; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Fany3a8H"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8024C1F008A4
	for <linux-hardening@vger.kernel.org>; Thu,  1 Oct 2026 07:56:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790841416;
	bh=A/Xpv/Ld+mjY+s1jwjSTwM7Z2N6DMmA39ET1qM/P03U=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=Fany3a8Hrfdl8cgiWkQqWcAGusDt67p1Z0IHYWxTvyk86an+cHLwyu+xLvPQzxEVc
	 ecHKlv5ZwsYCqAQ+hyjt6y6radJlHOKBOkl22sNX78Mhw8fb6Aqj/3Et5havmkUkgU
	 VbxGwZHkQJqO9uHlZTP3zAZAin67yZxFGVECdqhYUa7jyE3jCh2KMFAjxTBYwKy6Yo
	 4N0VZzBJ+pkAoTWtH35xw4ACJe2KOYaKW2RdoTsj6E3TNDzocDMDxFJj2I1YdYFeYi
	 ij7tasuUVt2JA6F1I8L9nDUoGfErzhMUrDlErOeOaAApPjmD0ZmyezyGgY3r4v3vlS
	 s/j3Kj46bX2rA==
Received: by mail-lf2-f12.google.com with SMTP id 2adb3069b0e04-5ba31af701aso2240749e87.2
        for <linux-hardening@vger.kernel.org>; Thu, 01 Oct 2026 00:56:56 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvBzhlxVtErqtS8D7h7n0D2sUIJgm8IDS76Bsid2fDMxkSTS+OQdz9ivyVZ5vJTVn67M1ODZk3HmaY3fk+zIzb0k=@vger.kernel.org
X-Gm-Message-State: AFq9FYJGRu4iyjwBAChRH//EPJ7h9MAAsKUgL88BoIfaSSRWUXs88s6L
	TeDK3qqMnS/rUjjc1tkVXBQzqpk+73+YPcVuhlVbnLaIhwAIvZLXfELHEDAchZgyCWsk+Vhyg5L
	xvHhZWF/QGXD863ZSMDzjGfgqOGiurAA=
X-Received: by 2002:a05:651c:19aa:b0:3a6:7094:b41d with SMTP id
 38308e7fff4ca-3a779732efamr12637801fa.10.1790841415198; Thu, 01 Oct 2026
 00:56:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260917211452.i.365-kees@kernel.org>
In-Reply-To: <20260917211452.i.365-kees@kernel.org>
From: Linus Walleij <linusw@kernel.org>
Date: Thu, 1 Oct 2026 09:56:43 +0200
X-Gmail-Original-Message-ID: <CAD++jLm=rWBqRT=SQGfj6D0jYoU1H8HSX3Cy+expg17W71xFvA@mail.gmail.com>
X-Gm-Features: AclHuK9DtT1wfkmby2eLKl-7MGj8F-6aYEGT9yi4ELgmjp-n_Oto8Rs1ZdDaY-s
Message-ID: <CAD++jLm=rWBqRT=SQGfj6D0jYoU1H8HSX3Cy+expg17W71xFvA@mail.gmail.com>
Subject: Re: [PATCH] pinctrl: s32cc: Remove const from groups allocation type
To: Kees Cook <kees@kernel.org>
Cc: Chester Lin <chester62515@gmail.com>, Kees Cook <kees+treewide@kernel.org>, 
	Matthias Brugger <mbrugger@suse.com>, Ghennadi Procopciuc <ghennadi.procopciuc@oss.nxp.com>, 
	NXP S32 Linux Team <s32@nxp.com>, Dong Aisheng <aisheng.dong@nxp.com>, Fabio Estevam <festevam@gmail.com>, 
	Frank Li <Frank.Li@nxp.com>, Jacky Bai <ping.bai@nxp.com>, 
	Pengutronix Kernel Team <kernel@pengutronix.de>, linux-arm-kernel@lists.infradead.org, 
	linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 17, 2026 at 11:14=E2=80=AFPM Kees Cook <kees@kernel.org> wrote:

> From: Kees Cook <kees+treewide@kernel.org>
>
> In preparation for making the devm_kmalloc family of allocators type
> aware, we need to make sure that the returned type from the allocation
> matches the type of the variable being assigned. (Before, the allocator
> would always return "void *", which can be implicitly cast to any
> pointer type.)
>
> The assigned type is "const char **", but the converted allocation type
> would be "const char * const *", as the size was taken from
> "*func->groups", whose type "const char * const" is const qualified. As
> there is no general way to remove const qualifiers, take the size from
> the assignment target instead. No change in allocation size results.
>
> Build tested ARCH=3Darm64 allmodconfig with GCC aarch64-linux-gnu 16.1.0:
> drivers/pinctrl/nxp/pinctrl-s32cc.o
>
> Assisted-by: LLM coccinelle
> Signed-off-by: Kees Cook <kees+treewide@kernel.org>

Patch applied!

Yours,
Linus Walleij
