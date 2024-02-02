Received: from mail-ot1-f52.google.com (mail-ot1-f52.google.com [209.85.210.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EAC583CCF
	for <linux-hardening@vger.kernel.org>; Fri,  2 Feb 2024 10:41:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706870519; cv=none; b=f9D074wk1xNzLwiZGCZy7QRqOSSM6Ri/i8SxHjH7NX+jan9ke9GnuZBUK2PIphgbWUFgwGJbFv2hK0xVU/kFmHxkbGUfWZ53iFB/YEhEJ5KaTn+4/6PrcLlcukdBSjHyrwN9w6C/W0TBwgrhspBvQSIfOsRGQzaEGIFlFy1OiH4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706870519; c=relaxed/simple;
	bh=yMB99VXpUpL4JIlzPigdgZ92go77Y6AQyL1YrMA2+mg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pK410lGvKRQtofmYHp62geGkSdwfaN5n5cLmS9Kc2lLNdA9ykkkHzCaECIKoqgqDbtfBkz6CrrzNyDDqS6DUQdjiqtKWFOWtRjVj/2h5m1lPEGqu5u9nqB19bTHiYngVTfe/24oGUmr0fQ/Tae0MN3XvyLmYS3TOB2M9+vkeVog=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=LePJTtpr; arc=none smtp.client-ip=209.85.210.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="LePJTtpr"
Received: by mail-ot1-f52.google.com with SMTP id 46e09a7af769-6e14b858785so1131348a34.0
        for <linux-hardening@vger.kernel.org>; Fri, 02 Feb 2024 02:41:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1706870516; x=1707475316; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=GtKF1JcH99Kg94k7kIgM/vz1+rYKyXQvL//a4MKJWpg=;
        b=LePJTtpr4uE4GJtSc5A2Z/5x3NTx6UORojPCCP8NfW4oznML7RqeSVbCMA665GnQbU
         LvMkqc+NT8HqzqpILX/OMje7ZGoQP+CrOvZZDv0IROqej5rx/ZOBH56pH27xeRjwrDpi
         tUlTWDCbyQiUq8vhMSNSSRmDeRa04XJDeDg9I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706870516; x=1707475316;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GtKF1JcH99Kg94k7kIgM/vz1+rYKyXQvL//a4MKJWpg=;
        b=uARBVmqB4MU6RcRQHLGnXNHuLzkqKNCGiJVhRuZVpwbPhOflbnhxfZbeQsteQ5P2yE
         OYmoFyR4k5vO/btSpjo/Q3I8c80kbkpYEsACLD6sf4T9g084jY9KWw0w/Xn9fUzEXUss
         nCXQUQlAGC3llARdg5GjTCUNiG1Fao5hRmoeHs4rwWZpMjlT9xTzAMabEkAkxkraL6lv
         ugvk72InP0hEbPfbvyZp3jCw0k+z7YdcV3/jac/7bdqAU9nESnX8XiNQP2eax3q0Us95
         x7mA3M2fsFy9lMZ9clgMAOQk0jTmhKdIERC8fYG1VUxzUK2Cb65XPkUYl86CmZj3ifDw
         oolg==
X-Gm-Message-State: AOJu0YznK68rrwZ7jszf1jJmf2G8AtWwyVAnpgjJbdSnMDpd0pRh2oMS
	fUejDIpFBTxNV4d6x7t5Px5IJU1G3s7R+VU9z9X4ygUYSZ9Sg2ZlBzc9D/26Tg==
X-Google-Smtp-Source: AGHT+IHdnQT+y2UI8yIqSfiqP3w+VuqFutmV/hoZqs/esycYc5feNeSSMgGvTOQiAv7kPqdQTHg5+w==
X-Received: by 2002:a05:6358:782:b0:178:8d3e:950c with SMTP id n2-20020a056358078200b001788d3e950cmr5729785rwj.20.1706870516692;
        Fri, 02 Feb 2024 02:41:56 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCUcGzIJg5LfmBudAHVKOlEckAQwPprdhCb3x0x5pnqeElCi7g0hV2Xt8z3l2kIywkULVbS4iSwzv+f1S+E2lULk9bqHDWsF/CPkNjo19YVn6waxdyf/alJtULRme+Z1WChLH3WoOCKGPOldKETc
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id it20-20020a056a00459400b006dddc5e3433sm1326606pfb.147.2024.02.02.02.41.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Feb 2024 02:41:56 -0800 (PST)
Date: Fri, 2 Feb 2024 02:41:55 -0800
From: Kees Cook <keescook@chromium.org>
To: Marco Elver <elver@google.com>
Cc: kernel test robot <lkp@intel.com>, linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: Re: [PATCH] ubsan: Silence W=1 warnings in self-test
Message-ID: <202402020239.1EEA467@keescook>
References: <20240202094550.work.205-kees@kernel.org>
 <CANpmjNMCBvdM7Ni+vWCQwtJbbVskOdjSA+gjhgh6R3dKRqjXnA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANpmjNMCBvdM7Ni+vWCQwtJbbVskOdjSA+gjhgh6R3dKRqjXnA@mail.gmail.com>

On Fri, Feb 02, 2024 at 10:57:11AM +0100, Marco Elver wrote:
> On Fri, 2 Feb 2024 at 10:46, Kees Cook <keescook@chromium.org> wrote:
> >
> > Silence a handful of W=1 warnings in the UBSan selftest, which set
> > variables without using them. For example:
> >
> >    lib/test_ubsan.c:101:6: warning: variable 'val1' set but not used [-Wunused-but-set-variable]
> >      101 |         int val1 = 10;
> >          |             ^
> 
> This is the shift_out_of_bounds test? It looks like the neg and wrap
> variables are volatile but the written-to variables aren't.
> Technically the compiler just has to emit the reads to neg and wrap,
> and can entirely omit the writes to val1 and val2.
> 
> Does making it volatile fix the warning?

It does for some, but not all:

../lib/test_ubsan.c: In function 'test_ubsan_out_of_bounds':
../lib/test_ubsan.c:115:22: warning: variable 'arr' set but not used [-Wunused-but-set-variable]
  115 |         volatile int arr[4];
      |                      ^~~
../lib/test_ubsan.c:114:23: warning: variable 'above' set but not used [-Wunused-but-set-variable]
  114 |         volatile char above[4] = { }; /* Protect surrounding memory. */
      |                       ^~~~~
../lib/test_ubsan.c: In function 'test_ubsan_load_invalid_value':
../lib/test_ubsan.c:137:44: warning: variable 'eptr' set but not used [-Wunused-but-set-variable]
  137 |         enum ubsan_test_enum eval, eval2, *eptr;
      |                                            ^~~~
../lib/test_ubsan.c:136:26: warning: variable 'ptr' set but not used [-Wunused-but-set-variable]
  136 |         bool val, val2, *ptr;
      |                          ^~~


-- 
Kees Cook
