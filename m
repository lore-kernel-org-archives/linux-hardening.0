Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C26FB36BCC0
	for <linux-hardening@vger.kernel.org>; Mon, 23 Mar 2026 20:19:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774297158; cv=none; b=lsfjvEMc1N0Y6OtdVP5VZgLzz+SDNGaPOgdb4WbfuPCAhtkvwHOYzDq8uvPgsSQeRsIZJs3A/MyEFOjfGZq65ImZHOzN/Ajbq21LKS3PiMAvXBAKSSZt+Ir2OZfI2cF/DFLppQYhhw1oM8tFl24kFar+eV+suUNiQPnM9CEJNg0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774297158; c=relaxed/simple;
	bh=Ps82ZXqOu0VF4EUBaCiYeI6G3LGOYrbRYcJ4p/zhW1c=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oKN3X4VdE6fxspcGBxDQVwjndriGIezmn7K3XHBG/mzaRm7aSNIG0HF6YejFmw9OU7k+tfALYEJmxJiB1IoA8eXdD8uh9niwuyFPzxyo/0uWIVA44zGUvF3ZbkInDjs817kACmi3ZUxcGrRX3xMqrZlW8Lc2fdNGZkjlIKTpeR0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=O8ocNCV2; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O8ocNCV2"
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-439b611274bso2548611f8f.3
        for <linux-hardening@vger.kernel.org>; Mon, 23 Mar 2026 13:19:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774297154; x=1774901954; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cr1t9sjlplOUkX17+4RyR0lC0VfTKhvSiQURz0qF41I=;
        b=O8ocNCV2o0UeNDNiciQQ3TuxdasXCMrAQhT/qfdGF/Df3T4K145yYpl+qLK2fI55z0
         z+CI/ODShyyRSakDjG6DUxuT3wAVHtpB5DxNgeLUY0FFRcotOzYFt3hRXJ1yEh8MKj6J
         fa8nM7SegPU2m+4yfApTXZVZ1Wukn/Vb41nHUkXamxsQChi/XdsXGQbGHA1Hur7Yaedt
         MguWiYEgXS8IBQzheRk3j/JSAtMZleU5tW1tHAG5oFqLvl0N/ulkm8Ey8aochaQC6cfW
         wXrhhZ6cNwqwAr6HrZeNh/FZR/WmwwyruYVFVdl+owpmqQzeXbMaeOYuaDbNMNQ13w/E
         ErSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774297154; x=1774901954;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=cr1t9sjlplOUkX17+4RyR0lC0VfTKhvSiQURz0qF41I=;
        b=X04djDPuKmTVhlAuTKvIAU3eqUyZu0o1E7t1fZmEBNTdLO6c+399nMEeVixxuFtqAG
         waYC+m+HYhx0o9dnNPfjNISOcjsqxRMY0E/UNB7iYVbJBqZ1QAgx4ebi3MHexMuM0Tdq
         ioZyBO98evYrRIiFtT8bk7hcM8a/ZMCDAhYshlC6wQtpsx2XE78L4OvQ06ftWqbzzfj0
         BV0T9Zg3vUuhxfazQ+cTkznFRXZ535+G0JUUfU6i99Pbi3mDq2rVjE7LS8bpptFX9hcP
         DqybzzkFFJfEuKokFx103CNpV9HotyJheccqIvSdnRBRQAruyVwqd7O4E3mcmJObSbdQ
         m1HQ==
X-Forwarded-Encrypted: i=1; AJvYcCXCfUjVV8StwaOUBqrHH1ctWwmR8IBxIMWrOYElonXsRASoXBNQLKP0p/mDSyCSOeTyl5GKiFJUA2IdqSrH16o=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy8KNtJnzAerx1u9EXu6Tqa8NEV0rqccmZD6/ruzplDjO9wwREf
	6rg+Pr+25FFxyAtc8B0oXQPOmncJBAt1IqftxABuaxStFAFC6ZE1N7j0TLalrQLD
X-Gm-Gg: ATEYQzyc2k2bMgGoIz5Zf6IPsgV2NkciYlK9ZoY44rBPiGXLTgye0vWw9kKkanxNbDW
	kZ4Q9hnINFJVUJUgRQwPxourqJ8djs4z3eZV4+kQAnn49GXaiN1NGlsulu1ZRqvVazVe6qLLBIA
	LMQkY3HMMHlidYLjLTY7qHwtnSFaUfdMrJYVL1gG72ZY3ZHO6xO2YHROaPA000m61/GaYJ3d1iL
	HH0DayBSZAoJSQcDYEjTyN50t1W9iQr8aBu7alJgqGuwExGqvAz5sYziFRRZg/69qcxX8uwfqhG
	TGNAz+7VvlBV5PDzcrG4Vfa9ixKyE5k3kNear0csgxbtIoQSEa6Q5J1p8QBf7lp8k/DNaFIGINx
	29uRDHe7oOsUlyaKl7zqzGLcW2mAhxhQyMDeNuxXi9kte6pN7Cn+ybjCJqIidBjCZS+veKdOiIh
	Of7o9WMOGSz9frY6dB5Z/vFOLjNASNjkXhn7BBzQGtxG32GzureTo6JhkoJksl1zzT
