Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA5131CD2C
	for <linux-hardening@vger.kernel.org>; Wed, 11 Mar 2026 12:57:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773233824; cv=none; b=OYhZBWLDMpbAUuHhXLDMwvGmThe71n7kctd6i/hzQsPppVveRCj7dwjZX4ulSHHPy9d/6Q4yG+e5yhnE8XJ+GrJdPFB48W/zRLjPfPvP+uL0/PtXzYVjsVsfbo1LgzJga4MlCbOlbiEOigFYpQdt+1NocNy8uIkEq6Gl4Bdt49w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773233824; c=relaxed/simple;
	bh=gTnf+8uCYqVV2sxyuJawFOVZpo55IObZKErFcPla61A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UzoYE+CaaF7SSzc4T4DO+56cTiacD+OtZkVUV70d9uBKIjTxQ/Ameq2dpNLzBQDtaJLTJ62c8Imnm2w3TsYah3UgPdrPKaZqb/v9hsGf1LnDNDRAemQbOl5VPimqMLX7WNEiPk4jjGaSXY7n08nzoB3oEj5aDTHv38poAn8z+pY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=F7rl74z1; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="F7rl74z1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A8D93C2BCAF
	for <linux-hardening@vger.kernel.org>; Wed, 11 Mar 2026 12:57:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773233823;
	bh=gTnf+8uCYqVV2sxyuJawFOVZpo55IObZKErFcPla61A=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=F7rl74z1HIIvmWnJDjTX0cAXPw2wBeYbTLOYNlwftLHPNzMKwAH6U4elDEJ6kdwR1
	 26ShWSc25+fcBCt5iUTtGyqT3hdAjMaUlybEZiciZyXPaQSpcMJxk0nXPHwjq+pLar
	 zt0a4jIB9Gy1qnkAlre3VLyXAz2dtku68thz5OrsfUr+hpqXr7UfOqr5Aarw2kguWb
	 oRHJKZp2romgIacH1icqw1aZ9Aj4KTkcekw5kU/PQnOynayMzRK9tBHyZyQxIpg1mu
	 4C64jTbr4FMTRHO3z+TlnLP3Y/MO3UnUGuAkGj0rtF7R/FGTiVYwBe2hSH03vWIv5x
	 uSbA821h8EnxA==
Received: by mail-yx1-f45.google.com with SMTP id 956f58d0204a3-64ad9238d8fso13919349d50.3
        for <linux-hardening@vger.kernel.org>; Wed, 11 Mar 2026 05:57:03 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXUqQoEqDulhwJZBcGaTKo814p3bmEsuQcOZrVxs30iD/v+Z7Erqm9OK7S+OjIO+Ko3hTJC9zdmZfGo1tMqHhM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzB5RLBTVrzU+f8fT1szzYACFvkdgPSudDPVqWaVFBRxxUIkhmN
	RdZfE2XTJEu9uW0DGIT8MTrIenIEtPIy97GZoCH7i8WnY3bQRsXGf+dYcHj/EtxCoTfZ1R0BdJ/
	2umUwy2eFArg5wMmSySbIrIHta9f0vvE=
X-Received: by 2002:a05:690c:e694:20b0:798:980f:66f0 with SMTP id
 00721157ae682-79917f69fd8mr15993927b3.33.1773233823073; Wed, 11 Mar 2026
 05:57:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260310222040.10324-1-rosenp@gmail.com>
In-Reply-To: <20260310222040.10324-1-rosenp@gmail.com>
From: Linus Walleij <linusw@kernel.org>
Date: Wed, 11 Mar 2026 13:56:51 +0100
X-Gmail-Original-Message-ID: <CAD++jLmR8TZHMbiSBaUmUvPYvP9bPOmr0a=yq4M7FNRFF4EzcQ@mail.gmail.com>
X-Gm-Features: AaiRm52zv2GLSL3fuEtbvEF3rCO8gpgv-QzUHQQI-EAm6dz5UlysklzPKtQCLbw
Message-ID: <CAD++jLmR8TZHMbiSBaUmUvPYvP9bPOmr0a=yq4M7FNRFF4EzcQ@mail.gmail.com>
Subject: Re: [PATCHv2] gpio: ljca: reduce struct allocation
To: Rosen Penev <rosenp@gmail.com>
Cc: linux-gpio@vger.kernel.org, Lixu Zhang <lixu.zhang@intel.com>, 
	Sakari Ailus <sakari.ailus@linux.intel.com>, Bartosz Golaszewski <brgl@kernel.org>, 
	Kees Cook <kees@kernel.org>, "Gustavo A. R. Silva" <gustavoars@kernel.org>, 
	open list <linux-kernel@vger.kernel.org>, 
	"open list:KERNEL HARDENING (not covered by other areas):Keyword:b__counted_by(_le|_be)?b" <linux-hardening@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 10, 2026 at 11:21=E2=80=AFPM Rosen Penev <rosenp@gmail.com> wro=
te:

> +       size_t num;

What about naming it num_connect_modes?
(and unsigned in as Sakari says.)

Yours,
Linus Walleij
