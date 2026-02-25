Received: from forward500d.mail.yandex.net (forward500d.mail.yandex.net [178.154.239.208])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A4C92C21DF;
	Wed, 25 Feb 2026 06:58:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.154.239.208
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772002722; cv=none; b=mJTwkBiLjO5NBQG+AQF58yVfwAYnJmfKWcJUlb4GW43hk15Pgp51ctH0mycMh4FC9d4hy1KjsjhgX6l0HgnbgWX20Wx4YThUbzVBOuRd83AlskLw766J7TxSgveQ6YxZdPEEfuz/w4JnvqvraTnUD2qate8d/xoD350/xb6hBYo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772002722; c=relaxed/simple;
	bh=UUnbu1AvaVUjFLrFgtgIFJ9LM7Ct+YXnwP6ZchgUaLM=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=aQP9zgf/8SUenEgj8OMEoqZksmyJE8awDCN9Y5P0/BIwzOqpsbnREZkqF2Y6TaXm0VK9iWUO6nUrEOi/R6/rKeOaH8UUILSFTduq6hLBva1iIMW5Ecb2wpOLcgoIBLe1Nqpx9wP57859WBncijf8ILsKDyRChkq6qS8ClqmNJ6I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex.ru; spf=pass smtp.mailfrom=yandex.ru; dkim=pass (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b=cLwUKliy; arc=none smtp.client-ip=178.154.239.208
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yandex.ru
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b="cLwUKliy"
Received: from mail-nwsmtp-smtp-production-main-81.klg.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-81.klg.yp-c.yandex.net [IPv6:2a02:6b8:c42:3d48:0:640:52d7:0])
	by forward500d.mail.yandex.net (Yandex) with ESMTPS id A890783CA0;
	Wed, 25 Feb 2026 09:58:34 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-81.klg.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id WwaTsClG0Cg0-WVs288Bd;
	Wed, 25 Feb 2026 09:58:34 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail;
	t=1772002714; bh=0ZNQLUZjuSTwJtQMEurZv9D4TeutYoBFTB38t4pvmoo=;
	h=References:Date:In-Reply-To:Cc:To:From:Subject:Message-ID;
	b=cLwUKliyxqzxnCp0gOjMU5dPEHX0HoLKIhrDPA0TcJ6jJUm+Y07VEgyTz+/oqma6v
	 Y9FUPQgyFW+2IlbMpr733vu1K7To7SfPvjaLauAVL0GN9mLo3QZLffMPut0MQ2gO2r
	 hRRNXrTqmXnkU0BooCXt4/PZ9EPOlErjzcqArhFM=
Authentication-Results: mail-nwsmtp-smtp-production-main-81.klg.yp-c.yandex.net; dkim=pass header.i=@yandex.ru
Message-ID: <61b376fd2acf6e8cf8a90ee4eb7d58397f2acfa1.camel@yandex.ru>
Subject: Re: [PATCH v8 2/5] lib: fix memparse() to handle overflow
From: Dmitry Antipov <dmantipov@yandex.ru>
To: Rodrigo Alencar <455.rodrigo.alencar@gmail.com>, Andy Shevchenko
	 <andriy.shevchenko@intel.com>, Andrew Morton <akpm@linux-foundation.org>
Cc: David Laight <david.laight.linux@gmail.com>, Kees Cook
 <kees@kernel.org>,  "Darrick J . Wong"	 <djwong@kernel.org>,
 linux-hardening@vger.kernel.org, 	linux-kernel@vger.kernel.org
Date: Wed, 25 Feb 2026 09:58:32 +0300
In-Reply-To: <pwycaqzyfpan3eglq6hwx4esyfm2w2buvvaqtcqw3aco5y3trq@2ft2ajxaqobu>
References: <20260212164413.889625-1-dmantipov@yandex.ru>
	 <20260212164413.889625-3-dmantipov@yandex.ru>
	 <umfxjjw2iukw5knj5xn5lxtkr2keorq3sws2mnegmw3zr64bmg@77v4cqwi2fay>
	 <pwycaqzyfpan3eglq6hwx4esyfm2w2buvvaqtcqw3aco5y3trq@2ft2ajxaqobu>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.3 (3.58.3-1.fc43) 
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2026-02-24 at 14:15 +0000, Rodrigo Alencar wrote:

> > I am interested on having _parse_integer_limit() overflow check
> > exposed to kernel modules.

Hm... _parse_integer_limit() may be EXPORT_SYMBOL()ed of course.
But are you sure that current API is not enough for your task?

> > ...
>=20
> I could propose the exposure of simple_strntoull() which is private
> to lib/vsprintf.c, slightly changing its prototype:
>=20
> * from:
> unsigned long long simple_strntoull(const char *startp,
> 				=C2=A0=C2=A0=C2=A0 char **endp,
> 				=C2=A0=C2=A0=C2=A0 unsigned int base,
> 				=C2=A0=C2=A0=C2=A0 size_t max_chars)
> * to:
> int simple_strntoull(const char *startp,
> 		=C2=A0=C2=A0=C2=A0=C2=A0 char **endp,
> 		=C2=A0=C2=A0=C2=A0=C2=A0 unsigned long long *result,
> 		=C2=A0=C2=A0=C2=A0=C2=A0 unsigned int base,
> 		=C2=A0=C2=A0=C2=A0=C2=A0 size_t max_chars)
>=20
> That would allow to tackle the FIXME tag. I suppose it is there
> because the overflow flag is being ignored, so the returned integer
> can be set to -ERANGE or -EOVERFLOW when overflow happens.

Well, removal of KSTRTOX_OVERFLOW quirk may be a subject for the next serie=
s.

Dmitry
