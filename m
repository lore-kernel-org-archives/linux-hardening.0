Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16AB832B996
	for <linux-hardening@vger.kernel.org>; Thu, 27 Nov 2025 10:33:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764239583; cv=none; b=h1fugW2CeGe/j25qWMwbtAgPO75vv9WxaStJhF4Z7VcsakoyJsEQZMqLaq89XQPxttSBO5r/hqH1Ylov9q2aMOx1ed5FOJLIhmwkLkhP0Pb1pXLEo6+oPBEOSHesTbq7GmdecSUHOnKiGR+ZxgVD6/cgETN61vT4f3SOzPCt4aA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764239583; c=relaxed/simple;
	bh=0TxRubWAllRCmV83+NRFzCjjIujms3H3INEK9PMJybg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MqrczjeZHzYy9LRT6ceJMHpYo55/UliS+s+sS2IGDckht93OBNiTp1eOIEBO8ylPNZots4fjB1XXbD9tpkWLhU26fsruC7eMYGR4jOpw89rNyT5pWUDKfQgFP5WWXLbx0ADrIByTH+9vX352K4Js8cRyrj6EYMYKzuGzPVxfir4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=F5rWq+Af; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="F5rWq+Af"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AE255C116D0
	for <linux-hardening@vger.kernel.org>; Thu, 27 Nov 2025 10:33:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764239582;
	bh=0TxRubWAllRCmV83+NRFzCjjIujms3H3INEK9PMJybg=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=F5rWq+AfjxKjPH97NaV/FEzQg5Fzu/NiWq+7lCj+FZQzgUKBs+2kcqYUT8iZJ9/MJ
	 JMOG85sXgkP5ZDql11NOaKFcngcF2bECaZeSWkVXbIyTZrBOeLov7yesFJ6uKbCePR
	 1aA0tQ5d0FqHAJ2Ge7t3DeHtOKzpSgheZIpqp6HzBXrV471BIFRQj5WXTCrxFvjXCg
	 oyOv+k2auvAvpnmNmGy2TGKUWReZ/5EupKCsrTp9vCAFAxwwdiqSvtQ41EHTyNrGHX
	 ohvbo+Y2KUHWWn8iA81AejRoGPtChliT8PdqRoogPeVpHY4NN6pnmscu7y6GO6gNIO
	 XgUWw2Bow1K4Q==
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-37d13ddaa6aso5615881fa.1
        for <linux-hardening@vger.kernel.org>; Thu, 27 Nov 2025 02:33:02 -0800 (PST)
X-Gm-Message-State: AOJu0YyM1eUdqIRa7aKUC99IqxOLSaVjDwjfzUEiH5OY0DIkI+dz6YGl
	WaRTVUVsEIfnChRAI1cw1vGkWJAvm2Z+qi9MSuZQsPSSraLkW64ADJfzJAGZ82ov+ix+kmwuybd
	RbCfN5oyrvaHasrubhIsOTa/lA8oeszQ=
X-Google-Smtp-Source: AGHT+IEKCHipYZEh6JGsjNNER5z+3CKP1etWl09QVeM3YONGTfjUvI5U4hE+viZw/8MZx/dyAn9ZkNQ4h/KuZvrnm+8=
X-Received: by 2002:a2e:7c05:0:b0:37a:47a4:d5cb with SMTP id
 38308e7fff4ca-37cd91b06d2mr59772791fa.11.1764239581012; Thu, 27 Nov 2025
 02:33:01 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251127092226.1439196-8-ardb+git@google.com> <20251127092226.1439196-12-ardb+git@google.com>
In-Reply-To: <20251127092226.1439196-12-ardb+git@google.com>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Thu, 27 Nov 2025 11:32:48 +0100
X-Gmail-Original-Message-ID: <CAMj1kXGLYYn9Fa+dbB2EWNbwJ6+PhKBz3vd=gUJDizvYwVSjfw@mail.gmail.com>
X-Gm-Features: AWmQ_blfqnL18qgHU_wCogCb4XqLMnCZzL8QS8DPfq2a28ZnCAui83obnxxDWCs
Message-ID: <CAMj1kXGLYYn9Fa+dbB2EWNbwJ6+PhKBz3vd=gUJDizvYwVSjfw@mail.gmail.com>
Subject: Re: [RFC/RFT PATCH 4/6] random: Use a lockless fast path for get_random_uXX()
To: Ard Biesheuvel <ardb+git@google.com>
Cc: linux-hardening@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, Kees Cook <kees@kernel.org>, 
	Ryan Roberts <ryan.roberts@arm.com>, Will Deacon <will@kernel.org>, Arnd Bergmann <arnd@arndb.de>, 
	Jeremy Linton <jeremy.linton@arm.com>, Catalin Marinas <Catalin.Marinas@arm.com>, 
	Mark Rutland <mark.rutland@arm.com>, "Jason A. Donenfeld" <Jason@zx2c4.com>
Content-Type: text/plain; charset="UTF-8"

On Thu, 27 Nov 2025 at 10:22, Ard Biesheuvel <ardb+git@google.com> wrote:
>
> From: Ard Biesheuvel <ardb@kernel.org>
>
> Currently, the implementations of the get_random_uXX() API protect their
> critical section with a local lock and disabling interrupts, to ensure
> that the code does not race with itself when called from interrupt
> context.
>
> Given that the fast path does nothing more than read a single uXX
> quantity from a linear buffer and bump the position pointer, poking the
> hardware registers to disable and re-enable interrupts is
> disproportionately costly, and best avoided.
>
> There are two conditions under which the batched entropy buffer is
> replenished, which is what forms the critical section:
> - the buffer is exhausted
> - the base_crng generation counter has incremented.
>
> By combining the position and generation counters into a single u64, we
> can use compare and exchange to implement the fast path without taking
> the local lock or disabling interrupts. By constructing the expected and
> next values carefully, the compare and exchange will only succeed if
> - we did not race with ourselves, i.e., the compare and exchange
>   increments the position counter by exactly 1;
> - the buffer is not exhausted
> - the generation counter equals the base_crng generation counter.
>
> Only if the compare and exchange fails is the original slow path taken,
> and only in that case do we take the local lock. This results in a
> considerable speedup (3-5x) when benchmarking get_random_u8() in a tight
> loop.
>
> Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
> ---
>  drivers/char/random.c | 44 ++++++++++++++------
>  1 file changed, 31 insertions(+), 13 deletions(-)
>

This needs the following applied to ensure correct behavior when first
called after the base_crng generation has already incremented to 1.

diff --git a/drivers/char/random.c b/drivers/char/random.c
index e8ba460c5c9c..dddbec7cf856 100644
--- a/drivers/char/random.c
+++ b/drivers/char/random.c
@@ -523,7 +523,7 @@ struct batch_ ##type {
                                 \

         \
 static DEFINE_PER_CPU(struct batch_ ##type, batched_entropy_ ##type)
= {       \
        .lock = INIT_LOCAL_LOCK(batched_entropy_ ##type.lock),
         \
-       .position = UINT_MAX
         \
+       .position = ARRAY_SIZE(batched_entropy_ ##type.entropy),
         \
 };
         \

         \
 type get_random_ ##type(void)
         \
