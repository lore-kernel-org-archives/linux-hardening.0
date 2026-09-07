Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7FB7413230
	for <linux-hardening@vger.kernel.org>; Mon,  7 Sep 2026 10:32:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788777155; cv=pass; b=g04juany/+gVy/LhkjS8HfzeNcGyNxJfOWd24t/YB9/ed18Wa9RIYaZUCKGPFiiggYi+FvMfT3sQjiuWoaEigpYst2qjwUyXSgfS6QDOCy7emA9bgygLjWq6wyVYaGbvdc6slrZLPxxn3RLjX99bFGxWZQ262rKk9Dx1FL7VIyo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788777155; c=relaxed/simple;
	bh=X1qWDgE4nF+kcB5zeHXPeP2a0sHwXZUBovy4AQQ1Zh0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ux77xB2gqFMN8UXLKQ1ZfCeYTVl2nZrhg6XDXfKt1Bzij+CtFtpX84/J929KDvdVZ2WFwG+HZaDebNROmtXWRaO15Se0K2lMcAIxQJmoDthBCcVi8J1vZNhREBcovto80lh4+MTE9K7KTN6fPVoRZloPQ9dKL9eJssHFF+B1u7o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aZUgWUGN; arc=pass smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aZUgWUGN"
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-c1c52d920b8so410411766b.2
        for <linux-hardening@vger.kernel.org>; Mon, 07 Sep 2026 03:32:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788777152; cv=none;
        d=google.com; s=arc-20260327;
        b=BSmevc4nNiBw41Sw8w3dHMGCjQQYHUwLJ36m/YVxEGpG0lEdORXuvO9Xo6jk91iSSV
         9zmSHOVYgjNl9IC2/14cW87t6XAlrVAocJ6LcTw+R+vZfZz44CVKR5ZUzLh9fUvjzk4G
         FWTEl2tnq5dNs4dzqCFhZsOonX80dFWUemrbJm00ImBew2jJulGquI1FLrhP9cIeFCD0
         gfw4mgklMejeSTN6XN08/EVSrJXuyVdYJDorVtDixpt57c0728GngZu5eHdGw+kmlkd8
         qW1kCgtK+uVvmgrjp2qWvaiVknPDT8H0CLPEI+yZuuvK0Kxe7bXQEyfq9qegeFneSJBw
         xMAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=X1qWDgE4nF+kcB5zeHXPeP2a0sHwXZUBovy4AQQ1Zh0=;
        fh=fCThv9rVMEH+1wAvrhqO7f4jUaGDUAJK6cN8L+y2//E=;
        b=X3Xs74lNRCqfE5tNe/3BpwiT1gLFdqLDgnJndjbkmLiGg1pUE4hWU2k0QH73cnxqjQ
         GEdxsVcF+teiT/EtM9wwajHDo+QMvzmYQkd7OwQCzGp0OcFgnWtSpY5lT5T9r2qYCvoY
         Oop3GA8Iu6TgrRxTFOdmWA5xfdVoSNLLCm7EJYApUPQnLOMM8hUnmuDGrA6FYr03RQsb
         wk8NVucv+IczKCZ/dLx/GGLSpjLK59XATeJ/i7QUjiG2jCI+IrFeV9cS0TTaHjs+FLwC
         OtEmTBhpR7UEKZAl5yvqrc3F1thm2P6MMqGNjLQJ2KKSNFzLzW1/dQp61yplFQ3xmksl
         novQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788777152; x=1789381952; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=X1qWDgE4nF+kcB5zeHXPeP2a0sHwXZUBovy4AQQ1Zh0=;
        b=aZUgWUGNhSKdU0nIKvkjb6Cw5yxj90QoLBEyhckqRrB0qA3hfhbB1fL0tnrHadsB5U
         LG7IjEYz0rDxcSvEFjVx7fvlbg3pDh7h3v6v+K/BYz94ttnmlbq0JpSX6TUNgm4PwS93
         IJl336Q5xTPjTQMAxlxOcW0n4z7iqZ/5eSjxpnFB68XlcwftBFdG6iFBjjbk44f+BjOU
         uLjPES0qhxiDcClsu2cuU6Ws5IwGyt6nbF6KY0FFTNsMM4JyMeC0kEAYKcFx0xprScCz
         8PodESrmtgT2HIXDHuW4B89WO4BTwoagjV3daDkEY3yba9yVoHHgDlNrTot2kAkN2Fuk
         +H5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788777152; x=1789381952;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=X1qWDgE4nF+kcB5zeHXPeP2a0sHwXZUBovy4AQQ1Zh0=;
        b=J8Dw3Q6JkidwNpC9d1Rvy7AEnD+cshr+O8QI4Ewk4iFqcu3IKk+r8uN0G3EvrqHZ4J
         xiCjrs/NZVgefKnjpXLA45DdbYBUbIbD7Va9OQBgumOOi04jzVFgBlpfD30EcoV0OZAT
         JrQaA18bEban1GTGhUnv1IHBEVPkQhXjtx2jy5cQBvT//dztH/Lyt+GkN4UE0y+LDyWw
         QeGFY7ZKCfxgENbZOF/sHjXnL60LXNpnIZme4cdV28tPe8jtvAfvMQVY09ibmYc72nvi
         IR/gc6joh/Z4ZhCiOcvUm7FchP3xD9mp/EesIev8b8KlKaYj1DG/QhNFLl7nSQQXLrx3
         q+hw==
