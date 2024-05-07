Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C105916D9C8
	for <linux-hardening@vger.kernel.org>; Tue,  7 May 2024 19:00:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715108440; cv=none; b=fGOlRhESEzyzlypbII25lNImAfaNROUr/DgykK2mGjZRMWemgLT/gs/+gsG9EByxfJ/JbCqVIZRDh7T/9/rw3N+Mx6Mu5X9x2rB6EOWcIT9sjyvTZRq1RVTq4of2ccdTAGu+0BKLxWGPuyHD4NIsdgXICjhZXsAF4sbAcRyeo8c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715108440; c=relaxed/simple;
	bh=7s3oPGkGLzvOuGWVPAZcFf2NPdjW/ND+O4YOkgFBmXE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IdzXJv/Jd5OY3QXW18wvKT03IMxXqxJjib23PS3IxOmcHrtUvgXuR41Aew5axj77NiVmk5hmABQtU6ExR/bfWNi6Bcet4hoHS0pBVhMWjQl02eKooyKksryJE7dixbgpooP45KjB3lGAKKkW5tWpwR3FkWerc+ylqQj1l8pjA0c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=LA0YijEL; arc=none smtp.client-ip=209.85.215.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="LA0YijEL"
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-628a551d10cso1627880a12.1
        for <linux-hardening@vger.kernel.org>; Tue, 07 May 2024 12:00:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1715108431; x=1715713231; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=52/TiGb0pRp1cCi0WAvKTSl0Kx/3b9XgA1N/tzA4luI=;
        b=LA0YijELBhtbFqj+kYPDc723zkxRrJQ3jYMZ0vaTfNAwYtW6HXeuX4RFhLCzYOpEkQ
         785nJ1jvgpc+famATuw+rdHQIGH9byxrsSf1tZpq1u6G88HVqvyTuHbdjwXCOBGVru17
         1T+bXwloEsbhpsaKeVAYI0tLCUxkhoQuwpgy6Ix0Xx5qvBQWh/AGzfnu1seyJkVcLHkT
         sBV02UO974N1BVr/BqsESwQCLOizTJ/472GNVbbtQKbuuVnf0nRPmPZU7Kt+LhpNnpbz
         i504WgCmYZeN4tpe4oKWCWqrgU4mLmaCXleke1TW9ydjdViNTC+x+uWmCJzBAa9rPngj
         imrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715108431; x=1715713231;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=52/TiGb0pRp1cCi0WAvKTSl0Kx/3b9XgA1N/tzA4luI=;
        b=ezLjlCQUmgocF4X6oX2I0dmQzaenPDyHvT2WkThUwilF01bnmmSKw8oqh04oXkUTSg
         wjWIBmDInv78ri2GYNdJ1s53LTY8TIMMwwE+6zScVYFemKdgtPq+U807kXoPjIqbYK0b
         msqT+mR7e0qsT1Cj8U7jtu6hxpIZCPWIZuEuMbB5mTMSXM5+hhmKbTZNWgXRtAGgTyNl
         Kzm545acqEWeG9wzF6alW2W5l/VkLYEDYLal8TjZRq/GLq8ORArZMsyD5V2PaUrH2t5x
         D8bhXFFJ5jM/jazCXww1VkCwm01Bor6W4PXj4eKN01T/tHAz3DNAkuwkwfPQlNQ/KHOO
         InTg==
X-Forwarded-Encrypted: i=1; AJvYcCVFfj3y2ZvKtA46v4HeC1/Tb8tiQj2hs5yQKq/w6gkSpzpwZSwFggZof0E1R+YsUIjdQoa0HcaPhLrR68OM6gw4njvixtOulQFjfRnHvskP
X-Gm-Message-State: AOJu0YwtWUtHXE7Lp7XDkDX0DEAJHGyoJjsfqimD9Z8/0hrFG3nTWvn3
	Gf3D4b6luQ+4B/fKHZWWJ+Ou7T3YUoH5leKi8RCIyIte3BZKtW3soBfS2JLdmkNqkOz3iA29UvB
	CB3XxS6oSFX4pHaPPsltO+PWmWwJTGeic2on4
X-Google-Smtp-Source: AGHT+IFdufqWMf0KRyS6ONQjfkqedO80otF+5gAkHmdq5Jd6uIJPgZyn9Nvw+Eax/axJml6eRyADco7/lvarEj7yCXU=
X-Received: by 2002:a17:90b:4f46:b0:2a2:70f6:8f67 with SMTP id
 98e67ed59e1d1-2b6169e318cmr418365a91.30.1715108430851; Tue, 07 May 2024
 12:00:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240503-gve-comma-v1-0-b50f965694ef@kernel.org>
In-Reply-To: <20240503-gve-comma-v1-0-b50f965694ef@kernel.org>
From: Shailend Chand <shailend@google.com>
Date: Tue, 7 May 2024 12:00:19 -0700
Message-ID: <CANLc=ata9H4ZTN92MhQ+P5bTBo9grE7sP1_JDk5MdzaCOhXOGQ@mail.gmail.com>
Subject: Re: [PATCH net-next 0/2] gve: Minor cleanups
To: Simon Horman <horms@kernel.org>
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Jeroen de Borst <jeroendb@google.com>, Praveen Kaligineedi <pkaligineedi@google.com>, 
	Nathan Chancellor <nathan@kernel.org>, Nick Desaulniers <ndesaulniers@google.com>, 
	Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>, 
	Dan Carpenter <dan.carpenter@linaro.org>, Kees Cook <keescook@chromium.org>, netdev@vger.kernel.org, 
	llvm@lists.linux.dev, linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, May 3, 2024 at 1:31=E2=80=AFPM Simon Horman <horms@kernel.org> wrot=
e:
>
> Hi,
>
> This short patchset provides two minor cleanups for the gve driver.
>
> These were found by tooling as mentioned in each patch,
> and otherwise by inspection.
>
> No change in run time behaviour is intended.
> Each patch is compile tested only.
>
> ---
> Simon Horman (2):
>       gve: Avoid unnecessary use of comma operator
>       gve: Use ethtool_sprintf/puts() to fill stats strings

Reviewed-by: Shailend Chand <shailend@google.com>
Thanks!

>
>  drivers/net/ethernet/google/gve/gve_adminq.c  |  4 +--
>  drivers/net/ethernet/google/gve/gve_ethtool.c | 42 +++++++++++----------=
------
>  2 files changed, 19 insertions(+), 27 deletions(-)
>
> base-commit: 5829614a7b3b2cc9820efb2d29a205c00d748fcf
>
