Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 073FD38A71F
	for <linux-hardening@vger.kernel.org>; Wed, 14 Jan 2026 10:10:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768385441; cv=none; b=u0KbF/kCvyjhSZTrsFJL6+2u9UfPJr8SrYCOZKLJ9Q0UzAWHgfUsD68tSO1g86pkC+UUqsu4pQXtS2zWYwPG3zfgrTxY00u3BiMGtTCOPB2imfMy0Kt3BAuU4V7LpES6DbO6JoH1w4yhi1G+FTlMW9JofpmAu9UzogBb6UfSiMA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768385441; c=relaxed/simple;
	bh=37u8gz2/tHxNUHRPxYBUO17B44+GEZ+fwxYbHUNfsKs=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QtbMzC31zhDnHr1F2OcnZY1zzfhROB0of2TPklNQ/nw57NXPISAOWVPFnWh5N7FjpywGrNVpCv5SBVs836NqtDzRqzWTPNzYIrw0o5+nLPG+EmEkfY9+xVnKmTb1kJ9xkss75Z/Kbnm0QVlTXFuIPRHxKQhHzEcv5+YW6oNTYzI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=h8SDWhGJ; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h8SDWhGJ"
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-477619f8ae5so63212115e9.3
        for <linux-hardening@vger.kernel.org>; Wed, 14 Jan 2026 02:10:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768385436; x=1768990236; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iTsZYQGV8ojRPa+c6PpWwRS4BhgS2Cix60DMHYVltjQ=;
        b=h8SDWhGJlJKZHr75rEAxI14sQt1A+PkfRMww8rQzFBpOhG34kVC8hR+QMvkMOn24I+
         R2alifFRUjNRui2BKA/CGX2pKAVPrp/t0C6Z140OrMbtqTg+I9HbBi6ErCZpfpaw9Lzv
         e/b6KHHyXVt1HYY9RnQYB474SZC5B30Lw06zPlsz1GEwXWW89m7YwxYiGsLmznggVOg0
         G5/yAcZlUqXGurVarm/lwn+TcGSfsdKF5A96e108iFNhgSFKktC2F60O/uVShGgQxLXH
         kDymM8GM0NBbuBgYkwLDsL/U2SAKpTNIZZ6XPvsBDi8QKyymv5SCYJz7ppIOVcINOMai
         eKIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768385436; x=1768990236;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=iTsZYQGV8ojRPa+c6PpWwRS4BhgS2Cix60DMHYVltjQ=;
        b=ZiImoW6NFYSd9r2c9lucjR2EmQJGIeLC60kLCJ4IeCeZnhM0WP7oFyYTJ0ITLOZekR
         uhSZCVoCArySk5H6k3xT1TWNbL+EcK+LGF8LV0UAiIrtZKlaIwnwo+1+OU+Tr4cEAae0
         8R93Pc/+010xCpHtOJkOJoEmYpZag+LLbUK+I+IL4mTX11NUP7gnTzZ9T+Q0FIfcXvcZ
         oJ0qNGWhIzwB0zRP4qh+yOk9vd1OXsrEZfh60MKn0pTcw0iMGD46KkSIJSFZSKjeutRu
         sg6EieoyC8pvEJFfMQDwtBHL2H5g72m+9C7kB8g9JkVYA8ZCR5aBP5cY1h92PoMmZVwN
         anCA==
X-Forwarded-Encrypted: i=1; AJvYcCV+jL6LHvbFp9Dp2PRsEUI8EnkPVGQ8bpkSbvTBprV6xlcl9H7yE8yczcPddzcSf1GY8h7xVuZGjHR2ELUq/9c=@vger.kernel.org
X-Gm-Message-State: AOJu0YyDivK353N2Tbb17KC923ZpQc4vPLXAZ2lNslfD6rcpww7jfJKn
	eiQQ0l1pYBuMFPs9qEIeWAsjuOSQ7r8hYQr5nG4Z0/6qqmic6azmr1rW