X-Forwarded-Encrypted: i=1; AKwUvBwo7WUg4Vz41gxOPS4qUAbvodccTjz8attczlUDAXxGH+NNxoW45Q1y7pRqMysukcnng+5sWNKih/umOCZi04U=@vger.kernel.org
X-Gm-Message-State: AFuF++lq3aR0sCfz2Li9sTZCVV0PhUJAQYh+3I8PNH6Oxvm4wBnGbsLo
	icVsBAXCmPWUgSNDq6jmnnYyFb6etHIB8mmgHlsw6lVFTYF77oFrBhfFmVsXoVNpc8sZIfa18Kl
	4pOpcIhQYl1lpO6HgaF7wvXZC5OFV0hE=
X-Gm-Gg: AYBFou2/0jdAYibztmKY01FYPt/yBJXDbXdQzyS863z+qNIEvvGLMusKXfydGWCm7+N
	rzK1pSTwcZFpgPbDPRFynXac+LLzO3BVj1lVqPF/oS9NCUtD9sjKvzU1hoqil4Ztd35NowacaRY
	iDQdy2I5Lcrhmgbiq4rqxZvd2AtMTor9rw0JjyU6LOl25KM9HDgiGuYSZGNHCd3HoQoiO9l7YUQ
	nUgkxlWf+Dwpe6tTvEGfPfyY+/gX9G3JfZZWc7TOruwGv/7FZIg9sFV3w3ppf9MopRJIg4/nTzP
	DCPOP2quFutMUZTAs9RRagVCBFIpXn5CWw7PlXqVqeyVPF1HaD99tQ+SxOkXWifgifWAuHdjiK4
	FKynbyMj9/OEbOj8gtAb21yD3X1W5xEOHAvMrrGqH8mWnyFzWIamEx0CdS3H3gq7YPssMjyZJ8j
	ckTuxiX3w9Gm7UYVjgaNnMiWdobLvR9zk=
X-Received: by 2002:a17:907:9490:b0:c26:19de:9ae5 with SMTP id
 a640c23a62f3a-c2619dea790mr625724566b.36.1788777151897; Mon, 07 Sep 2026
 03:32:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260907084319.351688-4-blum@kernel.org>
In-Reply-To: <20260907084319.351688-4-blum@kernel.org>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Mon, 7 Sep 2026 13:31:55 +0300
X-Gm-Features: AcwNN1WOOJgn8-p9-C3jUkiPvWDFmRlO5oCRAvc2gPgeLyW6w8fr-M5Dv74RW9U
Message-ID: <CAHp75Ve4pcd=KHcJpGW9qtpNJLwWsQjf-FzoNtkxdryVfUB6Vg@mail.gmail.com>
Subject: Re: [PATCH v2 0/2] Add and use supported/unsupported string helper
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
> Add a shared str_supported_unsupported() helper and use it to replace
> thinkpad_acpi's custom implementation.
>
> Changes in v2:
> - Add and use str_supported_unsupported() as suggested by Ilpo

Suggested-by?

--=20
With Best Regards,
Andy Shevchenko
