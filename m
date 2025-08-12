Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A45DB288CB5
	for <linux-hardening@vger.kernel.org>; Tue, 12 Aug 2025 16:25:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755015914; cv=none; b=ghdjnVylX306mLSWlmfBXKBMR7qXznHzc7PJNtlEtA/3kuLvMax/e9Icq2M0pA9+qPNEZ2e7hni/TXwgxsUYQJQvZYa83ZME322iNBQGlbrQzej/5dCQ7txG6wg/TEYoCnm0fqMpEHwzGEwo3gpQXwh5Ufb1yPo5SC41ig3+m3Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755015914; c=relaxed/simple;
	bh=kWuuYWccU2aWnyCiiC/tcj5cHAKu7ak7BIZpKMqc3TE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iC80JBX0Y2i/WKqu3HYmIGR2hbtBdNuHv0xDGu7HEETpYjGIus39r3fE7uJ1kwpp3XFQ4tmd8JlyrBKFo76ugqBQzkGaFeIReWJNxnABzFZw+zCadjvWyjDVUMOCQ+rMFb6ttFky0rYGqnOGt5TscQYYnx/ZdH0Y1Ya8wrwLSWU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=nMSD+se0; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="nMSD+se0"
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-24306318aeeso5405035ad.1
        for <linux-hardening@vger.kernel.org>; Tue, 12 Aug 2025 09:25:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1755015909; x=1755620709; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SLUEz/tgU3wZxbS9LDJCvqmXWzBlyYVJd+3ig6UYiHs=;
        b=nMSD+se0yZjJy4dWk9OVEgxgAz47R7WDiA5/prv1oAsEbetkMnIlMML3Jja3OmVbAE
         RndI+83fXRIsirz0NNSEmQ+4q6Liuo1tzIp+eY9QPzPvwMBNoMFqjytYWO81GBROC3UN
         bcldaTX9C5CjgtU2Fvxq8JUVbh5sDPs4oO6dg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755015909; x=1755620709;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SLUEz/tgU3wZxbS9LDJCvqmXWzBlyYVJd+3ig6UYiHs=;
        b=MFnhF1qmfy0/37f8+ZOcUFTwDKkdMCcKmNnRyxGfNFeaaGJNVnkjJznNj8bf5xwJd7
         mOG9ZZEdhzyk/K1BNZHBnSKLTQ7AeSHTgwNguSeSedd3dw4iAjnZrrfAtk4AkqA5ZBUV
         9mA1dI9PZVBQ1Fkl5ZZcceAcefc5g7HptwFQIMN/Qhc1d/r2+JZ+W+fRTnk2EglJGgQ5
         M/LcWMNrTy0P0aFJoAUjBRO76aMppb5Bx8mnZEdsC5ruVIFcp70jlMYegBwkceH0EvoA
         5kIXvDP0s6dsnLakiOOKFOJWowVmzd8lltxB4YoDfOuEC+EYZlJz5mAFql+K0EHxotmn
         kXlQ==
X-Forwarded-Encrypted: i=1; AJvYcCW8xWlvbkgiav0ZDHiNgKkd7ceHKG5sYT7jnLsey45RKf4bn8YgWuZjUJEHRLoaZvhlE3TjDszxVrPMfJC1QIA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx3b5ZQfpov2/1dtvg4SimCMje5GvJu8MppPEffIDIz9JqSB6V3
	EL3NYIiVrBiVX0RVNzQcBiU9aaX8QxEqNTV2avGrnJzxxRPtyZ31A8fF4dY3ogPIZE72JDS7GG9
	bP0w=
X-Gm-Gg: ASbGncsl2S/OGmX2g4QQeBsfKB7hXArg7srN7RHejfhOq9F652YxSdlvlXv9VPT9Hds
	/9EN0iGVKWhfcb1kjroFw3WEygmk4BCKxLNof5MufDD3JmzMD1Pezu2AS/suSeG5hqdv82te5Ce
	n2JJ5EKZJpDcy/l6v3BFBqh471qY80+2u+AtVgrK7TxprsjTrSMS+/kZ90aSsykUNvSSEXB/s/2
	aAfSjsE65rvBDuHW365+HTEReg1FQuPfgsPXlMTO3T/8MwVJW/zc2d+SX+l065CvF+lAbdoKLY6
	wq63Xh99FrRRA77l73nF4G1K1HadcD2B8TPPJoNj7xb5vwZ7/yiIaHptBugclFaVmUniNV4hjVC
	mwecHI3Y20vBMt7yBb8cjn++Vd76H2Z2C5n3yAicyFlJslYaRIqscxe2KGErjDPjQQw==
