Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F714277C81
	for <linux-hardening@vger.kernel.org>; Sun, 19 Apr 2026 10:41:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776595282; cv=none; b=nrxha89BM2X0tuZ9qAEYuzXt/OzwRnBaJleFC7l7yEyHmEjoVaEPChNTiV0r0JzM7fOST+gKxi9zM0QmfZKr3PQOeeiOd4tb2Lo4Fx4bNRbG1TfM8R+SYixA/t1f7Ml7Z5+LEskwwNNzWsIOS7xYr0JFdh50/IZSiRecYE23TZA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776595282; c=relaxed/simple;
	bh=qS6jpmxPn0ciU4hAsvRwK00rIYLp0V6xTjVqSfHBlQU=;
	h=Date:From:To:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Z3M2FzzvcmKqQEcasMwYMtgZnIBlU0IP4U7DKxuyTxCKDXlim6bJ0hydfaYVfjmom9bQr22cShTqLmd1UrP8lLLopjw9+a6SIJDLoKu+r/p3ezaldZXXfaNjjV4YyhbH0wnDYWMeoyZd1zgAikWE+lWcZ877PrQTc9Ooppa9rHQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=rIepnjRy; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rIepnjRy"
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-48374014a77so26119565e9.3
        for <linux-hardening@vger.kernel.org>; Sun, 19 Apr 2026 03:41:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776595279; x=1777200079; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:to:from:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SewYd26qMSqsJ3PdBJdB1FU0Fv0N/RaIvQ2whLAWfGQ=;
        b=rIepnjRy33BSUCRbiBUu1zmJbkUmoIlmq7WoBhJCBKxwFvni3KBJCXAvZ+dmLwBEU/
         VFivMEldX+wkiLA87zEtLT4+/S0QK2tgLU/WG1McLa6OH1hQKqrJV9ZX6y4jdGO5bcjb
         KqoikEZ5QUQZlHucRP3RKCbztYjbNPDJ2I6oFpcBBpGcatxieTDFt0D69mEVk0cSYcOa
         5li4qH9L2n4Rx9g6v6hWI4tWSKgBLnDexSi0W0Tzj5Zx5Q+u/LUhQhFmHouWDZa3baYG
         XNDywxEoQsYIB6mdM8NT+T00L/fioc18rLAc2jrIBSDkOhwNz6bYpVz0B7FsGDbhD4tN
         l8YA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776595279; x=1777200079;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:to:from:date:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=SewYd26qMSqsJ3PdBJdB1FU0Fv0N/RaIvQ2whLAWfGQ=;
        b=RFYaJz5cInRwqb7XHnYMGImdJnecrdvB6dA5Yu8YTRg1VRXJjou3o3OayFRZ6yxZM0
         HT0GIWmwrFEoIovFJJXrNpC3gu7ZJl2RZSJ92Xkhk30ssSi1T9yKEXA9FnzPbY6QhVbi
         F1i+0aDMw8+c4ensiuZ5J2VqEfyinde2/XqHCrLBUtksDmjoT1ds9xCml4eKPqYBaRm7
         fR4AWybJRThoqmgN6iYhC7Fgo0O6rV7MFBEp3EuI6qhttHtnQHNABTg7U2U626jTE89d
         6+rwcMgDqQQn1uhbARsBJx0i6djitdnIAePS8BcTHNx/X/T38nYUksvVPpOvudrvv631
         RahA==
X-Forwarded-Encrypted: i=1; AFNElJ+M6M/NWHEAAaq6CRcPHoVhWTXYYab3fycg9ukQd5Z3Eor0t+xJH7ul1JjDeVKgV/unkIqYUkIvs/YYYT9CGAc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw68c8cRH3mqJRt0aluqc7m6EKSxcbhe+pwKZZp5jAFAdBjpLQz
	nlkLf7zGfsqk8e/qOWiVMjlQ507GZJ0W5dOnN5gkrBlGFhXG0DikehFd
