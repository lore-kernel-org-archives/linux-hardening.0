Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 914FD155A43
	for <linux-hardening@vger.kernel.org>; Thu, 22 Feb 2024 17:57:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708624642; cv=none; b=jewzgRXZ4ADXxBFxBr/av//frITmpx19Km2HmY6MkU6ODY6zOh72ei0i2d42ZSY3khzVfud5bwkHAES5NBH2C7B5YKAuG1aPUwzzPPr645oFl765WDTgyCX/5PpOC7ZoZDqsqePEH+2CXFpKrGF1/SQtQR70wOddGSwK0rYN8m0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708624642; c=relaxed/simple;
	bh=hlPKjlQSc0kMs/W05kmcLVH3IEjiTit6toh7GkaAPKU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=vE63tDdK2Vgnho4uoyQD+Go0w/n2TKwtoUohuMl8Wu90vE9L7iUg+PpiavEjP5klGgLdWtSFG1MGxEwx54w3qskE7onFIezg9ekk/aT2Hp0XqVjKyfB3k9tt3xNxPwxxG48ovjWMhWa3yXv9g++cd4ACJhk2SKSf2PGWfd6gj6U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=LzI27tNp; arc=none smtp.client-ip=209.85.167.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="LzI27tNp"
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-512e39226efso98439e87.0
        for <linux-hardening@vger.kernel.org>; Thu, 22 Feb 2024 09:57:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1708624638; x=1709229438; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=2n36AeyXiuh8a+bUOx1L+r2cwQosoX8vn/3R6qLfBBs=;
        b=LzI27tNpWi75HOEGy25hCc71RgKcKAUGfxffz8GmDfam4I2V+MU41aKTFeKjd0zRzk
         NO9CA1DlzFI8pXTLPThgTU1ewGfQPyTzC483xhm+c/bD7Cp92h4InhMb0KxAV9UsUAT7
         IB3MAHjQi70V1je60+d29jj/L7PN+o+agOeHQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708624638; x=1709229438;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2n36AeyXiuh8a+bUOx1L+r2cwQosoX8vn/3R6qLfBBs=;
        b=vHwIOYKX+zfVM5ggJuwnhcifoZoag4Zk9mnRvYqCO+/qo3qZKsDSV73E812j0ajjhT
         mpjSBHRJR8tuQhYeBr1mStp7C4eU9/3kdtvOwG9+e25ZfGA+It9YTz6W7I7KYHKYoX0n
         FyBt8rHla9cd3YwkiSh2UYyCJfglxe92mBl+V6WzzxHaJ1Fp4CX4x5Jkrk1WTWjjLq48
         M9Dg4QoKU2regktKbrg7vojWhm01KVuDaP0jIukLys7qdJt9L2wS8I/pIJ2T4WdRg2Xv
         gyNIRphiD+AQEnWEDxj4efWEGZwOj26fJYGCVVpy2pVxLJeL0+/V/i9qXLBj89l8HFrT
         4AXw==
X-Forwarded-Encrypted: i=1; AJvYcCUc1zApWltnrdpcC+EACKp4FXMrtV8lzkM60rIjIZUPwOK4zDS4+NnrtlG0xGFYj418Hg6zpDSKaDiAs+bwxzUMF5FZ7cCksDaZc4KInpuH
X-Gm-Message-State: AOJu0YymQlHPp0HqlCSoiksivsYXgR/K8XF04otWjjBzLUARfvv5H51K
	raqgFQOrd6Q0UyvM6q6eh4e/UB5UwkHiewITWRr2Tqq3J9VHyPwNEahFejQ5O6lTF20HOLWYX7J
	cQMPing==
X-Google-Smtp-Source: AGHT+IEtNE9cPYwoO7rz3jl9cIDKnVMB+PAicPFyHPCUeaUEcUZzQjBsb2Ak6flad/8kJWDn9hJ37w==
X-Received: by 2002:a05:6512:2c97:b0:512:e00b:8da4 with SMTP id dw23-20020a0565122c9700b00512e00b8da4mr1374476lfb.53.1708624638573;
        Thu, 22 Feb 2024 09:57:18 -0800 (PST)
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com. [209.85.167.54])
        by smtp.gmail.com with ESMTPSA id x16-20020ac24890000000b00511736b0252sm2134901lfc.21.2024.02.22.09.57.18
        for <linux-hardening@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 22 Feb 2024 09:57:18 -0800 (PST)
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-512e4f53dbfso17574e87.3
        for <linux-hardening@vger.kernel.org>; Thu, 22 Feb 2024 09:57:18 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCU5AhxiJc+9zvz2ypdVKfWxD0PR4P+W4XT2GA1Nw40wifnAGnO0TwcE0MUugVXnFPwX4kVorF1zZgRqPMxnTMWQ5ODvKOkZdRIH+1fiUSnD
