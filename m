Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0ABEA371CFE
	for <linux-hardening@vger.kernel.org>; Thu,  2 Apr 2026 09:13:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775121236; cv=none; b=HOJSxBXUMYnpXzd+VHH6Nvz05CoxaBrlTE8P94kBpTc4/z4bpxBS7EsdgWMU9wMfd89nIAzGLsIYOOV9I4YiXszfTnPmxeh7afNYsaUWppZSYuauL7+MK9DdDTK9WszLkGw5AaD6fhMAKUguxw83lK+Ii0tUyyuyTiKwtl9yfKw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775121236; c=relaxed/simple;
	bh=Ue86H1KysRcjf2OINDQFXuIhBR4ESQnxLFwGpvhWUfw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YEQmJTvER2iIi7Hivyh+1Xb0u1Mdc0b5ZBSrEobH7COlcTze2YobW2WypehOdV6PgWfYcUBAp+YATMY44tsxjgHpEiOBMslG8kXf0FPSZjEkXWZb4at5v1vYs2MGCKRKKWdnefcJc9gZ7xt6N8zWEOiRtxKeNHHsMAiCvDpfmEU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=A5n06+QP; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A5n06+QP"
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-4887d4c6234so7989445e9.1
        for <linux-hardening@vger.kernel.org>; Thu, 02 Apr 2026 02:13:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775121231; x=1775726031; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Qr0tec9oGf/SBDgbf+2rD33HNBftwB6KGbVP3Dhy5ew=;
        b=A5n06+QPfUFaXxI/M3g/2ZIAVBIeHbAFIn9fGxXft8XKXsdeYwFLrT028wcoA2aKfh
         ERiSVNU05FnkjivehGxg+oTWbZUwi88KjkNlqZNBuzj0EzfXGeIMPkU9qUDcJO13u42n
         Qc+ToNX90wZatSr1UpDFyAIlOAWNRj5Iey84lKGAC8oPZnFP1/xhoIVKNw/RSkQZhGVC
         LkZhmMkiERw1w+Lqwvz5S1IMxAdtRlgS991nqazXXwMC0Q5FFDV55aopH6vHp5gcvO5d
         LLk4BkcUPU5LEV1MeB/R4F8tSYVJqHiT7Ti//bkOyEVfeVVHxdf12QoAkbSObQ/O7O7+
         P4iQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775121231; x=1775726031;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Qr0tec9oGf/SBDgbf+2rD33HNBftwB6KGbVP3Dhy5ew=;
        b=iIW7zA2nLuDRAINbkCjzinF+4OpLkYiO7kEwY1T8vPfVclL26vqLUh72tAGePf7QXb
         o6JAO8ISQSwcuwqfRshFisA386S5T7GfYTfa+Khh6DCOfbL+DFyJjfupaqYE9krJgPIC
         glNpj5Sh0woYGCnAfQhtnk3R7Q7taMXponZ0xvqku9SviRS/6VLZOZpJEp0b3WIVGPcp
         N6IH2GNv4BWaWiQfUxsBOhNVO4op1tKC5JQsaIyYOAGyksm41wL1+BFwICg46VVJW80c
         TivXK7djRUKbxB7P69N+4mfegd/ryloCQT2KzSh9XNl75W2UfLZ3HanM0iIuCNA3H4AG
         EgMA==
X-Forwarded-Encrypted: i=1; AJvYcCVow8ZlQvueEgsFBN5xjfyU1mLuJHyrA+AVxSr1dlBreyEOJiW6qO7hSFQa8x41TpJZhTR+24RJ8diBRjoOSBg=@vger.kernel.org
X-Gm-Message-State: AOJu0YySbyUk+MhgUQl1qP9j+lMGIQ2n0GEgss1ZZCX+aj41vYAL7250
	4UKx/4rKq8mPztE/es1Z/6VRMPLhhXqP4oHiIYQs/3CL3OSWQ/FkBcuDFN2xW3CO
X-Gm-Gg: ATEYQzykLkEUT9aHgbfRr59BQyRC4CJmFdr4SSQTkjw8MqWyIDbUNUyYhIBkS62Lrf7
	HEsLiDHImlO5VMb7PDDzN3TIiTUcJq6rv5Cm98XEtX1RaOYcvdhotkWJcVox8S1wL7zw/OarR8i
	igMcQjgQXxSsESuppPUkNqhvq5DLsNZnTZH0SVuguWTGsgaphFYwfyff4gF2xmndB/WWr73cOPH
	CLUXAe3CxhyQFodyOsHqiEuIDV3YKxT8sbPoftZEU19o9LtOZTQQPYW78Mn9i6DAoXQTun0y6M8
	8Ph8ykxSb4mlS04lf5/zq+6ALJKfD3IFwnVc2JdciUmTeTyX0/Aqm8PA0/LjKBJndHyxQdVnmQY
	Zh2EJI1BsJAUqxJTl1AQi+a1HrF/wzTV/ENV/0QdDTQ3Nn+gi0H+jT3ShY5cPImRBmSGNIwvz+a
	KZpdS2+8cVYHXjhd57/JSBDRyMhOVhmczDqeJMwk7btg1lqz7AiKYBG8rbqmIlzuwRs1VJTw0=
