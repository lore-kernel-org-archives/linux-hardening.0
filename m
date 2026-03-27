Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B05C1306486
	for <linux-hardening@vger.kernel.org>; Fri, 27 Mar 2026 22:49:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774651773; cv=none; b=e2pV5IME1p+afsblKsvBBbErmhp8NFu4/GWNehUXCfwXdfk6PyiuSXhT+JPTeTyrsjJcGlw5QwnpkJv7FfYwx+Whl2asfRlyYbUaZRIev0JgjE72/w3Q/usVX6FUMKAsgCD2nAVTwiFEvxYs743XdxQCPwTyJl51PHpcphXO318=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774651773; c=relaxed/simple;
	bh=SLT6pPwsHaBokjVl8eIUXxkeSr54MoOnOtASW7ZtGXk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Gj2N8708C16HKcinV7aKknMmzubOoTh0JaLWjWFlSpHaKPcuq9fJfaaTA5tBPYoVwf3lkKJBMhruYq6IsmDm1tsQKBN7Qr4DHzlgQcBoEpGgWoEkGpFaubwh7xrBXPuRU1Sa4ac/Xp8Qw0OnvUa2UA8reMgTmQACaKhkeDm5mgU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=tKB/FG4n; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tKB/FG4n"
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-439b6d9c981so1666820f8f.1
        for <linux-hardening@vger.kernel.org>; Fri, 27 Mar 2026 15:49:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774651770; x=1775256570; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7JYL4utRBXc9JpGjI8ycBBhWcwQT8ai5I1Ne6KWWFZ4=;
        b=tKB/FG4n/fene3SVNxEZb3hZw+pPNKDcWpYB7kVZAnRBYNb3sPJr3hyWQsDrNCjdf0
         GXj/xysdMfBg2FNxZsDM1YnOQcmZfUtksv7sUpLyTGCGJlfvUHY7hai28h+H56jCrzZG
         MQHxCdr3r3BINCKhCloYWTD5f/nN5sZGzkjlNb73XPmj7zmtknxiErvhid/nZROJ18SZ
         /dE/nso8C5RJQyU1/E1oR6pnNgJBWqsg//TQ/8eeY9FrfTEYIceZIvdPr67g6bgru4ss
         uFE0LfTTqc8MBqxkERQY0lc3WS9KPfnxg9E+c6O96OntpFGkYIrvoyUmI98/kGQsZXtR
         xBcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774651770; x=1775256570;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=7JYL4utRBXc9JpGjI8ycBBhWcwQT8ai5I1Ne6KWWFZ4=;
        b=N0m4bCaxAVSDfjRHNFcYSUESlYnXkwp+W9LzaUnFZ/whfx0I5BrwvptAKYf05Z2k8J
         FYROjpSNXCj/gZagE8dnRJV5fkuzYNZKs7hWjM2vmXRMbyEz3pJOGCUS+nMa6ytJLwjd
         9up+zrX1oK24X0b2X9W0YP+TbE1o2LDCFY/Sg6BkKut7vgH2XVKbOes6rSx6LA0Yz8Jm
         KE7JK26zpWcqEvwwuukNYros98nNM32QF664FfvzySzNQGR9DvZIAPOevmeoG8KsJK43
         ZWocFYXxTR1OGO7dnCGAzzAqCPnyB4Kfc9rH5v1xfDLS77rNEQ/XbzCoNtSrZp9DDR4y
         BE4w==
X-Forwarded-Encrypted: i=1; AJvYcCVQd1oat4L2h7zOHpVrmNeiYcrWCsZoyQ16fWRdX4u0LGeYfw9XEENFrYWMYV1C0p3TQVev11Uys14B8PVQvZE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwF14M4UagQMPh6aAPvh5bycPsaC4QzrfKRY/+pZCj2WygroSZl
	Xa8WuxdRHyp2HcTzCrkHk2jOopBAg519jFEjxv1S2p1IyI8XHIWc6wV2
X-Gm-Gg: ATEYQzysY9eqJQjHGlt6AHwJBH3NvAWCDjLROqXX1LZPlebx0gzFFha9Zeba9+ygbnz
	znHQf2wAs4lFHAQClPi8mMxREs/fFBHLixINEChZfDFYVUVoRhheeNKUIClsiKSQkqn0i9sjsDS
	X8BWZU+qkIyjygYfRVHI0nrRskYPxEv6dGjHKxn1ZgIAuZmUjv7TnC6hHNqdgajuLe6MhmOPhKV
	d1WHhEijqSFAp1DMwPsxyOZYWrl7pq8Ka140rUU5IUhT5MWJHYy1tc4D/9Rf/+VCBomadFYdm9t
	mCeHyzXw2mZLM+XA3WjJa8bRD0zVSNQsaEVgys8cKDuEDOdJVV40k9ViJqf6o3k0U2Pf7mgFn/P
	Qgrjw1qT14ggyrJWkHvfZcWDZOzCbknhxxvVHibFlcn3LwMom5L5P9f1tFHRZ8e/xffA2/GuKCN
	A7ntSBWogdTSD79ebRoF3Lu8sklbgbtk1kjOki9ycxErF38fwGf4HWnFa83iMBaWfY