X-Gm-Gg: AY/fxX4PkfxS0ZIgodp6wc6QU5Hlp9bUIhAJyNw4lonw894QkiDS8CGbE3vv/h/QHV5
	/DKncbp9awFyDYTMlhL8MS+qEsGoYGTCLysnmol/dEcwlmL1sDBoxtbOc6Q082g7b938x/P4n7U
	06pp8NBSYy78HJt1/xkWreKh26xpGEWaHGjIcNMbzTKoPROc9QeImwkvNokyDfsMFt7tj+Bbmem
	xcrHsBIsqfNY8AWBtWO+nhVFx70CyKpznI0qW3RmlljQPgFhxwVGDPIoH4U220GG0cfPAT7F+Ps
	BUz0gh8dI7sl7A6kUh1uVPBLfryTro2O5jpWNQjcBPoiZKu91KieI6vOO4+UuHNMRXJ3fLfRioj
	eK4GiqGIuqxioOe3Dqf2Rat5Sss5t2J9n3F/6EmqB5mXXLNG9GDHYEiZ6knA1DTvY63dNuc/wcM
	rfYBCi6So4r4SUaTHXjKin2mrYXeki8KbqqUaSf3EPhWvl3NBeOADB
X-Received: by 2002:a05:600c:1395:b0:47d:4fbe:e6d2 with SMTP id 5b1f17b1804b1-47ee334407fmr21631815e9.12.1768385435670;
        Wed, 14 Jan 2026 02:10:35 -0800 (PST)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47ee57fe917sm20267895e9.10.2026.01.14.02.10.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Jan 2026 02:10:35 -0800 (PST)
Date: Wed, 14 Jan 2026 10:10:34 +0000
From: David Laight <david.laight.linux@gmail.com>
To: Eric Biggers <ebiggers@kernel.org>
Cc: Feng Jiang <jiangfeng@kylinos.cn>, pjw@kernel.org, palmer@dabbelt.com,
 aou@eecs.berkeley.edu, alex@ghiti.fr, kees@kernel.org, andy@kernel.org,
 akpm@linux-foundation.org, martin.petersen@oracle.com, ardb@kernel.org,
 ajones@ventanamicro.com, conor.dooley@microchip.com,
 samuel.holland@sifive.com, linus.walleij@linaro.org, nathan@kernel.org,
 linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-hardening@vger.kernel.org
Subject: Re: [PATCH v2 01/14] lib/string: extract generic strlen() into
 __generic_strlen()
Message-ID: <20260114101034.7961852a@pumpkin>
In-Reply-To: <20260114000151.GB2178@quark>
References: <20260113082748.250916-1-jiangfeng@kylinos.cn>
	<20260113082748.250916-2-jiangfeng@kylinos.cn>
	<20260114000151.GB2178@quark>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 13 Jan 2026 16:01:51 -0800
Eric Biggers <ebiggers@kernel.org> wrote:

..
> A similar problem exists with the architecture-optimized CRC and crypto
> functions.  Historically, these subsystems exported both generic and
> architecture-optimized functions.
> 
> We've actually been moving away from that design to simplify things.
> For example, for CRC-32C there's now just the crc32c() function which
> delegates to the "best" CRC-32C implementation, with no direct access to
> the generic implementation of CRC-32C.
> 
> crc_kunit then just tests and benchmarks crc32c().  To check how the
> performance of crc32c() changes when its implementation changes (whether
> the change is the addition of an arch-optimized implementation or a
> change in an existing arch-optimized implementation), the developer just
> needs to run crc_kunit with two kernels, before and after.

For the mul_div tests I arranged that the test code could #include the
source for the generic implementation so it could run that as well as
the version compiled into the main kernel.

This involved wrapping the function in:
#if !defined(function) || defined(test_function)
type function(args)
...
}
#if !defined(function)
EXPORT_SYMBOL(function)
#endif
#endif

So the test code can use:
#define function generic_function
#define test_function
#include "function.c"

to get a private copy of the generic code.

	David
