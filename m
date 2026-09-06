Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14BDC346AFB
	for <linux-hardening@vger.kernel.org>; Sun,  6 Sep 2026 08:54:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788684856; cv=pass; b=kAfhF5zJOpbYGS9Pmj0yABXCwE6QFlOIRcqWAET7B72KJuFQx1+cjNtkYE1ATLn49tKflMfTGZfSqi/WG74Fqy/6O+4WChuTbXty3C43oIsLndqlbbOboTWgPU9YVPuMbckt5+S3ijecHhlFI1PjNVy20U3SBdfyenAYxmyzzZg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788684856; c=relaxed/simple;
	bh=FtMUsQ3c+eU5+RWwNkmgMZ0NRIy/xc4bbMVT5fiF/aA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PfzMOr30GA9LlPwux6L4QaCmZ3Wr17c8kfzgXLLVd9+aQPhNxbFca6xpBXl3/+UQKWvqR70FDZumW5uJiX4QmLaR6mq+WXVJiTkgKroMy0fEKFtxYjfadK7rGByP+K1rkwGz7wxZxqs13O7LBQOQvQ3K1H2zt/db3uz68j1jlzs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=h9TizUcl; arc=pass smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h9TizUcl"
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-6a0794669a6so3905508a12.2
        for <linux-hardening@vger.kernel.org>; Sun, 06 Sep 2026 01:54:14 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788684853; cv=none;
        d=google.com; s=arc-20260327;
        b=V5LwwcpXx1iNKPLq8StnznEacm+TPzvIvHGxwK3HLwbFQeE1P7eV1a72wAhxejuhfg
         rp9mZGm8BQw2h3E7mkdqO7ya1BxYXyH5b9gai1szLn50kqT4CoFOIlQ5pe7PQE1sg3/S
         DExId2V+axWMs4Zjykk9og6j3ubAlP/UyyHGOR/ge2qHLcHAHMmd9g1I5SwACMhh3Oaz
         SjaZ5jFbnRGe6MpgGP16A1zAEnxnDxHhWYkWmzGCtDKctTJyVZHeJxC/9aAq+r7D/I+y
         m4eXLhl0MDdw5h2/lmBgH+J/tvT9jBe9VN6776vjQvgXQYpjIbc0gh3ma5JuVDD06qMU
         BRpg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=YbwXKI+GsB7CVjJT81Ck70VdlQI8PJuud+2raignSOQ=;
        fh=cNwhPM15+bv9aQjv5YGDC60/oygcJ4rRXifEiV1yYD0=;
        b=XTmZgMotx+/9hFJJjv2rURb4+BW8aaKhilHvVLLdLIk7d1CQdn+oMvpssKIPl7/zQa
         zu/C9jLECiVmdpW8unjYMjtQpwHNRxmUyl7bpkQmaXQk3UJ7WQXIHVaK4IUj+lqiSmJW
         rs/Jn/x3+ttspjK7YrnxsT43YYLyJA3nthakOmnR/4X0mJpGJCRAZSUH38GR122k91qd
         qqdopzz1CC83jjCTKSKGgn8dk/G+YFWoYzDrKkj14iRUQeoA3cauAt4P1CKQ/3pabvjU
         dFQIJw24T6x+ZiAXLcfo784Wy8v/Gxc1vEhago9KOyD+6T6C4YfB+apGfa21AH+cIl1G
         e6cQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788684853; x=1789289653; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=YbwXKI+GsB7CVjJT81Ck70VdlQI8PJuud+2raignSOQ=;
        b=h9TizUclhnkWlz6L9RI1PZiRuKD2A6UZqzwrBT4mzNeaT+v6QRA7r4RC6B6gZ8t3Wh
         9VtwOqfAhpgtrz49eF7x0JDQVIA7Y5yAz2EtSNgn7VXyNl7Ae5C/5760Ex+EMEVj5vKT
         wsqDQbqjCurHiHAJ52WUifBMseVPi8eagaf+HpjFBX66AzHmp+b8jM1HyG/ijV2/r10G
         G9rOc6T+vGvLQ1Y8VSnBNUwrMJL3dEo8zYURQQcp9Y4fN7DP11TopTJQh+d1vbG/1TDZ
         3efGsk2hoO7KzAgaVfJfIIUSYqhs1BRoJOXBaEJyDK1QwxjbT4SudYw4FlGDaeBtQng7
         76eA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788684853; x=1789289653;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=YbwXKI+GsB7CVjJT81Ck70VdlQI8PJuud+2raignSOQ=;
        b=VY73fUnBMAeM/0TwASfR7x4OmQAjY8YNxd9m/rL72jJFAmVIMvy1TwnrTnjVs2aGqy
         iZay5bOxX+bLdVOHH1TG5n00asBgKnbiL40ZYiswEJzh0zu3+4T/r8obVP2Kk9v/p3t3
         i1o5TzGTBczZtKRqoTyq1KcSM7uDTC8hoGP1QJ0JKCcxTT65Ckuv7ZOD4OodvOc0z8Wg
         XjRdfVJ4qHwIMe6qbGqFFDvLZv/85F8R+EN6/kdd9Cp1Ol1Et8ZlVDUFxWT6xGsbfCkY
         2T3nC42rO7zHUpfTEU3lr2JW+y0MDexYg2x7sfA/x3vuGvvjZiNrnawxm2N8DZTmBQo1
         JlLg==
