Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC60D39F175
	for <linux-hardening@vger.kernel.org>; Fri, 27 Mar 2026 08:12:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.171.202.116
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774599176; cv=none; b=LvrrRHFz1JWMIkclFECv0m6bXx6NCZL3z+AlGjtkxJR/UYcB3xa26EaeuEMst2X1IeQBa3jzQciq6Bj96DqGeMfxspvTpVtN9h40Gfq3eOvQo3m8ZMMUJ3CuppDfzjmSDRXDSGWQBd0gMwcGm16PP0HKBU0jiagCjcMcKY2dEeg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774599176; c=relaxed/simple;
	bh=OZGqJJfaEt/rjtDGos1NluAEyyy3h8Cy72WfdbXAyDI=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:Cc:To:From:
	 References:In-Reply-To; b=oJtFvN8KK+og06rJ1f44Jdv9zZd/x/1Mjo5B+JmYm83avHoGEPnltg1gc7fbFBRsLy5b4ibJ8JIDjHChZkmsifqbeKVqkm+pHUJcAW1nVWtT7xV10jeqDZ0W8qlW/XVBoAk8Xgm+Ype7Y3ur2JQ5qme9ohkP77LL9Glj+CD0rBM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=LkK7r9Ro; arc=none smtp.client-ip=185.171.202.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="LkK7r9Ro"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id 690DAC406B4;
	Fri, 27 Mar 2026 08:13:19 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id CB03D60230;
	Fri, 27 Mar 2026 08:12:50 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id C206510450F0D;
	Fri, 27 Mar 2026 09:12:47 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1774599169; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=OZGqJJfaEt/rjtDGos1NluAEyyy3h8Cy72WfdbXAyDI=;
	b=LkK7r9Rok7+IDw2bhHIfnlBcoX+sM7VqOTP5NqIAsNihE8APKIBgpkSo0dr3V0Lsr7lisE
	gQwHsbz1WX9XxTOaCZx1m7oLc0JldTCgVVlCy4Cj8cVwAQuHUSXqRoymRdHbZgdLN03Yl3
	EEDf/NGDgaCkx5hTyh899P+YqfDLpbk6CASDGuXWT2szmX0QR8yB4kw0wPBIIG461YO1tb
	Yr3+OJRKETu1T1z2PZaWAFYsx9uxlwbkSKo7ZfiUOx9FLM+3xyJPHCeqWReN+mF1T6KoaT
	6QgW1oE+2rOPYY2lsZNLIj5627NdxAHE1JHQJKp/ayE2gpJIG/Y60K1Dpy7x7w==
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 27 Mar 2026 09:12:46 +0100
Message-Id: <DHDEWIRRJTP1.58HXGTBGH4A@bootlin.com>
Subject: Re: [PATCH] i2c: atr: use kzalloc_flex
Cc: "Tomi Valkeinen" <tomi.valkeinen@ideasonboard.com>, "Wolfram Sang"
 <wsa+renesas@sang-engineering.com>, "Kees Cook" <kees@kernel.org>, "Gustavo
 A. R. Silva" <gustavoars@kernel.org>, "open list"
 <linux-kernel@vger.kernel.org>, "open list:KERNEL HARDENING (not covered by
 other areas):Keyword:b__counted_by(_le|_be)?b"
 <linux-hardening@vger.kernel.org>, "Cosmin Tanislav"
 <demonsingur@gmail.com>, "Romain Gantois" <romain.gantois@bootlin.com>
To: "Rosen Penev" <rosenp@gmail.com>, <linux-i2c@vger.kernel.org>
From: "Luca Ceresoli" <luca.ceresoli@bootlin.com>
X-Mailer: aerc 0.20.1
References: <20260327030310.8502-1-rosenp@gmail.com>
In-Reply-To: <20260327030310.8502-1-rosenp@gmail.com>
X-Last-TLS-Session-Version: TLSv1.3

Hello Rosen,

+Cc Cosmin, Romain

On Fri Mar 27, 2026 at 4:03 AM CET, Rosen Penev wrote:
> Convert kzalloc_obj + kcalloc to kzalloc_flex to save an allocation.
>
> Add __counted_by to get extra runtime analysis.
>
> Signed-off-by: Rosen Penev <rosenp@gmail.com>

This is the second version of the previous patch, so the subject line
should start with "[PATCH v2]". You may try using b4 to automate this, it
takes over this and many other boring-but-useful details.

Additionally I suspect b4 would have a more complete Cc list, including
recent contributors to this driver like Cosmin Tanislav and Romain Gantois
who might want to review this patch. I'm Cc-ing them this time.

> ---

Also a changelog would be nice after the '---' marker, to help reviewers,
and a link to previous versions. It took a moment to me to realize I had
already reviewed almost the exact same code.

Other than than the patch looks good:

Reviewed-by: Luca Ceresoli <luca.ceresoli@bootlin.com>

--
Luca Ceresoli, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
