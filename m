Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8C4F37A496
	for <linux-hardening@vger.kernel.org>; Thu, 26 Mar 2026 01:53:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774489999; cv=pass; b=t5QXDRkSPOcSxUWANzuPoERUxHbuTl4QIpnV77hF2wAR2kXsgUC+cwmyDhnsGxwXUhXrSoQGxESCobwGTtv7OWQ2z88dbd359oRNtYv8nztQgGS/xBkJnno/G64GpWgNVZm6RXW/bR1a//S6jzT7qdAZgw0wyk0nqrkd01G14JE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774489999; c=relaxed/simple;
	bh=OkQDhqxdu/VghGhiJbxfiIKUvNi36C2xoIdqMy2/5jc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Hje3ox0EnNA5bIoLSuwAxZaX9femXM+M444YtvlB8ibhHdiJh58YzArzkbtOUClKsvhxqckbpGAHGkGm5T29NbWeq8vBZWwRvW2v9QT1N6jm7CysSf+BN42Xhd8StfA/lmeMb+WpFk5d/fuzpvZxDR0rc9C1/PIMJqtMtiMFO10=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=F3P2ixL1; arc=pass smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F3P2ixL1"
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-66847de014aso730562a12.2
        for <linux-hardening@vger.kernel.org>; Wed, 25 Mar 2026 18:53:18 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774489997; cv=none;
        d=google.com; s=arc-20240605;
        b=YgY18GH92RUNADoLydUwmqTkSZrj+8Zi2DKsX65Qoqm6taPXbA/cI2k3EbVzV7tNba
         S4wf4yFs5hTqp0eYPbj6mLDDOMaO2wQzXK1F0L8ACVZt/Nq6dhbfHYzwBn1YxCiXJ15c
         MvZvmnowbOBi+tcmsjyqKl2nqwmVn791TWp/Ueu1jmRD5Cm1S0SWik2uv63nuAta5G92
         RLIBVdBEQqDoZIACIvWGl0aDsm7/MmBWB7V47dQE5dz4dvebq14jThtuaYhnXIa4B5TQ
         tC2ZVL9Cyuanqx/YXQ7Y88iCZJluHO514U9SjzeEISOHlwkdqN3m4b0L3W+Cr4lNuyyh
         wjZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=OkQDhqxdu/VghGhiJbxfiIKUvNi36C2xoIdqMy2/5jc=;
        fh=jM1Yo7TvfB0ISc0lJvvH5GY28tCnyeQLX1v7kSxqdSc=;
        b=EQYYojUrmVtZgfPzje6j87rD5PWDDfsDTtKQOeJTfWB9gSabcturdQ8SX5JRvRqbxn
         uHQAiqX2usCp8sr95u0wlX/bWWaOjIMPKmTDwL9eCBRkg3PawSnw+Pzu6R5JFPITSuqp
         Zc/YtDaebCShwqA+AhGW9lTdcF7bAipcQtErK5IqHztXKJztoomSy/L+azOO4zdRJkmu
         aM78N+I7pjcMyDLroTxefCwmHkKOLEqW52s1pqMjl9aJGlTgpYGQ4dwIcSEIZ5ELQPkL
         RvZT9r1jZJ9ucNW/dIAfZQLpm9j5A5XIK+MmPjmMYR7V/AgzSjZhm1m79ibdcvVqdCci
         ff/A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774489997; x=1775094797; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OkQDhqxdu/VghGhiJbxfiIKUvNi36C2xoIdqMy2/5jc=;
        b=F3P2ixL1Lp+xUdlHD4A9fAInBG8yjo4AsXKmiOTT51SGB2Sg1mxf/ztCSRnfph2Eg2
         4bq2Ou0u69GpCqciNLfsB/U9Gh0QvBZ6FzXTLLoUlgPGmYvzyeimqjfnlVKXqGH939vU
         a31nQ7ElNLQig8N++3/c+GcL0BFEiZgnFC6+EMFTl/439nRAa/CU4vjNYenXS8ad4cvN
         s8noNTTcefYsuveDQfAyg6ya+Gom6RAw4WF4OnAg/EKmv6G1IFrAVSGaXolIHQeNF7d2
         td6nyeMq6PcR/U4sSHIcvWZdKmM48swJTnFx65ooBptO24KZ7bjdGRYkcESKMRtAYVyA
         H6rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774489997; x=1775094797;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=OkQDhqxdu/VghGhiJbxfiIKUvNi36C2xoIdqMy2/5jc=;
        b=dYtrFuUgS9SXF1wuaPBn/HNwNHjgJKUGViJ5qXqwePQaTjbD28rClVmi9O4ZO0swjw
         4ptFDCWBDQjoAlduAMA7YER4EKtiDRHUzHDYHWYKPSAqZZd3SgNCezudGzRUK2upPh9R
         eQnuXz887fzktjfXO+OjG59Uls79KX31u0C7/qDjXmn2Oduj8IEpfjwsbycTk0XFjXnZ
         JIdKU4J9LavrDTNQ5uu6eijbfG0Sxv0ohXyOwXCUKP2SduhbOCO7PQe63FZ2EeypseF2
         CIqg63dFKenlVsVAiMrv/ggRSe1KQv02RtmOaX94FsEggMrQ6nit605ohdf6ZaCxCGsF
         adWQ==
