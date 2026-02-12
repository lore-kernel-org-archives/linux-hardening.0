Received: from forward501b.mail.yandex.net (forward501b.mail.yandex.net [178.154.239.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A04B1E7C23;
	Thu, 12 Feb 2026 11:19:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.154.239.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770895173; cv=none; b=geGmv33Fr82D04/m+N9/SlVhSpDaod6F+JSIGEo5Tba4prXQJhHf8EpseM6HDr4Gl/73Yu+EIbhMMwoh9iMZGFvd5DBBc4CVzqFCS3UHTXMGFMf5HfiIxko2niYbyMTN+Q6lSSPXHDxi8wTQS8ddp9FaMHLnLlQSP+0Ve8o1S9A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770895173; c=relaxed/simple;
	bh=nhrsSkaCVo2m4HhNpCGvb70oeVPmlnWGCxV0ty/eYsw=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=PoVGg/O4LqqJIoPzUAUrPfxSwZZNajJ82LqLhGRMFwoS9vbiEZ6QsW4uKfyBavIPz3cctWqnWbwejd2OH1GeyycujZBqZAjXQcWxJRAy6+lnX6laVHs5nobuBbwQxE+5qky9KJDjhoiWsiISHoW1A5fKlgquUFuUyaY7I8tl7O4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex.ru; spf=pass smtp.mailfrom=yandex.ru; dkim=pass (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b=cfkIGyMd; arc=none smtp.client-ip=178.154.239.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yandex.ru
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b="cfkIGyMd"
Received: from mail-nwsmtp-smtp-production-main-74.sas.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-74.sas.yp-c.yandex.net [IPv6:2a02:6b8:c24:1698:0:640:befc:0])
	by forward501b.mail.yandex.net (Yandex) with ESMTPS id D522089D44;
	Thu, 12 Feb 2026 14:13:17 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-74.sas.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id GDSRnV9G4uQ0-Bi8zTBTc;
	Thu, 12 Feb 2026 14:13:17 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail;
	t=1770894797; bh=5f9J4ku+28W/h8uT0eiVMVZ7+dverkzco0L9EX6ZO6o=;
	h=References:Date:In-Reply-To:Cc:To:From:Subject:Message-ID;
	b=cfkIGyMd0emydD03D+UP/0ky4YKc+/wasKv6wWl6ZLVDTcfZhHDBEMDrNRlWbD4Ds
	 FxpS24mSy1qmOisuAJF0Dijw8bSrFDjU8RBfyYIOBAbrJl3SVyK0pL5G6Aly39UMmj
	 3TmZLDvRWs2lbuLS3z29AoU6fZToj7IzD1Jc0pvM=
Authentication-Results: mail-nwsmtp-smtp-production-main-74.sas.yp-c.yandex.net; dkim=pass header.i=@yandex.ru
Message-ID: <14e1e0ac3b2622f762c8f369afc9b1e9a84ca66b.camel@yandex.ru>
Subject: Re: [PATCH v6 1/5] lib: fix _parse_integer_limit() to handle
 overflow
From: Dmitry Antipov <dmantipov@yandex.ru>
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, David Laight	
 <david.laight.linux@gmail.com>, Kees Cook <kees@kernel.org>, "Darrick J .
 Wong"	 <djwong@kernel.org>, linux-hardening@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Date: Thu, 12 Feb 2026 14:13:16 +0300
In-Reply-To: <aYrgASJXAyoholbF@smile.fi.intel.com>
References: <20260209164757.433932-1-dmantipov@yandex.ru>
	 <20260209164757.433932-2-dmantipov@yandex.ru>
	 <aYrgASJXAyoholbF@smile.fi.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.2 (3.58.2-1.fc43) 
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2026-02-10 at 09:36 +0200, Andy Shevchenko wrote:

> I don't see how max_chars is used. With that said, I would rather see the=
 usual
> way of expressing the condition in the for-loop:
>=20
> 	for (rv =3D 0; rv < max_chars; rv++, s++) {

This will break the loop (and so stop consuming characters) if KSTRTOX_OVER=
FLOW
bit is set.

> > +		if (likely(res !=3D ULLONG_MAX)) {
>=20
> Have you seen David's question about these checks?
> Maybe I missed your answer...
>=20
> > +			if (unlikely(res & (~0ull << 60))) {

The first check may be dropped indeed (assuming check_mul_overflow(ULLONG_M=
AX, a, b)
and check_add_overflow(ULLONG_MAX, a, b) always signals an overflow).

Dmitry
