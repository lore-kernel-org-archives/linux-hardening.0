Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DD7A1B0F26;
	Sat, 11 Jan 2025 16:58:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736614730; cv=none; b=Uz0zsEKFNc8TmNuWjfcVTxYcTxPDr8SSqGRBDyQ2wquDs3zpR3Y502eYOZTdL+7t6tV8hHlPuoT6BXyfZuEm8AlpefTupNhUp+4mASAWW5KyOryJcpQgRcXljaJs7FLYxcKps/l6nq/RFbiCvdHwQ+Tkplg77Oo1LgpQN8/PiQw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736614730; c=relaxed/simple;
	bh=OUIi9F+TJRnFLryZrlChgH+XL0A567aTOShmQyBVaHg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UqaYXn/7lJ0HvFu96jfjTLXwU2MLZmdw48dGai06Pbip8pdHFtqRAlPsYsyKoAh49X/2MmtWaSB+7OcK2Ww3tOnCBIQC9qmDG8lDAjFbWb8QuEZ/NMyAsgCKd8EOFyykTVA8vy7LPu5yAFDCsuIH2NIJGy7IqWDsnrcS6USkFBE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=A39K7Q+t; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A39K7Q+t"
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-385de59c1a0so1528189f8f.2;
        Sat, 11 Jan 2025 08:58:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736614727; x=1737219527; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jUSRPHdzB/cOUjwwb3A27PIiwV4I4L9h3LIMwjYQ70g=;
        b=A39K7Q+t6gCVjKn6HbsYJyhpnZg0yc5bz7IR7PF+AziCgG72lMsJwE7KFgzNZSi6MV
         GPZvrsCHGZiQ0mMk+YBN7G79KTFjKkM8+/FZXvUq752PFqy8KPhJSoMKXZdeBkdBOt0+
         +JexoDW+C+PnYgPsRQJycO2pwkYBEmBPzmO0KacsheKFCw0ds4noFOwIbAVLIWErhRY2
         XbrdsXUJTJDGxmCQjCXjpkeckJGvKnWo2THP4xvP8jZtl6O/j9S/2xNZxwLSBQVygvKZ
         h9HzKbIciPppAmrzowosVYyS9uevNgpKeve5zTHaSTQPv6wgszh5Bc3537mz6VQKPQMx
         6dgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736614727; x=1737219527;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jUSRPHdzB/cOUjwwb3A27PIiwV4I4L9h3LIMwjYQ70g=;
        b=YaVUtYvtHDcP5CFY+PP6tKQvdaQ7BqfPjBlXErFnF5icDCuH0tA36nWpIu+bSu1XK9
         b11FVTAQfGWa035dCQ4xScl9lwCD6Gf81tBaV+DwF+yuxDgx+0dfqHy4Q6FAHi53Psj+
         mxmFpc3r/SeAH7KYhB6dWoTW3SbKbV0aSLpGCEjEqECWokL99GAPTi1O3v0AC7yJ5pRK
         j12cqeIHBmnj05IqSJFl4xosKlw5GqXQ9FelokvBiTDS/W6ZxyW3JKzLO83lbYbti59q
         RYR/OxVVBUX8sTh9bZf4nMX8nsgxn/OfgsR9SB7KJk/gpGYkaEI7x4kPLSJSfw3fyqZa
         8Blg==
X-Forwarded-Encrypted: i=1; AJvYcCXA/+s0+kCd8K8lBfB01ztt+090R5wzF69kiwW2z/TXXSvIQKUsXDeBtLsmOGsWsVO1UvWMhfYhFoPOxO1M@vger.kernel.org, AJvYcCXREpme6p3ZHpuBLQBHZhSjRrv/nNbrTEk/o8ftHG8OazcLpblPw3/ttMLTTTOl5Fxm4w9tjKaox14zqvtCmwI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yycan6O2Hsv4SGKvjs+JeaLzE6l9zHrGRTdDWZ0syQAkj5zPTpR
	5M5pElIOiX3aiDLRaLWIFqSfeW59Ims1MyRYxiXOWRYyvPOuGu+/Gmg4ug==
X-Gm-Gg: ASbGncsVStNs38S3uAWmd5yvAb4NSuWJO9CLc2uqga+9S01/XssZHZhwTvdhgGmyXCT
	Cpo3YB/A5lJNWdq9ZjiegloKgElZlkPhZQn9QP+q44QgwhK6cHuUyWomL7SrpQnDRn+RVAS3qHB
	j4vQh7YcSHnwLwyA3KQlAsYecOk3fXJDZC5VS6IA7zYg8lU1nzPSf3vBAAZ4xuLQQwzoWaOIOKB
	k9L4wSypxgqyxIA8/Z+jiSHYO8MBlDbk+hze9impIwy9w6o32RF+9RBrqSYWMrteE2ualvSvlN1
	by0c6bmVAzIISFDSpF0=
X-Google-Smtp-Source: AGHT+IHusHBn+G+Yu1cLeUYiEjTyAna7nOzbU+UumgpxXH7MRk6x3b4oahs1HW8+IObUWmb0XU4/qw==
X-Received: by 2002:a05:6000:1884:b0:385:ea2b:12cc with SMTP id ffacd0b85a97d-38a8730442fmr13918014f8f.13.1736614726620;
        Sat, 11 Jan 2025 08:58:46 -0800 (PST)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38a8e4b82ebsm7462898f8f.82.2025.01.11.08.58.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Jan 2025 08:58:46 -0800 (PST)
Date: Sat, 11 Jan 2025 16:58:44 +0000
From: David Laight <david.laight.linux@gmail.com>
To: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
Cc: Kees Cook <kees@kernel.org>, Nathan Chancellor <nathan@kernel.org>, Nick
 Desaulniers <ndesaulniers@google.com>, Bill Wendling <morbo@google.com>,
 Justin Stitt <justinstitt@google.com>, David Laight
 <david.laight@aculab.com>, linux-hardening@vger.kernel.org,
 linux-kernel@vger.kernel.org, llvm@lists.linux.dev
Subject: Re: [PATCH] fortify: turn strlen() into an inline function using
 __builtin_constant_p()
Message-ID: <20250111165844.6d95600f@pumpkin>
In-Reply-To: <CAMZ6RqJbinVpsGf6ADUtQTYPRRQN=D8Ne_n6pHtDUPXxED5ZvQ@mail.gmail.com>
References: <20250108-strlen_use_builtin_constant_p-v1-1-611b52e80a9f@wanadoo.fr>
	<202501081331.E4B6DF747@keescook>
	<CAMZ6RqJS5FwuBUdvVdXoZj6wZOJz8Nao4FzSzCK1VtbNF41sMw@mail.gmail.com>
	<CAMZ6RqJbinVpsGf6ADUtQTYPRRQN=D8Ne_n6pHtDUPXxED5ZvQ@mail.gmail.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 11 Jan 2025 23:40:41 +0900
Vincent Mailhol <mailhol.vincent@wanadoo.fr> wrote:

> On Thu. 9 Jan 2025 at 16:52, Vincent Mailhol <mailhol.vincent@wanadoo.fr> wrote:
...
> Actually, I did more investigation and it is working for some strange
> reasons. Whenever the argument of a function named strlen() is a
> compile time constant, the compiler (both GCC and clang) will replace
> it with the string length on the argument, even if strlen() is
> programmed to return something else:
> 
>   https://godbolt.org/z/nK4b3fnM7
> 
> So it is only working because the compiler uses its builtin strlen()
> instead of the function we provided.

It depends on whether -ffreestanding is set.
If not set gcc/clang assume a lot of the basic libc functions have their expected
behaviour.

	David