X-Google-Smtp-Source: AGHT+IG12ljEe0D6Z7hoLbJ3+e76Vqks2AshYR0PSQN3Q9j3OpsIZFeshwfgz5bQezHFVbM21ccO0g==
X-Received: by 2002:a17:902:fc8e:b0:235:7c6:ebdb with SMTP id d9443c01a7336-2430c016c4amr4112315ad.10.1755015908805;
        Tue, 12 Aug 2025 09:25:08 -0700 (PDT)
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com. [209.85.210.173])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-241e89768a7sm303717745ad.83.2025.08.12.09.25.07
        for <linux-hardening@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 12 Aug 2025 09:25:07 -0700 (PDT)
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-76bde897110so4742522b3a.3
        for <linux-hardening@vger.kernel.org>; Tue, 12 Aug 2025 09:25:07 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWaXQSH9hIsLlYIci2/ophx/z3C5HlitURtM6t1OPRUvhmm1zHXa2jvSVO3x+p9xt1gMayjBaeSQA/jh/gKImc=@vger.kernel.org
X-Received: by 2002:a17:903:2ca:b0:240:8cbb:7c86 with SMTP id
 d9443c01a7336-2430c051fd9mr5044945ad.16.1755015906847; Tue, 12 Aug 2025
 09:25:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250812132621.119641-3-thorsten.blum@linux.dev>
In-Reply-To: <20250812132621.119641-3-thorsten.blum@linux.dev>
From: Doug Anderson <dianders@chromium.org>
Date: Tue, 12 Aug 2025 09:24:55 -0700
X-Gmail-Original-Message-ID: <CAD=FV=VnvUUG7qE_RDKfos1H-baZUT8V5vKx2QNRX14OZ0QnwA@mail.gmail.com>
X-Gm-Features: Ac12FXzitB3rDj5b3cBiPPb6exLXxuQi_RRNYdD80_p1kC8DLuIk3JDtj_3Z_hQ
Message-ID: <CAD=FV=VnvUUG7qE_RDKfos1H-baZUT8V5vKx2QNRX14OZ0QnwA@mail.gmail.com>
Subject: Re: [PATCH v2] kdb: Replace deprecated strcpy() with memmove() in vkdb_printf()
To: Thorsten Blum <thorsten.blum@linux.dev>
Cc: Jason Wessel <jason.wessel@windriver.com>, Daniel Thompson <danielt@kernel.org>, 
	Justin Stitt <justinstitt@google.com>, linux-hardening@vger.kernel.org, 
	Daniel Thompson <daniel@riscstar.com>, kgdb-bugreport@lists.sourceforge.net, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Tue, Aug 12, 2025 at 6:27=E2=80=AFAM Thorsten Blum <thorsten.blum@linux.=
dev> wrote:
>
> strcpy() is deprecated and its behavior is undefined when the source and
> destination buffers overlap. Use memmove() instead to avoid any
> undefined behavior.
>
> Adjust comments for clarity.
>
> Link: https://github.com/KSPP/linux/issues/88
> Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
> ---
> Changes in v2:
> - Use memmove() because of strcpy()'s undefined behavior with
>   overlapping buffers as suggested by Doug Anderson
> - Compile-tested only
> - Link to v1: https://lore.kernel.org/lkml/20250811170351.68985-1-thorste=
n.blum@linux.dev/
> ---
>  kernel/debug/kdb/kdb_io.c | 14 ++++++++------
>  1 file changed, 8 insertions(+), 6 deletions(-)

Much nicer, thank you!

Given that the old code was officially relying on undefined behavior
of strcpy() before, I'd personally even add:

Fixes: 5d5314d6795f ("kdb: core for kgdb back end (1 of 2)")

In any case:

Reviewed-by: Douglas Anderson <dianders@chromium.org>
