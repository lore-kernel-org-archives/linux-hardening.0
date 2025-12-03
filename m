Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED71033ADAC
	for <linux-hardening@vger.kernel.org>; Wed,  3 Dec 2025 16:59:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764781175; cv=none; b=kA9Qs4H13lnrASeX9tD03YURIDcfCJmJcghJIrd+P5Fc2vfwG0IVrVrYPxeDu45H3mpIr52K8JBggjyhVs/OXUG1M4h6XyY6lCf/KVpx6rus7J+LOQxmb/4xJviX0UHOBxeD+Iei9GBtKkrdU93tns0fRbASlw1iGj+JxZ+nY/M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764781175; c=relaxed/simple;
	bh=GLNw0G6b149MCzPLLEzRuLxoLDWEj7jHYuM/qIPSZAs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rgU1GpBFrCJkyYy3MamEFLRNGRGuAvsv8SMpXopLR+5Fjj4P4YZtXGmyVPVJcR0i0BEkqsKLZDCTrt2CcBtptxL7GUB3ZArYZeAw4DBxp2z+n+AORHkD4QSMBuYudQfLGXSnq/yyDk6SEj2NBLoTQRyr3Aq15tbbb/pUIVAlAgo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Jvwgrgcf; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Jvwgrgcf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9EDB9C19423
	for <linux-hardening@vger.kernel.org>; Wed,  3 Dec 2025 16:59:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764781174;
	bh=GLNw0G6b149MCzPLLEzRuLxoLDWEj7jHYuM/qIPSZAs=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=JvwgrgcfGebBMg0+kif06uP4+Vu1gxC5loY2xSXlJZtgAzlldFv8S4vy2RyKW8TJf
	 wN2B9KwnwO8jdAxqox8WRFRELSKTOJcpDSnY/Ie2MCFmVBRE1wiWIWYfSTxe3bBQJ1
	 rhFRiWN3jpbitk07IXTF/9atAtyiqJUI6Iqk4RY1sUg0u15qWiirDgKJ0xcp9jhazb
	 eLsEuxM8bIxpnLNnDUImwJTE78o0h4A8RBdofvlLtcuwKfNhhgAVFtVPNE5z/50OwK
	 9wU5vsbUGkEXfMItdT/sF9Obxsbn6iaroqOtWfdz72NKOVyUgo1L/gYEsGuLmrcR+M
	 AEvyvB3KedC5A==
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-37a33b06028so63110181fa.2
        for <linux-hardening@vger.kernel.org>; Wed, 03 Dec 2025 08:59:34 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWKZrUoHDxGIH8DfpoEzslOdAM5Zgv2WaamlhZVeHQpeqPDuHwbXJOty4XOGQYkLAnJKnmWt8p1TD16ahMNHGQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx1Ic6RQAjryj0HjcWrsKi8o+t/KxnPpKWEQIb5m9fmMP7C7Gfe
	T0qYrTmswaNnksYk7k8go6PvFOSDeNuoCp4DbsKfXO9QDb299Tj0ZRGHdd7A/3J1G27/+rM8cVs
	JAF1/HmIvbV3UCw/HnMjW5fEef3TFOyU=
X-Google-Smtp-Source: AGHT+IFxEQ2Jijkxcdh/scou3ByOpWOH6CyVQrhGC1j+BRsw+a4wNEkslTkW0FzZgwwrgB0TC7sHeOVJskTQid6Ey9M=
X-Received: by 2002:a05:6512:3a95:b0:594:51ac:13e with SMTP id
 2adb3069b0e04-597d3f5be96mr1435500e87.17.1764781172972; Wed, 03 Dec 2025
 08:59:32 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251127092226.1439196-8-ardb+git@google.com> <20251127092226.1439196-10-ardb+git@google.com>
 <20251127150614.GA3271003@e124191.cambridge.arm.com>
In-Reply-To: <20251127150614.GA3271003@e124191.cambridge.arm.com>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Wed, 3 Dec 2025 17:59:21 +0100
X-Gmail-Original-Message-ID: <CAMj1kXHhSFj-ScYXCZu=9SyWp8j3ZrO4qwOcmKLZ9FBLwN6-Qg@mail.gmail.com>
X-Gm-Features: AWmQ_bmIzYenu2M9X7IlJutEKtuuegnOzOylc9adBpVGEOeCZ6TUe0IIN3luTYU
Message-ID: <CAMj1kXHhSFj-ScYXCZu=9SyWp8j3ZrO4qwOcmKLZ9FBLwN6-Qg@mail.gmail.com>
Subject: Re: [RFC/RFT PATCH 2/6] arc: Wire up cmpxchg64_local() to generic implementation
To: Joey Gouly <joey.gouly@arm.com>
Cc: Ard Biesheuvel <ardb+git@google.com>, linux-hardening@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	Kees Cook <kees@kernel.org>, Ryan Roberts <ryan.roberts@arm.com>, Will Deacon <will@kernel.org>, 
	Arnd Bergmann <arnd@arndb.de>, Jeremy Linton <jeremy.linton@arm.com>, 
	Catalin Marinas <Catalin.Marinas@arm.com>, Mark Rutland <mark.rutland@arm.com>, 
	"Jason A. Donenfeld" <Jason@zx2c4.com>
Content-Type: text/plain; charset="UTF-8"

On Thu, 27 Nov 2025 at 16:06, Joey Gouly <joey.gouly@arm.com> wrote:
>
> On Thu, Nov 27, 2025 at 10:22:29AM +0100, Ard Biesheuvel wrote:
> > From: Ard Biesheuvel <ardb@kernel.org>
> >
> > Provide cmpxchg64_local() for hexagon so we can start using it in
> > generic code.
>
> nit: this is for arc, not hexagon.
>

Indeed, thanks!
