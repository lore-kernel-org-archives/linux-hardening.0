Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6BD5257AF3;
	Sat, 30 Aug 2025 19:11:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756581104; cv=none; b=qQWBPqekGZQ/M4ZB+xsdog1p1FmsyDMsqPaOMzZv7jVp2NmOU3raBL5/vpjGzIFiT2VkSrN7P9bAEuwdTG2B9ik9MYMRWN2xD1Z1x+WJE7QRC6x/9HQaRmNBhZkY5isyBJdspiFE/vqZkxeeVtiWLjeDMQDyD4D8g6ejsPdW5ss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756581104; c=relaxed/simple;
	bh=50gJbBwtixydMvDBUecf/dpBUon5/5931vcLJn4NeMk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=reoe6407QQeq8p4F/uKenosJEdIZ+dbNSme1sBA/nzUbF7gUEnjSRHC1tFbuFnUxoqIhQFvi/Qn2WXsVyGapSmnET5aWYDFEbl1HvceK4q775rGiksw+C7LyLvnUW39ecBy28gzg6p9rlqE4f+FpKGM7lvhiEDfLcYseRIxcyK8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ue34I0Mh; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ue34I0Mh"
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-61cbfa1d820so6031898a12.3;
        Sat, 30 Aug 2025 12:11:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756581101; x=1757185901; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TE7opTv+bXEDaK/8HEHI+O6QGRpRy4oLfrvJAj6i/zQ=;
        b=Ue34I0MhiVNYm/G3kGZWxCjOIsyY7beANFraJam6pd0euluY4yFFYc699v2xf/6gCJ
         1+iAX914vODo0522jNGb58+I+Ajemda7iDf06m5T6OufeggdQkxD64d+6H3hshxkPFTp
         mCPCYfHtXPjuR5zNgvoQqBWTyvnGnxx93wVIC+oiG61/WeEeAs40iwGPj0pj2EeGAoOu
         17ZF6300JHOaW0WrIf3mGZ97gNzitIy/tok7tSow1OPy/CUzH+m8NIt0YiTlgQIHtWCT
         LQLVauSt354nGRYpZRYWugzaOLb86TwFHMmHq/tQFGfSg1PBgsbEQjFrNEHjvIr5lOrx
         VacA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756581101; x=1757185901;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TE7opTv+bXEDaK/8HEHI+O6QGRpRy4oLfrvJAj6i/zQ=;
        b=TeXb6tNjy/P3GA2SA7X/hMkCsRW7z8d82xUvhN1ZaCXyED7k0aMg4czCR5kqNyvlgv
         GKnetk8/2cY3zXJhHxmNVhFXQjYskwhuPpVo2s0krZb3hNg8maiv5eqtm1z5yU5JJ1YQ
         4jab2P1I15qjUPAnpDJDZFlkdjQTY84zZCZe2dcIEwwAm7oLODfE72T3VNgoKAawsjkC
         k0gGIYtlxRnLpSTT+HQT1lOKRkez50ApjfoSc+Sy7xBUCYWlgR7b4zPMI1acYG/hLNSN
         LZMXDVlrqQD8OhnPBUZISIRsrQ2n/vHsGou2cGAgh5sU5X9nc8GXwUlSZgFswb+2Yfrd
         10Ag==
X-Forwarded-Encrypted: i=1; AJvYcCVEtCMNo6asxR6aVzdQgw+KazIcYSM714dpRGyFmANSBq+slAQvWFZmkeKvFmTyGWpKSQbwABtF2M9+fQ==@vger.kernel.org, AJvYcCVslEbPdM+yBwgIF1YQYYihf1mAo7YubgojXpDtVzgo+r+8Qc6Wdrvsy/Bs682jLesedeC9zhE5FA6BQFR9tigu@vger.kernel.org, AJvYcCWnFFT/EobY/pkk2am5cyb3s9i5hK99EszVEchieb3BpRUdHzscdfiTWrulGzYoWUWoWFVS+Yxhk9GVueW6@vger.kernel.org
X-Gm-Message-State: AOJu0Yx6JUmkbDLUumV5W6Za89XCP+ckWZLWnYAxcRz/OXzXpWRWHD6C
	faYBOEfRz2DgZiPawBBt/sfEdXuVuYi8SM5sOvqODzjD3UeiVcgXL7QdLq9x8b1HuNHOznizE3p
	/bS+8uNXQDTrUFN0x1AvsRg674rwIIfrDpko5