X-Gm-Gg: AeBDiev1W6nP9ZMBgngTL8MK8L3km+2wtd+FOzjir1kmHm16U4M3UucXI5QwrNebA+k
	OMSF1tMG2fwI74pNjomA00MFEtWRdpHpbBAU4HsrwontamQ3Wzs6s8ytRFaLG4L8GSRIRckWTgy
	hFl7z5yOgbZyyEn/8BTSo+VQvuXqL1EkWTI0V8nW6mun/E337/79GRTh9jq3z+GDj38fL3NBb0I
	ROzkCX1Q0pesvTNmV87AX3M5XI6akY+dOHdDON1sVu73tzOUNaV/UY8coQkmTmkXHSGBtEI6282
	Zwa/8BEKC66QAOJM0p6weXLVyv16l6TBaZ65YDh3OsIOjcNO/yv7x1PvNW8/0lZNRNdn4+QIkwp
	La6jNehYmVaVoIanXJ9W9s249apozT6RCJuAZXFeIQ0gV6D5XoBO17bZLhbMSuRkxtYzB4qCrSC
	EOJ2wwT0F1qj40XNYoOG5cmWYBpZMRDtUgdu1h8akNSd2uXhise3ijf0fF+zlybKWzhFjA/fMDF
	OA=
X-Received: by 2002:a05:600d:10:b0:489:1b0c:8b43 with SMTP id 5b1f17b1804b1-4891b0c8c48mr4142765e9.1.1776595278820;
        Sun, 19 Apr 2026 03:41:18 -0700 (PDT)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43fe4cc2cacsm19934215f8f.13.2026.04.19.03.41.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Apr 2026 03:41:18 -0700 (PDT)
Date: Sun, 19 Apr 2026 11:41:17 +0100
From: David Laight <david.laight.linux@gmail.com>
To: Andrew Morton <akpm@linux-foundation.org>, Kees Cook <kees@kernel.org>,
 Andy Shevchenko <andy@kernel.org>, linux-kernel@vger.kernel.org,
 linux-hardening@vger.kernel.org, Linus Torvalds
 <torvalds@linux-foundation.org>
Subject: Re: [PATCH next] string: Optimise strlen()
Message-ID: <20260419114117.7cf50b2b@pumpkin>
In-Reply-To: <20260327195737.89537-1-david.laight.linux@gmail.com>
References: <20260327195737.89537-1-david.laight.linux@gmail.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 27 Mar 2026 19:57:37 +0000
david.laight.linux@gmail.com wrote:

> From: David Laight <david.laight.linux@gmail.com>
> 
> Unrolling the loop once significantly improves performance on some CPU.
> Userspace testing on a Zen-5 shows it runs at two bytes/clock rather than
> one byte/clock with only a marginal additional overhead.

I hate benchmarks.

I've finally got around to looking at this again (on x86-64).
I changed the order of the 'single byte' and 'two byte' tests and the
'two byte' loop slowed down massively - to pretty much the same speed
as the 'single byte' loop.
gcc had swapped over the two functions in the object file.
Swapping the order changed the alignment of the loop top between odd and
even multiples of 16 (this alignment is disabled in kernel to avoid bloat).
The loop in the 'two byte' code is 17 bytes, in the slow case the loop
top is aligned to an odd boundary so that the last byte is in a different
32 byte code block - which is presumably slow.
Changing the two 'cmpb $0, mem' to (say) 'cmpb %cl, mem' would reduce
the loop to 15 bytes and so wouldn't cross a 16 byte boundary.
(The 'single byte' loop doesn't cross a 16 byte boundary in the test program.)

The kernel build I just looked at has strlen() aligned to a 16 byte
boundary with the branch crossing the next 16 byte boundary.
So, if the same is true as in my test program, strlen() will run a
lot slower on 50% of kernel builds.
(And other cpu may have costs associated with the 16 byte boundary.)

Mostly this means that however hard you try you are guaranteed to
lose somewhere :-(

> 
> Using 'byte masking' is faster for longer strings - the break-even point
> is around 56 bytes on the same Zen-5 (there is much larger overhead, then
> it runs at 16 bytes in 3 clocks).
> But the majority of kernel calls won't be near that length.
> There will also be extra overhead for big-endian systems and those
> without a fast ffs().

I've had a further thought on that as well.

The 'byte masking' code is somewhat larger (112 rather than 32 or 48).
While the extra overhead is ~20 clocks, that is less than a 'branch
mispredict' penalty that the byte loop suffers every time the length
changes.
So for randomly changing lengths I'm beginning to think the 'byte mask'
version is better.

I ran the code on a Haswell a while back, the break even length was
also somewhat shorter (I'm remembering 32 bytes).

This all means the byte masking code may actually be sensible provided.
- LE or BE with byte swapping memory read.
- fast ffsl()
- 64bit

	David

