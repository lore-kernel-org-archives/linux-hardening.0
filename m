Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3409A38E5D4
	for <linux-hardening@vger.kernel.org>; Tue, 31 Mar 2026 18:36:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774982197; cv=none; b=lsemgtJxGDwoXmcIwbU8KpjqidMgpQootbUpU3NuIfswSnUzgiXkpHQM//RwVIrMSMuwqKm4Sc6JzfQlN13HuJHTOmubCZiGjTbkGbb+MY6THAL5EuJf9mQqcy4Urb7GVToOTqWhOMjuQSYSrKP2mRLbesVUQkayQuPcd6fpfFY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774982197; c=relaxed/simple;
	bh=DwEKjICeDkCjJOVrt0+LZu6p2US33YhraP63lKerfiE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kcgsCthI2cBIk+u0RuL94w6mG+qtFoL0g+VAqdzT8RM2wo5Apc+eV3L1+QU1Q42INgtjJwRi5fW/smgja8hYl7OzLuhk5AAlxdOyKppXAaGdodoXUJp9q+P8y3rBdiUZz09FuyKBdUsmv6zMaKooLEu4kC0GzaupnfhyJsqFCz8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=Dl3vov9+; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="Dl3vov9+"
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-66bf6aa4858so4167128a12.2
        for <linux-hardening@vger.kernel.org>; Tue, 31 Mar 2026 11:36:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1774982194; x=1775586994; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=6Jwbq+7LR0mSJFQk5uCurdhkOuVoq3zAKj7b6at5J18=;
        b=Dl3vov9+aM74fwdbt9zJObbuD4YDVht7BmGcbcqeoZWVpr3vh1hBuQagz18rvNEBjs
         RuzjULpKAo9F478+lY5De1dXHJkFC/mxeR003sfkLGGDPQIpPhPEG+LeH0/iaCPKwVo1
         NBZkNI2f+MUWGyplUrJrzIb7nOXgQs/ZQbMio=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774982194; x=1775586994;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6Jwbq+7LR0mSJFQk5uCurdhkOuVoq3zAKj7b6at5J18=;
        b=Z2KCEL5iFsLlpknmHnwGXzdaYIvSQUM+9p+S33KyjqIsvwcKpeCi9dul6qC1Hsj/5K
         3+0ybx7v6/xJ0m8XgxSSZKauOnKacr1eB3ZmA++uJB+LTWPwL4wErYKRtgAoO3fB7J3U
         raLMYbeEHcP0B6jj2Ju3tVb9jEG9iaBXjrI89wnjdAbmw62t+onkfL98STAJip/dMv7g
         CgMu5s/T+PF5qcHTEOPvHw6eLY1z4rDDd2twSgM1rn0oz/9bf2jGKIx7dD/KmzqfOqvs
         ont1ofgs+shs+SdkbxS0slJ23T+keb0CkbmjmUz2sZkswDXdBd9pkx7Q8TBRNlolS0af
         bavg==
X-Forwarded-Encrypted: i=1; AJvYcCVecOYcHYdYoiHd7KdLO48WUVtgDhO2dWHHSj9ajHIdZDtbu+3Y270e1xuOzip+hyX+57jwjEKHfhS06iUWPls=@vger.kernel.org
X-Gm-Message-State: AOJu0YyDiXw6g9MshADZ9j3NlWWXFsC5x1+9flj7ClBMehWd0RIWSbo6
	1Bhe+0Kv2W6/F/3+jIowROqNOcYiQTWIdyzCrvB6PPpTVwzyeYQEHJuKmp0JQmsGSJKFRZyvbRj
	uNOZUi415pg==
X-Gm-Gg: ATEYQzzd3tW3mBEsYAr3WmikGZPBu91Nyu11qZjkrZXRwG9orAbjmYHmaSbcW/mis00
	p81kIHkc7WvafaGxF9skzhqacncjE5nfTBAhb2sJV9e9sha1HSSiZBburxaq0WMU2ZfVfQuTH3W
	IczcfxW293Bq9Hv2L08bFelQGlPUJKciFBRsvkhSqDeEAzxDE3WcwvmmPzjtXAb6My+tgHPiuP3
	t9AFCevt52OSUUZIov/wlhIxZp9+Rut/fSTRD5ETjtArsxGPKzAHhZ/1vVuc7lwgiKly5Oh6ftH
	DD0bFfiAjokJPai3ZGasDZ/0fUzQb2SulA34aQSvfBfoLJHlq+QHGlIsEh4IhI0TH/EwfdJQ6JK
	5ffAWfk2SFG1q9wp5BzT/qJeUAUPckh5P4CCukzx8aCxuMIKZGJYb3q5UtEdYIGDWPXTmL5uwKv
	de04PuvugXe+MSfIWHjGg3dFMs1YuWg4n+g3hpIi31Xe30ljdBx1Ja+Po6lbnMVzOawqJ/wkSp
