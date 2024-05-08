Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3731D20E3
	for <linux-hardening@vger.kernel.org>; Wed,  8 May 2024 00:09:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715126968; cv=none; b=Qe5AYg29ReWJvIw4kt25VlYHAPXAcisveyHEJL77atBhxnysenyMcBUTCTp9m+PqzuIOC6+MhRh4e8nqOeMMAuLt3ipGI9x+9PZrGyZclGKCyphZxoyztaJW1QCB2oclQNWQBLSmnT2bgAjJx7wY9TnP3H5xdT/+2agz3yE/bqw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715126968; c=relaxed/simple;
	bh=2RBkzmRwSheKgkAQe2JV3Fs7F/JeQq/TzY2YuKFXwgU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Imv+oIWy7Iti8IEnMMWLKgaQhGJydP0dLF6VHGt5WIwbqkUjQg5F+60hlxUiGM95dPNFbvBHexmd4N629sGh350zV6svUSR5JYs3nu0v5SzTFQf4gAseCEo3qEY7Zce8pTwEhdG68AvwUTjmYeLU0ANac1sfI8kqkd4GmqMexoQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=P3BpdlBR; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="P3BpdlBR"
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-2b346712919so2844028a91.2
        for <linux-hardening@vger.kernel.org>; Tue, 07 May 2024 17:09:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1715126965; x=1715731765; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=y1syOJovW5eId25dp/lIC5NMYcXKMWcKV21Z0vOpfbA=;
        b=P3BpdlBRRYrhG9RwRG98tPisRxHqA9/nXL5OVnH/XDndDAqVIgGLLYrb23uF0xFmGC
         JYjuiUVsD6tEHDieYVr0BeFymRJW7cDFK5ge8ay0p55Cc/DLjk7yQPQS+CTCSFI3DEzm
         rhHntFPWo8s8mBoxlYvBTio3TYfad3n792GKY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715126965; x=1715731765;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=y1syOJovW5eId25dp/lIC5NMYcXKMWcKV21Z0vOpfbA=;
        b=ochT1Dkfe4ga6jWBklf9pRWrOUW+aI7pIHTYPSlbc5bPNTdD6YvIvVFWtv0Cso2RUc
         PE3QNUSPr1Xf9qDBQ/B/AL3UIlCUA1+oLWJZP5LrdOKGP7cgMz/dAD84xF6xXTs9a4Dl
         OVCq6Mc3swUe3zyFjmroDqGItGNzbUx/nKaWBKUtcgda4DO65zOusYiu3AQXC5Na6W/h
         mBGv3ddTPir56s2MoGDu7xI5tu/gkcqptiGvSuLd41MyNWr91K6ALz9j7MzwrTodx9jx
         RBXK13RPgrZUMI2HfEQIj9SaH/4rp1DWu+w0lc3j40dR0iaQGiNwMjdfENBa+qjzkUPk
         nWcw==
X-Forwarded-Encrypted: i=1; AJvYcCWPQsaWQfkVNKwWFmWw1O8rMvNdAx81xRJIacxEqnzAG+gJ3KpgwVALuw/Hxc9Z5O/W9uyOFgMmb5we5tmFkhYC2qDMMTzJrV9cwCSsdSUr
X-Gm-Message-State: AOJu0YwQydmjiLkalFRJGDiBhgb8ms9qSy/TpJ3gws2DkjatPmD5DPij
	hoSzvVEXax9KTajTHgLuUhvP+EjHKCi9INbO3xuGq2y/a7XxyyfKmnJ0Xrm6vg==
X-Google-Smtp-Source: AGHT+IG6ljKWC4/Nljh3hqVMgeNltqhDXr5URpX3VUK0fuEPsH/8i/GoTdfNLVoHrp3y4e/JzyIgVw==
X-Received: by 2002:a17:90b:4ac8:b0:2a8:1fdf:b1b0 with SMTP id 98e67ed59e1d1-2b6166bfe0bmr1137740a91.29.1715126965497;
        Tue, 07 May 2024 17:09:25 -0700 (PDT)
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id d12-20020a170902654c00b001ed9b384b6fsm6802901pln.23.2024.05.07.17.09.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 May 2024 17:09:25 -0700 (PDT)
Date: Tue, 7 May 2024 17:09:24 -0700
From: Kees Cook <keescook@chromium.org>
To: Justin Stitt <justinstitt@google.com>
Cc: Phillip Potter <phil@philpotter.co.uk>,
	Nathan Chancellor <nathan@kernel.org>,
	Bill Wendling <morbo@google.com>, linux-kernel@vger.kernel.org,
	llvm@lists.linux.dev, linux-hardening@vger.kernel.org
Subject: Re: [PATCH] cdrom: rearrange last_media_change check to avoid
 unintentional overflow
Message-ID: <202405071709.817AB45C0D@keescook>
References: <20240507-b4-sio-ata1-v1-1-810ffac6080a@google.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240507-b4-sio-ata1-v1-1-810ffac6080a@google.com>

On Tue, May 07, 2024 at 04:54:04AM +0000, Justin Stitt wrote:
> When running syzkaller with the newly reintroduced signed integer wrap
> sanitizer we encounter this splat:
> 
> [  366.015950] UBSAN: signed-integer-overflow in ../drivers/cdrom/cdrom.c:2361:33
> [  366.021089] -9223372036854775808 - 346321 cannot be represented in type '__s64' (aka 'long long')
> [  366.025894] program syz-executor.4 is using a deprecated SCSI ioctl, please convert it to SG_IO
> [  366.027502] CPU: 5 PID: 28472 Comm: syz-executor.7 Not tainted 6.8.0-rc2-00035-gb3ef86b5a957 #1
> [  366.027512] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.3-debian-1.16.3-2 04/01/2014
> [  366.027518] Call Trace:
> [  366.027523]  <TASK>
> [  366.027533]  dump_stack_lvl+0x93/0xd0
> [  366.027899]  handle_overflow+0x171/0x1b0
> [  366.038787] ata1.00: invalid multi_count 32 ignored
> [  366.043924]  cdrom_ioctl+0x2c3f/0x2d10
> [  366.063932]  ? __pm_runtime_resume+0xe6/0x130
> [  366.071923]  sr_block_ioctl+0x15d/0x1d0
> [  366.074624]  ? __pfx_sr_block_ioctl+0x10/0x10
> [  366.077642]  blkdev_ioctl+0x419/0x500
> [  366.080231]  ? __pfx_blkdev_ioctl+0x10/0x10
> ...
> 
> Historically, the signed integer overflow sanitizer did not work in the
> kernel due to its interaction with `-fwrapv` but this has since been
> changed [1] in the newest version of Clang. It was re-enabled in the
> kernel with Commit 557f8c582a9ba8ab ("ubsan: Reintroduce signed overflow
> sanitizer").
> 
> Let's rearrange the check to not perform any arithmetic, thus not
> tripping the sanitizer.
> 
> Link: https://github.com/llvm/llvm-project/pull/82432 [1]
> Closes: https://github.com/KSPP/linux/issues/354
> Cc: linux-hardening@vger.kernel.org
> Signed-off-by: Justin Stitt <justinstitt@google.com>

Much more idiomatic. :)

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
