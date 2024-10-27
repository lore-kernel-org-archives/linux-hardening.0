Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 537C61EA91;
	Sun, 27 Oct 2024 15:07:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730041643; cv=none; b=IdjnIMj4ci4nOuYr+3nF/J8C5h1B4/yjit/oxA6mSEL3F8x0KQaUkOzlLb9V1tEAXLPsvbaEn6nGh8qaAJg7o8ufYptS2KIVsd8nhad1++z/iw6jmg6FDi0J6qlW5COIlUkB1nivrETEziSCD9xT8hmLOHqf4NxTPZnNRvpF6C4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730041643; c=relaxed/simple;
	bh=DWVfrLiSQ1mLXzmeAJ2FQ1vcpLRRj7dDdM9zmE1eltc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZvE/Ek3BoIlTVdNMvRuAGhX/g/Asq5VFwXDXHemX9IZkQsE5cT8scjFprzQ+vlbWTuRC9DNtQDRu1F6DXwZqt+chRNiO/sSP8Udg/ctkonvuEE22otFP2XmJOHffky8efECl3YOIS8/oHap4Z1GmedjSu73aZzsNKlRppTZkoYY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FI7HGfOK; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FI7HGfOK"
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-a9a3dc089d8so519745466b.3;
        Sun, 27 Oct 2024 08:07:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730041640; x=1730646440; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DWVfrLiSQ1mLXzmeAJ2FQ1vcpLRRj7dDdM9zmE1eltc=;
        b=FI7HGfOKWrRxjKyDkRjmD5++Ogux0tgmN2kOc3R7I3/oLYmFtCcIa+xehsLqw3JE9m
         zBWEPq/H/JxLgJaXpwN3gn2pJ7INJT0coZCVl0rzozMTvy9EnfHNwcNmpzOiqv12RxNG
         rQHHDaBFETGrhX3FLJn6cgmfkvJLP+oyPAQit2UtMIvepW9wCSjhbkRAaFJWyQm63blC
         QDgL1t3Vhb/Ld1jqkj1jF94Bm7fL3ORXwevvv44jI3yp9QviS3nRwiNL1JUk3dGdZY/d
         6R/eNdHIuIn1bUteLJx92DRQd9rnwd86efi42DnzPGTJ6tJR6llGThV4TP9f35Q4MJCU
         pw/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730041640; x=1730646440;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DWVfrLiSQ1mLXzmeAJ2FQ1vcpLRRj7dDdM9zmE1eltc=;
        b=S5CsZI3RxCDs2d30doOlZ7WJfQqNMgdyGLlDd8Y0bZcPpTlQeDk0axnu9/x0Df9MWb
         aTkYxjMDwTWyVSh6rnPobWuCekeChDxLKTyDy24u92QKnflX1LNhC1Sm2fk/rcsfh2Z4
         8HlzH8Wl30zEBqqmEvp5WaJfRMyOH4LcaW7+bVxcAVU6h2hQk6A1tfxzIingXvPAqalL
         1UaOpCkCUf6jiqGyRCqdvcD36uTMBEVb3hgVDhJCEoOalkVbUw0d1fVBaEEKTnqYFuRg
         jo3H26w6m5XKUAHl99oOZ970CJ1HYk8y0d5+t+8V5yKHtbnbTvXPumsPuyiDLAyOVMzY
         5hVw==
X-Forwarded-Encrypted: i=1; AJvYcCUxCjhDGDJPRTuBAjjZ91SNNIA0VwS1/eAtLwV/qSJwvBCsfRKw1xGtCf7bLkciY53JYSqZn91dkCOVvYDEFu8=@vger.kernel.org, AJvYcCXiQKwI5Am/rdPWArjsVXsiePjC9gB6ADBj8IOxkWvMCnVuluSHj42M14IsAOjJ0z9sgOhki8OzyJlruOfr@vger.kernel.org
X-Gm-Message-State: AOJu0YzHWkSHByHhdJcEfSeiwYhBD4D75mruWZTYFhDNCADW+h+tAOmJ
	yZSwRrGCqm5VdiJffewaAfAicy4lQ68Jy4uoLaupmn86XUggZiOUu82JTjFSndjDV0Lq+bsgiRf
	LUaSOwjBf56zbqHqnW1He+pTXR000La0b
X-Google-Smtp-Source: AGHT+IHAMr1Prejw6UUMe3IADa5i/kKzZcgJeJyFLvdTQ0zMFs1aGYVL8QkXh0luqaJs01zHjAnHSrOxMr9J+/jUWMA=
X-Received: by 2002:a17:907:961c:b0:a99:55ab:b666 with SMTP id
 a640c23a62f3a-a9de5f27104mr510798466b.34.1730041639504; Sun, 27 Oct 2024
 08:07:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241027125858.1804-2-thorsten.blum@linux.dev>
In-Reply-To: <20241027125858.1804-2-thorsten.blum@linux.dev>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Sun, 27 Oct 2024 17:06:42 +0200
Message-ID: <CAHp75VeeUKWakOWW7ft8BB9Gg=29_z93fCjDk_VGsqd8py878A@mail.gmail.com>
Subject: Re: [PATCH] coccinelle: Add str_off_on() and str_no_yes() rules
To: Thorsten Blum <thorsten.blum@linux.dev>
Cc: Kees Cook <kees@kernel.org>, Andy Shevchenko <andy@kernel.org>, 
	Julia Lawall <Julia.Lawall@inria.fr>, Nicolas Palix <nicolas.palix@imag.fr>, 
	linux-hardening@vger.kernel.org, cocci@inria.fr, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Oct 27, 2024 at 2:59=E2=80=AFPM Thorsten Blum <thorsten.blum@linux.=
dev> wrote:
>
> In addition to str_on_off() and str_yes_no(), add rules to search for
> str_off_on() and str_no_yes() replacements.

I don't know cocci well enough, but this does simply not scale. We
also have cases where "Yes"/"No", "YES"/"NO" and all possible
variations of that.


--=20
With Best Regards,
Andy Shevchenko
