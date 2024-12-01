Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 412E34B5C1
	for <linux-hardening@vger.kernel.org>; Sun,  1 Dec 2024 20:32:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733085125; cv=none; b=dwf+OEAPpxnslkuFIqVWRNMy5upLA10bFXzvUVAKee5+3aoN4kx1jiaO4E/57afIn7XrIlz9e+19IHrkJQpd9klBtD++P6J7Y9G6ou5sGCXbg+xZBaTDQwR2iWrHHT7wRVcnk1dKR+rYYGGyqgxch3Cn0vZd4vQLT71MYjyOFiQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733085125; c=relaxed/simple;
	bh=4xGNzN9Wp70Q9GgcCs1b92wuOYHLnPfSc5E75h7FS04=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=m9cO+cqFwcQQY1D5EntkVdPRMHeiF7nbZTjJVnJM+iGuxGzj1NEH33xL0MqRhWzipTc124Sdvw4hON+0yVLAKB8vL/OSLgZFdLfLWBzhNrGtjXoc2WbdO1eor5G5kCQQfmGRbeyFKZK4zjl7emZ1pTwFpurqZZg3vjtySLT+yn4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=cNX9Ezas; arc=none smtp.client-ip=209.85.167.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="cNX9Ezas"
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-53df1e0641fso3897799e87.1
        for <linux-hardening@vger.kernel.org>; Sun, 01 Dec 2024 12:32:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1733085121; x=1733689921; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=N0PBRuUNrVMG3jWkuVgZ+alnShpvbiX+xpV3R8jGwMw=;
        b=cNX9EzasHvvdqthkcdX++NZyn5TsCCX0zE6dGT0Z/+sLBwW/aAhNp6HiFw8KjPRTyC
         gMD0UQRsxbaquvx9cN9I7dz8xlU998gnctPigNm5itN4c6f0vWnyR5Qvz9ofM+sHoAoq
         VEHTlvcIDP8qYKs6nNd7/+qaYb0SYwsLENxJQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733085121; x=1733689921;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=N0PBRuUNrVMG3jWkuVgZ+alnShpvbiX+xpV3R8jGwMw=;
        b=GuIxIEqGqDwxUxuIp+7F8u/5zFvqGwRUzik4j6e5uS1s67ZyEO41rr00M7khr4yEza
         oiu8BheWY3BWlm7/WCnK46lAr2IYZHsB9ldN/3aWV+b17F75rZ0PntXfcTOivRk5/xUL
         YNNGBe7c2hgL01FYhlkenZ4jYsSOPYqwmsN8nKIvaJ42JFWxTy0GGJoOAnBB43F3dMwb
         Rq7Kliwhxqc/IaCXmpz+ZpMx1ywREJ2EZTocp9Lgfx5aISit2wmgiMIHYYgu6YOE4VRA
         MommPrOedK/lAVEhVF65l40jgMbaEb/YKYkQ5e2sNZqtwAh1IL1du45aaocqI2JRkeMx
         Mqtw==
X-Forwarded-Encrypted: i=1; AJvYcCVKWz5/hKPt6lgyfJzBRhRL1iqxNSI0L9txWbjUtGxGJDmaGUSp9dFkCo7sMGccSQsMzFVPo9Vn6KdH//upbcQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzSIE8HkP5Mqg+8dIlrxcsOhUVduVlfzRzwKkLS6/yJ/Sk7HmjZ
	Qldlyn893YH0i1UfgTZ5cNwAgeTdnj0V7ZFxedV5NNUSvOzgM4EbEWMI50F9L0gJGM4KtuHFtPG
	ntUAdvw==
X-Gm-Gg: ASbGncu+HIAtZh58fDCxdg0ofxyUptgfkO823yOBr0LZxFN9H41s+IB2KFd9aYEqZnM
	FxLLDRGYXE5KQgPL3smftFk3eVP/Nbl1+1pp9N9UP5qGkMWIg0QTyxiY/xGibGCezWbNfxCZo0Q
	3sSvVskA42e1Ne3jPxbRULcW31xtL+62qQwj2bCuuyJzNJltqqwAmbmb9zYUlRo0YhU9ZvF0ST1
	JtoaMLQ3tc3ICsqd7GO921QzJJE2ND8VaqqkEzeUufN4pqutzpeNvsWMp8kJ3mR6uUedS97CTdw
	qnMdjRE9wNnPW2h+OCgzeYRRe8WZ
