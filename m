Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C3D127CB02
	for <linux-hardening@vger.kernel.org>; Wed, 25 Feb 2026 14:40:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772030426; cv=none; b=kzAzQQASHRXVu2lUejxypTdwegChQqV2yUKt3HackY2WV6h2hgEzte0hPCEf4nAc4Tku9z/BROA1EpHRItWNgmFd8OaVZ/NbiXkKRHoNULOfj8Wsv9Ejyb/ikdNQfCnnj47GSvmIy3E2US9EbZiS6tqJ3bRQ3imPAkzhm52s3JQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772030426; c=relaxed/simple;
	bh=666U2SeH2IF2l8bqfN3ChEOx/oJUibMvCH6ENY3ztPA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JqQDmZrEgrG+7nRiui2kyULZNCzitcJEJH2T/x0Cd5WS4QiRcNxYVh9De6LMOciZR0LLVOIfv8AkNXNwq6tb/jrIompBswZliu9UfYPciBwhnVMCbu5kniG/7PYd6k2+dI+GkgMaeXXfCyX3qbIkaiP3Y9vzXYFyn1jbvDUvDq0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QOUpS3mT; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QOUpS3mT"
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-483a233819aso67014165e9.3
        for <linux-hardening@vger.kernel.org>; Wed, 25 Feb 2026 06:40:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772030423; x=1772635223; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7q8RWpVROZPmxmIqcGCn3629mxXy+yPwavVRfw3rfAU=;
        b=QOUpS3mTecDe+Kw70tHOqPRUWapF32cfKstoDDBqnUiXfHHiL9yBtOmuMVBbANzsyl
         3RzAVQha2ZCDMfoUDM9aAxD6LG9aBT6WMsGKVwPESWDWlnymdKQjxS+JN2Ou9Wg24wCr
         CBX7QhzwXrqolmsjdfLel7JllYRJkDtrDoL409epV/kNhzLQwrHVUfwHseFbPVsZMrh0
         c3GmCCtLg2/c4KhOoNcHg6enyudKTShFWePUqW+Jt7dt6vfSxckcM2xiRoGL6wFytQgF
         xkv4pLWxFRERHZQp3haqoMmM/fAjdv7f6t//QlwGV0iaUdmSyzVWZxPM6hquTp03zrqf
         SLEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772030423; x=1772635223;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=7q8RWpVROZPmxmIqcGCn3629mxXy+yPwavVRfw3rfAU=;
        b=XyXga1K+3sqCARO0h8ghfak2ik8x3iokbvc1eqGG2z2lJEGiD2jdZQ4nOqbxRD6Xsi
         4Im0drSkA9JyoBcg5uPgAJbVqyRZZMlBh+QHcti6xyJd2UtVBlTUyKJlO/dfId03su2c
         y04n1YCBY+fbfY4YoAcZXIvF7KqFD1jZeAEXME7B+4Rrap9VXtFLrxVa0oGMDIsyH0x/
         IQfknKU1is1X10ejT6ksGON8xaij7ZCHZvcBcp2z5kV8W2Yf6IdiX7djZRS710c4hNcy
         2xu2VjezNXNSIHBbZ3G+miEyh6exZdPVkdwMOt9ufddWcb2hdN9LIufCjCpq1umNXb1R
         q4ZA==
X-Forwarded-Encrypted: i=1; AJvYcCUF/uwU85JHgoeLArm1q7pZZu7YrMaO1pOumyUlmi9TWUI18FIJDqehKk7PoTxyrTV6eLSnP3Ms9FSui/yGECE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxK+UYUafOJ5dTXw3MoQr8YD8egwss8rhE2YSqj0O8YQ+wOnM+Y
	Fe1x03M2jcmSnVjE35JFl3traBV7+WXs6/SHyHMcoIkWAwR2dsXZjcYD9dw0tXJ0
