Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 912B679C2;
	Sun, 27 Oct 2024 18:57:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730055445; cv=none; b=fq7rDfY2FJ3zaAyZui/fLit9Ho9220uYmc6E5kNRHh+tWqCocwYCiqc4JKp9C0JCoV++u3rVzZYytC2YeDT3cWnpdXwKBdWOi+mRll7bAe1rJJ+0jQKDjryPLOxUhd+WlAqjJM3+mjwCZsahfTH7731UetDmjj2jvS/lKfre5l0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730055445; c=relaxed/simple;
	bh=Ydgcd7V8Rk0BqHzg9kMDtZlz0BknHAiBAnOTCCda5xw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qNi5x5k1C9FJHorafiXIRZzeLf7grO6Q9C7ZLkr0Ig7ubPCF0R/bt3VTQ2HcEONYsDYakTq69wmIol0zEzpvHCzQIQCK2GubofMCP2cjRxcJxuSav2WcBXi5FDyaRcRX1JLbYp/TJJR51nwl0LOzqzYQdMLIb6N9PJ21WzoJlmA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FtZZeWxy; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FtZZeWxy"
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-a99ebb390a5so861145466b.1;
        Sun, 27 Oct 2024 11:57:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730055442; x=1730660242; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HDpvfAr7yg4uqjMsJ37M6bah0IGeg1cqpDTcfwTQmWA=;
        b=FtZZeWxy/uYl7pPPxYMd18m2/u0Bipn6x/FQCHIr+6YE8cxstU3dN89r+8KqCWKtkU
         OFlNKSfhAbLHijZ3eXxXgdyJFdZVnevrmIR0eQkpr3Pw/zVG+arKl8/96n+6IQXtVdeS
         ydi9U6+k+oXnc6a/U67zCLFsp+vPIvosbq+fH+7UW1GgzbDmwhEMQqaHl7CQ+9pzyMj3
         a7IcnIfih6nIUuQXgw6OMxBql5pkOfF2UlRHAhPGqpuvdSBmN+EfcYIlRCUcy+TA9J4+
         K/1RapUFn65tA59Asxbgcp/hU2H6jgRFXxuw3yx81xZJclP5E1LNLnTtDYFp0MdJ/HOF
         SH/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730055442; x=1730660242;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HDpvfAr7yg4uqjMsJ37M6bah0IGeg1cqpDTcfwTQmWA=;
        b=Jl2ZI3P7NJHbqEKJXgguh0vwWDBe74k9ppbIhW0D76s9I9bU06eFPLkVtWeaKim3qq
         jt2V/DEG9vqUK5rOV4AuXa3Bl3yDlAc5L8NRuE0l+NBI8B8vtv8apVkuY8K87jRCuvHr
         8cwS/y7rjDhKg8C4TOogEnf1I+BfyHtoDwQZrn6IwtzsaYf8LrDOgUWCe0EwdRTCZIEm
         bKT7tfA5diqpOqcpL8I3PTl5uRrbjsaYSFJydSpKVARNJILpqtF+B7wceKePT+KCL3r7
         X9E0sSOJZ7kaY1STBnL8xAeZivdTXgUCPav4HUyEovGh5yPH5MQbbHD4+s8Y0+0irCwb
         mTAA==
X-Forwarded-Encrypted: i=1; AJvYcCVvtnKIUw3o+p6wlp9tSDBAC4OrQHFKN1oi637cuqTxD60G9UHf+DW1wsN4wZOvRPTKnif3WTOPAAz6f7z0wLA=@vger.kernel.org, AJvYcCXefEiqwg6+YQ0m7rWQG4URYcNxiuXFB6DMmUGSWax9plEKR4JmqGYunIlZGTqLNC5XGQbq7EUMpRaVR9CG@vger.kernel.org
X-Gm-Message-State: AOJu0YxLS/NyyqR94nL5gMEGvplWm2P0GZQIF8ycoY9/0eyXQlmefZYQ
	ODM+/ykTia5bFrmEMgz/hvv59cxFoQteBwE/nsRtL4ljpxJ9IVkB1mqWZnHbn5tRHLjCtIrfqJX
	LtjbHAo/LK2yWQg85IlsovjRWKJ0=
X-Google-Smtp-Source: AGHT+IHpsz2AO82tS5i/igyhlrOSd8kln+NWEYxVU05Tx0rYmrjbp9XkLKHBCMfdHQXOEoOKQNGSrwbzgQa0SbxERiU=
X-Received: by 2002:a17:906:dc93:b0:a99:eef5:d360 with SMTP id
 a640c23a62f3a-a9ad19c506cmr1197003066b.19.1730055441654; Sun, 27 Oct 2024
 11:57:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241027125858.1804-2-thorsten.blum@linux.dev>
 <CAHp75VeeUKWakOWW7ft8BB9Gg=29_z93fCjDk_VGsqd8py878A@mail.gmail.com> <alpine.DEB.2.22.394.2410271624210.3498@hadrien>
In-Reply-To: <alpine.DEB.2.22.394.2410271624210.3498@hadrien>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Sun, 27 Oct 2024 20:56:44 +0200
Message-ID: <CAHp75Ve49oDYm56R+__5w3Rz8zG9L-0L1zaRrEctg3zTNXdgoQ@mail.gmail.com>
Subject: Re: [PATCH] coccinelle: Add str_off_on() and str_no_yes() rules
To: Julia Lawall <julia.lawall@inria.fr>
Cc: Thorsten Blum <thorsten.blum@linux.dev>, Kees Cook <kees@kernel.org>, 
	Andy Shevchenko <andy@kernel.org>, Nicolas Palix <nicolas.palix@imag.fr>, linux-hardening@vger.kernel.org, 
	cocci@inria.fr, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Oct 27, 2024 at 5:25=E2=80=AFPM Julia Lawall <julia.lawall@inria.fr=
> wrote:
> On Sun, 27 Oct 2024, Andy Shevchenko wrote:
> > On Sun, Oct 27, 2024 at 2:59=E2=80=AFPM Thorsten Blum <thorsten.blum@li=
nux.dev> wrote:
> > >
> > > In addition to str_on_off() and str_yes_no(), add rules to search for
> > > str_off_on() and str_no_yes() replacements.
> >
> > I don't know cocci well enough, but this does simply not scale. We
> > also have cases where "Yes"/"No", "YES"/"NO" and all possible
> > variations of that.
>
> Andy, are you concerned about the number of such functions in the kernel
> or the number of rules in the semantic patch.

Rules for the semantic patches I am worried about.

>  There are indeed more
> concise ways to write the semantic patch.

Would be nice to see ways to cover more cases in less lines in the spatch.


--=20
With Best Regards,
Andy Shevchenko
