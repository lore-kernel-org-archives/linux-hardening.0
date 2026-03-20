Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93F1D282F1E
	for <linux-hardening@vger.kernel.org>; Fri, 20 Mar 2026 13:40:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774014010; cv=none; b=DPdNFTUNIV9qQSqltXztoqeOsp6f3mHqcM+NZHdZ/DPcQfNhvYLk1G5Ds+dhRDdDGBJhSOzKHrE+CHGucCUFqAzispLkQHA3vH0fOPEpbsLVD1TpN0wrxff8bwWzT64JgJoG5s2CVZd7xNNjrWui9TEjsYRT4AeyhGRKzS3h6WE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774014010; c=relaxed/simple;
	bh=a3oCvWwktJOka9q2aoujsHbZ4rvoudf3Wlq8RAfXnIk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BaMZSo4TvscPDBN1v1XSP2EhifyRciH/rSBoUS1K7DGK9RD1qv1mR8zP+wCgzaApDrDacB/lUHXtQADilhgdAaSzmLzBaAAmrZMDxohHySbuEqT9TqLV1FIq56izKGD2vBzis4GEFqYoHK2ScYDqlnIeygi4+SPBvC9zS0nkLvQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pSbWswNC; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pSbWswNC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 428C1C2BCB1
	for <linux-hardening@vger.kernel.org>; Fri, 20 Mar 2026 13:40:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774014010;
	bh=a3oCvWwktJOka9q2aoujsHbZ4rvoudf3Wlq8RAfXnIk=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=pSbWswNCG1U+am53GXN61FyyVrA/NHtY2WmM4qZpgNbTT6uGcwitK1NnB7MwESUoz
	 W9CkAlCshbYKtU98OnBIEvmyp5Og2nNApzud/zbsoQPr+BIv+EoAfzeiSj4f7101yB
	 yi5IVR91Yw1b8BXPExgaxxl0QEYCKs+X+YZr+TL3jlrrjtXbyuj0Ae1daXsXO7YKCA
	 1wosZczUwO8m71FISeB4O6YdO710eNq5XjHIZoMh+ZOOm+2BthPag38s3FyQ9vndi8
	 UlfVeLWsGJxxtENegHwZY6Tylflz8jpybEIE4oOGD1CONDbsMgO3e0EM16y86HP3F1
	 PQcwJ4y6Ydntg==
Received: by mail-yx1-f54.google.com with SMTP id 956f58d0204a3-64ad79dfb7cso2568587d50.2
        for <linux-hardening@vger.kernel.org>; Fri, 20 Mar 2026 06:40:10 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUUuQ8J35rd4LF2OV6dO0hPKg9PgiU02qaVPXidNwXlUbUmzywpJXBTkiizQRVV4jr1Top+y03JIG6jwNFVi2A=@vger.kernel.org
X-Gm-Message-State: AOJu0YwY7vOxMQrsZhWSdG2z6iXsfMTRHjEJd4VmP80BdVgbTladwtC4
	0dK2RzjisBAIK/lAAnnAVhaOBe6ebNnc9mSfZ7N349rtwZKGGPUQ+v5T/csDG2N1mZmRaLLh+Cf
	xHNtwEHAqKmb0Fs/vVgblIJovn/FIeWw=
X-Received: by 2002:a05:690c:f14:b0:79a:6f11:3ac8 with SMTP id
 00721157ae682-79a90ba015dmr30839247b3.29.1774014009652; Fri, 20 Mar 2026
 06:40:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260320015323.36383-1-rosenp@gmail.com>
In-Reply-To: <20260320015323.36383-1-rosenp@gmail.com>
From: Linus Walleij <linusw@kernel.org>
Date: Fri, 20 Mar 2026 14:39:58 +0100
X-Gmail-Original-Message-ID: <CAD++jLmSs_zr+VjOFDcWeWd8k2fvW4D_=AB21sOzFDNeRfY77w@mail.gmail.com>
X-Gm-Features: AaiRm51td7xH5-vHG8a3FglHGrwjolWTDZvQoaQMPmI-u_KtaEKBB-jCCe9iV-Q
Message-ID: <CAD++jLmSs_zr+VjOFDcWeWd8k2fvW4D_=AB21sOzFDNeRfY77w@mail.gmail.com>
Subject: Re: [PATCHv2] gpio: msc313: remove kcalloc
To: Rosen Penev <rosenp@gmail.com>
Cc: linux-gpio@vger.kernel.org, Daniel Palmer <daniel@thingy.jp>, 
	Romain Perier <romain.perier@gmail.com>, Bartosz Golaszewski <brgl@kernel.org>, Kees Cook <kees@kernel.org>, 
	"Gustavo A. R. Silva" <gustavoars@kernel.org>, 
	"moderated list:ARM/MStar/Sigmastar Armv7 SoC support" <linux-arm-kernel@lists.infradead.org>, 
	open list <linux-kernel@vger.kernel.org>, 
	"open list:KERNEL HARDENING (not covered by other areas):Keyword:b__counted_by(_le|_be)?b" <linux-hardening@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 20, 2026 at 2:53=E2=80=AFAM Rosen Penev <rosenp@gmail.com> wrot=
e:

> Use a flexible array member to combine kzalloc and kcalloc.
>
> Add an extra counting member to support __counted_by.
>
> Signed-off-by: Rosen Penev <rosenp@gmail.com>

Reviewed-by: Linus Walleij <linusw@kernel.org>

Yours,
Linus Walleij
