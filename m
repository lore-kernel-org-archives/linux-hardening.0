Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF7623019D9
	for <linux-hardening@vger.kernel.org>; Wed,  1 Apr 2026 13:48:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775051306; cv=none; b=ek/ZoXSUf8Tna5lmpbVbqmrD+v1Y3BhL/AFBj81pM7bJY00ms4Ms0CsCEq0SMZgMLYPRnA8Iwo6glpv6Wqc8b7a8g6MvvENMpp/gYATudp0VbVhgKHHCc58YOx0S6WkHKVHOJlTh7eDPbzvu46VWx5woU7TlqWGZMouzPIxktDM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775051306; c=relaxed/simple;
	bh=H1qO9xPP+vzdMQg5jF11OQIlT57LPyaGIOSG8CHQ5xQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UBit/20HHI9RRpkfIMfrze7UXm/P5NdwKslOcvmZrpq++m11d7lQ32D7AbY6EHg7Qh/9XvNZdh7vApsJid+KcVSx0Uq3buVwaazaYodlkmghmS94kYkp9eoewvhkIac08soHTwWEuGZk3/WdLrzcwlnmhANnIYYFzuFk6sRqpFY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DRpPwxGy; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DRpPwxGy"
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-4888375f735so8703185e9.3
        for <linux-hardening@vger.kernel.org>; Wed, 01 Apr 2026 06:48:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775051303; x=1775656103; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+ll6rdV8XlQLSH7UYP9c199vG18Z0M9OVWAwKYpbOVw=;
        b=DRpPwxGyqiSVk0C4d+u1Ts4LOynY3GKlZ9/fCJVr7bTN4SJtAYlEg6hPFDvNoy6ybM
         3Ix8ne0f8UZxYEnc0OxEV+cgNjBwIZbT5jnAdwwlUe3ev2NQMCZFqY6lSjmzS8l6/AVQ
         G6bq/b6Gk5UyVUTzK8UNUswmPfggW7rGcuHZ1ZMOw8beEUBkGjbga3gQA8QPP2onI2o2
         BuL0CY0Fe5DgZYqiVLVUikLlkjresMXpSB/upEDlObr6nx2Nm+167nVhmQWFpsYjXcPv
         BpMeRrzbyLAoxQ0P4DFKGaHYTKAYSvydwgnpII9HAiuifxdZoEZurVFy8y8UjPjdOgiA
         lY+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775051303; x=1775656103;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=+ll6rdV8XlQLSH7UYP9c199vG18Z0M9OVWAwKYpbOVw=;
        b=m8D2hDlWRlzhhBBDfHTpPGYZiSCeuLLp8lrilzL97PP/2mW8zTwFFVlP2+YCIkumYN
         yueqIQF09yiUR+XGqSJHFKnB4/f/SEauhqKedm4tX1pwZ8ga5lz+B9cCkgcB6+EDBXNk
         ykpN11HWTm4MqAaf/bIpxatJSLDijDeOJvA2KQzcGQvucjyb2rkwUbMi4i2MIQkGAmw/
         sKu8Eo3wGXBAIl1DrsDPx6FJ+Pxgyzs8EeDhShd4kbfz8TUCxSUu21juZdrvSj+0miDW
         rCUuBtMbyUBZMHhtjGe/S4BJo6lDsHKItM7UV9jC6bfnpAtvI49Cu69iGtEkWvIbHstI
         Zn4A==
X-Gm-Message-State: AOJu0YygquS5EYCvTP0wlnUgQgcmKkNKTD1xMP6RBWVxaS3jPuwWOAST
	Vj7n9MmpWVJl2eoGiTfMwvTx0N2s//Ze/kuj9+mzba2htWzPlbC0hWJl
X-Gm-Gg: ATEYQzxQikaMEA4fzZuUiVw2BGceVZziJVUt9nGxVAv+HGzE1Mxh1ZyyTMBToP89fgM
	HLrpvpHRwYC8zmwV4B0AfcEeS6+e8l/bioDn8NJOxR4W70fQBlaUpW+yBiE4Fir5GeERIwACup7
	jzaQwmJ6ZYbj+bCcdhx/lkA4snzzcc6D9yQmYTkk2v7rg1mtY5VSOlQqhh9DcFJu3S7h3ahu8t0
	N4/iH9pcDWAKFsTVcLjTl373r5xP4vYWsZ5vgwESgy9dNBXBPn6J4Ug1lohePZJZFa0A0NUyo4Z
	NL7otg+I2McNFJLJ3Ot++z2r6CqZMQ/gvhoz2ECEZleMxBzaP1uHEZW6kfaj6wxHQrqjQhVKXgK
	kaB8HuFPwisFxisdJD13nkl3aw3d5bcVrqFvMO9E0ZkyD42+iD0r1+ALKYhXRZFUOeY9IsXII5i
	bGYi76z7yGdawlVqwppv8AGEFoz/CAA6P2J2aNJp1D9JssYtKgwCs3PV+bAUNo
X-Received: by 2002:a05:600c:3516:b0:485:3f72:3230 with SMTP id 5b1f17b1804b1-48883597e85mr54243935e9.15.1775051302755;
        Wed, 01 Apr 2026 06:48:22 -0700 (PDT)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4887e86ecf6sm126260725e9.14.2026.04.01.06.48.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Apr 2026 06:48:22 -0700 (PDT)
Date: Wed, 1 Apr 2026 14:48:20 +0100
From: David Laight <david.laight.linux@gmail.com>
To: Kees Cook <kees@kernel.org>
Cc: linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH next 2/3] fortify: Optimise strnlen()
Message-ID: <20260401144820.0f552783@pumpkin>
In-Reply-To: <202603311650.A59396A@keescook>
References: <20260330132003.3379-1-david.laight.linux@gmail.com>
	<20260330132003.3379-3-david.laight.linux@gmail.com>
	<202603301650.E7C1536632@keescook>
	<20260331230914.43698e74@pumpkin>
	<202603311650.A59396A@keescook>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 31 Mar 2026 16:51:26 -0700
Kees Cook <kees@kernel.org> wrote:

> On Tue, Mar 31, 2026 at 11:09:14PM +0100, David Laight wrote:
> > Any uses should be replaced by __builtin_strlen().  
> 
> When I looked at this before, __builtin_strlen() flip to run-time strlen
> on non-constant strings, which is why I had to jump through all the
> hoops to avoid calling it in those cases.
> 

It should be fine provided that you check that the result is constant.
So doing:
	size_t len = __builtin_strlen(p);
	if (__builtin_constant_p(len))
		...
should never generate a run-time call to strlen().
(Probably the optimiser throws the call away because it knows it has
no side effects.)

I did notice that:
	if (__builtin_constant_p(__builtin_strlen(p)))
		...
is true less often (more so with clang than gcc).
I suspect than an early compiler pass generates 'no' rather than 'maybe'
when used inside an inlined function.

There is also something odd going on with one of the 'bot' builds.
I've compiled x86 allmodconfig with clang-18, no warning or link fails.
But I've not tried the specific config being tested.
The link for reproducing the error isn't entirely helpful.

Looking into that error I noticed that clang fails to optimise the
strscpy(tmp_cmdline, boot_command_line, COMMAND_LINE_SIZE) in
init/main.c:setup_boot_config() to a memcpy().
That means it calls strnlen() and then strscpy() - two scans to find
the length is also silly.
(At some point early on that code needs to call a real function to
do all the work instead of inlining everything into the caller.)

	David
