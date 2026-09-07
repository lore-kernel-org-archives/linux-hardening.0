Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3A2845FFD8
	for <linux-hardening@vger.kernel.org>; Mon,  7 Sep 2026 10:31:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788777119; cv=pass; b=g/mvxce5NfWLfq+GpIPf7ZoJ+fwdF23QZwaAYU2w2ablc1iljWzhGusmhYX1ZgZ/eHe54qFwsFDMy++SHY3O5y5wlA1i5eVQ4KtvZxLxBvMiCOA9GjLgG0xE+eyJhjxJjezFb+vgPJGVjfyWlGQ7/RRfXt8uXg2iYu4vhurYWb0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788777119; c=relaxed/simple;
	bh=Xw+HRlcvjW0U6P6qm17Nuk1JE3pIENaL9TJbCB4UHJk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eIgLbAP6FaUputK9vpZsOxFx8TkEiP09U8+84isHQJG2hH7WawD7IXPfEQgNJMHZZDeaFC9zU3p8Fr9VmXSbEMGji3H4HJFYxOUBMyWsxGfpgI+Sy5BUI5mvSyNoIZIViglYkkLe6j/K4X0inIi3kVxkcZ3TBtCkdwmRBAShVCI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cwiq/BqH; arc=pass smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cwiq/BqH"
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-c25b661d37dso458495366b.0
        for <linux-hardening@vger.kernel.org>; Mon, 07 Sep 2026 03:31:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788777114; cv=none;
        d=google.com; s=arc-20260327;
        b=sv9KJ0om/yfHdZb55Kh3rYYUFmcHSRulEWGej7i/YBUxTt6RZIRmunygNlcuQUl+ME
         ZAEMjQcGXza17WmPVXHiRL0DeHCBIMMmACSkUR013ht8UxohZKoR68RvjYjqr7WN0s88
         /TYWeM6cfQzkAfu2y4con+erPZm40mFEBig5bNiuENPhkcqU7uzJBy/ILndx5y3dZx2t
         6WjvRWRryYaZYt6PL16xue4ifBBrRqhopxbeLZiFhve+7rwFL2lYrQii7tLV4hspx7Rv
         /zrlH84XAC8tJZXKpH2BT2VKehunkOuR4GdKZW7w8Gp/nTWZ1Y1Gl/mXL2zOCy6xnWPD
         BzMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Xw+HRlcvjW0U6P6qm17Nuk1JE3pIENaL9TJbCB4UHJk=;
        fh=R4Ky695sMghtZ0xqIFgHvnpSsa5XHx1SANO9fyTnsAo=;
        b=FhczPRe0xhQKPUy02mWQWyPEhQPMMvgA7nsIsF/I1WKUHLCwc9wjXdeGGYh4U+0DeC
         HjFhfxFmBpIhURAquTCDa0IobRX8auH+2jbxHZULGDNxyT2W3yVqx0Sbl2TzSjDKF/on
         Nc1XBqwYL75on1rSs0th4W6VHPY3NuJ6NICrbJoEMUz8WmiuiZV40UoCQAG7t/Ddw+3H
         YzKC/Nc7wPblChoKvfWZHPJAJ5ARI+9PrSOuwc154JoAd9KOG/QTlcf+Z+NeY8rLDLiE
         5cDVUx1Q1d+jIZLhJu1IHP+OII40t/SIf9ZZNYySxgPfzNsDHamxggNJhEnHnZuCkqUA
         DZIA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788777114; x=1789381914; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Xw+HRlcvjW0U6P6qm17Nuk1JE3pIENaL9TJbCB4UHJk=;
        b=cwiq/BqHqSn+EpVYUEp2vsqmAtWZIr2X071/991/3p6FU1kQu0Sb6s1EK9i11exsqZ
         7hVqvtkaDdnWFKvdYTUuJiBQEH2mkj3W851jsUhFcFIftFd60YILwZ84GOHtJBEfDQmC
         FIykK08Cs6nSOu8rxsZJrmn2E3WuT0ArxkRnA3SKzN2JE2REoK3CZbh9tnTf8mqo3GH6
         sFjzTWUqSRjxvVdILLSAcPwtKlyBPuCxwIUAgnpNalMYme+i+BmncE3HdheUq3duX+FJ
         xhtNfMDgOoaWOBQzxxXUbGpyu/oYyZkhUAMJXjTR3fuaShjYcbv7aqhRXR9ywxVm9I2R
         1o4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788777114; x=1789381914;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Xw+HRlcvjW0U6P6qm17Nuk1JE3pIENaL9TJbCB4UHJk=;
        b=CMOzwPt87YB2m9ixxQTVWw9cMt2aN8OWnvPB5XNpuh08BVdDeXxbNbx1SmoTLWUO0z
         EQdvY/P+VvrFx13ERqZRG4TOTjR2MMAmOm+jZDxdbZIC4zmpOmdCeMi3ue+ZRa7mgkMw
         kDJEWCdXSQAGiWmcCf6zGb/YRhAN1lPAIVj3HL97l59yutQtBq943pdAfD5/AOr8bEye
         BZKbhE0NpfbT5uuxR24C1k7j/99efe8DOzjc30Aj3KuftqpQhUzzCmMgALQ/timv7kXm
         Tp6bGihlSP8+5s2+C3MHZOSY2S3IBIJOEVzmYPkCnQsLfLXPXhBVyGRA7ooBfk433GEh
         0rHw==
