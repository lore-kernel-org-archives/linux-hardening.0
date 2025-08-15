Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEC0F1E51EB
	for <linux-hardening@vger.kernel.org>; Fri, 15 Aug 2025 14:32:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755268379; cv=none; b=C6CcLF8jVRmfyNkE99ZOb581N9LhzZyVwV6aq4+2RKKufw80xOfbxpea1A7S8Bzi6pJnt6O+hGllOMvSsJwmKtFfFTA2wXN/UHbdpuo5PQAQEiFBWfZlkSITWZ+Z7GoUnbwTXD/CWISNwJBCCoHsJ5wX96zq7qW6+HRcSR8N/Mg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755268379; c=relaxed/simple;
	bh=AN2BMV6s6s+J42sKLs0G5mD6S9TR1PkBT2u/6WOkMOg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oE5tAKsrSTPwJ0m3o46peVEiW60bgIIq3fyTvy4ynXif336cyDGLChhJQ5uvAQF7IinKMMbot/5jc6uh5HUUlJ8xrSZRQQgB/+gWULrS6YaiJReLdWdu9tz3Y84i3BZnPiXUVv78Z0n6E+Q4DuxgyzRp0duWcLftQoUN89+FgvQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=BH8WkmDM; arc=none smtp.client-ip=209.85.215.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="BH8WkmDM"
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-b47173a03ffso1260247a12.1
        for <linux-hardening@vger.kernel.org>; Fri, 15 Aug 2025 07:32:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1755268375; x=1755873175; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HUPDlQYeNV8xVNLPQ4s+Wppv5EkSz5BsCNrMzhAzL8c=;
        b=BH8WkmDMFVJsEf0mvkuIUaDOG978bejjNmSns5Odmd7YlQfNNdslboM2vTbgJaj8Z/
         cWG5ZhLLGG/P+nyWvpZ89r5vvd2OagS02+v35S4I6uhB43JGkw8kzQVRFLIpUL8uZ5hs
         qm4xZpp6mNMq5orh9UWovMX4+nb2i71L3YCuY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755268375; x=1755873175;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HUPDlQYeNV8xVNLPQ4s+Wppv5EkSz5BsCNrMzhAzL8c=;
        b=DfMHf3V3lrf1heq78zgEXCZkwPYwtFskFfcIKZPRl9dvYUPxnTBFTaXU0FygYKIXdy
         XIzzSTQY/feJVagXFtmoUv/1ckk6ZBtMqfb1Bdw1Z/EErt9y25FgIoRWBJRND6JUkdlH
         5FyHCQEpJbCk6od7xhYhBlBolmi9O7lVepkZXGnqp+DpPkebkRsa9iom9h8LHgyQ00A/
         ds2pZ3OWjG3M4yZq7u4S78pTAQMSgYDNb1jOSGo/eafEamvzcnW9IL0YfdvIojNh4cMK
         2G3uCyJV166LqqY60BKFyCmF7HgX67OQmgj+q2nLw1Kl31xhdqAq//IZicYEGo68gwwb
         2P6g==
X-Forwarded-Encrypted: i=1; AJvYcCU0c95u74k74OpsbVRFN9RmmmpvLywqr1qn7x1BLwY5Hx1XZXIRCeT2DAqgRwxQNEuk33Gvhy30BGRhazBLxEI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw7npji+JVRG569JWPulpM9hwZLxgV71LLw2vuOfPzyVkRkdAlP
	M94SGe3vtcnPbu2HeX7MzKDuAVO3TW+BwrOABNZQfyRbc0wJzY77kcNITn6qzXVOG/a7Kbzfo/n
	YUPM=
X-Gm-Gg: ASbGncv+sVwQmvzbkXzL0NhitC/tObyNRDLlbgXfFoZoVXxxcXAONpSBWldSHqDMs0o
	bHT9wU973V3vD0tverY6jc1Jx0wYjkxfNNSmdLTLbXnDmAzMOWrOCuDb8Aq38EWIEWYxD0Buo4g
	RxDHwqAd+2clAy5ZeKkYsSiD30aT5FCoCDWrdhvYRQ+5a51O5qJaIbY4wbMaj4+tnlTki44oXxS
	7gBdsGKcEZ5qBcgkzbiGh1CuzSd7klGUXq/oifnlrUS9jrD6yxG3nNusei2xjqcGOaTtprIm02C
	fKEoZgNcCAc2RlHulSOsIZbssi/tHMlfo4vJ3j+B39ZVHkOyPh5XxkurbhR7pw097gNwGbw1yCx
	j694VCkTTS/KHipDzz1R7OrjuN9/9iiEtQ6VYGUC2yvjyffyykPvZY4XDPaT6us9SYQ==
