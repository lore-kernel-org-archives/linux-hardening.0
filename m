Received: from mail-oo1-f54.google.com (mail-oo1-f54.google.com [209.85.161.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FB2D38945D
	for <linux-hardening@vger.kernel.org>; Mon,  1 Jun 2026 08:28:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.161.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780302539; cv=pass; b=n/qnnVAhHoUxLpeh4aTMXHU9wT4v4Yova7ijF8RXQLo3QOmQxQHa5/jAm43CevPkQotoy9N8BMf9P3xO/56JoFY0qPk70Cz8cWBlm4xO811QUl/qaMExRn4yxeHzv3rs7uWEqGHfkmbHOIwdi5LfAIdLrWMv32NZY3MPPigOtnc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780302539; c=relaxed/simple;
	bh=E0ZjGiqEou/mVVQhcRU5NDJl4927/rLFUpJnSc5CMI8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=u6wNljib96zGZ0ZfP7TVz9GbYvTnjTRNEKehV3C/90uoUdpZXoIfGrxurbU5JdF3uLgoOHkDJyBzqWLtjpCenLnDsba3Mcay8BoIBVaqtQ4udrqye5RJ4gci0HxUZ1uf1v0K9jVK1YK/zxAT5wu2sb0b2OIPtQfG1SKt6Gto5Ak=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brainfault.org; spf=none smtp.mailfrom=brainfault.org; dkim=pass (2048-bit key) header.d=brainfault-org.20251104.gappssmtp.com header.i=@brainfault-org.20251104.gappssmtp.com header.b=IaxhaWRn; arc=pass smtp.client-ip=209.85.161.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brainfault.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=brainfault.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=brainfault-org.20251104.gappssmtp.com header.i=@brainfault-org.20251104.gappssmtp.com header.b="IaxhaWRn"
Received: by mail-oo1-f54.google.com with SMTP id 006d021491bc7-69dead44101so2893374eaf.3
        for <linux-hardening@vger.kernel.org>; Mon, 01 Jun 2026 01:28:51 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780302531; cv=none;
        d=google.com; s=arc-20240605;
        b=gvezenULRvt5lT1GcS0IF+R9WiIOgiwyDUG4p/HgaJSi6asSLmXyX2WpLj7UKV4n1V
         Jofui0cbqP/S0dQgNXWG2UeZdWb3unZqdnCC/JHlqmrFFSJQk+v/6mpvHey7nBbA6ye1
         DT1cOzyyU09P+1RX7X8dTmQuxxs7mAfajhtWKNyUdwY7miae8yE6l+91kYDWH6GFuxqW
         IqWFtknzjPI9PStvjFwO3Rf0MR8Qb/HhqSr3y3uduloIjuMmB3qWV4VMqi1mQugHslqv
         8eOQ1Upk8OibzEW4BBi1e7g3TIzAHvzfDLYFaK7xqm3yHk6O+DawQXv+276KvyNVh6sR
         T99A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=2ESq39BgNzEi4Yu/c7RvuT+HDwB/a0FKWuDwlbw5nEw=;
        fh=FxldMz3P31eKZAiv88/PTN/Dked4gZ4gEzdwJpnw8TI=;
        b=ShE4zLjL8nH5Xywbdj5aW2/6/eANbyG9tCwLruzn/fHTmFw1FMSHxJWl14eDKmKqtx
         0o2Ph0aRAN5wWe+TNwloXunRXTZbuv7s9CspBqpd1Xgp/mKNydzVCWaBLLYgMRlbmpVL
         JkroGAlpmiUeN51vdq8zcvVC2Hp0orUxe4YGBBc8+g0gAodU1S4RZSOiuld/h4jY2+8J
         tExP4qFcX8PmRHB+RJjO8OyhiTCHFWQWTG6CuKDSacJrBzTPfrnm44iSWs4aXd79a85I
         05TBNdv1CYabeyhdLbGlgsiaJROlM8brHWDpTLrRfEtGEpqinYkeGdOExIj4UkZUd1kS
         ul1g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20251104.gappssmtp.com; s=20251104; t=1780302531; x=1780907331; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2ESq39BgNzEi4Yu/c7RvuT+HDwB/a0FKWuDwlbw5nEw=;
        b=IaxhaWRnVjuCasJ0/RGFB2WTozmapeE+8mUurFWRYMQYPn5vkQIUA5wk8GtMw62LIW
         G1ug/daRnR2+H2Rt7ozO9jAMDDtkrQd7XhNHP6nujdL8fVFClFJuGudg9ormh9mQZTO6
         c4sC7I+V1kd9Sgl7BN1lkmLFjCnYWI6ds9aATDGyDBfguEpIU08et1j6f8uX2h0WGzcG
         wfg5ujcRslVtPLu8o19NRV3r5/fwMuuRESQWTEGV8w0FzVzgf1VZsdBrb0nF1B0HotJ6
         IV703nAtZQpVYaOC4xPiGyDl1POR6Gc+6RFiwNPAguJESFV3NzNKLItIE+P8iivD/gO+
         TWRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780302531; x=1780907331;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=2ESq39BgNzEi4Yu/c7RvuT+HDwB/a0FKWuDwlbw5nEw=;
        b=T38oxLmCeugKgbm/GMkObPIEvlblziMP7y0tThRPtA1AQ4PPZNKlKqHBrPX2HN/4B1
         etSchCQGhnvKlvJUJoR5zbbia99erlD6DA7BtDxZqsT4sKCCims7Wa+gBv95/okyjTF+
         nIIYvfM3NPro8JB12usjUt37HRCfmyS+YTght1jI+g9k5FB+qCpcSJTpZ/Yir4MdFxEj
         XZi4fXryy2WZDkVKIQ4qRNB0O3xWF+8WXF6UcQE1NukoN5XQW7KLstppwpYF5v1IgWwA
         2aigJfMkIvnXaWgeWvUNhbgUGZppajrpjfkQUDW4WV5dw7jYodww1H+DLxOCZe+ubai3
         Chtw==
X-Forwarded-Encrypted: i=1; AFNElJ/rnQQ2qzXHIH6jYlE28ruoZ7yFx8UtvL5sB3ZoMxr7GlxD/C/mtpD0XVx/+mOVO+BxTBhe2wDBpOWlukj0Ubs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxq0NFTXF1vHJNFqgqlfu+j7mqnUEVBMY4osOq58GQDJ4HoA9tM
	174i97pzYKWt0NKSma+qg9R9FUCqn+aj1HW8EPu2txnzAOUgsRkj+Qj3fbldnbWTPs6hLy6IYTT
	xFWnxklwzi/yUC6MGpI2rYKjs9e+Ujvbr+XnZjlS88Q==
X-Gm-Gg: Acq92OEXZnyhvln+F2UIDwvOReF+9mXtLU7eXhxgjnN6OwNbSPg992r0I8K2au21G6f
	jIx3JbzTDbK03J6HbdLY5T54q29Z5HCP4AKL9V9LZZLsJfu40GrpGl6zxDvh8GDkxlfCbMWuPrW
	FkUhGJV9hrVIxxSeY23ELRU4d8D/WT1fB80nb1pFqFs5xcrDTIH31c6VKNCUrie69zx9ql1WgQo
	oxQplyH03RM3WN/HY6uzW74AsbGrN0mx31nEx3HiYDz3u5NdCUdkS7R802deb5eX5/eFyRVyRzR
	CN6ZkCuShaVeGLajJ49/+IoRxfP2P3hLhl1XLCDSHGp4y1N3Xf/mUESYjn/1K527Du5hmUpwkfJ
	2zt7ssI9IV0qAWRkaSUZUurDch5fzlpSg85N2Rg==
X-Received: by 2002:a05:6820:6ac2:b0:69d:79ff:d3b4 with SMTP id
 006d021491bc7-69e10403a78mr4828258eaf.7.1780302530944; Mon, 01 Jun 2026
 01:28:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260511032144.361520-1-rosenp@gmail.com>
In-Reply-To: <20260511032144.361520-1-rosenp@gmail.com>
From: Anup Patel <anup@brainfault.org>
Date: Mon, 1 Jun 2026 13:58:38 +0530
X-Gm-Features: AVHnY4IF73bShScS20qflmRSB7AeBeAPcEqSmcKeX3spZ09pNG9KxLbJgNe5j3s
Message-ID: <CAAhSdy34CXr4cky4cpg6eVV3FdwHvnR=pJqK=Y+ZsLLx0jL1_g@mail.gmail.com>
Subject: Re: [PATCH] RISC-V: KVM: Use flexible array for APLIC IRQ state
To: Rosen Penev <rosenp@gmail.com>
Cc: linux-riscv@lists.infradead.org, Atish Patra <atish.patra@linux.dev>, 
	Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Alexandre Ghiti <alex@ghiti.fr>, Kees Cook <kees@kernel.org>, 
	"Gustavo A. R. Silva" <gustavoars@kernel.org>, 
	"open list:KERNEL VIRTUAL MACHINE FOR RISC-V (KVM/riscv)" <kvm@vger.kernel.org>, 
	"open list:KERNEL VIRTUAL MACHINE FOR RISC-V (KVM/riscv)" <kvm-riscv@lists.infradead.org>, open list <linux-kernel@vger.kernel.org>, 
	"open list:KERNEL HARDENING (not covered by other areas):Keyword:b__counted_by(_le|_be)?b" <linux-hardening@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, May 11, 2026 at 8:52=E2=80=AFAM Rosen Penev <rosenp@gmail.com> wrot=
e:
>
> Store the per-source APLIC IRQ state in the APLIC allocation instead
> of allocating it separately.
>
> This ties the IRQ state lifetime directly to the APLIC state, removes a
> separate allocation failure path, and lets __counted_by() describe the
> array bounds.
>
> Assisted-by: Codex:GPT-5.5
> Signed-off-by: Rosen Penev <rosenp@gmail.com>

LGTM.

Reviewed-by: Anup Patel <anup@brainfault.org>

Queued this patch for Linux-7.2

Thanks,
Anup


> ---
>  arch/riscv/kvm/aia_aplic.c | 15 +++------------
>  1 file changed, 3 insertions(+), 12 deletions(-)
>
> diff --git a/arch/riscv/kvm/aia_aplic.c b/arch/riscv/kvm/aia_aplic.c
> index 3464f3351df7..748107c347d9 100644
> --- a/arch/riscv/kvm/aia_aplic.c
> +++ b/arch/riscv/kvm/aia_aplic.c
> @@ -35,7 +35,7 @@ struct aplic {
>
>         u32 nr_irqs;
>         u32 nr_words;
> -       struct aplic_irq *irqs;
> +       struct aplic_irq irqs[] __counted_by(nr_irqs);
>  };
>
>  static u32 aplic_read_sourcecfg(struct aplic *aplic, u32 irq)
> @@ -581,7 +581,7 @@ int kvm_riscv_aia_aplic_init(struct kvm *kvm)
>                 return 0;
>
>         /* Allocate APLIC global state */
> -       aplic =3D kzalloc_obj(*aplic);
> +       aplic =3D kzalloc_flex(*aplic, irqs, kvm->arch.aia.nr_sources + 1=
);
>         if (!aplic)
>                 return -ENOMEM;
>         kvm->arch.aia.aplic_state =3D aplic;
> @@ -589,11 +589,6 @@ int kvm_riscv_aia_aplic_init(struct kvm *kvm)
>         /* Setup APLIC IRQs */
>         aplic->nr_irqs =3D kvm->arch.aia.nr_sources + 1;
>         aplic->nr_words =3D DIV_ROUND_UP(aplic->nr_irqs, 32);
> -       aplic->irqs =3D kzalloc_objs(*aplic->irqs, aplic->nr_irqs);
> -       if (!aplic->irqs) {
> -               ret =3D -ENOMEM;
> -               goto fail_free_aplic;
> -       }
>         for (i =3D 0; i < aplic->nr_irqs; i++)
>                 raw_spin_lock_init(&aplic->irqs[i].lock);
>
> @@ -606,7 +601,7 @@ int kvm_riscv_aia_aplic_init(struct kvm *kvm)
>                                       &aplic->iodev);
>         mutex_unlock(&kvm->slots_lock);
>         if (ret)
> -               goto fail_free_aplic_irqs;
> +               goto fail_free_aplic;
>
>         /* Setup default IRQ routing */
>         ret =3D kvm_riscv_setup_default_irq_routing(kvm, aplic->nr_irqs);
> @@ -619,8 +614,6 @@ int kvm_riscv_aia_aplic_init(struct kvm *kvm)
>         mutex_lock(&kvm->slots_lock);
>         kvm_io_bus_unregister_dev(kvm, KVM_MMIO_BUS, &aplic->iodev);
>         mutex_unlock(&kvm->slots_lock);
> -fail_free_aplic_irqs:
> -       kfree(aplic->irqs);
>  fail_free_aplic:
>         kvm->arch.aia.aplic_state =3D NULL;
>         kfree(aplic);
> @@ -638,8 +631,6 @@ void kvm_riscv_aia_aplic_cleanup(struct kvm *kvm)
>         kvm_io_bus_unregister_dev(kvm, KVM_MMIO_BUS, &aplic->iodev);
>         mutex_unlock(&kvm->slots_lock);
>
> -       kfree(aplic->irqs);
> -
>         kvm->arch.aia.aplic_state =3D NULL;
>         kfree(aplic);
>  }
> --
> 2.54.0
>