X-Forwarded-Encrypted: i=1; AKwUvBx/Z0Xk5wOaoPX63NFlCKekV1YG2SmzuYYXMhDMqlmsgeiv/kBg+HAh6Vr6kje358bPfAxYOAV3jRUZ6cwPtq0=@vger.kernel.org
X-Gm-Message-State: AFuF++nqOFHMOcQtw3P/lAMq+aucJ8kTVqZZ5zlaBv5kJvT9gqeuETmc
	/ZsO6AjcYdY4lWoqnLPwh1lg4L6UycTW5J6QerXc2KFjdscHjTZHXu8K0KA9aIcl7/d30xC0ljU
	Pr8WSKCO5HfN81R8mEtMhLHTEidlBu4g=
X-Gm-Gg: AYBFou1NLU8iX+PhIWiAqAedJC+8evxsM9J/5j1VP27QRerbaOkjkWmySK3DQaD/4Ns
	sI5usQCixvAkDDaAQZZ+XvBancMuxJ00ZDgMUzB+oGkN/wSLCtXGL0kxYP65YvnVXMtElDJk1h9
	v5oF/p78jaGRfZfpCoafh0Q0xYZ/qhMaAr9Hykrm0inSGsAiv8ZhA4orzztzEuJghku1e8dY+WI
	73Hp7zD8pG248mSccGv/q+w6XSV2omjs6f/vXodGvIbaG654XmIUzJjlpoy85kdYyU+Z0y9DKof
	EnDb6TapBuuL45SKC4ZrXHuZlgHyG3BvdQCseAeGkz3sZq7gLUyDAsQ3cdP86ssvW0d2HQDE11r
	yYzUDd+q6Q160sDY9l9Nk79V/RI9b0stQl5K9P4P9lFSpM+p18Ggxl+/f5qwEjHd8oRfczqDIaV
	Ax6zW+YxB+Pq+PLwDisULP1xkYb2MoOxw=
X-Received: by 2002:a17:907:3f98:b0:c26:19e3:e988 with SMTP id
 a640c23a62f3a-c2619e3ef32mr701672366b.40.1788777114250; Mon, 07 Sep 2026
 03:31:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260907084319.351688-4-blum@kernel.org> <20260907084319.351688-5-blum@kernel.org>
In-Reply-To: <20260907084319.351688-5-blum@kernel.org>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Mon, 7 Sep 2026 13:31:17 +0300
X-Gm-Features: AcwNN1XM3d4ZDElQn3iIlQ6JTOd1vgZ6JbjOD4PpwcxjalKvdLb1jFd3p8gSdWc
Message-ID: <CAHp75VfwuHeoLhj1NHUMNTAjih=runLhp89-k=NgUWGA0RLiAw@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] lib/string_choices: Add str_supported_unsupported()
 helper
To: Thorsten Blum <blum@kernel.org>
Cc: Mark Pearson <mpearson-lenovo@squebb.ca>, "Derek J. Clark" <derekjohn.clark@gmail.com>, 
	Henrique de Moraes Holschuh <hmh@hmh.eng.br>, Hans de Goede <hansg@kernel.org>, 
	=?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>, 
	Kees Cook <kees@kernel.org>, Andy Shevchenko <andy@kernel.org>, platform-driver-x86@vger.kernel.org, 
	ibm-acpi-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org, 
	linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 7, 2026 at 11:44=E2=80=AFAM Thorsten Blum <blum@kernel.org> wro=
te:
>
> Add str_supported_unsupported() to return "supported" or "unsupported"
> depending on the boolean argument. Also add the inverse
> str_unsupported_supported().

Reviewed-by: Andy Shevchenko <andy@kernel.org>

--=20
With Best Regards,
Andy Shevchenko
