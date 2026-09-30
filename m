Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2C0F4ED1B1
	for <linux-hardening@vger.kernel.org>; Wed, 30 Sep 2026 13:21:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790774473; cv=none; b=nWfqCVLhxqgeHe+ufY0pwq9DyFVP8qYyy0Mmv9SxB/N/O0ZUtWYOEjSFveioqxJRtM5tuNnaob1PNt89u3w/YtAPQ9kJkVkvcS3PXIcTRNh3CeIOZHUgUlxkla4u2j+tN5wzPiWsrtEXNSBOtIWHnbLAD+EFuHlCTve1JPoUeCE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790774473; c=relaxed/simple;
	bh=6IzQF+Q+mst0ME7ROJtfUb5Jcpg0Z1nzhB6w2uJrJos=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dNQl0r/6I7fIncLpNTTSDEeef2mUxcZdoI3TonPcKWAAgieTkPllcJnaWf4NzAhaJQboQwn3HXLADtx5zb4WK0UNPt4ARaQR6NA83hGTp3NoOV5F1LNUrS4NcJmKbZlcb7mknfdZDox7xPrsCBPRIAcL7QApQvUOvtOHSMvZPRM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=i1QB5CNb; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="i1QB5CNb"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 09DCC1F000FF
	for <linux-hardening@vger.kernel.org>; Wed, 30 Sep 2026 13:20:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790774459;
	bh=6IzQF+Q+mst0ME7ROJtfUb5Jcpg0Z1nzhB6w2uJrJos=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=i1QB5CNb0e4yAO69gGpeGDQ4+3cNF/GYGIwzLC+sZz6I9I5qUNqY+vCp3ouJ+Nodz
	 NNkH0b3BWs6psnkxr2EAkO8Y50PaZwvRiQ/oT7/cisZflys68yXDAvp3O4KXyejhZm
	 CH+TWTcGc0aqXK5hUciE4MvMi4+Xai6/r5lbAEcRxl94G1OFkbR7kX2mnIvVgkRCtR
	 xfYAgKo4OHuG0XwKOA8IhTMhJGYDTJM4gInwf6w+oPCC6LloOnOQQXoeq9WX9kPX+I
	 5ivLMv7eur5s+F+a2dY7Amur9JxTfXPH1+mQ0tvlciAK510abinNSr7QyCwV5qMQIe
	 VPW9P+ZOCw7Bg==
Received: by mail-lf2-f13.google.com with SMTP id 2adb3069b0e04-5ba37427a3aso1400196e87.2
        for <linux-hardening@vger.kernel.org>; Wed, 30 Sep 2026 06:20:58 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvBxoE6v77k1TTsbb7mqO5FfgQZ0rbyJm1nl2lqWGMo+Lu6TZzLYsnzu6gv2kjuGu/SJZ3vUgwxJb179shVztAR8=@vger.kernel.org
X-Gm-Message-State: AFq9FYL+4XshiPYpsCUvW1/nTuEQw3t9JNfl5sg2b5Ruq6Pivma+xYjd
	67xRbDB1pAigQLKhcSeGj6tTtVo+G9kOXUG3jZUwmMYFio9UfBIYP0r1ZJ5567X9b0/CakudbxN
	jfmfX2/AUk5G2R+i/10TgTK0yIdhfdDk=
X-Received: by 2002:a05:6512:67da:b0:5b8:d9ce:1d88 with SMTP id
 2adb3069b0e04-5ba405f5e1bmr513623e87.29.1790774457839; Wed, 30 Sep 2026
 06:20:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260917211323.i.101-kees@kernel.org>
In-Reply-To: <20260917211323.i.101-kees@kernel.org>
From: Linus Walleij <linusw@kernel.org>
Date: Wed, 30 Sep 2026 15:20:45 +0200
X-Gmail-Original-Message-ID: <CAD++jL=sN7Pq9cyoNbv7-7WQgFzUUb7uPT99E7z4CvbkpfQuVQ@mail.gmail.com>
X-Gm-Features: AclHuK_84YC7Bc4GJIIPmMM0TRscaoNjNwKwonpkM8TVCPVhw3xp987UXfg7Btw
Message-ID: <CAD++jL=sN7Pq9cyoNbv7-7WQgFzUUb7uPT99E7z4CvbkpfQuVQ@mail.gmail.com>
Subject: Re: [PATCH] pinctrl: mediatek: Fix eint->base allocation type
To: Kees Cook <kees@kernel.org>
Cc: Sean Wang <sean.wang@kernel.org>, Kees Cook <kees+treewide@kernel.org>, 
	Matthias Brugger <matthias.bgg@gmail.com>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
	linux-mediatek@lists.infradead.org, linux-gpio@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 17, 2026 at 11:13=E2=80=AFPM Kees Cook <kees@kernel.org> wrote:

> From: Kees Cook <kees+treewide@kernel.org>
>
> In preparation for making the devm_kmalloc family of allocators type
> aware, we need to make sure that the returned type from the allocation
> matches the type of the variable being assigned. (Before, the allocator
> would always return "void *", which can be implicitly cast to any
> pointer type.)
>
> This allocates the single-entry array that mtk-eint expects (nbase is
> set to 1). The assigned type is "void __iomem **", but the converted
> allocation type would be "void __iomem ***", as the size was taken from
> "pctl->eint->base" itself rather than from what it points at. Luckily
> "void __iomem **" and "void __iomem *" are the same size. Take the size
> from the pointed-at type to match the assignment.
>
> Build tested ARCH=3Dx86_64 allmodconfig with GCC 16.2.0:
> drivers/pinctrl/mediatek/pinctrl-mtk-common.o
>
> Assisted-by: LLM coccinelle
> Signed-off-by: Kees Cook <kees+treewide@kernel.org>

Patch applied!

Yours,
Linus Walleij
