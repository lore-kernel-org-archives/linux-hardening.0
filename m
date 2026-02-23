Received: from lithops.sigma-star.at (mailout.nod.at [116.203.167.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34C67379988;
	Mon, 23 Feb 2026 21:52:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.167.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771883582; cv=none; b=K1Sk1qUmOwajZWBkTKQYJ06bQEC99LzCWOn/fpn9fbf4/2QHCFFy2PKEDjcnqFKDmWGDfgqRx7TmT3cHp5jPIYK1BdD+ebAfYlC68SL/frbfTbttBWZQ4vmVub1s6F5KjnisURkk6CYTE3YQN2XntS9IdKQYQdMpHhSuKDCe1D8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771883582; c=relaxed/simple;
	bh=23EdARInHQbn9UQZ4Ze1RUj9umLs+AsB6ZkBrB7Nyg8=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=kJVDDhON0xo0d1jpnQGPCxGC2UkDNp08UkGJOMfQAARFJS1OwlgJqvTTpw/vH/cBhFm++C+WNfl6mQ6t3qpifn4eYNfavbJqEKKQDKRpBtnkR4Bq9lccxK9iO+eyuMcdk4drmqbvts7JCdqs2/DizFXzPd5C0R+HGY1az6tp89c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nod.at; spf=fail smtp.mailfrom=nod.at; arc=none smtp.client-ip=116.203.167.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nod.at
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nod.at
Received: from localhost (localhost [127.0.0.1])
	by lithops.sigma-star.at (Postfix) with ESMTP id 08D87244B24;
	Mon, 23 Feb 2026 22:52:57 +0100 (CET)
Received: from lithops.sigma-star.at ([127.0.0.1])
	by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10032)
	with ESMTP id T9J9XODYy7yM; Mon, 23 Feb 2026 22:52:56 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by lithops.sigma-star.at (Postfix) with ESMTP id B31AA244B26;
	Mon, 23 Feb 2026 22:52:55 +0100 (CET)
Received: from lithops.sigma-star.at ([127.0.0.1])
	by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id Wy8rytRbA5QY; Mon, 23 Feb 2026 22:52:55 +0100 (CET)
Received: from lithops.sigma-star.at (lithops.sigma-star.at [195.201.40.130])
	by lithops.sigma-star.at (Postfix) with ESMTP id 4DAC5244B24;
	Mon, 23 Feb 2026 22:52:55 +0100 (CET)
Date: Mon, 23 Feb 2026 22:52:54 +0100 (CET)
From: Richard Weinberger <richard@nod.at>
To: Kees Cook <kees@kernel.org>
Cc: Nathan Chancellor <nathan@kernel.org>, Guenter Roeck <linux@roeck-us.net>, 
	anton ivanov <anton.ivanov@cambridgegreys.com>, 
	Johannes Berg <johannes@sipsolutions.net>, 
	Jens Axboe <axboe@kernel.dk>, Hannes Reinecke <hare@suse.de>, 
	"Martin K. Petersen" <martin.petersen@oracle.com>, 
	Tiwei Bie <tiwei.btw@antgroup.com>, 
	linux-um <linux-um@lists.infradead.org>, 
	Al Viro <viro@zeniv.linux.org.uk>, 
	linux-kernel <linux-kernel@vger.kernel.org>, 
	linux-hardening <linux-hardening@vger.kernel.org>
Message-ID: <905832921.1560.1771883574809.JavaMail.zimbra@nod.at>
In-Reply-To: <20260223214341.work.846-kees@kernel.org>
References: <20260223214341.work.846-kees@kernel.org>
Subject: Re: [PATCH] ubd: Use pointer-to-pointers for io_thread_req arrays
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Mailer: Zimbra 8.8.12_GA_3807 (ZimbraWebClient - FF147 (Linux)/8.8.12_GA_3809)
Thread-Topic: Use pointer-to-pointers for io_thread_req arrays
Thread-Index: G+WYJ58A7oYNOlTL/FXMTchaZRbPMg==

----- Urspr=C3=BCngliche Mail -----
> Von: "Kees Cook" <kees@kernel.org>
> An: "richard" <richard@nod.at>
> CC: "Kees Cook" <kees@kernel.org>, "Nathan Chancellor" <nathan@kernel.org=
>, "Guenter Roeck" <linux@roeck-us.net>, "anton
> ivanov" <anton.ivanov@cambridgegreys.com>, "Johannes Berg" <johannes@sips=
olutions.net>, "Jens Axboe" <axboe@kernel.dk>,
> "Hannes Reinecke" <hare@suse.de>, "Martin K. Petersen" <martin.petersen@o=
racle.com>, "Tiwei Bie"
> <tiwei.btw@antgroup.com>, "linux-um" <linux-um@lists.infradead.org>, "Al =
Viro" <viro@zeniv.linux.org.uk>,
> "linux-kernel" <linux-kernel@vger.kernel.org>, "linux-hardening" <linux-h=
ardening@vger.kernel.org>
> Gesendet: Montag, 23. Februar 2026 22:43:45
> Betreff: [PATCH] ubd: Use pointer-to-pointers for io_thread_req arrays

> Having an unbounded array for irq_req_buffer and io_req_buffer doesn't
> provide any bounds safety, and confuses the needed allocation type,
> which is returning a pointer to pointers. Instead of the implicit cast,
> switch the variable types.
>=20
> Reported-by: Nathan Chancellor <nathan@kernel.org>
> Reported-by: Guenter Roeck <linux@roeck-us.net>
> Closes:
> https://lore.kernel.org/all/b04b6c13-7d0e-4a89-9e68-b572b6c686ac@roeck-us=
.net
> Fixes: 69050f8d6d07 ("treewide: Replace kmalloc with kmalloc_obj for non-=
scalar
> types")
> Signed-off-by: Kees Cook <kees@kernel.org>
> ---
> Cc: Richard Weinberger <richard@nod.at>
> Cc: Anton Ivanov <anton.ivanov@cambridgegreys.com>
> Cc: Johannes Berg <johannes@sipsolutions.net>
> Cc: Jens Axboe <axboe@kernel.dk>
> Cc: Hannes Reinecke <hare@suse.de>
> Cc: "Martin K. Petersen" <martin.petersen@oracle.com>
> Cc: Tiwei Bie <tiwei.btw@antgroup.com>
> Cc: <linux-um@lists.infradead.org>
> ---
> arch/um/drivers/ubd_kern.c | 10 +++++-----
> 1 file changed, 5 insertions(+), 5 deletions(-)

Acked-by: Richard Weinberger <richard@nod.at>

Thanks,
//richard