X-Received: by 2002:a05:6512:3089:b0:512:acf1:6970 with SMTP id
 z9-20020a056512308900b00512acf16970mr11555378lfd.35.1708624617484; Thu, 22
 Feb 2024 09:56:57 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240221092728.1281499-1-davidgow@google.com> <20240221092728.1281499-3-davidgow@google.com>
 <20240221201008.ez5tu7xvkedtln3o@google.com> <CABVgOSn+VxTb5TOmZd82HN04j_ZG9J2G-AoJmdxWG8QDh9xGxg@mail.gmail.com>
 <CAGS_qxoW0v0eM646zLu=SWL1O5UUp5k08SZsQO51gCDx_LnhcQ@mail.gmail.com>
In-Reply-To: <CAGS_qxoW0v0eM646zLu=SWL1O5UUp5k08SZsQO51gCDx_LnhcQ@mail.gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Thu, 22 Feb 2024 09:56:40 -0800
X-Gmail-Original-Message-ID: <CAHk-=wiODww51Kz-TTWn0ka5T8oMtt0AfbO9t0U3iJqfLZO+8w@mail.gmail.com>
Message-ID: <CAHk-=wiODww51Kz-TTWn0ka5T8oMtt0AfbO9t0U3iJqfLZO+8w@mail.gmail.com>
Subject: Re: [PATCH 2/9] lib/cmdline: Fix an invalid format specifier in an
 assertion msg
To: Daniel Latypov <dlatypov@google.com>
Cc: David Gow <davidgow@google.com>, Justin Stitt <justinstitt@google.com>, 
	Shuah Khan <skhan@linuxfoundation.org>, Guenter Roeck <linux@roeck-us.net>, 
	Rae Moar <rmoar@google.com>, Matthew Auld <matthew.auld@intel.com>, 
	Arunpravin Paneer Selvam <arunpravin.paneerselvam@amd.com>, 
	=?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
	Kees Cook <keescook@chromium.org>, =?UTF-8?B?TWHDrXJhIENhbmFs?= <mcanal@igalia.com>, 
	Rodrigo Vivi <rodrigo.vivi@intel.com>, Matthew Brost <matthew.brost@intel.com>, 
	Willem de Bruijn <willemb@google.com>, Florian Westphal <fw@strlen.de>, Cassio Neri <cassio.neri@gmail.com>, 
	Javier Martinez Canillas <javierm@redhat.com>, Arthur Grillo <arthur.grillo@usp.br>, 
	Brendan Higgins <brendan.higgins@linux.dev>, Stephen Boyd <sboyd@kernel.org>, 
	David Airlie <airlied@gmail.com>, Maxime Ripard <mripard@kernel.org>, 
	"David S . Miller" <davem@davemloft.net>, dri-devel@lists.freedesktop.org, 
	linux-kernel@vger.kernel.org, intel-xe@lists.freedesktop.org, 
	linux-rtc@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	kunit-dev@googlegroups.com, linux-hardening@vger.kernel.org, 
	netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Thu, 22 Feb 2024 at 09:36, Daniel Latypov <dlatypov@google.com> wrote:
>
> Copying the line for context, it's about `p-r` where
>   p = memchr_inv(&r[1], 0, sizeof(r) - sizeof(r[0]));
> `p-r` should never be negative unless something has gone horribly
> horribly wrong.

Sure it would - if 'p' is NULL.

Of course, then a negative value wouldn't be helpful either, and in
this case that's what the EXPECT_PTR_EQ checking is testing in the
first place, so it's a non-issue.

IOW, in practice clearly the sign should simply not matter here.

I do think that the default case for pointer differences should be
that they are signed, because they *can* be.

Just because of that "default case", unless there's some actual reason
to use '%tu', I think '%td' should be seen as the normal case to use.

That said, just as a quick aside: be careful with pointer differences
in the kernel.

For this particular case, when we're talking about just 'char *', it's
not a big deal, but we've had code where people didn't think about
what it means to do a pointer difference in C, and how it can be often
unnecessarily expensive due to the implied "divide by the size of the
pointed object".

Sometimes it's actually worth writing the code in ways that avoids
pointer differences entirely (which might involve passing around
indexes instead of pointers).

                 Linus
