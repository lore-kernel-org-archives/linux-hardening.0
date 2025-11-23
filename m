Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5791124113D
	for <linux-hardening@vger.kernel.org>; Sun, 23 Nov 2025 20:39:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763930342; cv=none; b=MpBkuHAqp3NiqBxMHYrAAxPgCdC8q0ibcYv9gwlUoRrobkrIbtlMQSqgoRJZxIYFNfKt1EzF62ry7cNhsa1Ez0CpheGXNfrNOTa9HD3Rg6tb/kla63wGENvYajEQ+DfxIKvbeqJsJ5NbWr/6tthSpLJAc84gInRUH2z6D+3t+Ss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763930342; c=relaxed/simple;
	bh=Xs/To29mUVJFqIVu8vqjiXrIIPpRQcJYIIXwXzOktko=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GJTNcHY8atogbtmr0gQleQVPiAWBdQ1cFUAkCEMNebnFLvv6DWDs+jyVliGg9DSnGQTOZTj9Uyv5hyU2UfWawuzgF8ZqXGgKTZpznsCDpsdndHnXHx8XppnwfhJXiKpulu6tcyYsq+9CXiUw3IHDxM0PG2Rvr/2k/51j5ih9N6Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b=Jvsl9HrC; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="Jvsl9HrC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 98137C16AAE
	for <linux-hardening@vger.kernel.org>; Sun, 23 Nov 2025 20:39:01 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
	dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="Jvsl9HrC"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
	t=1763930338;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=LrSg6VukRJewGGIoUsrxkct7GBnk0pK1zaPqwHrWy+I=;
	b=Jvsl9HrCFOxQ+NuaSA7V3Ixj9l9vDki/4rFATf1IKzWJJZNwiw+zJ+brnlm3ws8Rq9Nycm
	Aep1CAzVBBr4pbFEu+rZ54LJA1afz8U5qE5yTeTBWsrNBJSpIeqmVw/JwI87SKnjgjjJYJ
	ldK0/IxxPQJ5upAbRnYn0Mw3lIUv8oI=
Received: 
	by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id d15f7ff8 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <linux-hardening@vger.kernel.org>;
	Sun, 23 Nov 2025 20:38:58 +0000 (UTC)
Received: by mail-oa1-f43.google.com with SMTP id 586e51a60fabf-3e3dac349easo2902845fac.2
        for <linux-hardening@vger.kernel.org>; Sun, 23 Nov 2025 12:38:58 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVEwXoaif+qM9UftfNAKddlSkGRAH7cOHL0wjpT3cxTZA0YPzYoL7YrbnWK6OYxYiEjegUOV/XSVxzBOWvQLug=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz9ttGF4eHXU3dccHYYnupL5iBr2NuWr1ydAC/DW/Iib9kVzz0R
	co5H8xHGUzlaSz8mZzrzIcBym2IduDkoX12USRkEy5qjo7mOYR/dxt26TstzmMnd0sAY/U1h64o
	NY0BqKLjtO+pDTmNCnmfEiod6vC3sq7A=
X-Google-Smtp-Source: AGHT+IGuchnmQU0JHdzSOZG+k6fEPm1DXWlSHGDjZEdIdCnb/pIAXjCkzH7pNqzYbVWLdKCIH30wX7ueKMO0NXdawJs=
X-Received: by 2002:a05:6820:4dc3:b0:657:17a5:b314 with SMTP id
 006d021491bc7-65791d46c32mr3360136eaf.0.1763930337142; Sun, 23 Nov 2025
 12:38:57 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251122194206.31822-1-ebiggers@kernel.org> <CAMj1kXFSL9=TWzv35mSwVMVaKAQ=3n=w93=1+VSfKyDe+0A+Ow@mail.gmail.com>
 <20251123203558.GD49083@sol>
In-Reply-To: <20251123203558.GD49083@sol>
From: "Jason A. Donenfeld" <Jason@zx2c4.com>
Date: Sun, 23 Nov 2025 21:38:49 +0100
X-Gmail-Original-Message-ID: <CAHmME9qm8Xo6ccUUBm=QJ4X9BfTc3WgkmWohHsi_+xaGsgY4rw@mail.gmail.com>
X-Gm-Features: AWmQ_bl2jAP1lXYKpSLEdqnT6rpiVDxk5cD2sGi_qZgmIzUImiVUrYH2KULb0rw
Message-ID: <CAHmME9qm8Xo6ccUUBm=QJ4X9BfTc3WgkmWohHsi_+xaGsgY4rw@mail.gmail.com>
Subject: Re: [PATCH 0/6] lib/crypto: More at_least decorations
To: Eric Biggers <ebiggers@kernel.org>
Cc: Ard Biesheuvel <ardb@kernel.org>, linux-crypto@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Herbert Xu <herbert@gondor.apana.org.au>, 
	linux-hardening@vger.kernel.org, Kees Cook <kees@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Nov 23, 2025 at 9:37=E2=80=AFPM Eric Biggers <ebiggers@kernel.org> =
wrote:
>
> On Sun, Nov 23, 2025 at 09:31:19AM +0100, Ard Biesheuvel wrote:
> > On Sat, 22 Nov 2025 at 20:42, Eric Biggers <ebiggers@kernel.org> wrote:
> > >
> > > This series depends on the 'at_least' macro added by
> > > https://lore.kernel.org/r/20251122025510.1625066-4-Jason@zx2c4.com
> > > It can also be retrieved from
> > >
> > >     git fetch https://git.kernel.org/pub/scm/linux/kernel/git/ebigger=
s/linux.git more-at-least-decorations-v1
> > >
> > > Add the at_least (i.e. 'static') decoration to the fixed-size array
> > > parameters of more of the crypto library functions.  This causes clan=
g
> > > to generate a warning if a too-small array of known size is passed.
> > >
> >
> > FTR GCC does so too.
>
> See https://lore.kernel.org/linux-crypto/20251115021430.GA2148@sol/
> Unfortunately gcc puts these warnings under -Wstringop-overflow which
> the kernel disables, so we don't see them.  clang works, though.

Is that disabling new? Look at the commit message in my chapoly
patch... The warning shown there happened from a real live kernel
build.

Jason
