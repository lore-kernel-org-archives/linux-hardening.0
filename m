Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C59A674E11
	for <linux-hardening@vger.kernel.org>; Thu,  9 May 2024 18:39:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715279965; cv=none; b=kDkyfZwdb2JdQVkBAOtYWjXweKsIU7ZZhBNTOj3LNyHITJ6OSQ7qQXO38KX4KXZUmQMgSHqqIfP2aRDAKNYsOalEoqFKjMiFkW+X96kmCmJpkFFGx1ljF6inNz3coFi3YULR7YINpRCt9ZDjZR/Kob197ZgE7qCE0OMLFKg6JbY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715279965; c=relaxed/simple;
	bh=eJ9IVERHhky971S0DcjHHKpGh5uHfCRuKvsYihoB6wA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=N0WrVE3g4DDyD/zsuea3b0RgxjePDLwQVrfV5Eo8TK+QizVivxuBBA3SkHMe31L0D1WIckeul8zdvWnSsJyygLzsPGmRb4O66Vmxw5KJYLXEiiQPmXyQpvf4Ugn6vFliNW7cLkBkTr86ywXwHPmWR980N5LAO0Jou6m8WeClE8I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=adTeBkAR; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="adTeBkAR"
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-a59ce1e8609so403015166b.0
        for <linux-hardening@vger.kernel.org>; Thu, 09 May 2024 11:39:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1715279962; x=1715884762; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=fqOAT+gv91pKFh1YCYnEhtgE7NzT8BCjrBwFy+U+dzg=;
        b=adTeBkARsSZ8vrx3Vyx4gqT32PUH0y3/Cu0hZ/rADfmbLwfYUxtZLfakmVAlaHRCLu
         K5RChHRpa7IocyFLXGra2qQ66uJe/9nH/+Mge9Qq1XP9cQX/6JwkfGj5VtYzi3rq/vnt
         XYdSx4XWSfRBYBQTv+uhN/LkV0H5UJXcuSkY4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715279962; x=1715884762;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fqOAT+gv91pKFh1YCYnEhtgE7NzT8BCjrBwFy+U+dzg=;
        b=f/9hEuCrS+LlINLsoQKRB9tsJjA0Ag/t/BrO8/Y8y1wtrzIo2i6TMRc2HdN0diHYKW
         VKvZ2cYnVVGYlT9k94pqW9GLZtYNjZzbg2Ey0vSf5tiZyXTBSbRc1EW5y9K1XDJkiqoL
         vsxrbrgnhNehCY5IaIXpWtQP12tAlhhcVRbLvQeWG99hPZ6mVDDxQECiuivLqOUr03QF
         lbQMrLBeAGsZl3F/7GfZ7B/S3UN1UDyq37MzVd4TLINrTqyRhngvLdqVUmSB8KQKuow2
         PamSfQA8mOGb8r+GfB7U9i+OduhpOp1w5UdWeCfW4adORKSzTSGZYaYW0h//QibU422g
         1VWg==
X-Forwarded-Encrypted: i=1; AJvYcCUUbgHBNNIGP+txqugookq+jT9AZ122KPtrp9o46BRCjcEBRwBGEcBpC0xijyye9sbGjhj1Z99ep528mpPtDc5sbSFlpHdAaCfNKFTNhf0F
X-Gm-Message-State: AOJu0Ywj7qkQF4RC3lue66mVodYZVzE2V4pXDm5QKa7To9quRxgCZ3to
	YnhRxV1IVZj3pZYKK2ZOtF3kbqDfK241k/5rH3F/zxSkhGnl9wxi0T0Y4He7TFlr+S0SESrO43H
	2KBfGGg==
X-Google-Smtp-Source: AGHT+IGQmBbtXD+DuYoF6lciQ7pk1lrybjAyc52Cr7x4p1Gn7Gpbzc7MO8ls749qIHySiibXDTzRVA==
X-Received: by 2002:a17:906:a452:b0:a59:a1b1:2978 with SMTP id a640c23a62f3a-a5a2d1de441mr43364166b.20.1715279961750;
        Thu, 09 May 2024 11:39:21 -0700 (PDT)
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com. [209.85.218.54])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a5a17b1804esm100790066b.223.2024.05.09.11.39.21
        for <linux-hardening@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 May 2024 11:39:21 -0700 (PDT)
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-a59ce1e8609so403011666b.0
        for <linux-hardening@vger.kernel.org>; Thu, 09 May 2024 11:39:21 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVXme/2Ju97mVt7+rbcSUq8ieV6+RrmU1z+j7/b9biAc1FhdBodLzWjuBIkvjdvzf3UeB/VPgRHfOPD57rmnf2QgC6HvqGRH83dXWkOOg6S
X-Received: by 2002:a17:906:410b:b0:a59:ad76:b371 with SMTP id
 a640c23a62f3a-a5a2d292a8amr45358966b.26.1715279960933; Thu, 09 May 2024
 11:39:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <202404291502.612E0A10@keescook> <CAHk-=wi5YPwWA8f5RAf_Hi8iL0NhGJeL6MN6UFWwRMY8L6UDvQ@mail.gmail.com>
 <202405081144.D5FCC44A@keescook> <CAHk-=wjeiGb1UxCy6Q8aif50C=wWDX9Pgp+WbZYrO72+B1f_QA@mail.gmail.com>
 <202405081354.B0A8194B3C@keescook> <CAHk-=wgoE5EkH+sQwi4KhRhCZizUxwZAnC=+9RbZcw7g6016LQ@mail.gmail.com>
 <202405081949.0565810E46@keescook> <20240509140854.GF3620298@mit.edu>
 <CAHk-=wgKyP2ffZPa6aKYtytzzFibiNVN5MS=D2cn7_UGCECKdw@mail.gmail.com>
 <20240509175417.GR2118490@ZenIV> <CAHk-=wgXm15gZHvt8waSFhXS9yZTfvMV95xyvNtPc6FSEA_rvA@mail.gmail.com>
In-Reply-To: <CAHk-=wgXm15gZHvt8waSFhXS9yZTfvMV95xyvNtPc6FSEA_rvA@mail.gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Thu, 9 May 2024 11:39:04 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgBprh=8Us-MtwH9sVNELZK2hdOkFn3EoauwecYgtXOCQ@mail.gmail.com>
Message-ID: <CAHk-=wgBprh=8Us-MtwH9sVNELZK2hdOkFn3EoauwecYgtXOCQ@mail.gmail.com>
Subject: Re: [RFC] Mitigating unexpected arithmetic overflow
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: "Theodore Ts'o" <tytso@mit.edu>, Kees Cook <keescook@chromium.org>, 
	Justin Stitt <justinstitt@google.com>, Peter Zijlstra <peterz@infradead.org>, 
	Mark Rutland <mark.rutland@arm.com>, linux-hardening@vger.kernel.org, 
	linux-kernel@vger.kernel.org, llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

On Thu, 9 May 2024 at 11:08, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
>  Any half-way decent compiler will end up optimizing away the shifts
> and adds for the high bits because they see the assignment to
> 'all_bits'. There's no point in generating high bits that just get
> thrown away.

.. it might also actually be a good idea *IF* we were to have some
kind of "implicit cast drops bits" warning, in that the compiler for
that case wouldn't remove the upper bits calculation, but would
trigger a warning if they are non-zero.

So there are actually potential advantages to just always apparently
doing the full 64-bit arithmetic.

Without debug warnings, it's a no-op that the compiler will just skip.
And with some hypothetical debug flag, it would be a "you are now
losing the high bits of the time value when assigning the result to a
limited 32-bit time_t" warning.

             Linus
