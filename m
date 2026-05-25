Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65B2C3DC4D0
	for <linux-hardening@vger.kernel.org>; Mon, 25 May 2026 08:10:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779696621; cv=none; b=Id5Y8pfb27f/ZpjcodHWBv5I4y6BO7QkRZAWtjYUCK7ExHufFN7x5yFRlqCqqoRgp7sGCxpm5CDGCL0Ihf/Qq8Y1BxL6ryqOoPQ2InOIAICaP97cDvap0E499u+z/UR5Kbqh7vaMg+T/e/zmous48K31iBcC62KzNrJ+lNiE694=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779696621; c=relaxed/simple;
	bh=kppKC02SPWGevMCIBIKVt+x2mcxmdbvbJlks0CtpFXw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YeeJCjEwPyPMQkjr9YazJk6JGugyVDrEBPBvULGrWBjRcEOUhmVlHXUgv3r4CbKs87Em0ELSJxIWoizEpqYrhT2zP7ryK4/8rwbXbNQZzLL0Zl4tugr6HP0jtaCZMNbgw3nJzJ6AzS3Y83KT0C8puQ4s2BY8qt7E+UFOvSiReaQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=o0a6IpFf; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="o0a6IpFf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C62DC1F00A3A
	for <linux-hardening@vger.kernel.org>; Mon, 25 May 2026 08:10:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779696617;
	bh=kppKC02SPWGevMCIBIKVt+x2mcxmdbvbJlks0CtpFXw=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=o0a6IpFfh+9K7uPekwzkGW3kZ8NOcX485sQJ5+Q0LkPJv73atNadBbvjUTzQJhCYT
	 6OxdlhdM7nJ4rkdCyfO3OCBn1nP4NI7qXlyllKVRiOhS2fVPuMAW0ty08y0HPEHz70
	 GK1DyDkzrmKsYGOoUufkpcbA6nvAO4HUqea8Mw9pT9wETR7mRZ4oJXQyaa7tzpSxi0
	 PBsh1Mv926/sBd6xK11Py3clytTeQ4TNiyGcR1n93hoXirS1UMgvTIjh8e6cOoLkr6
	 nz6djIFKuwDf6gmVqsCKpuKdDzHsJ2Qr1rMtEG98gCCdgwNEh9l99XVdIr4hySJgUW
	 /MDDT/7VzAYrA==
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-5a8e33556c0so11323255e87.0
        for <linux-hardening@vger.kernel.org>; Mon, 25 May 2026 01:10:17 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ81cBeN441NoMSn8Ls9yCiwyiTM1lRjYZjsAoUkFjp9N5EuePOm7ENXCK2ZP9hVEWcqWgzwg/dPBDuhWXCGzSg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwtrAMMTOrq0mHfsd9ca9eUwMxM4dcVsg4RQ5ab/wmtQ92Qfkl6
	aK9JjA3iPYaW7XFBhVdHcKAVgginGuDV7qr6BOH6wC6mFprqavWWl8sFf8ZNF54p1HtdxUOsWSq
	Zr/C7gE1/cQo/AkuM3Nw6EHUm/pekoOQ=
X-Received: by 2002:a05:6512:6486:b0:5a3:ff:cf83 with SMTP id
 2adb3069b0e04-5aa2ba69220mr4159280e87.7.1779696616626; Mon, 25 May 2026
 01:10:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260516105737.45174-1-len.bao@gmx.us>
In-Reply-To: <20260516105737.45174-1-len.bao@gmx.us>
From: Linus Walleij <linusw@kernel.org>
Date: Mon, 25 May 2026 10:10:02 +0200
X-Gmail-Original-Message-ID: <CAD++jL=5W56YAgJ8o7XXZRJQ_LJxW87SPc_C0VEYW0EccxpJ5Q@mail.gmail.com>
X-Gm-Features: AVHnY4L4wsU4sQ0-5AxCn0tp1JcG0jEo8KLQSs8UJdS_b33DPk9WQZ0hZbchbQQ
Message-ID: <CAD++jL=5W56YAgJ8o7XXZRJQ_LJxW87SPc_C0VEYW0EccxpJ5Q@mail.gmail.com>
Subject: Re: [PATCH] gpiolib: Mark gpio_devt, gpiolib_initialized and
 gpio_stub_drv as __ro_after_init
To: Len Bao <len.bao@gmx.us>
Cc: Bartosz Golaszewski <brgl@kernel.org>, linux-gpio@vger.kernel.org, 
	linux-kernel@vger.kernel.org, 
	"open list:KERNEL HARDENING (not covered by other areas):Keyword:b__counted_by(_le|_be)?b" <linux-hardening@vger.kernel.org>, Kees Cook <kees@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Len,

thanks for your patch!

On Sat, May 16, 2026 at 12:58=E2=80=AFPM Len Bao <len.bao@gmx.us> wrote:

> The 'gpio_devt' and 'gpiolib_initialized' variables are initialized only
> during the init phase in the 'gpiolib_dev_init' function and never
> changed. So, mark these as __ro_after_init.
>
> The 'gpio_stub_drv' variable is initialized only in the declaration and
> never changed. So, this variable could be 'const', but using the
> 'driver_register' and 'driver_unregister' functions discards the 'const'
> qualifier. Therefore, as an alternative, mark it as a __ro_after_init.
>
> Signed-off-by: Len Bao <len.bao@gmx.us>

Patches like this should be CC to linux-hardening.

Anyways it looks good to me!
Reviewed-by: Linus Walleij <linusw@kernel.org>

Yours,
Linus Walleij