X-Google-Smtp-Source: AGHT+IG90LonlwHUJRITVt67D46yFkymp4Z/GoVFIU5FQAAPiVNXje4extrXBfucwK0Fz/IY89ZfaA==
X-Received: by 2002:a05:6512:b26:b0:53d:e4cc:f5f0 with SMTP id 2adb3069b0e04-53df00dd50emr9935146e87.33.1733085121099;
        Sun, 01 Dec 2024 12:32:01 -0800 (PST)
Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com. [209.85.208.178])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-53df6430ff6sm1201324e87.34.2024.12.01.12.31.58
        for <linux-hardening@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 01 Dec 2024 12:31:59 -0800 (PST)
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-2ffe28c12bdso30221551fa.1
        for <linux-hardening@vger.kernel.org>; Sun, 01 Dec 2024 12:31:58 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVuHZryBU18FN8S8x9CrZe6BTmQJwA/Ft7J68nXFoXFkrdslj+2mYJuKmoB08rVo7LphXNplab9rU3lNF/vDrg=@vger.kernel.org
X-Received: by 2002:a17:906:3090:b0:aa5:1585:ef33 with SMTP id
 a640c23a62f3a-aa580f1ae0emr1684398666b.23.1733084623092; Sun, 01 Dec 2024
 12:23:43 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241130044909.work.541-kees@kernel.org> <CAHk-=wjAmu9OBS--RwB+HQn4nhUku=7ECOnSRP8JG0oRU97-kA@mail.gmail.com>
In-Reply-To: <CAHk-=wjAmu9OBS--RwB+HQn4nhUku=7ECOnSRP8JG0oRU97-kA@mail.gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Sun, 1 Dec 2024 12:23:26 -0800
X-Gmail-Original-Message-ID: <CAHk-=wiGWbU-MpmrXnHdqey5kDkyXnPxQ-ZsGVGBkZQ5d5g0mw@mail.gmail.com>
Message-ID: <CAHk-=wiGWbU-MpmrXnHdqey5kDkyXnPxQ-ZsGVGBkZQ5d5g0mw@mail.gmail.com>
Subject: Re: [PATCH] exec: Make sure task->comm is always NUL-terminated
To: Kees Cook <kees@kernel.org>
Cc: Eric Biederman <ebiederm@xmission.com>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, linux-mm@kvack.org, 
	linux-fsdevel@vger.kernel.org, Ingo Molnar <mingo@redhat.com>, 
	Peter Zijlstra <peterz@infradead.org>, Juri Lelli <juri.lelli@redhat.com>, 
	Vincent Guittot <vincent.guittot@linaro.org>, Dietmar Eggemann <dietmar.eggemann@arm.com>, 
	Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>, 
	Valentin Schneider <vschneid@redhat.com>, Jens Axboe <axboe@kernel.dk>, 
	Pavel Begunkov <asml.silence@gmail.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Chen Yu <yu.c.chen@intel.com>, Shuah Khan <skhan@linuxfoundation.org>, 
	=?UTF-8?B?TWlja2HDq2wgU2FsYcO8bg==?= <mic@digikod.net>, 
	linux-kernel@vger.kernel.org, io-uring@vger.kernel.org, 
	linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Fri, 29 Nov 2024 at 23:15, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> And yes, we could make the word-at-a-time case also know about masking
> the last word, but it's kind of annoying and depends on byte ordering.

Actually, it turned out to be really trivial to do. It does depend on
byte order, but not in a very complex way.

Also, doing the memory accesses with READ_ONCE() might be good for
clarity, but it makes gcc have conniptions and makes the code
generation noticeably worse.

I'm not sure why, but gcc stops doing address generation in the memory
instruction for volatile accesses. I've seen that before, but
completely forgot about how odd the code generation becomes.

This actually generates quite good code - apart from the later
'memset()' by strscpy_pad().  Kind of sad, since the word-at-a-time
code by 'strscpy()' actually handles comm[] really well (the buffer is
a nice multiple of the word length), and extending it to padding would
be trivial.

The whole sized_strscpy_pad() macro is in fact all kinds of stupid. It does

        __wrote = sized_strscpy(__dst, __src, __count);
        if (__wrote >= 0 && __wrote < __count)

and that '__wrote' name is actively misleading, and the "__wrote <
__count" test is pointless.

The underlying sized_strscpy() function doesn't return how many
characters it wrote, it returns the length of the resulting string (or
error if it truncated it), so the return value is *always* smaller
than __count.

That's the whole point of the function, after all.

Oh well. I'll just commit my strscpy() improvement as a fix.

And I'll think about how to do the "pad" version better too. Just because.

                Linus
