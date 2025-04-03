Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C7821993B1
	for <linux-hardening@vger.kernel.org>; Thu,  3 Apr 2025 16:48:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743698893; cv=none; b=pAD0HIqk6sB0IivQBDL0zeHFBVA9Zh8fxABv5InW5z7+c2knVVEVlQrp0EpxpdkO9wrGscJqGa2Mu5bV8EJnXfPRPbg1N0tGRZud2GQcgt3tjHma1FLb0PVl/9S4Aqrd8t43Y19fGEpKW3mUZAsvUwn9mAhDaj0WYs2Mz0xZn20=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743698893; c=relaxed/simple;
	bh=tOhPfAjNck/fuEMBPjbaUAakEcHx5aW4W6Mm4+qEg6o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jC6zsR3Pvlrc+2n5ymfLyovUzArWfLpGxdyxn85NLW7oFmjON/uAz04Sd8vEC7SkBKTI1I8C51Nkj2y8wkdNHElENF4z+DtlrAS/+T6XpzoUVdhk8Lv3X/LC61IWvwQDW+svohdaWRFrChaQk1Qp5wvQ+LDG70Sde/zZvcRdVP0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=erOxsGB9; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="erOxsGB9"
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-aaecf50578eso177636266b.2
        for <linux-hardening@vger.kernel.org>; Thu, 03 Apr 2025 09:48:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1743698889; x=1744303689; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=5IeBQ5EurNMkDT+fQ3nS/eQb46kO76MprunhtwmK6a4=;
        b=erOxsGB9Zw3CnAdxBSFISTDfRbZDpL+IlAqFd482TeYkiioLESeH++0YlsKL9+OTFc
         7PxrYVHOcuttOEAlh2JESMqACzv1QN5ZBQWmajzWE3bFgNJSTaVwrPRJi38I5eDZI7LE
         aXmOwqMewHdRx4gPw7wrhNurmh+7qk+WqLTw8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743698889; x=1744303689;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5IeBQ5EurNMkDT+fQ3nS/eQb46kO76MprunhtwmK6a4=;
        b=RqcWTgRZLiwPr6EyBHefpPhDWMv4PK75ciJ1ZBp5O3G8Z+t5ZroZffq4Fnj4+xLKTH
         X+Z8IB/HTV2PpLl8Ms0MnU79h88ZSKsIoxX2DSS2mOeuFUi7jo8MZMQHRfOjM42y+mmp
         koRhhum9LAH4XMUMDLpu9irHMYpGfwO8+yU8BdvyhuoQkfvsAJ7qcyRpXvPHm5EJyIFA
         lqKvcXQlyg9p8fdZEqRJ9f1AXV4J7l/HBZJtAfAm7bZAheKL1ucbcXWncMXOSzy39SeV
         a2RBlGpHnT/JDiRTKwlnlqjyOVVS/AuzGShTzbAc7FcNH1FlA6zlhzBWntUsGspC6xHO
         VdUA==
X-Forwarded-Encrypted: i=1; AJvYcCWEY//oR6M6aMFrxcWvFE3ak9Db/S4mjHqKDM5z4NLBWs/Rp0aREBjpmzskNlW91Mg37At+xlAte8pUPUU7xb8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw7ryP6fp60uzRFXug3fLcOhhbDJg2Cd6RPUBSws6J9QvTOJ61G
	z24cM7yfKgJSVyLwHrpQ4Nxfdw5u59blrwEeV9ei1eB2bRvInFDsm6rchqliCRw20nO9kkjbjOD
	QeSw=
X-Gm-Gg: ASbGncusRemSZmBda99OItC7zxBUV9nefFjEMkdSmGUiPwbRHefvUciQt2v7V5FST1D
	zFa38Dzf2HCuGGenNNPO7PFCUbOfsjsnHmuWxnUMrDJfGwhmVTLvl3IRw8DJAXbLPZw6jq/WGHr
	DrrI1REqU2zaaQkqER+TIIFhYDDQ1gcbYvv8HTJ6uO8mKYRUMyZDf5fceUzDnlfN7pCBAX+XQfC
	91eE/vuwoQHw70XIpYxsMdk+BymkwrNyKpV77jG3L5DlMlFQ+Wgpuq4Cj67Ghkrk3WUm+msoER+
	5XUEgFrreePymyTC2rz1KQlx0zV6epmhoez4GzZ+nWMXzbOKiFZ4VgUy1MAfoU9USHRQ+MihElT
	2Ej8UfYGhAlihZYeCPn8=