X-Received: by 2002:a05:6402:34d5:b0:66b:b34a:a016 with SMTP id 4fb4d7f45d1cf-66db0ae600bmr371089a12.18.1774982194396;
        Tue, 31 Mar 2026 11:36:34 -0700 (PDT)
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com. [209.85.218.42])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-66b72762eabsm4202106a12.4.2026.03.31.11.36.33
        for <linux-hardening@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 31 Mar 2026 11:36:33 -0700 (PDT)
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-b97e6e48b24so1016573066b.2
        for <linux-hardening@vger.kernel.org>; Tue, 31 Mar 2026 11:36:33 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXwWszI6uzfJg63KuRr7+bVNdjfI0Vwd6R9hPLPSucHq3uZeiz7Aav/wUIcmw0RJFpIMyYRHU20p6oYBOHFas8=@vger.kernel.org
X-Received: by 2002:a17:907:c789:b0:b97:d126:c007 with SMTP id
 a640c23a62f3a-b9c13b2c4a6mr48468766b.30.1774982192841; Tue, 31 Mar 2026
 11:36:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260331163716.work.696-kees@kernel.org> <20260331163725.2765789-5-kees@kernel.org>
 <CAHk-=wiJ6Q_qMHSe-hs+QvqKVZphvDZjvFP_gQLw1eaWimv8+w@mail.gmail.com>
 <CANiq72kL3rTKyDNYmD7wXiKCVJSfa1bnp2L8NShXU7OPmWjJ4w@mail.gmail.com>
 <CAHk-=whjwHjmB0_2yXsOjDa7Mi_yFSx3AMd3vGk5r70WocvZZg@mail.gmail.com> <202603311117.454F578@keescook>
In-Reply-To: <202603311117.454F578@keescook>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Tue, 31 Mar 2026 11:36:16 -0700
X-Gmail-Original-Message-ID: <CAHk-=wizJdr1qgJ9NKNjtbH=ugL3umA9JRW9ifrQaD+PpWCMuQ@mail.gmail.com>
X-Gm-Features: AQROBzBUflXPh777BM9crSo8MSIUJXluDEJ78_cVjfj9YSXDGlWfMakjxHiYmFw
Message-ID: <CAHk-=wizJdr1qgJ9NKNjtbH=ugL3umA9JRW9ifrQaD+PpWCMuQ@mail.gmail.com>
Subject: Re: [PATCH 5/5] types: Add standard __ob_trap and __ob_wrap scalar types
To: Kees Cook <kees@kernel.org>
Cc: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>, Peter Zijlstra <peterz@infradead.org>, 
	Justin Stitt <justinstitt@google.com>, Miguel Ojeda <ojeda@kernel.org>, 
	Nathan Chancellor <nathan@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, 
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Arnd Bergmann <arnd@arndb.de>, 
	Mark Rutland <mark.rutland@arm.com>, "Matthew Wilcox (Oracle)" <willy@infradead.org>, 
	Suren Baghdasaryan <surenb@google.com>, Thomas Gleixner <tglx@kernel.org>, Finn Thain <fthain@linux-m68k.org>, 
	Geert Uytterhoeven <geert+renesas@glider.be>, 
	=?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>, 
	llvm@lists.linux.dev, Marco Elver <elver@google.com>, Jonathan Corbet <corbet@lwn.net>, 
	Nicolas Schier <nsc@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	linux-kernel@vger.kernel.org, kasan-dev@googlegroups.com, 
	linux-hardening@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-kbuild@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 31 Mar 2026 at 11:32, Kees Cook <kees@kernel.org> wrote:
>
> If the code was written perfectly, then there's no problem.

My point is that BUG_ON() DOES NTO SOLVE THE PROBLEM.

> The point is to make a type that still works with C and all the associated
> APIs (e.g. format strings, native arithmetic, etc) without creating the
> mess that Jakub, Peter, and others (correctly) balked at around accessors
> for doing function based math.

Has anybody tried to suggest that "use a label" model?

Because I 100% agree that the current overflow handling is pure
garbage, and doesn't allow the code to be used in any kind of sane
code.

But I think that's solvable with the "branch out on error to be
handled elsewhere" model.

               Linus
