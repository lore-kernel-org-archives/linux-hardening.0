Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3C811388;
	Fri, 19 Jul 2024 01:23:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721352192; cv=none; b=RDkEHHj+GIlzoSEtu6sZ8p3VaLX8wOB9p3EiMHkIg9OumFLQJTxiL+UOS5H1vYVWLko0KdiM6J82igrh2ViKS+19w7Nq+MOZ9qqoz7/MN5cs1fLc/JCquNyG8xUDpRPPWTvy5F+HAwJAUcOIW4LCgIqtXNsfO72S184ZNNvJcDs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721352192; c=relaxed/simple;
	bh=TcVAZ4o5JqH+rw1XtKK3khM+41WGsSy3IOlZhc+8zLY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NvbEi0IQ+cv0M0ZV8N4AedCnq8QVCaOqCVA9wJr8O3b8qDgx79uis8wQ93MjkY4xKhmRNSqEzxO0aqLoi9OxPGRGWLjTT0zHQIlXdiF7g9tBaaohWYR+Y26tfWU8q2BLUWbUhiuO/bmsDB2965kd1BiquH9xsxr4/Jc9UGSmKTk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bKnmvyUf; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bKnmvyUf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8DBDFC4AF0E;
	Fri, 19 Jul 2024 01:23:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721352191;
	bh=TcVAZ4o5JqH+rw1XtKK3khM+41WGsSy3IOlZhc+8zLY=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=bKnmvyUfjIv97LB/d19T2GocMlByH83H67qBMG5ZIAvtvblyoxlBnWavOcIOu4rTn
	 e16Z1oTCAgAOYgNX8E4NFIkx6NlnMlo8fcEDqNVcdBNkIdZ6J5BKlKKN16Ov/VyLxN
	 C1075NNZyqQCNOP1mXplNB9AfS/GJ41cdo+4qWt64bb/83rQhrDNBtH3HBqFuh+wuP
	 duC5BbJupk5IXvXzdFFHEM0WVQT46ZlZ6mlQQMQ8W51EkIcuDTqUf4rxQ8MdXoet+l
	 /T+HcBZT4aVHYnCAFwZS8dO15tSLYTIO+xGKwOdXGj061Ya2eawiZ5SbtdSqj2mPIU
	 QNLxgKewuf+/w==
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-5a2ffc34431so78226a12.0;
        Thu, 18 Jul 2024 18:23:11 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVPqJ5PA+NK+qwUFNH7VVrfty1CM9G0NRqDGf9umFhYeufMFrSwt9zIcHw00EO5yS5hr2SMbHrFcGpo+ODdrgHcw7SUBkrAGd3hXyW9Y6JCjODCM4kuGjNqGObkXeZamBTzhyUfEH6ZxuxjJNsC
X-Gm-Message-State: AOJu0YyiyMASOf6uH+5FV0sOjIjIDLL8msgcjvr2MtK4erKqCM6mTCs+
	dfcUrGaoa1eZHHbWP+AKy/XKIPTfMUYFXr84qawmoUksVFp2PKE3OWevCAR0qfhhJLrP2qNGA28
	4yupFqP9ayy6xMx3iYOIw8KMPzHs=
X-Google-Smtp-Source: AGHT+IG+qKjO5YiCC/oG0ujwmVvgw6ET6u//7Pu323EbszO1mAZTdlhl0JlKHspoa2FnkNKrGOS40auZtiTMPAODExI=
X-Received: by 2002:a50:cd55:0:b0:5a2:2b56:e06e with SMTP id
 4fb4d7f45d1cf-5a22b56e48cmr2218940a12.36.1721352190063; Thu, 18 Jul 2024
 18:23:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240718124739.3834489-1-ruanjinjie@huawei.com>
In-Reply-To: <20240718124739.3834489-1-ruanjinjie@huawei.com>
From: Huacai Chen <chenhuacai@kernel.org>
Date: Fri, 19 Jul 2024 09:22:56 +0800
X-Gmail-Original-Message-ID: <CAAhV-H6e8RTU2avkLY7EqO_xJeRdSHm_VzHvTzmqezHQwMSr3g@mail.gmail.com>
Message-ID: <CAAhV-H6e8RTU2avkLY7EqO_xJeRdSHm_VzHvTzmqezHQwMSr3g@mail.gmail.com>
Subject: Re: [PATCH] loongarch: Support RANDOMIZE_KSTACK_OFFSET
To: Jinjie Ruan <ruanjinjie@huawei.com>
Cc: kernel@xen0n.name, kees@kernel.org, gustavoars@kernel.org, arnd@arndb.de, 
	maobibo@loongson.cn, loongarch@lists.linux.dev, linux-kernel@vger.kernel.org, 
	linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi, Jinjie,