X-Gm-Gg: ATEYQzxOlBfXUNpd2dOZVJ19FHmqj8bePdDSfPk6VsSuFit2StHZRZdnjNX5JIvwipl
	cRLFfWUQqd3vnhSFbL/hHjUJXDCTu0zVDz0q9qD5hOXqMyTy66hiMmLcH0LSvHoDYMKQ4K+PosQ
	ibagHkE/4RZ++JxISylXg20c7AoR0U6fYN9t1VFyTGDb1tGEcl/RChEhKqCJvpEJa6AB0Xwodwa
	52IfxmjtTAx3Rwk3Qddo4AZvWIqEEVMfHj3eLBhqG0NVaz2zaxav7RbnJK4ZJRxIpE+a6cY86UP
	4Xte7wYOZO2WrrGAqMiC+yKlZwR1toCGQCTbkksLKTPu8zW73Sfua3FGsNKmO40Vy0eERJbHDGl
	CUOj/DCnZ8kFW/BFnjUay291HlhMw2pq+2OXNLPsmv60XD65TIzVq2zBcRtaQ68QfccGuNsk6Zg
	XZDHOdwCVPltoleu3YMK573fC2A972vqQ52pWD9UIJnmlwEXGzJoMsOIEfXGGScRr1
X-Received: by 2002:a05:600c:1d29:b0:477:a36f:1a57 with SMTP id 5b1f17b1804b1-483a95eb537mr244540785e9.3.1772030423078;
        Wed, 25 Feb 2026 06:40:23 -0800 (PST)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-483bfcb4f8bsm33408465e9.4.2026.02.25.06.40.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Feb 2026 06:40:22 -0800 (PST)
Date: Wed, 25 Feb 2026 14:40:21 +0000
From: David Laight <david.laight.linux@gmail.com>
To: Fuad Tabba <tabba@google.com>
Cc: Kees Cook <kees@kernel.org>, Andy Shevchenko <andy@kernel.org>, Andrew
 Morton <akpm@linux-foundation.org>, linux-hardening@vger.kernel.org,
 linux-kernel@vger.kernel.org, will@kernel.org
Subject: Re: [PATCH] lib/string: Fix UBSAN misaligned access in
 sized_strscpy
Message-ID: <20260225144021.61ba508e@pumpkin>
In-Reply-To: <CA+EHjTzCFAecmjkX5iYJ99GqCsJhT6T5ONCSFMDh=khNG6MzTA@mail.gmail.com>
References: <20260224170427.2296592-1-tabba@google.com>
	<202602241302.75B565883@keescook>
	<CA+EHjTzCFAecmjkX5iYJ99GqCsJhT6T5ONCSFMDh=khNG6MzTA@mail.gmail.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 25 Feb 2026 08:08:34 +0000
Fuad Tabba <tabba@google.com> wrote:

...
> I also noticed that the read path already expects and handles
> unaligned addresses. If you look at load_unaligned_zeropad() (called
> above the write), it explicitly loads an unaligned word and handles
> potential page-crossing faults. The write path lacked the equivalent
> put_unaligned() wrapper, leaving it exposed to UB.

Not really, the read side is doing reads that might go past the '\0'
that terminates the string.
If they are misaligned they can fault even though the string is
correctly terminated.
OTOH the write side must not write beyond the terminating '\0'
so the memory must always be there.

I didn't look at exactly how the 'word at a time' version terminates.
For strlen() doing it at all is pretty marginal for 32bit.
For strcpy() it may depend on whether the byte writes get merged
it the cpu's store buffer.
On 64bit you have to try quite hard to stop the compiler making
'a right pigs breakfast' of generating the constants; it is pretty
bad on x64-64, mips64 is a lot worse.
On LE with fast 'bit scan' you can quickly determine the number of
partial bytes - so they can be written without re-reading from
memory.

The actual problem with that version of strlen() is that it is
only faster for strings above (about and IIRC) 64 bytes long.
So in the kernel it is pretty much a complete waste of time.
The same is probably true for strscpy().

My guess is that the fastest code uses the 'unrolled once' loop:
	do {
		if ((dst[len] = src[len]) == 0)
			break;
		if ((dst[len + 1] = src[len + 1]) == 0) {
			len++;
			break;
		}
	} while ((len += 2) < lim);
(Provided it gets compiled reasonably).
Without the writes that was pretty much the best strlen() on the few cpu
I tried it on.

	David