X-Received: by 2002:a05:6000:605:b0:439:bee4:8a93 with SMTP id ffacd0b85a97d-43b9eac532fmr6834514f8f.12.1774651769760;
        Fri, 27 Mar 2026 15:49:29 -0700 (PDT)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43cf21e265fsm1245770f8f.1.2026.03.27.15.49.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Mar 2026 15:49:29 -0700 (PDT)
Date: Fri, 27 Mar 2026 22:49:28 +0000
From: David Laight <david.laight.linux@gmail.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, Kees Cook <kees@kernel.org>,
 Andy Shevchenko <andy@kernel.org>, linux-kernel@vger.kernel.org,
 linux-hardening@vger.kernel.org
Subject: Re: [PATCH next] string: Optimise strlen()
Message-ID: <20260327224928.7c4220cb@pumpkin>
In-Reply-To: <CAHk-=wgADjjXEN_8ANbU_E94uxbQHW-3v5p0-pwLOtTvL+0Wrw@mail.gmail.com>
References: <20260327195737.89537-1-david.laight.linux@gmail.com>
	<CAHk-=wgADjjXEN_8ANbU_E94uxbQHW-3v5p0-pwLOtTvL+0Wrw@mail.gmail.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 27 Mar 2026 13:37:29 -0700
Linus Torvalds <torvalds@linux-foundation.org> wrote:

> On Fri, 27 Mar 2026 at 12:57, <david.laight.linux@gmail.com> wrote:
> >
> > Using 'byte masking' is faster for longer strings - the break-even point
> > is around 56 bytes on the same Zen-5 (there is much larger overhead, then
> > it runs at 16 bytes in 3 clocks).  
> 
> What byte masking approach did you actually use?

This is the code I was testing.
It does aligned accesses - I did measure it without the alignment
code, made little/no difference.

The OPTIMIZER_HIDE_VAR() is needed to stop gcc generating different
64bit constants and to make it generate the constant in a sane way
(especially on architectures with only 16bit immediates).

size_t strlen_longs(const char *s)
{       
        unsigned int off = (unsigned long)s % sizeof (long);
        const unsigned long *p = (void *)(s - off);
        unsigned long ones = 0x01010101ul;
        unsigned long val;
        unsigned long mask;
        int first = 1;
                
        OPTIMIZER_HIDE_VAR(ones);
        ones |= ones << 16 << 16;
     
        mask = (~0ul >> 8) >> 8 * (sizeof (long) - 1 - off);

// I've just realised that might be better as:
//	mask = ones >> 1 + 8 * (sizeof (long) - 1 - off);
// which has the right properties and stops the compiler generating
// 0x00ffffffffffffff

        val = *p | mask;        
                
        do {    
                if (!first)
                        val = *++p;
                first = 0;
                mask = (val - ones) & ~val & (ones << 7);
        } while (!mask);

        off = (__builtin_ffsl(mask) - 1)/8;
        
        return (const char *)p + off - s;
}

That loop is the one that compiled best, ISTR it has a 'spare'
register move in it ('first' gets optimised out).

On many BE systems doing a byteswapping memory read may be best.

> We have 'lib/strnlen_user.c', which is actually the only strlen() in
> the kernel that I've really ever seen in profiles (it shows up for
> execve() with lots of arguments).
> 
> That has tons of extra overhead due to the whole user access setup,
> but the core loop should be pretty good with that has_zero() thing.

I've not measured strnlen(), but it wouldn't surprise me if argv[]
processing wouldn't be faster with something like the strlen() in this
patch.
After all arguments are usually relatively short.

If you were going to use the above then both 'ones' and 'ones << 7'
need so be calculated once and kept in registers.

> I do agree that we shouldn't use 'rep scas'. It goes back to the
> *very* original linux kernel sources, though, and I've never seen it
> in profiles because very few things in the kernel actually use strings
> a lot.

True, and most are short.
strscpy() is next on the list...

And the arm64 strlen() has special code to optimise crossing page boundaries.
God knows how slow it is on your typical 10 character string.

	David

> 
>                Linus