X-Received: by 2002:a05:600c:3514:b0:47e:e48b:506d with SMTP id 5b1f17b1804b1-4888358c8b3mr115476365e9.16.1775121230625;
        Thu, 02 Apr 2026 02:13:50 -0700 (PDT)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4887e952b0bsm162303495e9.12.2026.04.02.02.13.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Apr 2026 02:13:50 -0700 (PDT)
Date: Thu, 2 Apr 2026 10:13:48 +0100
From: David Laight <david.laight.linux@gmail.com>
To: Kees Cook <kees@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Justin Stitt
 <justinstitt@google.com>, Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
 Marco Elver <elver@google.com>, Andrey Konovalov <andreyknvl@gmail.com>,
 Andrey Ryabinin <ryabinin.a.a@gmail.com>, Jonathan Corbet <corbet@lwn.net>,
 Shuah Khan <skhan@linuxfoundation.org>, Miguel Ojeda <ojeda@kernel.org>,
 Nathan Chancellor <nathan@kernel.org>, kasan-dev@googlegroups.com,
 linux-doc@vger.kernel.org, llvm@lists.linux.dev, Linus Torvalds
 <torvalds@linux-foundation.org>, Nicolas Schier <nsc@kernel.org>, Arnd
 Bergmann <arnd@arndb.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org,
 linux-hardening@vger.kernel.org, linux-kbuild@vger.kernel.org
Subject: Re: [PATCH 3/5] compiler_attributes: Add overflow_behavior macros
 __ob_trap and __ob_wrap
Message-ID: <20260402101348.2f758a58@pumpkin>
In-Reply-To: <202604011313.AD471BC8@keescook>
References: <20260331163716.work.696-kees@kernel.org>
	<20260331163725.2765789-3-kees@kernel.org>
	<CANiq72mK9fz6Spmgt4js3hScqhqvZb2YP2T7tDfR0fHPDFWJ7g@mail.gmail.com>
	<CAFhGd8paijFboDVr8rJDjScob047q+zgYAs038WuVozOG0aYaQ@mail.gmail.com>
	<202603311249.30B44C66@keescook>
	<20260401090815.GV3738786@noisy.programming.kicks-ass.net>
	<202604011313.AD471BC8@keescook>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 1 Apr 2026 13:21:17 -0700
Kees Cook <kees@kernel.org> wrote:

> On Wed, Apr 01, 2026 at 11:08:15AM +0200, Peter Zijlstra wrote:
> > On Tue, Mar 31, 2026 at 12:52:10PM -0700, Kees Cook wrote:
> >   
> > > I think for this series, __ob_trap/__ob_wrap is what should be used.
> > > 
> > > And for other folks, the background here is that we originally wanted
> > > to use macros for "__trap" and "__wrap", but the powerpc C compiler
> > > (both Clang and GCC) have a builtin macro named "__trap" already. So
> > > I switched to just using the Clang-native type qualifier. We can use
> > > the attribute style too, but there was a lot of confusion during the
> > > Clang development phases where people kept forgetting this was a type
> > > qualifier, not an attribute (i.e. the attribute is an internal alias
> > > for the qualifier, and the qualifier is a new type).  
> > 
> > Since you mention qualifiers...
> > 
> > What is the result of __typeof_unqual__(int __ob_trap) ?  
> 
> Hmm, it seems like "const" doesn't get peeled off. That can be fixed, if
> that's needed?
> 
> 'typeof_unqual(int)' (aka 'int')
> 'typeof_unqual(__ob_trap int)' (aka '__ob_trap int')
> 'typeof_unqual(const int)' (aka 'int')
> 'typeof_unqual(__ob_trap const int)' (aka '__ob_trap const int')
> 
> -Kees
> 

Adding all the required cases to the _Generic() doesn't scale.

typeof_unqual() needs to die.
Just using 'auto a = b;' should remove const and volatile - but gcc is buggy.
There are some alternatives that work in many cases.
(It has all been discussed before.)
In most cases you can use 'auto a = (b) + 0'.
That does do integer promotions - but they happen as soon as 'a' is
used; so it pretty much doesn't change the type of value, just the
type of the variable.

	David