X-Google-Smtp-Source: AGHT+IHw+jH69NPKPkmC2YNAM/a5Qe8n+3drt9J6mT2/WBlF9OCOegVIGnsU3W1lQU20lSR4Lv81Xg==
X-Received: by 2002:a17:903:198e:b0:240:640a:c576 with SMTP id d9443c01a7336-2446d73a930mr31262195ad.15.1755268375085;
        Fri, 15 Aug 2025 07:32:55 -0700 (PDT)
Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com. [209.85.215.174])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2446d53a2bbsm15500535ad.110.2025.08.15.07.32.54
        for <linux-hardening@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 15 Aug 2025 07:32:54 -0700 (PDT)
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-b47174beb13so1415588a12.2
        for <linux-hardening@vger.kernel.org>; Fri, 15 Aug 2025 07:32:54 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVCHe5uw+rVgVop5ZmpLX82PCMOr6gqT2SI8sofnZNYYLFuSo37PAWut56Hk93w15tuEjLY7isD5ejWqClCr80=@vger.kernel.org
X-Received: by 2002:a17:903:19c7:b0:240:92cc:8fcf with SMTP id
 d9443c01a7336-2446d97a21dmr41288195ad.49.1755268373349; Fri, 15 Aug 2025
 07:32:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250814220130.281187-2-thorsten.blum@linux.dev>
 <CAD=FV=Udf3pZjhpPxEuHsFynP7GoHnZ7RG=NYZ2gLzm=E_4V4A@mail.gmail.com> <0BB3AC5A-5B9B-4149-90CA-80171B8B0A48@linux.dev>
In-Reply-To: <0BB3AC5A-5B9B-4149-90CA-80171B8B0A48@linux.dev>
From: Doug Anderson <dianders@chromium.org>
Date: Fri, 15 Aug 2025 07:32:40 -0700
X-Gmail-Original-Message-ID: <CAD=FV=V06iHUurHQYN07ri=2-5tHon3G2OMnT1rtZ2Qp7EAW+w@mail.gmail.com>
X-Gm-Features: Ac12FXxL2rPDKIvnBjqZEgiiOTotbJwxpdaBhPYpGXK_jpG3oTuZHDGRA0uWCfE
Message-ID: <CAD=FV=V06iHUurHQYN07ri=2-5tHon3G2OMnT1rtZ2Qp7EAW+w@mail.gmail.com>
Subject: Re: [PATCH v3] kdb: Replace deprecated strcpy() with strscpy() and memcpy()
To: Thorsten Blum <thorsten.blum@linux.dev>
Cc: Jason Wessel <jason.wessel@windriver.com>, Daniel Thompson <danielt@kernel.org>, 
	Nir Lichtman <nir@lichtman.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Yuran Pereira <yuran.pereira@hotmail.com>, linux-hardening@vger.kernel.org, 
	Daniel Thompson <daniel@riscstar.com>, kgdb-bugreport@lists.sourceforge.net, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Fri, Aug 15, 2025 at 3:48=E2=80=AFAM Thorsten Blum <thorsten.blum@linux.=
dev> wrote:
>
> Hi Doug,
>
> On 15. Aug 2025, at 04:05, Doug Anderson wrote:
> > Let's think about some test cases...
> >
> > Old code:
> > mp->usage =3D kdb_strdup(argv[2], GFP_KDB);
> > if (mp->usage[0] =3D=3D '"') {
> >  strcpy(mp->usage, argv[2]+1);
> >  mp->usage[strlen(mp->usage)-1] =3D '\0';
> > }
> >
> > New code:
> > mp->usage =3D kdb_strdup(argv[2], GFP_KDB);
> > if (mp->usage[0] =3D=3D '"')
> >  strscpy(mp->usage, argv[2] + 1, strlen(argv[2]) - 1);
> >
> > Example string: argv[2] =3D "\"xyz\""
> >
> > Old:
> >  mp->usage =3D strdup("\"xyz\"")
> >  mp->usage becomes "xyz\""
> >  mp->usage becomes "xyz"
> >
> > New:
> >  mp->usage =3D strdup("\"xyz\"")
> >  mp->usage becomes "xyz\""
> >  mp->usage doesn't change (!)
> >
> > To match old behavior, I think you'd need "strlen(argv[2]) - 2", right?
>
> No, it should be "strlen(argv[2]) - 1" to match the old behavior.
>
> In the new code, there are only two steps instead of three.
>
> With your example source string "\"xyz\"" in argv[2]:
>
>         strscpy(mp->usage, argv[2] + 1, strlen(argv[2]) - 1)
>
> evaluates to:
>
>         strscpy(mp->usage, "xyz\"", strlen("\"xyz\"") - 1)
>
> strlen("\"xyz\"") is 5, so this becomes:
>
>         strscpy(mp->usage, "xyz\"", 4)
>
> Unlike strcpy(), strscpy() copies at most 'size - 1' characters and then
> appends a NUL terminator. In the example, it copies only the first three
> bytes (xyz) and then appends a NUL terminator, effectively replacing the
> trailing quote. The result is "xyz", the same as before.

Ugh, I missed that strscpy() implicitly takes away an extra character.
So, yes, your version does appear correct in that sense. It's
definitely non-obvious and I agree with Daniel that it doesn't feel
like the right way to use strscpy().

-Doug