X-Forwarded-Encrypted: i=1; AKwUvBxDIrIIupPLL8O1fKVL8PsQA+8/QILSZQkwTja25WZ8romCf0nDocDHJvIr2wIhjjXl/Q8HoJS7+zfFvyBsdWE=@vger.kernel.org
X-Gm-Message-State: AFuF++kBYVDewMrx9oGLnvgsGL4TqY78sCyPjJrw4L/gtYr3Oel/mB+O
	OvaeP4DR/TvOw8zo32MpswtIDKrhxcIN4Ofmh4kNnI6K/JqkuL03JuknhnTUsStiUn2dVd+PXdX
	DcuuGZAYC2pWFw9+w5PhDC/sTXvze5Os=
X-Gm-Gg: AYBFou2cuD2dAHJvCXBaBuFlvlYh3+g4nrT6KSZm9XdMxVD/37rcBwI3CCBfP0zlwFS
	cVLDQkFfAIZom1KuiE+PFa0MGOVC1OF1YkaUyvCtetcpwAxzbUwiM159d3XU6tyKmmEdt0D8LCM
	z4d30SoPH49ZlkzgbiN5FJr1PcpuXqeD1bRSnrB1+YqgeJaFIPaNlXq12YR/b3wzUVWA6PNRTTG
	pWHACN3BeEyJT4WJac4o8jHtfLJasy9xvDK0EgCWOwOQlcHMftBl9e/WtL0WW44E+3rzcsBy1zz
	TsNrWwazNq98nfUTo9oV7c3AoxxTOlaAl2BRN1bNliUXpIoqsP/7dojB7S9fyzfN2bZ+ayeE+uR
	k26JazzNRvuLWVfDrINBHVwDiWIvVoxMz2EIz3a0qFw==
X-Received: by 2002:a05:6402:27ce:b0:6a6:7882:89f2 with SMTP id
 4fb4d7f45d1cf-6a7e8f9623cmr5389972a12.17.1788684852982; Sun, 06 Sep 2026
 01:54:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260905-arch-kconfig-options-v2-v2-0-83e8245761a2@gmail.com> <20260905-arch-kconfig-options-v2-v2-1-83e8245761a2@gmail.com>
In-Reply-To: <20260905-arch-kconfig-options-v2-v2-1-83e8245761a2@gmail.com>
From: Magnus Lindholm <linmag7@gmail.com>
Date: Sun, 6 Sep 2026 10:53:59 +0200
X-Gm-Features: AcwNN1UUMEovJX_eDQLTzWZBni3pDHzUeZjtKQmab2rob-n71CYiUsiteVtNV_I
Message-ID: <CA+=Fv5SZRccPT=1A39uqucCcCahkMCeecX_FnnCt-q39o=vx5g@mail.gmail.com>
Subject: Re: [PATCH v2 01/22] alpha: enter hardirq context before looking up
 the irq descriptor
To: Matt Turner <mattst88@gmail.com>
Cc: Richard Henderson <richard.henderson@linaro.org>, Kees Cook <kees@kernel.org>, 
	Marco Elver <elver@google.com>, Andrey Konovalov <andreyknvl@gmail.com>, 
	Andrey Ryabinin <ryabinin.a.a@gmail.com>, Jonathan Corbet <corbet@lwn.net>, 
	Shuah Khan <skhan@linuxfoundation.org>, Randy Dunlap <rdunlap@infradead.org>, 
	linux-alpha@vger.kernel.org, linux-kernel@vger.kernel.org, 
	kasan-dev@googlegroups.com, linux-hardening@vger.kernel.org, 
	linux-doc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Matt,

On Sat, Sep 5, 2026 at 9:29=E2=80=AFPM Matt Turner <mattst88@gmail.com> wro=
te:
>
> handle_irq() called irq_to_desc() before irq_enter(), so that lookup ran
> with the preempt count still saying task context and with RCU not yet
> watching.  Generic code called from an interrupt handler should see
> hardirq context, and irq_to_desc() is more than an array index once
> SPARSE_IRQ is in use.
>
> Move irq_enter() to the top of the function and add the matching
> irq_exit() to the invalid interrupt path.
>
> Assisted-by: Claude:claude-opus-5
> Signed-off-by: Matt Turner <mattst88@gmail.com>
> ---
>  arch/alpha/kernel/irq.c | 9 ++++++---
>  1 file changed, 6 insertions(+), 3 deletions(-)
>
> diff --git a/arch/alpha/kernel/irq.c b/arch/alpha/kernel/irq.c
> index 4a6a8b1d5a8b..5867a1655045 100644
> --- a/arch/alpha/kernel/irq.c
> +++ b/arch/alpha/kernel/irq.c
> @@ -107,18 +107,21 @@ handle_irq(int irq)
>          * handled by some other CPU. (or is disabled)
>          */
>         static unsigned int illegal_count=3D0;
> -       struct irq_desc *desc =3D irq_to_desc(irq);
> -
> +       struct irq_desc *desc;
> +
> +       irq_enter();
> +
> +       desc =3D irq_to_desc(irq);
>         if (!desc || ((unsigned) irq > ACTUAL_NR_IRQS &&
>             illegal_count < MAX_ILLEGAL_IRQS)) {
>                 irq_err_count++;
>                 illegal_count++;
>                 printk(KERN_CRIT "device_interrupt: invalid interrupt %d\=
n",
>                        irq);
> +               irq_exit();
>                 return;
>         }
>
> -       irq_enter();
>         generic_handle_irq_desc(desc);
>         irq_exit();
>  }
>

Since this patch is unchanged in v2, and we agreed to handle the
hardirq-context consolidation as a follow-up, my tags from reviewing
and testing the current change are:

Tested-by: Magnus Lindholm <linmag7@gmail.com>
Reviewed-by: Magnus Lindholm <linmag7@gmail.com>

Regards,
Magnus