X-Google-Smtp-Source: AGHT+IHzps9r5VlDk7KJZmkHqP5Z1Qp0ZEgkJ3KYKVojThZ6g6Jhdph7gBPso8oXUyf6X9Rifak9nQ==
X-Received: by 2002:a17:907:7288:b0:abf:59e1:ad88 with SMTP id a640c23a62f3a-ac7d192200amr25636466b.29.1743698889351;
        Thu, 03 Apr 2025 09:48:09 -0700 (PDT)
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com. [209.85.218.50])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ac7bfee46fbsm117867066b.75.2025.04.03.09.48.08
        for <linux-hardening@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 03 Apr 2025 09:48:09 -0700 (PDT)
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-abec8b750ebso182270966b.0
        for <linux-hardening@vger.kernel.org>; Thu, 03 Apr 2025 09:48:08 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVIy0eFZdgYT+6HWMJpc/lszSbHGHmwDNn5ZvxW/QxQMbvhu5Apopnd8wiAuo8GJ6MPaOXoM14k0689A9X/Wr0=@vger.kernel.org
X-Received: by 2002:a17:907:3da3:b0:ac2:7a97:87fb with SMTP id
 a640c23a62f3a-ac7d199c916mr29245166b.33.1743698888537; Thu, 03 Apr 2025
 09:48:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAHk-=wg0wQb+CbUk2GY0CeVuTQvq67-oYR0nL8wGgySia3ce7g@mail.gmail.com>
 <Z-4jzImykAbHK2Gz@gondor.apana.org.au>
In-Reply-To: <Z-4jzImykAbHK2Gz@gondor.apana.org.au>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Thu, 3 Apr 2025 09:47:51 -0700
X-Gmail-Original-Message-ID: <CAHk-=whch6fMKH8FadOigqm_xrXfgWJyn=jz32GM6tUuM=nqvg@mail.gmail.com>
X-Gm-Features: ATxdqUEfHA6tq4tIjCHeUdY_kmVbwhB0XtABIt9Eygs4AQmADpeBZZvH_WAQpHA
Message-ID: <CAHk-=whch6fMKH8FadOigqm_xrXfgWJyn=jz32GM6tUuM=nqvg@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] tracing: ring-buffer: Have the ring buffer code do
 the vmap of physical memory
To: Herbert Xu <herbert@gondor.apana.org.au>
Cc: rostedt@goodmis.org, linux-kernel@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, mhiramat@kernel.org, mark.rutland@arm.com, 
	mathieu.desnoyers@efficios.com, akpm@linux-foundation.org, 
	vdonnefort@google.com, vbabka@suse.cz, rppt@kernel.org, kees@kernel.org, 
	tony.luck@intel.com, gpiccoli@igalia.com, linux-hardening@vger.kernel.org, 
	willy@infradead.org, Eric Biggers <ebiggers@kernel.org>, 
	Michael Ellerman <mpe@ellerman.id.au>
Content-Type: text/plain; charset="UTF-8"

On Wed, 2 Apr 2025 at 23:00, Herbert Xu <herbert@gondor.apana.org.au> wrote:
>
> There is no fallback implementation of flush_dcache_range for the
> architectures that don't need it.

Yeah, that literally looks like an oversight.

Probably because nobody needed it - or people didn't realize it was an
option and did the "loop over each page by hand" as in your example.

So yeah, I think it would be good to just expose flush_dcache_range()
as a dummy empty function in <asm-generic/cacheflush.h>, with the
usual "if the architecture defines this, that will override it" rule.

However, part of the problem is likely just unclear semantics. Because
the existing flush_cache_range() is about pure virtual caches and how
they need to be flushed before the TLB is flushed.

Also about D$ aliasing, but there isn't necessarily any TLB issues.

Honestly, I'd personally be perfectly fine saying "nobody sane cares,
and if your D$ isn't coherent, your perf mmap won't work".

                Linus
