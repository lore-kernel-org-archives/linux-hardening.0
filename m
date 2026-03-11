Received: from mail-dl1-f53.google.com (mail-dl1-f53.google.com [74.125.82.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D75F344D80
	for <linux-hardening@vger.kernel.org>; Wed, 11 Mar 2026 13:50:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773237046; cv=pass; b=DuJVGDDa1IIdrvTu9siSDvOq50FtAHyfBherMMwiPBQv2gfXL1cMpZ5T9nwQU7JGKSigPITo/xY9pPKVf3IC2FvyXg3MHtt4sm3POeHj3aGvKHXdgGxbGaSY3uQNwyk3LIJj332hcb8zWihAYn2dbN816JHLuErGBQ6KrDXEpgc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773237046; c=relaxed/simple;
	bh=oVv316C2TEL/OC4vpAz4nefTk4yHE3YkVKBDK98mhMs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jwB3W3srfFywBCsdHBnHhb5FZIP/sCGmwXePlkEWg6Gs60qwNLdKa20f89IFzGDmZuTySoAxklla9pwPAtwnUPiS4ctZVUt5l80YO7Xzb7n0okZSZ7JSbE0YdGJLQmpsoGWtmodIlBQ9rjCs08JEI4m+3Vz2Q0+bBMziJRJ7AmM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZjtBAKga; arc=pass smtp.client-ip=74.125.82.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZjtBAKga"
Received: by mail-dl1-f53.google.com with SMTP id a92af1059eb24-12714f01940so810055c88.0
        for <linux-hardening@vger.kernel.org>; Wed, 11 Mar 2026 06:50:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773237042; cv=none;
        d=google.com; s=arc-20240605;
        b=Xy+cw3AHSSNZVPFYq6sU+fCHHgY376pY8FU8IE4m8m+43MNFftFEgt1eLnMe0y25Re
         ChbqnH3tJagekoKqIeUxxHQ04/npGvr5tgRudggrldFXXbVm9fMW0vekIKoQH0nbAr6j
         edx4zy4FHjz7NNzdy7glvRNT4BCOvAjO+/Z0FC7i2lSMwxJ3FPEqz0+ntA5rp68fd7TX
         /LwNioNKGwbJzZVBaBf0Y4AB7PbirumllwFtu1oKOtIxq3UxRhNCwybvCjD2x+2/rYnM
         DtcqmYCZm382yWQIqUmG6sizwU8wJgGkRcrGGmgJ9a17BRPd+HK5dvIOtgzxa0jaIK6o
         BMLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=hrWxe7huXLGcH2eRq/nDkQyqOoBgN9FgmWPPk3aJ7iQ=;
        fh=IUtZlKBTQiAvRhkieOsQN6f5Fvq5Sfji6f5V/Z/ydLY=;
        b=Hbe6E9NGsuY171EnWqiADX4Om37hJzQLMfKIZlkon6pc+ZkhdtiqVrHmHGxkp9pf7q
         ZwZOj9ncYQEoDaxuD0rep3KntGTR8dCKJmXjudihPjnq+Ch/olhYEgzq2ktmP9k9EF8D
         xICciu1pJ8QiHuciJ46JBTtgrveEHnjOV/wm35N93WWhDIMiPCrf3rrA14rLQJEq1jQd
         gENcCnCdkEHUfRdDlb6rj13rLasut4PRHkFOsM4gJ8qMdwD8Y+IqYBldFPy2t+2kWTCU
         Unisa3VzEMjOKOKeT+fpwRW1IHyeNtaHFNL6XldnIrx5lp/Pafa1Z2m1bTiQDL9WE0RP
         RS8w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773237042; x=1773841842; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hrWxe7huXLGcH2eRq/nDkQyqOoBgN9FgmWPPk3aJ7iQ=;
        b=ZjtBAKgalI+1aUzvLmSCcQJU45aQyvCQ5jm/pa0vuCbRTmwPM/g8fcLOwtnHpcBFYN
         IUduokX++ne/ZqDctDn1KI6D6E7jphPmTA44Y8nHV3ys3cwE3CMMgBZnWO7UubaTdaSE
         xfsfQZ5os8r587NYAsyxAq1Ludijv1dPhrecnkr3a9QkKMAsx5Fw/v1o4JP1/z/zwWFM
         3zNhT1dzJqS4TtYWHPgxWj2RLR0SxhjEW5D78vO++sI45c5YzqKei8P1Iyhp7XpWLS8L
         iJGxOCSfKpnwFsDnAHtBy7VvG69NVzZVOk3KcMDq6qzGSrCDqdnwam1fUJcnAJ7M+qWA
         xyIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773237042; x=1773841842;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=hrWxe7huXLGcH2eRq/nDkQyqOoBgN9FgmWPPk3aJ7iQ=;
        b=P7NZ9LB8VUfsZVHUBnoetA9vzcczBZZ9Vek9MGriYvRIwwTGkJ7VQ9z0UFhQvt+bbs
         JFjCJ9F4Y6ibbIPhfxtQQNy76Mv3B8TlOTC6eokn+xQEt33mUvSGlI17vbC1nFNuurpR
         glDoVNADj4rRaVpq72c4AbfQec6cNwakeg0zro+B4FNOA8AJZN33wcH+Vj96C7nbqwv1
         67kDIa0J2NJxVzNnJtYxO6f7OAQ+eFO9Z1pL1beWneHkPmUbMN5gpZTIcOTxFHtFThQe
         nXEQaAxNZUYMiclEsSqMO1AR9un+5bCDLWgLujOONqYPwUKUBmPVzCmo0nqk1fqRShXA
         YcWA==
X-Forwarded-Encrypted: i=1; AJvYcCUfBh4YvicebLt+yG9a5cZ37KwIHNI786MbvPwamtU3JSWDsnfUDf2q84XdrUAMXfJK89Ci/4aGtgZxgfqa52o=@vger.kernel.org
X-Gm-Message-State: AOJu0YzfpfHzXVBeNw/ZkUUxvX7YiOUzBYBBCXPPqVkEBc21M3yE+aNX
	kS2o+0vlMfD+H1HzDiosZA754B4P/+4FgFSfPuQXpXDB9xgWwBrvGP08Jhm+geMjuCxONAK5Z5D
	ens5se4td67WujmIdmqZcKd4q6wytT6g=
X-Gm-Gg: ATEYQzx1Ibl154/n8vLMzT5QU84m6FNjQB29JxgnfThYPNfWypU5Yur3m4NDRGz92eb
	lgQRN7B+DNxhoLO9IfIgjO+sf7pvyXhtu54/DK260mhU+xsr1gn+7mtX57M4Er68i/2PaLE4vNr
	+aIgXlyZSaMGstngcx4vu4f4+8mC+Pku3XvlJhyCPxuGPRrTMKZj6TiZylH/uSjfZyUX6fCPrwr
	+U+4L8fsAE/Yh0SCW0UZWiwyUx2QuF46O7SVJwAFOTaHFHMvTh5JOifdwjDJMurTlQdzs8FU6Z2
	HlPyePfisqO95Wv15h15h5fhPMdoQM30Dhe85PR28b9n6IG4crABLXL+OD3ztbcVvLssDA==
X-Received: by 2002:a05:7022:1503:b0:127:3480:7ca9 with SMTP id
 a92af1059eb24-128e778b056mr646722c88.2.1773237042449; Wed, 11 Mar 2026
 06:50:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260109162514.308143-1-yiconghui@gmail.com> <202601091117.122A9268@keescook>
 <be86c64d-db3f-447b-92e8-085333c28d11@gmail.com>
In-Reply-To: <be86c64d-db3f-447b-92e8-085333c28d11@gmail.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Wed, 11 Mar 2026 09:50:31 -0400
X-Gm-Features: AaiRm52BZqGIbP0vEq-B5UeZs-CBWlpJXFWO9mG7NhBLLIxZnacde8BTAw8Hoyc
Message-ID: <CADnq5_N9PdjcbV=X4eDStPZd0COOGjaFJf+J-e_Lr9dMpEmq+g@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: Replace deprecated strcpy() in amdgpu_virt_write_vf2pf_data
To: Yicong Hui <yiconghui@gmail.com>
Cc: Kees Cook <kees@kernel.org>, airlied@gmail.com, christian.koenig@amd.com, 
	alexander.deucher@amd.com, simona@ffwll.ch, amd-gfx@lists.freedesktop.org, 
	dri-devel@lists.freedesktop.org, skhan@linuxfoundation.org, 
	david.hunter.linux@gmail.com, linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 11, 2026 at 7:59=E2=80=AFAM Yicong Hui <yiconghui@gmail.com> wr=
ote:
>
> On 1/9/26 7:18 PM, Kees Cook wrote:
> > On Fri, Jan 09, 2026 at 04:25:14PM +0000, Yicong Hui wrote:
> >> strcpy() is deprecated as it does not do any bounds checking (as
> >> specified in Documentation/process/deprecated.rst).
> >>
> >> There is a risk of buffer overflow in the case that the value for
> >> THIS_MODULE->version exceeds the 64 characters. This is unlikely, but
> >> replacing the deprecated function will pre-emptively remove this risk
> >> entirely.
> >>
> >> Replace both instances of strcpy() with the safer strscpy() function.
> >
> > This looks correct to me -- dest and src are both fixed-size, so strscp=
y
> > happily checks everything at compile time. :)
> >
> > Reviewed-by: Kees Cook <kees@kernel.org>
> >
> > -Kees
> >
>
> Hello!
>
> Is there any further feedback or progress on this patch?

Applied.  Thanks. If any other patches slipped through the cracks,
please feel free to resend or ping on them.

Alex

>
> Thank you!
> Yicong
