Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32923132103
	for <linux-hardening@vger.kernel.org>; Sat, 30 Nov 2024 21:39:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733002747; cv=none; b=aTUIo03X16bbgrMznnBQWTjCT7r6KtQ8swLXot4NrlKzl+1o5+3qyc61KBB6H3ORvjBorgMl+9lx2Ttb4fr7BvRTNxUzLDPAUI1FN+faJJ1eB7UodjdH7LXTThgHw04YrsUg7JRLM6IXbQguhmJKKvl8Rfe6N7iEh0N+tNYBkw4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733002747; c=relaxed/simple;
	bh=QIh5LPdBUUadt5QzHZ7uB31Jw1WDhsvFhK956BLp8P8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CZtXra6ht/uyNwoDPac9YkCEcCQZ5EXtOH5H8DMah2Qxg/NTYae7f3ncV94s7wodA3EHZI5ogw4jDKD4ZZKw7a0xAFp1qkKe6mwnVSKIqQ74nwfOxiG4+ZE6OPeFiS6nXDaHdsieU53HqrTofnfsf2YPduPy2s8y/cbdVSYNoU8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=Rs6amgc5; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="Rs6amgc5"
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-a9ec267b879so436255066b.2
        for <linux-hardening@vger.kernel.org>; Sat, 30 Nov 2024 13:39:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1733002743; x=1733607543; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Pw67/dEHvgxdkhQ24l1tOBa/DcJdy1WA/fl+pLzPNUA=;
        b=Rs6amgc5gDdUww+n2XWgrpGlOFFiVgFrKd88UPbnQTBUVoOjtSG0dqKWbvtgSvERjL
         8sNoCczC5o+/qhLWCIFF9AsSJmygyfNqnK5MfUjAZU6+qd9U+F4Z7jVqrjfvm+YnNqXR
         23SZ58ZEjXTGcJXg0ca1yrqm0F/OTCKw77+pM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733002743; x=1733607543;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Pw67/dEHvgxdkhQ24l1tOBa/DcJdy1WA/fl+pLzPNUA=;
        b=NV+c+lYlGyIm/gYDclpB8CFO1l+aWDUTRF8Y2jGaoiCqo+7S3cGTvN0dAYHyASmxMY
         ncgYKRzc3YlUNBoADt296FEQtxapKJKUGWWe+NorI3TlrZx9T0I+ukEhBDvMutmPrN4/
         ybylHTYqQYFQjD/dfk9lpkK55KCR9HjlInW0wBYGMyXoTR5ddhSPReTIOmpQK93WdeRL
         BmnGg/t6QyTMu0G5Dtu3GYBEffzrAaxe5dJYHroi+L9g3+zC+u0ww+fyVk7KmDyk4Qgi
         j9YrLernlpmzF6rgHuCKq/P8Gg0EQqR2Qz2YZuu4PDco7Vebf3QWWGOrC9Omo/ZHdK6j
         r54w==
X-Forwarded-Encrypted: i=1; AJvYcCVJlECmwROhvQqxBpmcvdBdUtzWYzzPKF5LhyMKqJ+VuQathFOSNgLBT4cred7/N1jH0iC8kjo7piE6Xdz4ujw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxj2GCTXqfQMFsX+marChaQpGPvAMBwshlBpU9NiqOOxzRe1Lnz
	LWrYUes9okhz0BM9mjjNNfgH8aKTq2QkzClKFLea2WsT+VK30oSKMqHxsQApiFUWhijb/MZHYgQ
	P6qBkJw==
X-Gm-Gg: ASbGnctTfRxoKjuLXVGTBOojy2H3CIYhSN3ftZ6G033mExalzKXw3n954PN3dvAeuUJ
	UI3R0c7+9bfbrGELSDIhUYAaZa2A3fz6CGgfV4poUMU2L05QUJWeXpWbYmUCzjlFOCjLTzO5c7w
	UatAuBenfwVzC5Qz80TBtZQWqwKmGvvNA+c9klPtcST5CjDDPQXDTHxQgwOQnpf8xlwIfu/tcdb
	CjfVEr4yZG5x5OSatqPvx+ec6Xl/9G4U4z7ToJSCQ98KIrdta7Rs0moU3AElKdfO30Q2mc6N1X4
	ooZsOnZJg/gG1zSBO2TejLJI
X-Google-Smtp-Source: AGHT+IFlc4uN6PVj77tV+8T/bkmgzfwX7ei7x1xV1VTGV1WKLo1sLhYjBxfqU8VftesmA1zhMZRQUw==
X-Received: by 2002:a17:906:3145:b0:aa5:1d68:1ec8 with SMTP id a640c23a62f3a-aa580eddd16mr1419176166b.7.1733002743296;
        Sat, 30 Nov 2024 13:39:03 -0800 (PST)
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com. [209.85.218.52])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aa5997fcf5bsm319563966b.84.2024.11.30.13.39.01
        for <linux-hardening@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 30 Nov 2024 13:39:02 -0800 (PST)
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-a9f1c590ecdso466747266b.1
        for <linux-hardening@vger.kernel.org>; Sat, 30 Nov 2024 13:39:01 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVNcdgf1I/CWQzwU2Z1iIU0FqE4d1L4+1srM43klJQThh05nSvt1xKR0KiUQ72LzBGk4AlhvP8nNMwZo1n/dII=@vger.kernel.org
X-Received: by 2002:a17:906:3090:b0:aa5:1585:ef33 with SMTP id
 a640c23a62f3a-aa580f1ae0emr1355585766b.23.1733002401515; Sat, 30 Nov 2024
 13:33:21 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241130044909.work.541-kees@kernel.org> <CAHk-=wjAmu9OBS--RwB+HQn4nhUku=7ECOnSRP8JG0oRU97-kA@mail.gmail.com>
 <202411301244.381F2B8D17@keescook>
In-Reply-To: <202411301244.381F2B8D17@keescook>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Sat, 30 Nov 2024 13:33:05 -0800
X-Gmail-Original-Message-ID: <CAHk-=wgSsP6w=wLeydMiZLjNwDaZrxyTx7MjFHo+BLXa+6YtVg@mail.gmail.com>
Message-ID: <CAHk-=wgSsP6w=wLeydMiZLjNwDaZrxyTx7MjFHo+BLXa+6YtVg@mail.gmail.com>
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

On Sat, 30 Nov 2024 at 13:05, Kees Cook <kees@kernel.org> wrote:
>
> Yeah, this just means it has greater potential to be garbled.

Garbled is fine. Id' just rather it be "consistently padded".

> This is fine, but it doesn't solve either an unstable source nor
> concurrent writers to dest.

Yeah, I guess concurrent writers will also cause possibly inconsistent padding.

Maybe we just don't care. As long as it's NUL-terminated, it's a
string. If somebody is messing with the kernel, they get to the
garbled string parts.

           Linus
