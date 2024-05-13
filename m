Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB44225755
	for <linux-hardening@vger.kernel.org>; Mon, 13 May 2024 18:34:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715625263; cv=none; b=jK+uRrAe7WQlEeq72BDrsSuW18Oh13XidpquIK3oE3MaeWHr/3ulRHdkBbrD9pL3AtWmaeAEwS73zT/qim2Q7fNgPgJi+JHufolMk11NOMEynY55WewGgDSJiU975VgPeAR/MOucD6P0lwCYarlBQPULirBpUsocy4B/plcfCt4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715625263; c=relaxed/simple;
	bh=LMpgS9YUb5fP274F97/qNj06fpYzBLVeI1R6c6nW9QM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GvGD9wkjUKcgHnP/vcftfw236pskHaUeGZBAHWHlLuPad4mo2rYYugHEKZYjegASQukGKj0wd3euNRJqVaeLKWOcuIU/RUF6M784N2PtNIyL5Bk/6NYJRj3mDFYcqrNmHyvtmXJGakRxbGCYhqWThRpQW8QH0RaPIAO2nouSLuk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=IRZbdAg5; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="IRZbdAg5"
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-1edf506b216so31656935ad.2
        for <linux-hardening@vger.kernel.org>; Mon, 13 May 2024 11:34:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1715625261; x=1716230061; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=h++n7Qlyg3sgT4EiaSRCnOzzYyK0B8BDWAHRP3/F3N0=;
        b=IRZbdAg5Fjfq1LlzW2OU3qJQiaF0Y36cLpUw+oWEwGb1ZbDoU98E6N8oHl/2rzWCHk
         0J1HOQmi4/qvXT4+9oLUQs4sUJ2KF7lmn65JzzrEUIB/BXbV/B7gvwACHU3Oyso/lcv/
         FGQOa0cTZ0i3NV+ABmzUpys6SdplIP6k+ErvY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715625261; x=1716230061;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=h++n7Qlyg3sgT4EiaSRCnOzzYyK0B8BDWAHRP3/F3N0=;
        b=kAh80c+MtW7xZn6FIr+BSfI1hM1B6fPRt7C7ecqcpDWURFoFYyuq44V1ClO+xo2BKv
         ChylT6Fn1+R19tn3ZJevZ31+C8fVG7hxpg7crlEZJ9jGCAjcfmcPuqgBkYbHAMXwLeuA
         vdT6ydEvQtqsy0GAxS1fjlK9/YAnqcB75ZQHvrwScEwvWQSkBo58PpLWqKwGpEW3KbLG
         uw5Hww6SLGvqb+TGcOriHinyq2nT2HokYhoODKs9FRGxP76mZIa2aWmSd/HrJenjkS9g
         yxpPd3znrBTQ8cs8qoyWYby4LKKkyb9VP6P0CuGlSKoBmtiCONnv8jwhJfJJkMpoXhnj
         xmhA==
X-Forwarded-Encrypted: i=1; AJvYcCXJMY+0rCxPdXkhHMn0jIsdMcw+Y4YUOgHRkTs0usruWgpw3h4IZ1rDcUPL39EJarW4ULzajzujsvy29fMGPuMsSmeDaDsoea7RdN+16Lyv
X-Gm-Message-State: AOJu0YyrO2nQdvTgUctKueqCHzoyj0U30w5qA1kcoPtbhfLmPxgD5UBz
	rUVucKWLvnpeKJuloERWhtv5XgBbtoJQTheFc/BGHXZa1VGTS4k50HYJjFrEEA==
X-Google-Smtp-Source: AGHT+IHCc1iDoDY8y7cN3McKpzD8GoP+zaGEka3xojOMmbdy8UwKg3X31LKvQDdXyzyN7fH2gRjLEA==
X-Received: by 2002:a17:902:dac6:b0:1e0:b62a:c0a2 with SMTP id d9443c01a7336-1ef441613edmr122093915ad.51.1715625261157;
        Mon, 13 May 2024 11:34:21 -0700 (PDT)
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1ef0c13908bsm82642315ad.265.2024.05.13.11.34.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 May 2024 11:34:20 -0700 (PDT)
Date: Mon, 13 May 2024 11:34:20 -0700
From: Kees Cook <keescook@chromium.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Martin Uecker <uecker@tugraz.at>, Justin Stitt <justinstitt@google.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Mark Rutland <mark.rutland@arm.com>,
	linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org,
	llvm@lists.linux.dev
Subject: Re: [RFC] Mitigating unexpected arithmetic overflow
Message-ID: <202405131047.A3861EC13@keescook>
References: <202404291502.612E0A10@keescook>
 <CAHk-=wi5YPwWA8f5RAf_Hi8iL0NhGJeL6MN6UFWwRMY8L6UDvQ@mail.gmail.com>
 <202405081144.D5FCC44A@keescook>
 <CAHk-=wjeiGb1UxCy6Q8aif50C=wWDX9Pgp+WbZYrO72+B1f_QA@mail.gmail.com>
 <202405081354.B0A8194B3C@keescook>
 <CAHk-=wgoE5EkH+sQwi4KhRhCZizUxwZAnC=+9RbZcw7g6016LQ@mail.gmail.com>
 <59f731ab619673afec4956fce6832a1cd5324fb8.camel@tugraz.at>
 <CAHk-=wjERv03yFU7-RUuqX1y89DYHcpdsuu++ako2nR41-EjYg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wjERv03yFU7-RUuqX1y89DYHcpdsuu++ako2nR41-EjYg@mail.gmail.com>

On Sun, May 12, 2024 at 09:09:08AM -0700, Linus Torvalds wrote:
>         unsigned char *p;
>         u32 val;
> 
>         p[0] = val;
>         p[1] = val >> 8;
>         p[2] = val >> 16;
>         p[3] = val >> 24;
> 
> kind of code is both traditional and correct, but obviously drops bits
> very much intentionally on each of those assignments.

The good news here is that the integer implicit truncation sanitizers
are already split between "signed" and "unsigned". So the 2 cases of
exploitable flaws mentioned earlier:

	u8 num_elems;
	...
	num_elems++;		/* int promotion stored back to u8 */

and

	int size;
	u16 read_size;
	...
	read_size = size;	/* large int stored to u16 */

are both confusions across signed/unsigned types, which the signed
sanitizer would catch. The signed sanitizer would entirely ignore
the quoted example at the top: everything is unsigned and no int
promotion is happening.

So, I think we can start with just the "signed integer implicit
truncation" sanitizer. The compiler will still need to deal with the
issues I outlined in [1], where I think we need some consideration
specifically on how to handle things like this (that have a
smaller-than-int size and trip the sanitizer due to int promotion):

u8 checksum(const u8 *buf)
{
	u8 sum = 0;

	for (int i = 0; i < 4; i++)
		sum += buf[i];		/* int promotion */
	return sum;
}

We want "sum" to wrap. We could avoid the "implicit" truncation by
explicitly truncating with something eye-bleedingly horrible like:

		sum = (u8)(sum + buf[i]);

Adding a wrapper for the calculation could work but repeats "sum", and
needs to be explicitly typed, making it just as unfriendly:

		sum = truncate(u8, sum + buf[i]);

Part of the work I'd done in preparation for all this was making the
verbosely named wrapping_assign_add() helper which handles all the
types by examining the arguments and avoids repeating the destination
argument. So this would become:

		wrapping_assign_add(sum, buf[i]);

Still not as clean as "+=", but at least more readable than the
alternatives and leaves no question about wrapping intent.

-Kees

[1] https://lore.kernel.org/lkml/202405081949.0565810E46@keescook/

-- 
Kees Cook
