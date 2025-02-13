Received: from mail-oi1-f174.google.com (mail-oi1-f174.google.com [209.85.167.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C99B281346
	for <linux-hardening@vger.kernel.org>; Thu, 13 Feb 2025 14:20:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739456448; cv=none; b=r+NNG8PkANXzVnURulxhiRNug+WDoVMkiusWQpYyOXU+g8yj+630SA+4tAk/6qu0jwmI5QGijYFaNLuHbVAV66aTuL/ROV3Zs14Ey1p8oFC9VGthjnYn3ASmcVMODzKb33Oj7I6EYGEpvlBKqSfiVHa4AbyKqSI5LALLxj2aG/M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739456448; c=relaxed/simple;
	bh=W4UC5h0oxNGNf3Gcc3aP7t6L4iCexNLWYlMLrbpEbw4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fLxjwg23JwjQ/Ov1m+Bgecrg2QVkK+5v9BPUf3FWC2Whe8A629VPAcx4PJukcAyCtNv5+4s/I1v8cYkSAJrGUsbYrvwlmqzeaygGbyIZDVxCccwVusx03spRfb9uJ2MtprkiCktJhBlqgrj8b66lCb8XFoEo+PFboKlnFphXbFg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=Nk1bX0/t; arc=none smtp.client-ip=209.85.167.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Nk1bX0/t"
Received: by mail-oi1-f174.google.com with SMTP id 5614622812f47-3f20f9eef03so17599b6e.1
        for <linux-hardening@vger.kernel.org>; Thu, 13 Feb 2025 06:20:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1739456445; x=1740061245; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=W4UC5h0oxNGNf3Gcc3aP7t6L4iCexNLWYlMLrbpEbw4=;
        b=Nk1bX0/t+Wg49Sud9aF9L+2146eGOZuquDOs5M0/wQOW2ELLDgm8X5PcIkXjDU3GZ4
         cq+WlyvY0NGPdO+wztGfkzOcquMjsSB3Ipid9Y2dcQsQ/fDXgDsiHUk9G9sQYt897+Gp
         v8QGP8A1CMTYxrZHrO0oNSiyerKOi/i7DXlO0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739456445; x=1740061245;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=W4UC5h0oxNGNf3Gcc3aP7t6L4iCexNLWYlMLrbpEbw4=;
        b=PLquaPQpUMEA8O+wa0/aOxTeG2JZz3+KhQ3yMjJGNc3W61h/gl57vPLkH78iiF12Fv
         MSP4VFfLhPnePaREG3LaTmQo2uauNcVo8yp0yuWFaTNHVnnv6l5eW0ADxDBnB+q3LrU+
         jRrItY7TJeHPHUExW5jQW8yM3WDPyio6gW7omBxtkJ4m+zLzTWtDNmRmtzY94GVOCek3
         7L+FpWPu08nt7at96sRuvDvrgJJ7hk+/vsarDXOfNu1no9Ce/xsKf0YiOvuAeu4CTgdZ
         R0SlRMBCNqysCX3X2A3bKNh3abfHzGFjDz6WI/eodU9qaOH2BEIH+G4hZI1rFTnZ/caz
         xj8w==
X-Forwarded-Encrypted: i=1; AJvYcCWihS6jlzHGMPALwI03NoieQCBqlV+Oj/gAS//aRyxuJx6+t9Mc09X+F9UDpifG1oN5y2NpfeiykZpkPEB1Wmw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyy0U5RgCtaNkmiGfYsslOCa2n2bxRLykZk96Jn1wl9O9oociW+
	YVO83PWfV2xSBY9vIZvZkku+LKvEWNE1SepiQ/Q9OjzVBaA7PL0cNIatGTYzWy8iyRu0JgciAIT
	GntqFRh4eSNIsDkyGpbhTgIntyzAzAsgUry4q
X-Gm-Gg: ASbGncuqBfNJiDkKOMH2KEAmLpQ2H2T2y1D9BBJemxKcHsWpZ4k0IUwd5HqPiSm9c/g
	voI1p2DBuwD+/MdGmSvzkw0+mDNh/vawUwNmyRziTBccjAzhCx7WaYdC+79spLO2Z8QrBkq+n1z
	5feSdgMbWsmmnVBr5k8oneJtACr2YW+Q==
X-Google-Smtp-Source: AGHT+IGAXPpwFZ7DOEudMrOlVqjPC+LaHLP+X27Z9YtQOz9iiB2ORSQ7DxYPkmOMw4okkqdaC7PyOXVEXg9CiOpB7yg=
X-Received: by 2002:a05:6870:14cc:b0:29e:73f6:ee8b with SMTP id
 586e51a60fabf-2b8d68c8a25mr1609549fac.12.1739456445551; Thu, 13 Feb 2025
 06:20:45 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250212032155.1276806-1-jeffxu@google.com> <b114f48a-a485-4ebd-9278-6c62a1f33d9c@lucifer.local>
 <202502121401.B6EF2D4517@keescook>
In-Reply-To: <202502121401.B6EF2D4517@keescook>
From: Jeff Xu <jeffxu@chromium.org>
Date: Thu, 13 Feb 2025 06:20:33 -0800
X-Gm-Features: AWEUYZl-9kl58flpzB7gHde-CGvyUjvurrYBhAejrmr0ps8oWaWIhTMUJXeqP18
Message-ID: <CABi2SkVMzeerqeFcmGxVwB+uNeZDmRPF5Nd1oicUXJuAFnHB=g@mail.gmail.com>
Subject: Re: [RFC PATCH v5 0/7] mseal system mappings
To: Kees Cook <kees@kernel.org>
Cc: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, akpm@linux-foundation.org, jannh@google.com, 
	torvalds@linux-foundation.org, vbabka@suse.cz, Liam.Howlett@oracle.com, 
	adhemerval.zanella@linaro.org, oleg@redhat.com, avagin@gmail.com, 
	benjamin@sipsolutions.net, linux-kernel@vger.kernel.org, 
	linux-hardening@vger.kernel.org, linux-mm@kvack.org, jorgelo@chromium.org, 
	sroettger@google.com, hch@lst.de, ojeda@kernel.org, 
	thomas.weissschuh@linutronix.de, adobriyan@gmail.com, 
	johannes@sipsolutions.net, pedro.falcato@gmail.com, hca@linux.ibm.com, 
	willy@infradead.org, anna-maria@linutronix.de, mark.rutland@arm.com, 
	linus.walleij@linaro.org, Jason@zx2c4.com, deller@gmx.de, 
	rdunlap@infradead.org, davem@davemloft.net, peterx@redhat.com, 
	f.fainelli@gmail.com, gerg@kernel.org, dave.hansen@linux.intel.com, 
	mingo@kernel.org, ardb@kernel.org, mhocko@suse.com, 42.hyeyoo@gmail.com, 
	peterz@infradead.org, ardb@google.com, enh@google.com, rientjes@google.com, 
	groeck@chromium.org, mpe@ellerman.id.au, aleksandr.mikhalitsyn@canonical.com, 
	mike.rapoport@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 12, 2025 at 2:05=E2=80=AFPM Kees Cook <kees@kernel.org> wrote:
>
> > It'd be nice to update the documentation to have a list of 'known
> > problematic userland software with sealed VDSO' so we make people aware=
.
>
> I like this idea! Probably in mseal.rst, as the Kconfig help already
> points there.
>
Will update mseal.rst to include the above suggestion in the next version.

Thanks
-Jeff

> -Kees


>
> --
> Kees Cook