Thank you for your patch, but I think it is better to use drdtime()
instead of get_random_u16()? drdtime() is similar to rdtsc() of x86
which is defined in arch/loongarch/include/asm/loongarch.h.

Huacai

On Thu, Jul 18, 2024 at 8:42=E2=80=AFPM Jinjie Ruan <ruanjinjie@huawei.com>=
 wrote:
>
> Add support of kernel stack offset randomization while handling syscall,
> the offset is defaultly limited by KSTACK_OFFSET_MAX().
>
> In order to avoid trigger stack canaries (due to __builtin_alloca) and
> slowing down the entry path, use __no_stack_protector attribute to
> disable stack protector for do_syscall() at function level.
>
> With this patch, the REPORT_STACK test show that:
>         `loongarch64 bits of stack entropy: 7`
>
> Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
> ---
>  arch/loongarch/Kconfig          |  1 +
>  arch/loongarch/kernel/syscall.c | 16 +++++++++++++++-
>  2 files changed, 16 insertions(+), 1 deletion(-)
>
> diff --git a/arch/loongarch/Kconfig b/arch/loongarch/Kconfig
> index ddc042895d01..fcf6451b4e38 100644
> --- a/arch/loongarch/Kconfig
> +++ b/arch/loongarch/Kconfig
> @@ -106,6 +106,7 @@ config LOONGARCH
>         select HAVE_ARCH_KFENCE
>         select HAVE_ARCH_KGDB if PERF_EVENTS
>         select HAVE_ARCH_MMAP_RND_BITS if MMU
> +       select HAVE_ARCH_RANDOMIZE_KSTACK_OFFSET
>         select HAVE_ARCH_SECCOMP
>         select HAVE_ARCH_SECCOMP_FILTER
>         select HAVE_ARCH_TRACEHOOK
> diff --git a/arch/loongarch/kernel/syscall.c b/arch/loongarch/kernel/sysc=
all.c
> index ec17cd5163b7..a332c6cb76ec 100644
> --- a/arch/loongarch/kernel/syscall.c
> +++ b/arch/loongarch/kernel/syscall.c
> @@ -9,6 +9,7 @@
>  #include <linux/entry-common.h>
>  #include <linux/errno.h>
>  #include <linux/linkage.h>
> +#include <linux/randomize_kstack.h>
>  #include <linux/syscalls.h>
>  #include <linux/unistd.h>
>
> @@ -39,7 +40,7 @@ void *sys_call_table[__NR_syscalls] =3D {
>  typedef long (*sys_call_fn)(unsigned long, unsigned long,
>         unsigned long, unsigned long, unsigned long, unsigned long);
>
> -void noinstr do_syscall(struct pt_regs *regs)
> +__no_stack_protector void noinstr do_syscall(struct pt_regs *regs)
>  {
>         unsigned long nr;
>         sys_call_fn syscall_fn;
> @@ -55,11 +56,24 @@ void noinstr do_syscall(struct pt_regs *regs)
>
>         nr =3D syscall_enter_from_user_mode(regs, nr);
>
> +       add_random_kstack_offset();
> +
>         if (nr < NR_syscalls) {
>                 syscall_fn =3D sys_call_table[nr];
>                 regs->regs[4] =3D syscall_fn(regs->orig_a0, regs->regs[5]=
, regs->regs[6],
>                                            regs->regs[7], regs->regs[8], =
regs->regs[9]);
>         }
>
> +       /*
> +        * This value will get limited by KSTACK_OFFSET_MAX(), which is 1=
0
> +        * bits. The actual entropy will be further reduced by the compil=
er
> +        * when applying stack alignment constraints: 16-byte (i.e. 4-bit=
)
> +        * aligned, which will remove the 4 low bits from any entropy cho=
sen
> +        * here.
> +        *
> +        * The resulting 6 bits of entropy is seen in SP[9:4].
> +        */
> +       choose_random_kstack_offset(get_random_u16());
> +
>         syscall_exit_to_user_mode(regs);
>  }
> --
> 2.34.1
>
>