X-Received: by 2002:a05:6000:2303:b0:437:8fd6:d849 with SMTP id ffacd0b85a97d-43b6428ab6bmr20344375f8f.54.1774297154043;
        Mon, 23 Mar 2026 13:19:14 -0700 (PDT)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43b6cdfdfa9sm22985479f8f.9.2026.03.23.13.19.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Mar 2026 13:19:13 -0700 (PDT)
Date: Mon, 23 Mar 2026 20:19:12 +0000
From: David Laight <david.laight.linux@gmail.com>
To: Kees Cook <kees@kernel.org>
Cc: Carlos Maiolino <cem@kernel.org>, "Darrick J. Wong" <djwong@kernel.org>,
 Andrey Albershteyn <aalbersh@redhat.com>, Steven Rostedt
 <rostedt@goodmis.org>, linux-kernel@vger.kernel.org,
 linux-xfs@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH] xfs: Replace strncpy() with strscpy_pad() in tracepoint
 error paths
Message-ID: <20260323201912.2cb99938@pumpkin>
In-Reply-To: <20260323172204.work.979-kees@kernel.org>
References: <20260323172204.work.979-kees@kernel.org>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 23 Mar 2026 10:22:09 -0700
Kees Cook <kees@kernel.org> wrote:

> Replace the deprecated[1] strncpy() with strscpy_pad() in the
> xfile_create and xmbuf_create tracepoints.
> 
> Both tracepoints use file_path() to resolve a pathname into
> __entry->pathname (a char[MAXNAMELEN] trace ring buffer field). On
> failure, the error path overwrites the buffer with the string literal
> "(unknown)" via strncpy(). The original strncpy() zero-pads the
> remaining 246 bytes (MAXNAMELEN is 256, "(unknown)" is 10 bytes
> including NUL).
> 
> strscpy_pad() preserves this zero-padding, which matters because the
> destination is a trace ring buffer entry: ring buffer slots are not
> zeroed on allocation, and the raw buffer is readable by userspace via
> tracefs. The zero-padding ensures no stale data remains in the
> buffer after the error path overwrites it.

Eh?
AFAICT file_path() doesn't zero pad on success.
Not only that is calls d_path() to do the work and that has the comment:

 * Returns a pointer into the buffer or an error code if the path was
 * too long. Note: Callers should use the returned pointer, not the passed
 * in buffer, to use the name! The implementation often starts at an offset
 * into the buffer, and may leave 0 bytes at the start.

So the code actually looks entirely broken.

	David

> 
> The source is a 10-byte string literal into a 256-byte destination,
> so there is no behavioral change.
> 
> Link: https://github.com/KSPP/linux/issues/90 [1]
> Signed-off-by: Kees Cook <kees@kernel.org>
> ---
>  fs/xfs/scrub/trace.h | 3 +--
>  fs/xfs/xfs_trace.h   | 3 +--
>  2 files changed, 2 insertions(+), 4 deletions(-)
> 
> diff --git a/fs/xfs/scrub/trace.h b/fs/xfs/scrub/trace.h
> index 39ea651cbb75..46c420f51129 100644
> --- a/fs/xfs/scrub/trace.h
> +++ b/fs/xfs/scrub/trace.h
> @@ -980,8 +980,7 @@ TRACE_EVENT(xfile_create,
>  		__entry->ino = file_inode(xf->file)->i_ino;
>  		path = file_path(xf->file, __entry->pathname, MAXNAMELEN);
>  		if (IS_ERR(path))
> -			strncpy(__entry->pathname, "(unknown)",
> -					sizeof(__entry->pathname));
> +			strscpy_pad(__entry->pathname, "(unknown)");
>  	),
>  	TP_printk("xfino 0x%lx path '%s'",
>  		  __entry->ino,
> diff --git a/fs/xfs/xfs_trace.h b/fs/xfs/xfs_trace.h
> index 813e5a9f57eb..9f9fb86097ed 100644
> --- a/fs/xfs/xfs_trace.h
> +++ b/fs/xfs/xfs_trace.h
> @@ -5101,8 +5101,7 @@ TRACE_EVENT(xmbuf_create,
>  		__entry->ino = file_inode(file)->i_ino;
>  		path = file_path(file, __entry->pathname, MAXNAMELEN);
>  		if (IS_ERR(path))
> -			strncpy(__entry->pathname, "(unknown)",
> -					sizeof(__entry->pathname));
> +			strscpy_pad(__entry->pathname, "(unknown)");
>  	),
>  	TP_printk("dev %d:%d xmino 0x%lx path '%s'",
>  		  MAJOR(__entry->dev), MINOR(__entry->dev),

