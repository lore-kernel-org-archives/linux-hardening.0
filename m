Received: from mail-ua1-f43.google.com (mail-ua1-f43.google.com [209.85.222.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43FB82C68C
	for <linux-hardening@vger.kernel.org>; Thu, 16 May 2024 23:55:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715903733; cv=none; b=qLb7VOt1nHLeqzZeF6inBs8eTrcpGGdAmiUnbCoGaGPCz2hcPOaL8bmhhs8qLQhFYDrLq0g81ekjSs/emyrzeLhePtrxmA/yRC/Ko36fdTRqCab3dnKNdxM5zAAaW0mSu4ZCeppjP4Spu9T7goFXXXaMmHJdMDHjSC6TR2VU/HE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715903733; c=relaxed/simple;
	bh=4pwCjRrdKlshy11Q9Qidn/PkDr98ccPmPz4v2MD8UlY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=K0Vjjwp16/gpQVMgCXxDgVneoMjqDQjmUX5m6acVNK6KvayOn11XpZ3QYPtaX2YGE34BUDs3aC8SEylkeRhUOT+MyA9IPz0pPPbMja5G4/DCGyDbMIaGS/IEPSSnrshH6mHAyZ+msYsDv3353cLCTkkvQP3b5QKMjA7tdp5SapA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=E/imWOJQ; arc=none smtp.client-ip=209.85.222.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="E/imWOJQ"
Received: by mail-ua1-f43.google.com with SMTP id a1e0cc1a2514c-7f3aee7c531so12935241.0
        for <linux-hardening@vger.kernel.org>; Thu, 16 May 2024 16:55:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1715903731; x=1716508531; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/gLVcqBV3F66KdisazNL7hONRkMphSyVVTtUEh3IZ/0=;
        b=E/imWOJQUukqIhTYGUAHSeDRJpe2R/x3Oe9ByVALnfK124hIndaA/8Mjmdr2phBqKM
         u+NeUR/kYgXJZTF9KDzqa8/qGoIpf4dNDMHyidkK15c1c79VKQ9BgcSSlQxV2Ylk5OYp
         4ec+y4+bcN2lFZNRS7toy2FItQ7CiMxRTwZQJz/tkxw4T0w92KbXAqZWDRqe23pZOOwJ
         xCetOdesSvIbcayGyrlV6mXFWl37iPVGpEyelL8b5X0eIW+Z8L5S1lFhZiBygIHTPRQU
         eWLEnmom0n++EIvDSroYuCc3OrBHxEaHTp8Bz01kT9VHoRUpoWm2rOCma0ULrHayezss
         8oeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715903731; x=1716508531;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/gLVcqBV3F66KdisazNL7hONRkMphSyVVTtUEh3IZ/0=;
        b=wAQEUux6xml9IfHsuY0wpTjbQJJcR07C9KXfSsf+bK5OjqDRMesck8LA8QztCt8I/a
         k4YvRh+61Ij+/LV25qWRTqxnEK2UXaGwltkWqn9/8GdGN9FzhUNASwO1xzb+HE/W7OEm
         3S9CXC7eA4Y1gJ7e73cWX/JpYrp5JoTTwi4FyH2BaZHvr57hjTcdmGBD9K2VfrjRd3js
         lPI5p1jbN2D5zht+wNkS2TIlPPQXcNol/7UWt+zvKJEAdGc0O+3VGePrM8aCpMo3mZSb
         R4gSIzxLDI3gsN42xnK+wXeNEEiQTKK+azgLtKKFacVMxEjdh8QS0JyTd7P9MeFYJXBr
         FklA==
X-Forwarded-Encrypted: i=1; AJvYcCWMSOxKWiworKzgmaObf3R1UI/gnLLdEjY69M75UkynpDr4AT5uES+gWOvNaf7avcCHCvO7T+5zAOBmEcZkilJgvgjTBwNjKt4W4TfBdZ5a
X-Gm-Message-State: AOJu0YzqywDgXrs1Wuaripww9vDU1OVd4ZQxcEBGefoaEJ6PesmQ67md
	h3+JEqbDzTWqLBL3A3SEb2U+FeI0FXQP0cj4u9M3j253sw7j9m+9KBs6hq0YqjOuYlYt+/+zRuX
	ZjZGdcWlnYD9DKv1ZeHt+hdWNJMalRvUXvnUK
X-Google-Smtp-Source: AGHT+IG+/22HSGO1aEWyeCTPHI7nYt0GiaqCsKk1aiSbOHC0OUQTiWABWrFf6IIzcykO5qWDSD6ZOxcp/txXENrYfSk=
X-Received: by 2002:a05:6102:5089:b0:485:9a12:cae with SMTP id
 ada2fe7eead31-4859a1210d8mr3163573137.21.1715903730652; Thu, 16 May 2024
 16:55:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240507-b4-sio-ntp-usec-v1-1-15003fc9c2b4@google.com>
 <87v83gllv8.ffs@tglx> <CAFhGd8p94sHpDc8MApZK7q9iEQ_C8c5frwZx9v_bTnhwtAM=HQ@mail.gmail.com>
In-Reply-To: <CAFhGd8p94sHpDc8MApZK7q9iEQ_C8c5frwZx9v_bTnhwtAM=HQ@mail.gmail.com>
From: Justin Stitt <justinstitt@google.com>
Date: Thu, 16 May 2024 16:55:19 -0700
Message-ID: <CAFhGd8rTHPiKG+XOkkUihj9r8k1=n3zgitpM9X2aQf6zhp9psQ@mail.gmail.com>
Subject: Re: [PATCH] ntp: remove accidental integer wrap-around
To: Thomas Gleixner <tglx@linutronix.de>
Cc: John Stultz <jstultz@google.com>, Stephen Boyd <sboyd@kernel.org>, 
	Nathan Chancellor <nathan@kernel.org>, Bill Wendling <morbo@google.com>, linux-kernel@vger.kernel.org, 
	llvm@lists.linux.dev, linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, May 16, 2024 at 4:40=E2=80=AFPM Justin Stitt <justinstitt@google.co=
m> wrote:
> Isn't this usually supplied from the user and can be some pretty
> random stuff? Are you suggesting we update
> timekeeping_validate_timex() to include a check to limit the maxerror
> field to (NTP_PHASE_LIMIT-(MAXFREQ / NSEC_PER_USEC))? It seems like we
> should handle the overflow case where it happens: in
> second_overflow().

Or, I suppose we could add a check to timekeeping_validate_timex() like:

if (txc->modes & ADJ_MAXERROR) {
    if (txc->maxerror < 0 || txc->maxerror > NTP_PHASE_LIMIT)
        return -EINVAL;
}


> Thanks
> Justin
