Received: from mail-vs2-f38.google.com (mail-vs2-f38.google.com [74.125.227.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 773C0383C6E
	for <linux-hardening@vger.kernel.org>; Mon, 28 Sep 2026 07:22:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.227.38
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790580166; cv=pass; b=jFG4bhWI9ng7eSLfX/5WdrVgGMyvsy7xJGyJ9V/JFCzFRch8tw7QzJ9H3U/juMfBfg6w7WR4mYjG3cDq8CBBSLIO2qIHYMUORyHlaFwbXj8bGr/9bw0vNX7jyhQrFt3fORlPHGq7tJMEHh6/ttysSd6Zn9RcjayaP4/hBFuPfv4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790580166; c=relaxed/simple;
	bh=APrQLHWyNaMSnUAIds3Epz7+tbhmT/nxmeVzEs8HE4E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=m5oTSRe+VBoCuKqVpHUP3KGaOY2NAXWHZ2vs94e5Dy/xXiZe71IiCkDBq30ms0MjbkP4d9qjM8ePRQAAY5Ixf+Q+E11H5GYTYoZDWCPaDaiXQ+OSmSOIZKz+AsrLAtmVxnBvXC04HsDHlQfrO9CfE/xTU9lAKU2n3U6ttoetngQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=aowtTon9; arc=pass smtp.client-ip=74.125.227.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="aowtTon9"
Received: by mail-vs2-f38.google.com with SMTP id ada2fe7eead31-7b30092f554so361909137.3
        for <linux-hardening@vger.kernel.org>; Mon, 28 Sep 2026 00:22:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790580154; cv=none;
        d=google.com; s=arc-20260327;
        b=ao9ThpcCJ2f14aF4BKaO+ym2J7WznJxLUJxWHsQtX0iVdbmSth/2t+WFxuD9mizbQS
         7t+WhRqr1TTmfESgflUJwOtx3cTPOU6cKL5jkSTpGgkZik64KxPnOhWe/JLM4YwT+Mny
         sTJY5F9YM1v54EokeSAkUUt0FHFnUj/8eMMZe7zv1ig39ywkB7qupBJepNdmyTjm1DV9
         +jjRcu8Hi+8p2ssb352GFNAu5+ZzAvDROJ5pxMZD8el8lkUZcMzn8CE8PH4hhdaE3z/f
         YAQpiIFGhMuYoKGgZckCd3wNfJgPduMErVt67/RqD+3GkysnTdHXxpakB1hjNzSuD6H1
         m7hQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=7S7hcaIQrNT100EqV+kMOddYduCRqLzOTn6PrUxYv68=;
        fh=gqyn/CqYfwtnVYdF3wKxoDGxsRLdMaWUFgL7aq6ajRE=;
        b=aGtZXXDRDb0D9ueefiZIpyWouAuIXuz87ObRdjexk6jVfTJ/Af2vRbi+sJ5UGhbUxH
         7ColPoSGvFg1Q+dcmGCcMyAP9WumAqnOUb+Ig3bftgGEdbFgRum0kNPcoSSIkCZzi0L4
         BqETd1ypjajd38IBe7mRAxDogcEHdM1QMqfV7ptL18arKCgWM57FVI7CbB4Qz+OZfQ6R
         fMxVVy3kew1sHcaWpmdGj3p79UUX5JBY2Uol9yeweMa5zS4Obn/tsxgNxGGocb/49+Gm
         eLu4AqrxxSyMi81db5AVIVgE8U+1qWU98zLujK4LO9uvd/Md5NM1PK/MTZla9Icucbbo
         YJ+w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790580154; x=1791184954; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=7S7hcaIQrNT100EqV+kMOddYduCRqLzOTn6PrUxYv68=;
        b=aowtTon9eurVABMkco2PDehcr/Udzr/nr4OhZ9Sv/tqOxSXHrkp/TGRYtOzBXeef2x
         L+p1lw7+1d8T3kosxzJ/covXUFOf/UtBEXDEqGR/aCkFEWhB+lv7mrW6pa2ZseW41W1r
         tsHx9oHjkZhhTdBc0VMhShTEq2qSwDj5Lcj4i8c00QTjzK0wgVOTTohMHYPqrU8FzyXJ
         aZmEy6/G8SUrF6vDt4uNBDVOk5SRorvptVTwyQBzENqsPXBa4HSVAGO7zbQ6bcjnVH2Q
         nA5nf5cZBX79bXvFgnPRzND/i8KGd2jDp7czqNhfeQEjy6W+KKdZXUtuivc2y0e6xp3D
         /hsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790580154; x=1791184954;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=7S7hcaIQrNT100EqV+kMOddYduCRqLzOTn6PrUxYv68=;
        b=Rf5W5gDrapyNZPlChPBL/5zEDANRft8F3XLS1fyKu9WZYJyG4QHSDguI01PB3jY2Eq
         5pXivzFMFO4u+VEXkyKcxcTYofp1SOrPBChH3J5tvHA1RixOHGqV9yICsLdgCOXIbVrj
         KVBPFmZWCmYmlUuL/xKhMoNqTLJgNfr2a5yy3pQGGb+lVoOZ8YOyWLKWFJhapxD0FYKg
         2DpVPPE/4kaWltFR2iJZHgNNyGBawqOKOq9srRy5fzfMrYx/Tl7OI8Oo0EE5pmiSka9d
         TurnenvCdsMkIhnLTh3W2Y/+rTPRILWlK75ynfJkZ+I6BtFkaXHN8Xa8q85Ua7Pyi3AM
         4L5g==
X-Forwarded-Encrypted: i=1; AKwUvBwFRV1pZQ9f+RU0DJPCrak+sKHtkoWNICq0SiqD3VcZXdyzUGmmIgD/GCAD+9YCyhBJaRc09PfawFXTfoxehnA=@vger.kernel.org
X-Gm-Message-State: AFq9FYIbmbrF8Y8/Ufp/F2oTHnUE+DpxXby4OXRrORCI0sDHSAqVlWgV
	xEt2HTNnFLS5zx4dlPETQzktbVfk1cPGLKgD4aMHdNsjUAHsvXRYOtwsPkVqKY1kU8qMLm2Hjrv
	HDHIimy62sJUJ2jko5kkEMcp4UosANyvXKiyMORI=
X-Gm-Gg: AYBFou0IP6UPt2NDwuEJSs6FiqzgAx7ytlRNN9EggZQ1qybda0dL5gwI3OASmIFqyRe
	7HSJqch4nP2rCpjUsxy6nGzkRO8O+8ZolJaMx8aKVmgnCnuuiBukvJxxXX4EoQlRcyavaoQ8NPh
	hp7SOxyeodrhrygGcAKPSJVDUMLBv5Y5SlfbZUnQ41ECYfVLLPH+MZ3qFI68JGau/77hROR0ApZ
	GqhCyThNo+5ZiL3GeW24ZndB3gjzF9hI+ZGCEsqiuU4WKWLsvhVAhxazgidX57dbwTRoypjImTY
	iy7JcpjOfe7CW/HU2frC23qGwIOi//tTWPz9IEs3aVDY11KIuMJM4USe5Dzw4o029rQc9f9tisL
	i+YEQKishGNRtwmvBtOIiNSrYnktcBOY=
X-Received: by 2002:a05:6102:3912:b0:7a5:9a:3a31 with SMTP id
 ada2fe7eead31-7af1e0ef5f1mr4324150137.34.1790580153025; Mon, 28 Sep 2026
 00:22:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260928063824.1386524-1-morbo@google.com>
In-Reply-To: <20260928063824.1386524-1-morbo@google.com>
From: Bill Wendling <morbo@google.com>
Date: Mon, 28 Sep 2026 00:22:17 -0700
X-Gm-Features: AclHuK-aDUfgxYTMcH2KBUEabNgFX4lq35X-cZ81U2Qsle4b2SorScwmDO1r1OY
Message-ID: <CAGG=3QWCmQ+LVvn2dtjEauj5WFwvx=pvg4Q6man_A2imdjRe7A@mail.gmail.com>
Subject: Re: [PATCH] gpiolib: annotate struct acpi_gpio_mapping with __counted_by_ptr
To: Linus Walleij <linusw@kernel.org>, Bartosz Golaszewski <brgl@kernel.org>
Cc: Kees Cook <kees@kernel.org>, "Gustavo A. R. Silva" <gustavoars@kernel.org>, linux-gpio@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org, 
	codemender-patching+linux@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Sep 27, 2026 at 11:38=E2=80=AFPM Bill Wendling <morbo@google.com> w=
rote:
>
> The 'data' pointer field in 'struct acpi_gpio_mapping' is associated
> with the 'size' field, which represents the number of elements of
> type 'struct acpi_gpio_params' allocated for 'data'.
>
> To improve bounds checking via CONFIG_UBSAN_BOUNDS and
> CONFIG_FORTIFY_SOURCE, annotate 'data' with the __counted_by_ptr
> attribute.
>
> Analysis of allocation, assignment, and access points shows that the
> pointer is never accessed before the count is set, which guarantees that
> this annotation is safe and will not cause runtime panics or
> false-positive bounds checks.
>
> Cc: codemender-patching+linux@google.com
> Assisted-by: LLM
> Signed-off-by: Bill Wendling <morbo@google.com>
> ---
>  include/linux/gpio/consumer.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/include/linux/gpio/consumer.h b/include/linux/gpio/consumer.=
h
> index fceeefd5f893..2b80cf7aa7e7 100644
> --- a/include/linux/gpio/consumer.h
> +++ b/include/linux/gpio/consumer.h
> @@ -667,7 +667,7 @@ struct acpi_gpio_params {
>
>  struct acpi_gpio_mapping {
>         const char *name;
> -       const struct acpi_gpio_params *data;
> +       const struct acpi_gpio_params *data __counted_by_ptr(size);
>         unsigned int size;
>
>  /* Ignore IoRestriction field */

There's a problem with 'drivers/firmware/efi/libstub/Makefile'. Clang
needs a compiler flag to support the "__counted_by_ptr" attribute
referencing a field *after* the pointer, like in this patch. However,
the Makefile blasts the flag away for x86 platforms. Below is a hack
that copies the part of the top-level Makefile that adds the flag. I
don't think that's a good solution. The comment in the driver's
Makefile says that the stub code executes before the kernel does,
which I assume is why a lot of the flags are blown away... In any
event, I'm not sure how best to address this.

-bw

diff --git a/drivers/firmware/efi/libstub/Makefile
b/drivers/firmware/efi/libstub/Makefile
index 77a2b2d74f3f..945674048d8f 100644
--- a/drivers/firmware/efi/libstub/Makefile
+++ b/drivers/firmware/efi/libstub/Makefile
@@ -19,6 +19,14 @@ cflags-$(CONFIG_X86)         +=3D -m$(BITS)
-D__KERNEL__ $(CC_FLAGS_DIALECT) \
                                   -fno-asynchronous-unwind-tables \
                                   $(CLANG_FLAGS)

+ifeq ($(CONFIG_X86_32)$(CONFIG_X86_64),y)
+ifdef CONFIG_CC_IS_CLANG
+ifdef CONFIG_CC_HAS_COUNTED_BY_PTR
+cflags-y                       +=3D -fexperimental-late-parse-attributes
+endif
+endif
+endif
+
 # arm64 uses the full KBUILD_CFLAGS so it's necessary to explicitly
 # disable the stackleak plugin
 cflags-$(CONFIG_ARM64)         +=3D -fpie $(DISABLE_KSTACK_ERASE) \
