Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E208B368946
	for <linux-hardening@vger.kernel.org>; Fri,  1 May 2026 08:56:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777625773; cv=pass; b=aCoCj1ozNrgzatHvFOH3hPRPDBrmjOrpTqyidj0V1rjQ7jNdeiQXHpX1Q70nYtL+AbMw1KCfclphJ+mR6CZgWrFCsU6Gu3ApmTq4S76wDisPK3Xnfyni+l/XlGTzyGoqTiq3iLNRujKysrafnUn8DT7mKIq4dwQIwIUJQuaaPKM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777625773; c=relaxed/simple;
	bh=36PHmiLjnvPvuCZ/OQ0Ec7KPT1E2bQTBQYcqYvEiOHQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pygsaNEEA+5ZifyXuYElugfxRWzMq2n8fYUEgJo04ijgJTZkAj2Lc12r7DXtJCwIQBSwO4eHo1xegaDp9gm62ZllwD2fRduOMnDz/mKqy5bkfyx7o/RCmigMjB2M7NpcarsUo4Rsg9yRfMcfVI3xthtsJwPChH7JdpRH5S9Ybak=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DVEOIu5J; arc=pass smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DVEOIu5J"
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-ba3115fe0d5so506372766b.1
        for <linux-hardening@vger.kernel.org>; Fri, 01 May 2026 01:56:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777625770; cv=none;
        d=google.com; s=arc-20240605;
        b=e3VlsRu/1iQeXjGzoEsoiGQsdPSfS9whA9zCvev003vR7z8ZQN56cFu1yj9sA/RIBY
         kI0edxYbWgSbMAYudpPxCk73okN/iC2G0f0V4ZBSl5MHXYhep8wN/LK2Z0TDgEm10Z2M
         I87NQwaLAiOQJ6JjjxhAPn4RdvR0OyWaKro58QPxT8vo+vCPo+v1s6p6pW4B4qh4zosn
         usiPwKzsL8agT4S8gvOEgnDUVNMC5ZYOdChbNxl7HEAojzbS8UTeZM7WhQJtZz5Z8YYX
         L+z/mCuS7yoCahE7r1Y/1N/vZKaszS/01zVqLPZD5S9V+1YCk/ULCWFpoBWC0i/+C5GX
         6JyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=36PHmiLjnvPvuCZ/OQ0Ec7KPT1E2bQTBQYcqYvEiOHQ=;
        fh=q4DrqKwpqRsjXpizMHKcbp7KoBf0wwQFHqtiNOFtJhU=;
        b=SLV1zfZZLlNLdQtuCAlNQL8GYyHdlM3z4Z4XHmPH2UHXUKGDbrgmUQWrUczqkEGHSn
         gAK77F/aKJ0S6tk3qQGfS9N1+z50+9x8hv11o/q79kghWBrp2KdS+prknxmiOdFiNHY8
         Ao61lBMhxW1dlgMqrA9HoUqnEHuD8ZhlymLXDVawgJN9aNIAduSZmm7ROOJAwDGDLS4J
         1IPDRP7zg7SX3BX//KyMebHe7fJAY4kAR5KfrG8wV3RIs/2cri+uTg40HCsQNsLeFOEI
         cTDdHM1cYRpuwBy46Y8Yfb2s6tJorgBC6Bwiyj0znfM9mynsUjzq8JTO3VW0ZjW1iNUZ
         qiIQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777625770; x=1778230570; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=36PHmiLjnvPvuCZ/OQ0Ec7KPT1E2bQTBQYcqYvEiOHQ=;
        b=DVEOIu5JUyGuwm51K72Lk57x7jJf/mcqQ/gxl5+joaQQQ2eWt/yPpYH+XsH3phue1S
         xbv5jyIOu2eFEUGSbLfaU/oOOj0vu+wcrXM4GgIM3k8Q8PVzQBuN/14lTUzAO/zgV5KF
         1r1qUtJN4p7jenpaiYVFnuVWJcwJWm5aJWNO3lvGISd+4yFOInI3ZyjgZ1e4CU1UzGdA
         liErc+EG+mxZwkFxOvzRD2fYMDFNh5tMJa7geuWqmte0ZKG+neTfL1K7xb/ItQ+fhRX8
         xn80BA2fUI0t3pWPjegdULePTMd3RsYDQ+abBbYEtV+kHjgk/cBhYJivvLGvO1FljuWd
         7hIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777625770; x=1778230570;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=36PHmiLjnvPvuCZ/OQ0Ec7KPT1E2bQTBQYcqYvEiOHQ=;
        b=PZs7p0+upn/7uji1lN/wQzEG6/QVAUjOdajXEaXnhEZJnbDu8b6vRYOlksjGBNyXTI
         qGNSmdSzVCyvJ6YKsQpUrHnIQn3XC7ET7LU7Dv8N2ilwzvTxu6SgqU051UNb5SxLH5/H
         7h1ilm4XTS2XL3VT7u1VyKgKoSUsvMuWm933GS2TWjXX2Vfv8toCR0dae+Ape4hR5CuA
         ohMyYl9tgqWuhcnJE9gLiBKSDlZqsfcnRRjtGZCBiOrOCPoEhG7/go22LrW+k8N7S2XC
         VuqkAmwICpfWUIzKhRZacjR9pwE+TYdt73l1ZxlzrUCHfOX8L1iCLsd0TfmG+SmyTsNR
         Ftsw==