X-Forwarded-Encrypted: i=1; AJvYcCUSoLm0THMAkt/0a4+4bDP9Pn/Hca/HAGCGKVMVwW9aLpzf/SMR1MbnF1msc3eEqPg+O5zLhrmfZDZnTqpPCH4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz7RAaxO1FSMytZD71x1VlMHoEtjpDed1bvrxjlLq6CZhCSB53g
	cRJ2gj9wpYUjTSqDPikgk2prB898mwhs+ZuZ/2WPQzA8EOD2Hk6zuop4kMxOTZkAZWM/D5/B4X9
	dGVrhLg4rZOsFNteq1ae4DpZMAKzA1tc=
X-Gm-Gg: ATEYQzwixtUml4hRi3KrHfOsdrp6MbNO+LEN3ju+2BBSu6i4+wyw201xFr4tKO4JHkQ
	HLVjIG/HwKitUANpVFF9VTnt/B+S92ihTA9mFX15NBTDoQvCq+QgmgXTcixEeUpBqn7HANCR3O+
	U2cRaCF7G07JKQolzjKHil+ia0L2kT85rkYYTFXFyLbCTGzMsIWXrARgM26D5GsZfBeGj4av9T1
	pNYVQdvWQxcobv40s16qwHku4MWSKrowTndKjIwQAsvCOUrQ7IR5Svbq/t/4evIzLNsUwjJG8k/
	d5aCZZrNp2vBErw1hIJDM6441xJrGQ3G8ffu/qHTzX3uKE893YfHFdb+LFN0HbmPbYOBuFJOoxT
	iBfMtPg==
X-Received: by 2002:a17:907:3e0f:b0:b9b:155a:6f92 with SMTP id
 a640c23a62f3a-b9b155a77ccmr272420566b.7.1774489996810; Wed, 25 Mar 2026
 18:53:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260306044536.149204-1-rosenp@gmail.com> <20260319220901.GD950375@killaraus.ideasonboard.com>
 <CAKxU2N856yYXURRf3td-_RCpe9hyX=zAy3qtD3ki23RjgO+a4Q@mail.gmail.com> <202603201114.9A02FDA977@keescook>
In-Reply-To: <202603201114.9A02FDA977@keescook>
From: Rosen Penev <rosenp@gmail.com>
Date: Wed, 25 Mar 2026 18:53:05 -0700
X-Gm-Features: AQROBzBSJyDOFvefMdXxKt78jroAsA-q-37591igukparmS24ZzPgm6s7TLFqAI
Message-ID: <CAKxU2N-eVyzunEC1PivSmRF9xctOF2NZHDJyoVUMYHHXCN6qoA@mail.gmail.com>
Subject: Re: [PATCH] media: nxp: imx8-isi: remove kzalloc_objs
To: Kees Cook <kees@kernel.org>
Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>, linux-media@vger.kernel.org, 
	linux-hardening@vger.kernel.org, gustavoars@kernel.org, 
	Mauro Carvalho Chehab <mchehab@kernel.org>, Frank Li <Frank.Li@nxp.com>, 
	Sascha Hauer <s.hauer@pengutronix.de>, Pengutronix Kernel Team <kernel@pengutronix.de>, 
	Fabio Estevam <festevam@gmail.com>, 
	"open list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" <imx@lists.linux.dev>, 
	"moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" <linux-arm-kernel@lists.infradead.org>, 
	open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 20, 2026 at 11:15=E2=80=AFAM Kees Cook <kees@kernel.org> wrote:
>
> On Thu, Mar 19, 2026 at 05:11:22PM -0700, Rosen Penev wrote:
> > Technically kzalloc_flex is simpler but I assume a devm version of
> > that will be handled in another treewide commit.
>
> Yup, that's coming. I wanted to get the "first pass" of the base kmalloc
> family converted first. There are a few classes of "kmalloc wrappers"
> like devm_* that I'm hoping to convert to type-based allocations. devm
> is next. :)
As an aside, I recently noticed a pattern of kzalloc + kmemdup_array.
As kzalloc_flex is basically, kzalloc + kcalloc, Would a kmemdup_flex
make sense?
>
> --
> Kees Cook