X-Gm-Gg: ASbGncuaE7jRsfgMPlWi8Ajpzl0CetCDkwIPNTbt5xSKfkUaSKUzgU6Gypmn/mKXsZy
	alYIQFad+uDRR1tcQlRu2VT639a+po3xcNixs1jJNc/aZZNXL1SESv8VWIh8wrxUE7UpLqi8LaW
	Ghf2M8Pe4ikGdH1XFuDV26WMr+M/uI7WjYbic137fv9OnPF6RScKYLQi+S29SrxNiCVs6i78oDL
	dOJd2nz
X-Google-Smtp-Source: AGHT+IHK1D4MTIB3dfb/YWiZqAszHiAgJM47+GNAOx4rWFgMAoZY4wzDnS0uJ1baHeRW1Wc5U0wTJM8fpc7DdUw4Myc=
X-Received: by 2002:a05:6402:388d:b0:617:4b56:5bb1 with SMTP id
 4fb4d7f45d1cf-61d269a717amr2353973a12.11.1756581100911; Sat, 30 Aug 2025
 12:11:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250817231753.633899-1-thorsten.blum@linux.dev>
In-Reply-To: <20250817231753.633899-1-thorsten.blum@linux.dev>
From: Magnus Lindholm <linmag7@gmail.com>
Date: Sat, 30 Aug 2025 21:11:29 +0200
X-Gm-Features: Ac12FXws0ffiID41jCEYPRV3uWnLZ6Kfr3vkeMthfBN828jI2KAat5HjI_uSoHQ
Message-ID: <CA+=Fv5QdP-qGjUXQZ4ig1RX=0zx5c11gdrvwT9gqXNqTTqSZvA@mail.gmail.com>
Subject: Re: [PATCH RESEND] alpha: Replace strcpy() with strscpy() in setup_arch()
To: Thorsten Blum <thorsten.blum@linux.dev>
Cc: Richard Henderson <richard.henderson@linaro.org>, Matt Turner <mattst88@gmail.com>, 
	linux-hardening@vger.kernel.org, linux-alpha@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

It can be a bit controversial to replace the platform specific string
manipulation functions with a generic interface. On Alpha, there is nothing
(at least to my knowledge) that indicates that strcpy is broken or used in
an unsafe way and hence this patch doesn't really fix anything.
In my opinion, I think this should be a NAK.

Linus wrote some relevant stuff on this topic

Link:
https://github.com/torvalds/linux/commit/30c44659f4a3e7e1f9f47e895591b4b40b=
f62671

like for example:

"Use this in places where it makes sense, but don't do trivial patches
to fix things that aren't actually known to be broken."


Regards

Magnus Lindholm

On Mon, Aug 18, 2025 at 1:23=E2=80=AFAM Thorsten Blum <thorsten.blum@linux.=
dev> wrote:
>
> strcpy() is deprecated; use strscpy() instead.
>
> Since the destination buffer 'command_line' has a fixed length,
> strscpy() automatically determines its size using sizeof() when the size
> argument is omitted. This makes the explicit size argument for the
> existing strscpy() call unnecessary - remove it.
>
> No functional changes intended.
>
> Link: https://github.com/KSPP/linux/issues/88
> Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
> ---
>  arch/alpha/kernel/setup.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/arch/alpha/kernel/setup.c b/arch/alpha/kernel/setup.c
> index bebdffafaee8..8b51e6ca83d6 100644
> --- a/arch/alpha/kernel/setup.c
> +++ b/arch/alpha/kernel/setup.c
> @@ -468,8 +468,8 @@ setup_arch(char **cmdline_p)
>         /*
>          * Locate the command line.
>          */
> -       strscpy(command_line, COMMAND_LINE, sizeof(command_line));
> -       strcpy(boot_command_line, command_line);
> +       strscpy(command_line, COMMAND_LINE);
> +       strscpy(boot_command_line, command_line, COMMAND_LINE_SIZE);
>         *cmdline_p =3D command_line;
>
>         /*
> @@ -511,7 +511,7 @@ setup_arch(char **cmdline_p)
>         }
>
>         /* Replace the command line, now that we've killed it with strsep=
.  */
> -       strcpy(command_line, boot_command_line);
> +       strscpy(command_line, boot_command_line);
>
>         /* If we want SRM console printk echoing early, do it now. */
>         if (alpha_using_srm && srmcons_output) {
> --
> 2.50.1
>
>
