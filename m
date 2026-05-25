Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B604C3D6469
	for <linux-hardening@vger.kernel.org>; Mon, 25 May 2026 08:13:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779696800; cv=none; b=NPXdwl1q8bwNH3vGXIXI8Cc9+zotiBpiBbD92HE04O44h2Z7Oj1LZcLFFW3jE3d25DwG4jpcxwwa0aZtW0cD5NsDEdq50B0ueHik1GZQB4H6dLenXzB3edj7NARgX7dryq1o+UPqhcY2t2eg+bjD/RGMl5PEhOEaHrB7vPb4hAw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779696800; c=relaxed/simple;
	bh=4X8VfEgtynQvkRUQ78d4BHm3Hijx2XsryIkyquHe10w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pZnJQInf40tWhraP8A/HNk1n54cZa4qf17Wsae7fPHpJrX5xxsaCRrDaunjZ30EhcZxEP7gPeMjp61WnTiVQQmonBUkBVsWIeW8pdJ+Usk3EgUA99KH6VewKiffiej08PWaoMZVeEJ5OAOm7lFj17Zs1CnG8HIDlD2FAE7oTkl0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NWiBFVJt; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NWiBFVJt"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE7AC1F00A3F
	for <linux-hardening@vger.kernel.org>; Mon, 25 May 2026 08:13:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779696796;
	bh=djik/NyBClnw3R4F4UGKM2JB/KJ8BBucJTMUN+ykxwU=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=NWiBFVJtOpi8kLKWTj2nPyM5zzicJL2YLTjfqbqQJRlW7j3ExmOkXK5dhKMCgSdDO
	 BDcIsebDB+QdKdAloPf6z357mMwakV37+duOhOxuy2eUR6VEcHH5Wc0NDzJ06rzbVK
	 fUk++MygEGvwfY55IYUnFanvW6CuxI7/dXvp9s5jsmGn3GLvdBfKVzFwj3ugvEFT3C
	 pbTdduOPQU3MWA64cCNNOwJtlYFPR52coEonYA5HURUij6G91EioUnpPy8X8STYlK2
	 AqM3JkqAj/GZOWVlvYaosu6B8lTuhmtbzDrtfubkHM+bXyCuZJrffhkn+Gg4mMW211
	 yCCChaHSQ8FPw==
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-5a884815606so10183351e87.0
        for <linux-hardening@vger.kernel.org>; Mon, 25 May 2026 01:13:16 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ8iN//HM+NstcAtSBNjV3+xyy4Pax1rQY8yDhsMNA2lr0PMNYVLFjA+Eeg+ZPZQSJ81QtPMqnbL9SP+Xjn/cj4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwAksP1zG0efGkRM9Qy/ixadXxcmJLncqCirT5on8QmW+JJpEHC
	C5TrrYhj6lYqtP/LSZ/5yiSYfs7Jvdb6gBLan/QNYvO7GIhRZJtCLBPvIaViwuxcsFTD8wgaQmg
	POwNGPO9KjbpG4vFM9BmeVsWSngMjHP4=
X-Received: by 2002:a05:6512:31c2:b0:5a2:874e:8a1e with SMTP id
 2adb3069b0e04-5aa323c56bbmr4080347e87.26.1779696795660; Mon, 25 May 2026
 01:13:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260518-jh7110-v1-0-fdb0daae5a4b@kernel.org> <20260518-jh7110-v1-2-fdb0daae5a4b@kernel.org>
 <CAKxU2N9jD5Mj+ZeQbtQV+hJ5zknEbVOiniGUdJysFOSLTzMKEw@mail.gmail.com>
In-Reply-To: <CAKxU2N9jD5Mj+ZeQbtQV+hJ5zknEbVOiniGUdJysFOSLTzMKEw@mail.gmail.com>
From: Linus Walleij <linusw@kernel.org>
Date: Mon, 25 May 2026 10:13:03 +0200
X-Gmail-Original-Message-ID: <CAD++jL=n34pTH01v_wPukRfGJ_gBCgK-SMMyRMvzPrh5UrAtrw@mail.gmail.com>
X-Gm-Features: AVHnY4IFRPE3qmOHetw4UlfepyIDwS5QEDWWNGUZV8mpVdGPJ6G3XVgslclmt-g
Message-ID: <CAD++jL=n34pTH01v_wPukRfGJ_gBCgK-SMMyRMvzPrh5UrAtrw@mail.gmail.com>
Subject: Re: [PATCH 2/2] pinctrl: starfive: jh7110: Avoid ifdeffery
To: Rosen Penev <rosenp@gmail.com>
Cc: Emil Renner Berthing <kernel@esmil.dk>, Hal Feng <hal.feng@starfivetech.com>, 
	Kees Cook <kees@kernel.org>, "Gustavo A. R. Silva" <gustavoars@kernel.org>, linux-gpio@vger.kernel.org, 
	linux-hardening@vger.kernel.org, Geert Uytterhoeven <geert@linux-m68k.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, May 18, 2026 at 4:39=E2=80=AFAM Rosen Penev <rosenp@gmail.com> wrot=
e:

> > -       sfp->num_saved_regs =3D info->nsaved_regs;
> > +       sfp->num_saved_regs =3D num_saved_regs;

> yeah and this is used absolutely nowhere. Both for loops are of the form
>
> for (i =3D 0 ; i < sfp->info->nsaved_regs ; i++)
>
> I really don't think __counted_by is worth it here.

__counted_by() is used by compiler instrumentation, i.e. by hardening
code that is not visible directly in the driver.

During compilation, code will be inserted that checks boundaries of the
array at runtime.

Yours,
Linus Walleij
