Received: from mail-yw1-f175.google.com (mail-yw1-f175.google.com [209.85.128.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D6C31292E8
	for <linux-hardening@vger.kernel.org>; Wed,  7 Feb 2024 18:06:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707329193; cv=none; b=Mm/yDTRm3HZfou9Ef8tBvtiewDzfTpsz2HFtXjGZGG4C3rlzrLTTnwePy7C5+zY7+Gn59rJqxUYrwPUdd2gpWXKJTg92Nx0PuI6YOjrgynIpZht1oe/duVAFYJr1BPwnO+6OSSAmz4YRGdMCvv0R/hDlTpC+MCtwSrtPgAv2FEY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707329193; c=relaxed/simple;
	bh=FbPnNAGdA+Z4vkIjVqGfUek4LBzvBXvj6UQfxJdNe4k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pcrOvDz/iPgf7litvit4j2EJhn4U14r19FdQgnI9nuKrrsKgjB9TSpyW3oTPGOkp9qUjecFNu5AumoZ4AMfNsr8ZYnWekkjVlFRZXeej+33F59pG4ydi6BfqzeU6+z/7z5c/MIXk48P4Nd3++XhPPecmGNMfulLt8LuU0Mqargc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=lz2hSV7a; arc=none smtp.client-ip=209.85.128.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="lz2hSV7a"
Received: by mail-yw1-f175.google.com with SMTP id 00721157ae682-60486805aa8so10897237b3.0
        for <linux-hardening@vger.kernel.org>; Wed, 07 Feb 2024 10:06:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1707329191; x=1707933991; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=FbPnNAGdA+Z4vkIjVqGfUek4LBzvBXvj6UQfxJdNe4k=;
        b=lz2hSV7aH1YH9XsTdpNFeWTQl+l6HC9/gjk2lpVcY9+4+wnJkAn6G/6QXS5zYA/2I+
         MSk57tMpMHQkDpCnte8zb/drmSw+5lDPXBd2m/NJx78Y13wZGP4Q2tjbFGlbttIbZV+5
         qBKYuP4SOPgWk7uEEjzb96ZxZxHymSC0ZL94kWRbffhRodJN1MEKU4YTBN9kOR2oEi+X
         b1Mp9WIcgk2zOgf7DQCfXCLUeXSIOCtMJ5Ga8O+x3PAPPzKKN510MQ27ENqcDAUnkAeW
         RFeAK3mBhMXjEzsLmElwZxYKICfi6CIeRaFMX1sBeNuuhUm9sjPoU8Gq3AALZziK/7Mh
         vcjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707329191; x=1707933991;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FbPnNAGdA+Z4vkIjVqGfUek4LBzvBXvj6UQfxJdNe4k=;
        b=g/7mAlw0h7fgpbY5/paQl1q3f3be9IKNcEmqG5oEDzgG/dSfMOKDzmYqkT5r1QlK5m
         NFkYJOQi8RBaTBONOuoaRgDrRZHofODB2bx9sMjaeU/6WWIRAsHzFKAyIZNz2rEe8YtJ
         1yFhoGJ78zB3plt2vG0l8+H2Z2isAxYB8sSsoW3RkaFKgZ4kTPaVNUKqHf707Z8x7e1Y
         fZTzeSGJwJlQROuVRWFSSL9wo+sC1Runmcuwl+d20EMkWewAsYLi1np1Tp8Yfa3z4l4b
         JZGIiIlteYULe85YL/bUy6rhkkK/trElS6j/dOrvC8zH75ejmWy7fyBUwq/lzDe7mdqy
         7q6A==
X-Gm-Message-State: AOJu0YzwQT0wlXl8mBhGlah1a3Yy5zZhHKeGmpXW+SeX6oNgPbTBX4Ob
	5A1lsGvWwgZBwxsCUXEV8dIfaY2+Z3v+7FgUjnIfT1fpHOFGjZ+CPa8F9y+d7dl07fsmlrne7ns
	T8rObGek5REu8LHA7TxWFEDJLh50z3Xr5G5MH
X-Google-Smtp-Source: AGHT+IHiHfdXSidG+UIo+maPrsvLOXJqVcz2vALelw+WT2KPbSH1zbreoW7LTGliN0/tbJJTyJ1mg6NwB8XOFhC8Kl8=
X-Received: by 2002:a5b:609:0:b0:dc2:1d13:2f4c with SMTP id
 d9-20020a5b0609000000b00dc21d132f4cmr1820152ybq.46.1707329190680; Wed, 07 Feb
 2024 10:06:30 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <e2871686-ea25-4cdb-b29d-ddeb33338a21@kernel.org>
In-Reply-To: <e2871686-ea25-4cdb-b29d-ddeb33338a21@kernel.org>
From: Marco Elver <elver@google.com>
Date: Wed, 7 Feb 2024 19:05:31 +0100
Message-ID: <CANpmjNP==CANQi4_qFV_VVFDMsj1wHROxt3RKzwJBqo8_McCTg@mail.gmail.com>
Subject: Re: KFENCE: included in x86 defconfig?
To: Matthieu Baerts <matttbe@kernel.org>
Cc: Alexander Potapenko <glider@google.com>, Dmitry Vyukov <dvyukov@google.com>, kasan-dev@googlegroups.com, 
	Netdev <netdev@vger.kernel.org>, Jakub Kicinski <kuba@kernel.org>, 
	linux-hardening@vger.kernel.org, Kees Cook <keescook@chromium.org>, 
	"the arch/x86 maintainers" <x86@kernel.org>
Content-Type: text/plain; charset="UTF-8"

[Cc'ing a bunch more people to get input]

Hi Matt,

On Wed, 7 Feb 2024 at 17:16, Matthieu Baerts <matttbe@kernel.org> wrote:
[...]
> When talking to Jakub about the kernel config used by the new CI for the
> net tree [1], Jakub suggested [2] to check if KFENCE could not be
> enabled by default for x86 architecture.
>
> As KFENCE maintainers, what do you think about that? Do you see some
> blocking points? Do you plan to add it in x86_64_defconfig?

We have no concrete plans to add it to x86 defconfig. I don't think
there'd be anything wrong with that from a technical point of view,
but I think defconfig should remain relatively minimal.

I guess different groups of people will disagree here: as kernel
maintainers, it'd be a good thing because we get more coverage and
higher probability of catching memory-safety bugs; as a user, I think
having defconfig enable KFENCE seems unintuitive.

I think this would belong into some "hardening" config - while KFENCE
is not a mitigation (due to sampling) it has the performance
characteristics of unintrusive hardening techniques, so I think it
would be a good fit. I think that'd be
"kernel/configs/hardening.config".

Preferences?

Thanks,
-- Marco
