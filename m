Received: from mail-ej2-f42.google.com (mail-ej2-f42.google.com [74.125.228.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81BB446E019
	for <linux-hardening@vger.kernel.org>; Mon, 28 Sep 2026 08:12:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.228.170
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790583154; cv=pass; b=WUUJmfsgPE/4pO3TG6wWiMsg0ofnQPQAnJVSoerl1STNK1C00YE4SYzmOHLdBJQwLBrylKOjfuL5sv5oANvHsH/jdfa/+0fe+G+14p7aERDQOeQlg0Nt0irgAix/eSraavv7TpLPaJqi8YTQTpRL34jcZqulAMED1X8doci+yuw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790583154; c=relaxed/simple;
	bh=z5il5iLEAXne22CvI2hr1JfqhTjdsIamCjtdwPqG6TQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CM/p2puk/gKyI0TFY3M79kzbCuK3niVHnTDL22aW/rw5xuL03ROmi5e8iHXFpHkkhwS7fi9Fpo9odcXOUtXJFc6ZFBMNet+wfVZioRsuE8nI7jCKOZBun4v3IG96DH4zr8dqAu0aC2SQCOLtpF4D0I1JKRokUZUa7aBLOq4eWG0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TFJUGb2e; arc=pass smtp.client-ip=74.125.228.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TFJUGb2e"
Received: by mail-ej2-f42.google.com with SMTP id a640c23a62f3a-c2c996fd607so99185566b.0
        for <linux-hardening@vger.kernel.org>; Mon, 28 Sep 2026 01:12:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790583151; cv=none;
        d=google.com; s=arc-20260327;
        b=HeKs8u2foPjKAMNDxA+RhtbTQtainDzJDMeG4M6o/4kjVhuTKefW8UyTzkelf99J8R
         NeAv9gwxQ6QZB223iINTIKjcUAv/hBSqFpvoTIXPtKj9CdclO+NokvH7bxPQtvMDhh6o
         UYUD8Xj6+U2lEXD4n9+8x4T50f5pJd33KBmTww1PDH9Q9Lm2FwQ/VTn+YwtGlZSpVjLF
         DkrleN463Pgb+OsPwVN4oYUdxg50p9eWbH8xo1EpUsFE+brRniWCqWa00eQRkWFAnB+o
         fvTEGD06ua7vYAHPt44RdiPwN/ndfy5GTIsoFw/qeBgJCLdoZ1zTAnLKGjCmEV29lorG
         8lmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=z5il5iLEAXne22CvI2hr1JfqhTjdsIamCjtdwPqG6TQ=;
        fh=EBWXnXnA/eBZrDAhkPS8uI4bycnfggSJD150mpiBHkc=;
        b=l59gEdiwt2UdgvDmVeHYS2yfz2lhDcTP/xf4j4F4vVHbsxspm0/AdaWRh9AQgcMw+o
         JaWTunkUfOJ4TTR5fr6zEZci5eRSA9p1lEd7hTCbDTXUNKt8VB8KRdoMR+N51W0Gyt/Q
         lYZlliMgu7Qh/VDTHLWOYmCx/ijorpc0prP7fUmN0g/kvdPdBFrbFSQlgcxnd2utk2m3
         xdJwU0gJdKF7QqX0HINfycpFCW/p+3x1ef0XVqp6rozt8RcJmAGyt/IK+hEVZEtuHN7x
         Gc/NkJNR4kPwNtHes87uv7XoZtD0hGwVxO8lEV73RdjkPXN4cubVXpCGGaNDPYkoOrJu
         LNLA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790583151; x=1791187951; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=z5il5iLEAXne22CvI2hr1JfqhTjdsIamCjtdwPqG6TQ=;
        b=TFJUGb2eTFWXjZWpTjlcr54KoNdzb0ctqe8Oh7fuka/MB2hrrqRyrcHnFdZu7E086w
         Y2uQ6Lr2WnM9ksqKpVdDP1xYi8nnncRsOU2Qi8BDaZWGHk4SLRKD25AbfSPV8nqiEEtt
         LMUDJMem56F2Hw+lPTs91C+hCMAeTw1mUDRqvjW/PXX30EW5It3hH4DYtPyK8lC20Fro
         w7sY7tQBbjlrLuBeMRRlMrlQxPNzCcZXDIKIElm6d/nn+BYBBRufI5DmjLOEkdLTeQb/
         m6TU2DB1lW4NSA/IYkkAz99NZE2jV1ebpSMKZySuJk4h1vvGLQtYd11y6Gp7+f9XFJLX
         zzZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790583151; x=1791187951;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=z5il5iLEAXne22CvI2hr1JfqhTjdsIamCjtdwPqG6TQ=;
        b=dtDp9P+WjLdw4nGXlvihFEPsz0X0NWE/5N/VE9hAlBLY4/c+27TIjtQiwb4z4u1YkR
         7PVbYeymnjSAaNvbh5VAeRCJXOmkENb7ovQMybiujilYca5Jv0No6cCFB/+vu/GpcEjF
         6KW6sd4JoZ2tvMjIjRceeqGLG6b+nu3k9hQZ2YJd1jBF74fQziAws1E2JKwlJYQgn3b0
         SiDEVj+Zm9lfHlcvSHqEPdyPDj1wyI8A20wTm6ei+A43lH03tVZHhNREuJPX754jS/zm
         YgQ6md8vqxTfISI/PKLBDDonqswAfjg6dj5M5aAHAv8+eL95vY/UZ7MKg8UzcOaOewSF
         4Opw==
X-Forwarded-Encrypted: i=1; AKwUvBzEAho0GBFUYh9vTR6zcDrHthL3iQvcGOra4x0N6IUY1UIi/BdoqW3ePCBknHCzWtiB5FUKl3E5Chv1lwP8RzQ=@vger.kernel.org
X-Gm-Message-State: AFuF++n825uBGQRaPRjIeXGpctV9KHn1VEhMjWJDm4HTvRIqADrlnk4R
	m3NHhR8VPGspWI09lfdtGsm/Fke0cqkSc3/EkuzADxrNmGhrcAFwUakYlJer1kipQd9RWi0DqtS
	ucSnSmP0s6ok6eP/2QpDgzxhWMSQvJGI=
X-Gm-Gg: AYBFou2/Q18ZTK65LdylwSEk0LOHkm+aEjEg99Oz412ZO6H4kca1eXReRlTPVbDwTgB
	kKWx5Xh17GjB6ZB5b9lFuPF7GmuqHm68wNTSy5VwRudKsvn5tO7EMhHBPDuT6rJrpz/dotfri83
	BWPRXayDtl/gLi6Ji6U6SjyBeMipGpA7Ym75blGJ9FKA8fPah+4ky8KOL94gKqrUGN6rP6MHWre
	Tu79+FGxqxzX1PGm15caN4FMzArRp4CGTnLkLKm8l54kb7CJEPmkpTk9wDe7gkFcFODoMCfDiZO
	rKsnXgFVSsDcmQvXOOAHjChnwghIjsGPGMx4ZEF3Yifyv6ytX2K3mnIt75AxKumFolJBeaW8Mnn
	D8fGjcgmnS0Qu05nOTPtxhdhQtmA8u1k2lbqbECrFEMfmrElO4fdtbohlYL5DQvCmE8b3DWIdis
	UMObOUjhu1jpGi8obD8mz6ulw8wUIefyxB7qmo5gyPQfxBtEoP9sI=
X-Received: by 2002:a17:907:9445:b0:c15:a7b9:2ae1 with SMTP id
 a640c23a62f3a-c2ac2240116mr1123056066b.6.1790583150489; Mon, 28 Sep 2026
 01:12:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260926205708.384308-1-meatuni001@gmail.com>
In-Reply-To: <20260926205708.384308-1-meatuni001@gmail.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Mon, 28 Sep 2026 11:11:53 +0300
X-Gm-Features: AclHuK9D8qRVgBG-QEUy3UMVCseEKQ9HNcOf9R8MNobcvmS6Q91d5O4vq8jd4pU
Message-ID: <CAHp75Vdj8qVY-hCoCxxd1Pg2JaaDjc+QgAK-G=w+Cb=FTYYJEQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] lib/string_helpers: add ESCAPE_BACKSLASH flag to string_escape_mem()
To: Muhammad Bilal <meatuni001@gmail.com>
Cc: Kees Cook <kees@kernel.org>, Andy Shevchenko <andy@kernel.org>, 
	=?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>, 
	linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Sep 26, 2026 at 11:57=E2=80=AFPM Muhammad Bilal <meatuni001@gmail.c=
om> wrote:
>
> ESCAPE_SPECIAL escapes '\\', '\a', '\e' and '"' as one group. A caller
> that wants '\\' escaped but needs '"' left untouched, because it has
> its own handling for quotes or because quoting is not meaningful in
> its output, currently has no way to pull just the backslash case out
> of that set.
>
> Add ESCAPE_BACKSLASH, which escapes only '\\'. It can be combined with
> ESCAPE_SPACE, or used on its own, without pulling in ESCAPE_SPECIAL's
> quote and control-character handling.

But why? I believe it can be done in the current implementation using
the last argument @only (id est use the list of the characters you
want to escape).

> This only adds a new opt-in flag; no existing caller changes
> behavior.

No test cases --> automatically NAK.

...

Also you missed printk() update and respective documentation.

--=20
With Best Regards,
Andy Shevchenko
