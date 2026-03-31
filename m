Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65C26342524
	for <linux-hardening@vger.kernel.org>; Tue, 31 Mar 2026 17:18:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774977537; cv=none; b=q09i5EBAKf8yoLh6PuWP3IZzjkO+iN1gjtl7EmqGHi3VlLlAOTOcVBNQc4jguZW0SctSgdt+/oEirw9sm6I8QC+Sost0PjS6cFulHQkOZS74DXXu5xVYnFoLDM/WCcs5Mr8ohb4YU8lknrfVe2bzyo5DDuEqJc0rZGY4tDg1Cxc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774977537; c=relaxed/simple;
	bh=6ac9F4nte1Yiyo3mPmvL0jRUpnUVgMzCJ+yaIK6fLrw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gaUkP6mZBO7EYzAKTWcnq+ZZEAt72vLPf9ICRzJqk49m9ackmGK4WLzS7ROAmfiLQUmVO70jJlO7+DrN4h3GmzOOVNqG2QT9tDWHQsPVyL4CpyIfTjuuWn9gm3iWZjRCOsACQQtKQJ2W6RqxKMs1FPfhCu5m0JZEW5Ddjz3Xs0M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=GtScww03; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="GtScww03"
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-b97e6e48b24so1003452466b.2
        for <linux-hardening@vger.kernel.org>; Tue, 31 Mar 2026 10:18:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1774977534; x=1775582334; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=4f6EWJpSf2F8Fa/9meaVrgxvLf6j4eAN5dwsMo8lPrs=;
        b=GtScww03pFgORotIst0RaygJ4xUlaG+Fd772YnjSHdILzAqzaMC+b3kgchAp1igrUJ
         zWy4pmOpyujoFcxTFqjYluOLDVw9q9NW2cWCbaxIvLupraLFxsOVjESsR09HC3MryDGI
         gwxNYml8lTQKMnlC1JsOVEpH5INs1Y7gL/gOY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774977534; x=1775582334;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4f6EWJpSf2F8Fa/9meaVrgxvLf6j4eAN5dwsMo8lPrs=;
        b=TVO4sdDLGDI39TPjwag05+LnPZGwKNvmgoeKT6Z08pT6FdXZXVW+yrPSYkp5ILp3x+
         9CIe2uoBnrL0TChm31uwXPZ8DilNETC+IZaN8i0ZQqUmF+OwUcQlDwz92XPrM2ParoIf
         F7J4sfKbf0jQX4zKQlK5xvdN4p8Fq0lSGaFOAod03cVm7t2Zwhk1XnZm63ha4nQyiIQN
         wypqkSA2A+2m51Ea3TFZyMGDYEBvf2JKhUKDXmYfSMXOABDiJrWq5StwI5A1FP229WGz
         qYtOwLMXoPHSvA24qyVIXPaOYQdA3K6Gd3u8YF9oE+A+9cCZb9TPs/47c335pgKmu0tL
         qSLA==
X-Forwarded-Encrypted: i=1; AJvYcCUjIxlMy8gofR0R7KMIObEaXs9cap/QF0NenYTuNnsuaMNbd26dU4o1LxrAW2utui5g5i3X8GX+r8brTMF2gU0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwG9jpjGAxthptqcJuGZ1t91kwNB/zhz1SWEkW2LeBThJq0N5iA
	lTrSlrPenKtbHbybSiEZ45W6H2XYEB5jIeUZ7X191DB7/av6ua4afddNdrydhbGcBR6o5osgTXG
	Bn4nHPYJ5Hg==
