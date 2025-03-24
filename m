Received: from mail-ua1-f54.google.com (mail-ua1-f54.google.com [209.85.222.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F512BA36;
	Mon, 24 Mar 2025 09:03:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742807016; cv=none; b=pvxBmBz/fFBv8WdW6dnYXoIQuLrfHS2YbT94tmEHH7GDcZAcDcxv4JTwApQZdoGmXOGE7X8GNOfu0OQCHPhzhp+m+1NCFVh1Y8eIhRhTTSVMOwKpdcnXB+f+BsasmbsCz5JNzzxNna0Nv3urMuaiUb71DzMbBJH3jZVGZAAQLOk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742807016; c=relaxed/simple;
	bh=KqRUMD2XdQQ9CG7Nb2vZ5/GtFfomSxM64REk2V7g3po=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TLImVVDrdBoBeM1sAkVnw6iTaQUvqufqbmW8ZEqqWLQb5a6agfjiWATPJdxFJca0mtbywCJIQrqgtLA5MyVimzyHI97BizLkY+YujeqztUBgFJN8kcTITnJMOPXH0/7OqEmXZOL4tV/MJZ8jv4SBWUyRJwH8C3fHYLi/xKrVjnY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.222.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f54.google.com with SMTP id a1e0cc1a2514c-86ba07fe7a4so3615134241.2;
        Mon, 24 Mar 2025 02:03:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742807014; x=1743411814;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=12C9f7Hkrurs0MZwp3rUXbOHTi8BuaCTTSuYZ39XhRs=;
        b=Yl5I6vfScXTeIM1ASKwR+MuWpWlvDalT9iree8XN+ifk7V4wTqEL7nELotbfSeMpa/
         N6vITO3pgNyis8wB+0PaMY0QlRI/gFvhdQByPv8420tRcRLtIUrXgPBgyufJexAd/LPs
         Y6dWnSj+iePvtMsar12C/hyWCiah8ZrjWMenXEweX6qgb96dxUjpZ0/X/yVvt0o7dT+R
         EEeqOynl6uvi84cYw5qdA3aYsewwntDeYxWJHE87BAytufPH9avjMphNhWj0t8hegPcF
         FTDKtqRGz3N/SK1N2nZc2YNiGN+e3BlV/s/0oLJOjStPU6+KPqosbAZg1Hk8W49NRp+l
         Zu5A==
X-Forwarded-Encrypted: i=1; AJvYcCVWx3lkPWXJMJ2svFz+HZJqWi8cB/96dHw47CpCOcqblUts3bIm8wr7el/qsXmaYBqt9YKAFEKi33VAhtc6468=@vger.kernel.org, AJvYcCWKi69VaNGM6E+Go0QesUfVMle1gvUSZOp+ggEQfQzSybJu0ZGYvR7QDo8s1IOaRnhKCdJ1PgxDGdvY2GqB@vger.kernel.org
X-Gm-Message-State: AOJu0YwIg0x2KuaFFU29mDLnWERZbMbwjZodVJmFnv5E9GSxqDLF/rp+
	RhwTImD/yPpP0mpG0a7gcVVR9OP7J9JJ8jb/pJJBnjsbWBBdpiHCv77apnu2
X-Gm-Gg: ASbGncsc9WDWLBUsjHLPeaMrzeYcsHyTQst9KURYCV0jRFYGwxPFwYLysz00vBBIumB
	IvwxSLhFNXeKEG4pv+8B3hIbu1ks/az8Lm1zkNn/m8BBRq4VUgldFqQ1Coo8d+2BOANWB7wsuR/
	j/w1A5Q0WeUC+mmQwaLSLxy0miYK0VzOEnpg1ktYGif5qDVIBvRb56dFjb0Ocv3IEGgmCgpfk2S
	T2Mv20LdMk2fFUJApS4C8J278r3FuQDL7EiB54q9Qs9D3PewQaJoJHbSuFfRVh//hh9iCAg7nFm
	NyJhUzi6etX4C/iUMYMu8fB2SxutLjcaq9p8x3yIXmQte4mcbhnHbKCmSVgZ/qLDj9h+8WcQCTY
	QSistS9sMA7o=
X-Google-Smtp-Source: AGHT+IEu/ZrdRQHW5S3aziTM3AcCWGNi0CFd17W1ltj4xgGQjydX+UbH5MIQddYnuJIsxXhhcocH5g==
X-Received: by 2002:a05:6102:fa1:b0:4c1:9288:906c with SMTP id ada2fe7eead31-4c50d4b49cemr9449136137.9.1742807013477;
        Mon, 24 Mar 2025 02:03:33 -0700 (PDT)
Received: from mail-vk1-f174.google.com (mail-vk1-f174.google.com. [209.85.221.174])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-86f9f385523sm1538132241.7.2025.03.24.02.03.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 Mar 2025 02:03:32 -0700 (PDT)
Received: by mail-vk1-f174.google.com with SMTP id 71dfb90a1353d-52410fb2afeso3668455e0c.3;
        Mon, 24 Mar 2025 02:03:32 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXGGj9x098i7WlDik4uaUfpaKEbTyUlFar5iX3a7/pXPhOii4sR41F9HJBhWBiznpGstJBuUBFZzLMhnO4I@vger.kernel.org, AJvYcCXucWxasXT3vcReadEnrloXZY2Tz7ttvpezILP0n+MAMkZyAOs9byHEJ0z7R1nhCqNesJ2xdrEb/+Es7WmYImM=@vger.kernel.org
X-Received: by 2002:a05:6102:dca:b0:4c4:e451:6f24 with SMTP id
 ada2fe7eead31-4c50d623b0amr9079671137.22.1742807012667; Mon, 24 Mar 2025
 02:03:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250321032627.4147562-1-jeffxu@google.com> <20250321032627.4147562-2-jeffxu@google.com>
In-Reply-To: <20250321032627.4147562-2-jeffxu@google.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 24 Mar 2025 10:03:21 +0100
X-Gmail-Original-Message-ID: <CAMuHMdWDrByGrgcTK9dRKRJyQ3ecQwadJjCcW=Nd0SjUeEukpg@mail.gmail.com>
X-Gm-Features: AQ5f1JptHW9VS-Yelex_Y6M47FPBnm2RiYqpGcgh9ZUdERvWy3D01ssL2b_YVHU
Message-ID: <CAMuHMdWDrByGrgcTK9dRKRJyQ3ecQwadJjCcW=Nd0SjUeEukpg@mail.gmail.com>
Subject: Re: [PATCH v2 1/1] mseal sysmap: add arch-support txt
To: jeffxu@chromium.org
Cc: Liam.Howlett@oracle.com, agordeev@linux.ibm.com, akpm@linux-foundation.org, 
	borntraeger@linux.ibm.com, edumazet@google.com, gor@linux.ibm.com, 
	guoweikang.kernel@gmail.com, hca@linux.ibm.com, kees@kernel.org, 
	kevin.brodsky@arm.com, linux-hardening@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, lorenzo.stoakes@oracle.com, 
	m-malladi@ti.com, svens@linux.ibm.com, thomas.weissschuh@linutronix.de, 
	zhengqi.arch@bytedance.com
Content-Type: text/plain; charset="UTF-8"

Hi Jeff,

On Fri, 21 Mar 2025 at 04:26, <jeffxu@chromium.org> wrote:
> From: Jeff Xu <jeffxu@chromium.org>
>
> Add Documentation/features/core/mseal_sys_mappings/arch-support.txt
>
> Signed-off-by: Jeff Xu <jeffxu@chromium.org>

Thanks for your patch!

> --- /dev/null
> +++ b/Documentation/features/core/mseal_sys_mappings/arch-support.txt
> @@ -0,0 +1,30 @@
> +#
> +# Feature name:          mseal-system-mappings
> +#         Kconfig:       ARCH_SUPPORTS_MSEAL_SYSTEM_MAPPINGS
> +#         description:   arch supports mseal system mappings
> +#
> +    -----------------------
> +    |         arch |status|
> +    -----------------------
> +    |       alpha: | TODO |
> +    |         arc: | TODO |

N/A (32-bit only)

> +    |         arm: |  N/A |
> +    |       arm64: |  ok  |
> +    |        csky: | TODO |

N/A (32-bit only)

> +    |     hexagon: |  N/A |
> +    |   loongarch: | TODO |
> +    |        m68k: | TODO |

N/A (32-bit only)

> +    |  microblaze: |  N/A |
> +    |        mips: | TODO |
> +    |       nios2: | TODO |

N/A (32-bit only)

> +    |    openrisc: |  N/A |
> +    |      parisc: | TODO |
> +    |     powerpc: | TODO |
> +    |       riscv: | TODO |
> +    |        s390: |  ok  |
> +    |          sh: |  N/A |
> +    |       sparc: | TODO |
> +    |          um: | TODO |
> +    |         x86: |  ok  |
> +    |      xtensa: | TODO |

N/A (32-bit only)

> +    -----------------------
> --
> 2.49.0.395.g12beb8f557-goog

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
