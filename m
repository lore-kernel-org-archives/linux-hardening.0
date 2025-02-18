Received: from mail-vk1-f170.google.com (mail-vk1-f170.google.com [209.85.221.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42E46269B09;
	Tue, 18 Feb 2025 14:13:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739888028; cv=none; b=JqgbydyUTWymgehwa8kTzeK3Iz1fr82XE3dIU6WZ7oULOCLDeoQlBm00r/kl2o9/bonLgSnl26UWW1utD2cI5lQhoEqPVgFpiTGzQxfzxvNM/4GWGAfGvoseprqgo1InBgEVXvjal9BmH1O47rRPednAastWwRWO8e2M7sryKM0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739888028; c=relaxed/simple;
	bh=GU95lFGcor/jEjChW240ELXZRh0JYb7LZci6IUdhpok=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Bxrd4td97NxBKuG7q+fJES5XbVCdbttoHvtPTNNcAj1x1mYVJ6iBCh9AwzCniT1gkKPQI/gysD3+Tw/q3ncmuMeHDJYeIovEzaSfQ8cEpJpg/jhNejIAzaqe6NurlWM+CvMGH/qhVM/knk1FRqKpu54Iw7b99ALl1vi8syyqMT8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.221.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f170.google.com with SMTP id 71dfb90a1353d-51eb1818d4fso3781502e0c.1;
        Tue, 18 Feb 2025 06:13:46 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739888025; x=1740492825;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=welPK9uUk6TPPZEsep1eDldHA81BmMQSGld/AT5ISsE=;
        b=TJYAdzQUTjnOMj+n//GPapoeVIAKfAGIQLS5QEhAwiqmkO+CUn28S+WkwnAKJO+4PA
         JXHc51nHyyUJtFJErlaZyL20btqcxlaIZoD7zaSiRUqRj6FmDO/BdzGZ4n4oMZgUznsO
         sdjQKhuc6ntTXKSEtkil0cAYQ0hYIJfSh3qQ410RxHK2Y01vAXwY/wn5aNKO2LazylHA
         c9Xs4qjfTWwEetpImtC4CeD7n+qtHHzH3jcSrA53CQSeWLgKZr6lrTDHiF/x6UjbuUcL
         tUW4Qcf1NjP8gNLQbo3Pyptr4ljiW3u/4C6VZJN7rjhRCGLPhVt1BcHvcCI66YpcVurP
         iMPg==
X-Forwarded-Encrypted: i=1; AJvYcCUB2x0Q7jy6T16OcCMpOR61N9ZCcJUcA6KcBaflkgQL8ffU6VdSrfFRK4wN06/8qkBx/lcFY8QnI/K9MeUi@vger.kernel.org, AJvYcCX/DGrNx0nBDa6Tv0nucXOH2Nm5c6thW0Ut1vF/ntgEA1xyhcIqZXIZR8QpG8AJMkbxsqGFTNXzcAv7oslajtk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxTb1SKWmisLlK7pwPPaP3pJrEVaF1DRcemQp7xqSRLhn/ShHyH
	OdQ9BYEmJPh6ahWrJreNgNwzM6NHjfaLc6e8lRW0L1NYMyMFuPE2mX26T/B0
X-Gm-Gg: ASbGnctfztWDHzq+WmheXf3CFkyLl8nADYWmphtKDGprMar91+Hjd4Z2rHG7qaqujSA
	FeZmZZYx5siTZ8bI2MSlJ7LA7UYiWouaeOu5FJUylKyclt2iPCSBaVu+YIJq5bMGUKvKh/JPoA8
	gI2P9bht6ueZbw8Rqi4quUKs6z4KQrGx5lN0CyKesZqRkOIkURf6IutXFlR3VBFNVaoYh90rar7
	OBFT0xf/b2In8nC0BvkONlA+kHY+B/PYO4nPNxDRiSUk3lZYFNaHWmG/4eKva6N+iHDNWCdtBX2
	yoBZMLZJ0zL3BZT2BWR7uqCZiIqUQn5V2D5osgA0nvOVxE2FBVT1tg==
X-Google-Smtp-Source: AGHT+IHa1EIabhP+wFOAyj3bDL1VRYOxzePy/s8c0HPcrTqblPOD//2TKEZReYeucbWPBF0ltcZPyA==
X-Received: by 2002:a05:6122:2525:b0:520:4996:7cf2 with SMTP id 71dfb90a1353d-5209dd874bamr6723223e0c.10.1739888025230;
        Tue, 18 Feb 2025 06:13:45 -0800 (PST)
Received: from mail-vs1-f53.google.com (mail-vs1-f53.google.com. [209.85.217.53])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-4be0475e486sm1577447137.21.2025.02.18.06.13.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Feb 2025 06:13:44 -0800 (PST)
Received: by mail-vs1-f53.google.com with SMTP id ada2fe7eead31-4bd3c887545so2551622137.1;
        Tue, 18 Feb 2025 06:13:44 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVZAKlTNpM92H8J3Rk9GO7MP0g7NgO8Hitrqw3u2vSEgwSc6X0EjP7iX5JjnQbPR7Za3UsYB4+7gz84Mt+2@vger.kernel.org, AJvYcCWgPUQilmExMP6KU4qogNwXyWrlicvdf3TLpPVDqvWG6+4CRbMOe02qT9+k110m2rEeJ/8Rb4pvEQ+mUuftoAg=@vger.kernel.org
X-Received: by 2002:a05:6102:5e91:b0:4bb:d062:422 with SMTP id
 ada2fe7eead31-4bd3fc8be75mr8565480137.3.1739888024406; Tue, 18 Feb 2025
 06:13:44 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250213141037.50394-2-thorsten.blum@linux.dev>
In-Reply-To: <20250213141037.50394-2-thorsten.blum@linux.dev>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Tue, 18 Feb 2025 15:13:31 +0100
X-Gmail-Original-Message-ID: <CAMuHMdWFaudnOhwXpYJSwt3R909D8GLV+bLK7UhnH1Z3NB3ZsQ@mail.gmail.com>
X-Gm-Features: AWEUYZkKbv0Ikcr7vDWTODLeRcLURgXx3Q90nK_z6xouR-EVJTD8ZQrSq2ruLFU
Message-ID: <CAMuHMdWFaudnOhwXpYJSwt3R909D8GLV+bLK7UhnH1Z3NB3ZsQ@mail.gmail.com>
Subject: Re: [PATCH] m68k: mm: Replace deprecated strncpy() with strscpy()
To: Thorsten Blum <thorsten.blum@linux.dev>
Cc: Jean-Michel Hautbois <jeanmichel.hautbois@yoseli.org>, linux-hardening@vger.kernel.org, 
	linux-m68k@lists.linux-m68k.org, linux-kernel@vger.kernel.org, 
	Greg Ungerer <gerg@linux-m68k.org>
Content-Type: text/plain; charset="UTF-8"

On Thu, 13 Feb 2025 at 15:11, Thorsten Blum <thorsten.blum@linux.dev> wrote:
> strncpy() is deprecated for NUL-terminated destination buffers. Use
> strscpy() instead and remove the manual NUL-termination.
>
> Compile-tested only.
>
> Link: https://github.com/KSPP/linux/issues/90
> Cc: linux-hardening@vger.kernel.org
> Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>

Reviewed-by: Geert Uytterhoeven <geert@linux-m68k.org>

> --- a/arch/m68k/kernel/setup_mm.c
> +++ b/arch/m68k/kernel/setup_mm.c
> @@ -243,8 +243,7 @@ void __init setup_arch(char **cmdline_p)
>         setup_initial_init_mm((void *)PAGE_OFFSET, _etext, _edata, _end);
>
>  #if defined(CONFIG_BOOTPARAM)
> -       strncpy(m68k_command_line, CONFIG_BOOTPARAM_STRING, CL_SIZE);
> -       m68k_command_line[CL_SIZE - 1] = 0;
> +       strscpy(m68k_command_line, CONFIG_BOOTPARAM_STRING, CL_SIZE);
>  #endif /* CONFIG_BOOTPARAM */
>         process_uboot_commandline(&m68k_command_line[0], CL_SIZE);
>         *cmdline_p = m68k_command_line;

This seems to be used mostly by Coldfire, so I'll let Greg handle it.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