X-Gm-Gg: ATEYQzzZzd1jxL6g1Av1W8TYZMFbMWT4Q+0WIqpF62DHlA3y7N94tTAiI2/eRvekCZw
	/XZi7H49nOz6xG76DniQyftj9kH82mOVghC6fs7llz0ygePIGpXICjzyfZNj6RNV9cc4lA9klV+
	yWUE7ZSMg6w1I35CJcqFbK1m4plJX555WZEmFNhfcgyMZiO5StIPyzD2jhyae3q6VBXheuWkMl2
	LSymFaMoksx2pU/dEaHQWcYk7BadEwdgAhR1bhRZ+j3cVTmBaczuDWtt/0AteQIdw+GBQMJF105
	U8HBuI/VTVZ9Dsh6F7qZGBu2NMY0osvsSBcE+9l16rQigHFyFvSXsFXLQDDoHtr6DeoN+eY0hnc
	lXPYHLNv2EGru5eKLkZoGv/5w8JGrESaWNe4hlXjDZ12+tsHDHptHK0icOl8DWM9h4gnWterfvb
	Cz7w091ySAHTd7a7lwNPREAFXSDtqMNsKHnRgWPtBsoJ2ma3rlTJqoc4d94pD96x8EDgnV0gcP
X-Received: by 2002:a17:906:8417:b0:b98:2496:1b0f with SMTP id a640c23a62f3a-b9c1391782emr31032366b.20.1774977534420;
        Tue, 31 Mar 2026 10:18:54 -0700 (PDT)
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com. [209.85.208.46])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b9b7b225193sm428506266b.57.2026.03.31.10.18.52
        for <linux-hardening@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 31 Mar 2026 10:18:53 -0700 (PDT)
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-66d24c6963bso595962a12.1
        for <linux-hardening@vger.kernel.org>; Tue, 31 Mar 2026 10:18:52 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXqh0hVdz6k23ZVaihbedaTN6oc89vfrggm9gocQ9T1eAP/QzWsVXT7O8/FHrxZXPUyIdsHJFkh6rW2dS+FkJ0=@vger.kernel.org
X-Received: by 2002:a05:6402:43cd:b0:66b:b46f:cbee with SMTP id
 4fb4d7f45d1cf-66dafead9ebmr239737a12.4.1774977532763; Tue, 31 Mar 2026
 10:18:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260331163716.work.696-kees@kernel.org> <20260331163725.2765789-3-kees@kernel.org>
 <CAHk-=wg=q7ptcMyUAqPGDbX_DKHivJVppc8bP0zpQqzOky_avA@mail.gmail.com>
In-Reply-To: <CAHk-=wg=q7ptcMyUAqPGDbX_DKHivJVppc8bP0zpQqzOky_avA@mail.gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Tue, 31 Mar 2026 10:18:35 -0700
X-Gmail-Original-Message-ID: <CAHk-=whfF-T-qrvL567DYD3ymqUhEXm_455CS=Xqvngjucd+Pg@mail.gmail.com>
X-Gm-Features: AQROBzDZPm_0YIwJ05O5Tx8cRSfkjvtMjCTPVCmkYZWKjM8JxXDJ7ksIZ8sr0Tg
Message-ID: <CAHk-=whfF-T-qrvL567DYD3ymqUhEXm_455CS=Xqvngjucd+Pg@mail.gmail.com>
Subject: Re: [PATCH 3/5] compiler_attributes: Add overflow_behavior macros
 __ob_trap and __ob_wrap
To: Kees Cook <kees@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Justin Stitt <justinstitt@google.com>, 
	Marco Elver <elver@google.com>, Andrey Konovalov <andreyknvl@gmail.com>, 
	Andrey Ryabinin <ryabinin.a.a@gmail.com>, Jonathan Corbet <corbet@lwn.net>, 
	Shuah Khan <skhan@linuxfoundation.org>, Miguel Ojeda <ojeda@kernel.org>, 
	Nathan Chancellor <nathan@kernel.org>, kasan-dev@googlegroups.com, linux-doc@vger.kernel.org, 
	llvm@lists.linux.dev, Nicolas Schier <nsc@kernel.org>, Arnd Bergmann <arnd@arndb.de>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Andrew Morton <akpm@linux-foundation.org>, 
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org, 
	linux-kbuild@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 31 Mar 2026 at 10:16, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> The only safe trapping behavior is something that has a clear an
> unambiguous and simple to use way to *HANDLE* it. Not just "mark it
> trapping".

Side note: this is the same kind of complete and utter idiocy that
made Rust people have allocators that abort when running out of
memory, because it's "safer" than returning NULL.

THAT KIND OF THINKING IS NOT ACCEPTABLE IN THE KERNEL.

I don't know why people keep doing this. Stop it.

                   Linus
