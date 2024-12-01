Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 190F61D7E47
	for <linux-hardening@vger.kernel.org>; Sun,  1 Dec 2024 21:49:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733089792; cv=none; b=NgWQkc8/k7qV0EEVHg8YsMIbRMCuQPca6UF3vIrv+P/OsoyVk4t/2MZVPzWUhLlHU+4Zjhk4swQij0rEcGp/MHzjjtDkCfEMp1VuyislGWgb3FguoSIrSj1uVwemI31qaqNPemVwnpcMynEqoDdCxZLYa6Y1SEKVn4ktugPozEE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733089792; c=relaxed/simple;
	bh=xXJPQ6YbYgc+LsntidKKs/X461vEK6auxVARRMkPIzQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GSSObRdxILo2vBwMnL1UmPfxXsJtqspS823k8WhuIYNPaOEiTVA/I7sxL+zdxwopluxwr+9G/NeKYiu5Ydpeen60mXDkcpX5BtnPGhWKyeylwsCW9hmgETSoGL/h3ZLBEnGxrzLY3rVUOAwS8Eg0fDTbQF8HfVvsFy3tcWci8oo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=L39OeohB; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="L39OeohB"
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-7242f559a9fso3489046b3a.1
        for <linux-hardening@vger.kernel.org>; Sun, 01 Dec 2024 13:49:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1733089790; x=1733694590; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ckF5QGnSsa0BB01QMlPw18K2Y6z5eE1xBtBTmSkmOrU=;
        b=L39OeohBrATyQzBYGf4B7mSuB61Oo0AczOununI4eMr8/Gj9jeHZBzWs1oNGBjKx+D
         ua80OZzaYqPz6BU8mNGMuySjhC4CSBohfAdtGmF8UWCn6Fx5dcvmc+bBCT70E+WGLCiH
         s3YOJs2DPvrTgCpbJwonNarS8FcZs+FUgL8/7/tGI6PcdGBz2n8N91qpcJvT8Ef6dyKb
         X3Eb0AOls8Ht5mMSgJxNqf0s0sEmO/WqMknhI866IgFD9pXnVemKaTsqqQ+a2MBUAKcF
         wl6fiGw5DQJ95TvmeZFRRqjoNEncPdB4E3ODCFY8dDbwn0ueD0nmc0QhKOhkUJ5pN4LT
         z7LQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733089790; x=1733694590;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ckF5QGnSsa0BB01QMlPw18K2Y6z5eE1xBtBTmSkmOrU=;
        b=AJyHp7sQPinqVMv5hD2TJYmzOwrZtoguDqHkfTWUYIPwNv6h1loLVzKynEcn5qSHAI
         uAW6lA8nke8bn1RCXgmCrThUdUYV+8JCK2AWUQWz1puj+cfqmwkTcIZX2vcKjpAPBTD+
         AB4XN4el1GDuvqfs5M3OQZ6PWaBBGjcFPITMZhmsH+azip00q3fUSsJvt/rYt0Lmv55a
         0K8FxEK8WUNXxYgzZJAVPw4zKu6tC7+nfYYecZeUMZp/ahsz7n5rl9WSmfafCodWWqFk
         VDFyGdvKLMloNfm2Fxg6d5GyLoMbyzbAPZ7vfObgLvsJWmwp/dPy5HLLsSFIJTIK4CEQ
         qfVw==
X-Forwarded-Encrypted: i=1; AJvYcCV1z9p5soIDbIGHid9FMfXVv5+T4SAc08eTysa7jN9QbuUlXr4yYURcrlk3dq8l7gcmpVpbQiZfOuHeqV6SUMU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyxzrTzjYXtSB1QaSny0HR5sClidkGAp4x8AG7A4eW6h9EDqyyT
	2yceq0KshX4Ovk2EeeTnZ/I4NErP8wmONI9DnCqQvxqUBJRY6K5UeqHT0uuwAaM=
X-Gm-Gg: ASbGncuMwoArKK7ue9/9NiNdLRaTtkrL6oPKkouVgbwR4JY5dVW2VyKk3x0dFSzl6eT
	tyON34s+WlldMdP19Qrk2BvUUFlumh6YP0Q6BotO9JjSjyGDPChTO5xbSrQlY1Tz5XQekAOb8pp
	xztrldbGtv5Wcfs1Q+NqW63JPnWbQb3PTNOnEPRcQ3xxHq/fEIry8kE0ic0Uw2LCkML6iFk8ppn
	zIy9sqUpvNDNo6FVV8Lmqcvd7vl3lK2aIiTZuZdqSB7Iv8=
X-Google-Smtp-Source: AGHT+IEJ8i/d4RS5aNUgb0ZzcIBRhjMpR8RaWqdw3iTHbi813IFT7He4V5pwrlQ+TjGvCu78jA5zjQ==
X-Received: by 2002:a05:6a00:2381:b0:71e:5d1d:1aa2 with SMTP id d2e1a72fcca58-7253000347emr24970119b3a.7.1733089790310;
        Sun, 01 Dec 2024 13:49:50 -0800 (PST)
Received: from [192.168.1.150] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-725417725e9sm7069306b3a.80.2024.12.01.13.49.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 01 Dec 2024 13:49:49 -0800 (PST)
Message-ID: <be3a3bd5-0991-480e-8190-010faa5b4727@kernel.dk>
Date: Sun, 1 Dec 2024 14:49:47 -0700
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] exec: Make sure task->comm is always NUL-terminated
To: Kees Cook <kees@kernel.org>, Eric Biederman <ebiederm@xmission.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
 Alexander Viro <viro@zeniv.linux.org.uk>,
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
 linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
 Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
 Juri Lelli <juri.lelli@redhat.com>,
 Vincent Guittot <vincent.guittot@linaro.org>,
 Dietmar Eggemann <dietmar.eggemann@arm.com>,
 Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>,
 Mel Gorman <mgorman@suse.de>, Valentin Schneider <vschneid@redhat.com>,
 Pavel Begunkov <asml.silence@gmail.com>,
 Andrew Morton <akpm@linux-foundation.org>, Chen Yu <yu.c.chen@intel.com>,
 Shuah Khan <skhan@linuxfoundation.org>, =?UTF-8?Q?Micka=C3=ABl_Sala=C3=BCn?=
 <mic@digikod.net>, linux-kernel@vger.kernel.org, io-uring@vger.kernel.org,
 linux-hardening@vger.kernel.org
References: <20241130044909.work.541-kees@kernel.org>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20241130044909.work.541-kees@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/29/24 9:49 PM, Kees Cook wrote:
> Using strscpy() meant that the final character in task->comm may be
> non-NUL for a moment before the "string too long" truncation happens.
> 
> Instead of adding a new use of the ambiguous strncpy(), we'd want to
> use memtostr_pad() which enforces being able to check at compile time
> that sizes are sensible, but this requires being able to see string
> buffer lengths. Instead of trying to inline __set_task_comm() (which
> needs to call trace and perf functions), just open-code it. But to
> make sure we're always safe, add compile-time checking like we already
> do for get_task_comm().

In terms of the io_uring changes, both of those looks fine to me. Feel
free to bundle it with something else. If you're still changing things,
then I do prefer = { }; rather than no space...

-- 
Jens Axboe
