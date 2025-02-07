Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com [209.85.208.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36C55194C8B
	for <linux-hardening@vger.kernel.org>; Fri,  7 Feb 2025 19:56:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738958220; cv=none; b=NXqRKmsa0XvPLByxDojgkQoY72ArLjHBRUe03qgPc7sn95I3zIlCo2Wp7lqz/68s0O+EaRyRh3rAA0akYybzeAMeFh6XqCjCuxrd9VUbSe7QyDpcXN3TW7Dc/LqtB0WuMKlFCYhiufGKUBX1CwkGP5eO5EniTkXl1lOYwUvFr0U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738958220; c=relaxed/simple;
	bh=79LQgR3k/Btr24QSq/kePaUzIL0o36tX30EbGhUwh5w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AgVvYYZWLP2Axly4TKxbSJd+Y6CiTE5ce+xkI/xbJu5g5cZ6kaaczbMHFD3XLDkslaztWThgRp7dUkV/SjTbKw2Iy4vwQwnyV7rIFSyvpmBUc8lQYsKgrrpow4JjiCuIiRJuSGEMfNx3XPeZDu5MkRQ9mmhdBdbEmwjiowkGFS4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=syBEdqOT; arc=none smtp.client-ip=209.85.208.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="syBEdqOT"
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-308dc0878dfso3355291fa.3
        for <linux-hardening@vger.kernel.org>; Fri, 07 Feb 2025 11:56:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1738958216; x=1739563016; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=79LQgR3k/Btr24QSq/kePaUzIL0o36tX30EbGhUwh5w=;
        b=syBEdqOTadXkZfHYjUXyDF3/b63gua7a9RgUgXbVet1Tuj+KAyuKzrSj1TswCxG4zL
         ja16qKJ51px5SoCQIZs0NgyVWrP925ZkX1xYILlxbCzOhD7/QHaLHxuO4f7R5p+QQdgP
         P1eQrXeMR+ROJIPYFW7yuQ3sAZv/M6Td0zCRhhoP5ay0rk8DhmmbZ7cF3imPFEE79Ad2
         MA4ovYu/oxScgB8/r+XdW1V4nkTdGkEynhqmw6oMey6FAy0b4f1/dG9ba50MzFTDiXv0
         ihQEBQOSPs/jfUtwsyL6zIp3qlqORO8n5YNShZ55GMrIaW5hhd2VW305a7Bp7M5as6c7
         umYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738958216; x=1739563016;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=79LQgR3k/Btr24QSq/kePaUzIL0o36tX30EbGhUwh5w=;
        b=B/oMjVMTqiNHjZDqAzvNU4qY+S+JsgDqjbsGg4pCdUml/OAIOiZ2KSFC2VU3v7snvd
         IaVlLI1+YvcKIe2vU+gjjGTJvyVh21iUhVkgq/YVcC4E81+qdaKitfI/HEC2bXUOqLXd
         ghSTEFFg3RlaaJjupOFkEjW5tUa9DzwrDaudRepxpHeR1umR0ge+GF72NkCMJ9bjool3
         MszBydcjm7rrXmQvQbAHQPt+cYBI8KzCcttlhF1tDOt2v+0tQaEHbBmUXrZE+tS/qfkj
         z002qo0GkY4hkYDxN+emnT6V/p1FdxHRXH1sa1Eucu+cqFBtbGLyHV/w26v/lSKN5e+E
         5Qgw==
X-Forwarded-Encrypted: i=1; AJvYcCX5fQ+38Pf+pmvKWwe1nbBXe2N3fDHZSlfGWTLhmBJ9h+K1O5svMrPOoOU1rLYTJcDIgNPIGFMk1A3cRFBvegg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxttzLWx33cy7jyl4SizTK3iobSysdhIoUFdeG1txOBL5PwrDS5
	nCvuDdLhVObnNdCFO74JH4HZUxLLQurD824spH14yzEPP/BPK9IEA21nDsxMyIkZX7ixgZAQs6r
	ODdch6tUeoIaWGfB36wD8ug4wrpEFJobfHxcXm1Z+8B8XV4PB4Mo=
X-Gm-Gg: ASbGncup7hTw5cRS/CKNJv/shIZXpxt/5AQYiDLv4OIFhy/E+ZCVtZho0Bg6MeY7sOi
	NfW4D69wt4buckytuR623fu3l5Ivm37uFx0iThE/sgXzu0H0/PqhXHycaEpxo2/pyBGS1LErygH
	fYr/WJUe+Gm/XWbk2813XW6DexoOg=
X-Google-Smtp-Source: AGHT+IGcldAttxlLtJk4Fmc6rBnfR3YDGT0u2J7Iom+k4vjkPDF1Uo8mr4HUXBeyLSkHxMEFExi1YbQDREIHsVDAdKk=
X-Received: by 2002:a2e:bea0:0:b0:302:1de7:ef3c with SMTP id
 38308e7fff4ca-307e5a84a4bmr12434941fa.31.1738958215983; Fri, 07 Feb 2025
 11:56:55 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250207151825.2122419-1-andriy.shevchenko@linux.intel.com>
 <20250207151825.2122419-8-andriy.shevchenko@linux.intel.com> <Z6Ypww-xXAvoCCq1@smile.fi.intel.com>
In-Reply-To: <Z6Ypww-xXAvoCCq1@smile.fi.intel.com>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Fri, 7 Feb 2025 20:56:45 +0100
X-Gm-Features: AWEUYZmXWJ_lbK-g8mszuq861gNNZ5AaVN8r5wA7kPpaIp5zjgxpgUc3nebktXg
Message-ID: <CAMRc=MeTgjHYCmZcDhvZGKCaKyHhxUU=3EF6OvsLW-H-Dv+Y6Q@mail.gmail.com>
Subject: Re: [PATCH v2 7/7] gpio: 74x164: Utilise temporary variable for
 struct device
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-hardening@vger.kernel.org, Linus Walleij <linus.walleij@linaro.org>, 
	Kees Cook <kees@kernel.org>, "Gustavo A. R. Silva" <gustavoars@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 7, 2025 at 4:42=E2=80=AFPM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> On Fri, Feb 07, 2025 at 05:17:14PM +0200, Andy Shevchenko wrote:
> > We have a temporary variable to keep a pointer to struct device.
> > Utilise it where it makes sense.
>
> Urgh, this seems incomplete...
> There are more lines to convert, however they do not affect =C4=85 statis=
tics.
>
> Tell me if I need to send full v3 or just this patch.
>
> --
> With Best Regards,
> Andy Shevchenko
>
>

No worries, I may fix it when applying.

I'll still give this series a few more days on the list.

Bart