X-Forwarded-Encrypted: i=1; AFNElJ+B5Y3B4gXfQQeqhAya727IfyvlZMKPk3v/O/pzSvm+PLzDV+0XDgvZzk7ebdIbbNkExPjfGi0mWILFWzH0XYM=@vger.kernel.org
X-Gm-Message-State: AOJu0YylBiDooV8/s48kttNE9I0JNWFlHy2fk+C4pVzqGg+qVXi9kyfJ
	R06OrbTlMndJPzAMdTDaA/6mHX0cwv9C1ePUwh9GvtpDK47c00Bh0VmfUvE1iJcVVhdwa3825u9
	NNTXlDuijlV+KKk/p2+sKfkT/kJBYHK4=
X-Gm-Gg: AeBDiesf4P65ynIaEyjgsGbDp5YdnA2eSoAb2lRJNPpvqUWccAczJr6n5+yUsbBGI1O
	uVgZwwSi2PgksvLj0liGs836ZpJ2/T8Vz1WH/HI24d3P7Q4KXjkZe+yFOtT557fqqbJaV6aG4GY
	ADIrwCF92NVJ1YvwyPcptrY7xW4vTK4FNFuGUQ0+nzsTc/OaqTd5ZfYcKOHf8YEzPSUu6TkKXoD
	vBRNv0TsLDhBP4aqcC710e4pK/PA4ojOoIXfkF8MjXBbhOuuraL7WG3ji3qWOjSBoHuvciZq5jw
	nsNY8U743HGWJSCcJ18JOds2ofbKZrvzU1IgEJd1O6h093wLwDYYfw3RD8C5H1bjcq13XVo5gQa
	DVurCld5eV3CwHm8Huo68LztwqEqvZQ==
X-Received: by 2002:a17:906:b84d:b0:bbd:ceba:97b7 with SMTP id
 a640c23a62f3a-bbdceba9b04mr164097766b.8.1777625770038; Fri, 01 May 2026
 01:56:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260430205050.400822-4-thorsten.blum@linux.dev>
In-Reply-To: <20260430205050.400822-4-thorsten.blum@linux.dev>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Fri, 1 May 2026 11:55:33 +0300
X-Gm-Features: AVHnY4Ky_AV8lEMqNX_kJhWS2ScrfEs95biutGIOLf2KxijJAUbykyBafBXeuko
Message-ID: <CAHp75Vd10OdNQfhb-hOAapJ4=uhZ+t26vp_WMAoeCska6NCyOA@mail.gmail.com>
Subject: Re: [PATCH] string: use strnlen in strlcat
To: Thorsten Blum <thorsten.blum@linux.dev>
Cc: Andrew Morton <akpm@linux-foundation.org>, Kees Cook <kees@kernel.org>, 
	Andy Shevchenko <andy@kernel.org>, linux-kernel@vger.kernel.org, 
	linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 30, 2026 at 11:53=E2=80=AFPM Thorsten Blum <thorsten.blum@linux=
.dev> wrote:
>
> Use strnlen() to limit the destination scan to the provided buffer size.
> Remove the redundant comment.

Please, do not spend time on amending strlcat(). This function must
die. Instead, convert current users to use alternative ways.

--=20
With Best Regards,
Andy Shevchenko
