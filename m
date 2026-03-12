Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07818377545
	for <linux-hardening@vger.kernel.org>; Thu, 12 Mar 2026 08:16:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773303417; cv=none; b=pQJMpu3QY32eUAaDtR46Uv3uQVPIn9BDzHDnBtAUiWVwiCW/1Xzlkk9wHHXXVBj+PWBZiv2N72uKUPycCYX407La/s5pA6w2C0fvKm9AMuUcwcRqkMvMQxS3qNkRcvZLtptBN6vV2qsrNuzpwLpr5rejdr+ZtpCaNaId7fOFkUM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773303417; c=relaxed/simple;
	bh=D4WWa8Y5yjK/moIqWIvtf/ihJJy5NFelb2nndJ9FSiw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EVW9iieqh70rWXGrdez/nZoo2htrrAA8sK8UWcVDIck7smyq/or0tSpbJjdAYsk6Vm5qLQDY00o/l/7gIuI+lvPhX/wLMVIYZdP9oTGAwNtbze6M4xgA7UdcgPY1NUtrYoObAQCfv24PeMx9dd+hPrDlBJ4UQAr1uMYP8vGkW1s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UG9o+8Hk; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UG9o+8Hk"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CD510C2BC87
	for <linux-hardening@vger.kernel.org>; Thu, 12 Mar 2026 08:16:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773303416;
	bh=D4WWa8Y5yjK/moIqWIvtf/ihJJy5NFelb2nndJ9FSiw=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=UG9o+8Hkin/VcRIuTk58als4P05HRvouID08yN+ZS8NfubSdX0XCqztWtQHbaN9bk
	 SRXivH25nCCcdpd5r3lU6cAj1+XmG7eqGA93sWoMDf9WAcutFVyAOQzmExki0mxPcG
	 0kwFu4vFKQ5O5VXknhgD+PUs9IfsGQ0NaCP8K9BC+FvyNgUkt7uYOrGx+/765opza/
	 wo9GLu9O0ht+opLa4maNTE40eh7FNKyCLGgOVIC4IiXjreE9WGpbgWg48PhMbnP8Am
	 pZ/bTD33SRbwIHSKwGvWzbtoyWdnO1IhV/qzzHY5yX2RgQx5535enMdkQEacucFaYO
	 nfL1YzkmufduQ==
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-7982c3b7dfcso7460087b3.0
        for <linux-hardening@vger.kernel.org>; Thu, 12 Mar 2026 01:16:56 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXoCk7uJcYsm33IhzBQHTCL1ES010EOUyuEvwlYPE4jifZ8dkw4j/rZnYyrF8hxNxT34PqqVc51Wi2t/S0/tfk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy3Z85H9+Pke9AYksLSWBowcMnP7+QMG/BVKpxfSUlj9sUVsNXB
	cfenmefFht5aEIrXI14+n2gyCrRrXXMFYA6uUBnPEAD0ik5iGlaPiGn6WM47zc1QhLDkIAvscy7
	3ZEJS/dU7wQOVoidJvPiIhFwiyfQ/r9k=
X-Received: by 2002:a05:690c:90:b0:798:6619:f1ab with SMTP id
 00721157ae682-79917fa9637mr47647187b3.54.1773303416146; Thu, 12 Mar 2026
 01:16:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260310222040.10324-1-rosenp@gmail.com> <CAD++jLmR8TZHMbiSBaUmUvPYvP9bPOmr0a=yq4M7FNRFF4EzcQ@mail.gmail.com>
 <CAKxU2N9fExr=72E6ZPs+VqCe+eSzyxS8zbcCU2PPcqKjvqiO_g@mail.gmail.com>
In-Reply-To: <CAKxU2N9fExr=72E6ZPs+VqCe+eSzyxS8zbcCU2PPcqKjvqiO_g@mail.gmail.com>
From: Linus Walleij <linusw@kernel.org>
Date: Thu, 12 Mar 2026 09:16:45 +0100
X-Gmail-Original-Message-ID: <CAD++jLkErpPjZq7BUsa5X7ievDD7B2QUsOA6k5dPyN6=2=2Wpw@mail.gmail.com>
X-Gm-Features: AaiRm538VBJiBN-ob7H39qqeYRzq5Zr80Zd1bwmEyCAbn0Q-s6w4cMSBPpX2svk
Message-ID: <CAD++jLkErpPjZq7BUsa5X7ievDD7B2QUsOA6k5dPyN6=2=2Wpw@mail.gmail.com>
Subject: Re: [PATCHv2] gpio: ljca: reduce struct allocation
To: Rosen Penev <rosenp@gmail.com>
Cc: linux-gpio@vger.kernel.org, Lixu Zhang <lixu.zhang@intel.com>, 
	Sakari Ailus <sakari.ailus@linux.intel.com>, Bartosz Golaszewski <brgl@kernel.org>, 
	Kees Cook <kees@kernel.org>, "Gustavo A. R. Silva" <gustavoars@kernel.org>, 
	open list <linux-kernel@vger.kernel.org>, 
	"open list:KERNEL HARDENING (not covered by other areas):Keyword:b__counted_by(_le|_be)?b" <linux-hardening@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 12, 2026 at 12:19=E2=80=AFAM Rosen Penev <rosenp@gmail.com> wro=
te:
> On Wed, Mar 11, 2026 at 5:57=E2=80=AFAM Linus Walleij <linusw@kernel.org>=
 wrote:
> > On Tue, Mar 10, 2026 at 11:21=E2=80=AFPM Rosen Penev <rosenp@gmail.com>=
 wrote:
> >
> > > +       size_t num;
> >
> > What about naming it num_connect_modes?
> > (and unsigned in as Sakari says.)
>
> Too long IMO. Makes the most sense to match variable names.

This is one of those times I would bring up Rusty Russell's
API item #6 "The name tells you how to use it." well,
does it? Number of what?

Yours,
Linus Walleij
