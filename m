Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 844CD8BEE
	for <linux-hardening@vger.kernel.org>; Wed,  8 May 2024 17:53:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715190786; cv=none; b=obzle9VrJ7jE4bHEWP5u7gxOC37JDNcKMydkG7vv0CHeckCbbhygBNShJI07IhwzGre8QMXC2ctQwXqWTqETtXQhoPT0q3CJdKBFwHERw9Tmyax/68zrhfsAbZnB59pmkmFAe95NmHmeALFUICAU7CxUPZ4/YdOm00u2+7oFLd8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715190786; c=relaxed/simple;
	bh=8O4fYZMWhW1IHisxTbuBjvyMlQTTyIfPG8nknj8tOK8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GyNpGUmmnzHAnmV7cIgMYa9UcaU5S6kxBuKbzysPbaT7MKViw4G/XM1gTJSvkNuVk/Y38WeG+B/mKEK0AANCewMl6KGp6f8TJZqtt1FI9SO+UGXYIFb9TSSJrldV+es4j4yThJFmqLvUHqgT6X9DJkNMPlAWUlgs1ub+NSXD0B0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=Md+ZRopN; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="Md+ZRopN"
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-a59a0e4b773so1132475266b.2
        for <linux-hardening@vger.kernel.org>; Wed, 08 May 2024 10:53:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1715190783; x=1715795583; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=CDD6cSkxh18P1B/GILc0PBtmaYxZm1FGfsVGarC9pdM=;
        b=Md+ZRopNVIx0SsuPfGzTaF5YfH+NJQfYXWPelu76tOufw2LfyfRreY6Oz1Ui1Xq2cb
         pgrVx0pL1qFbv4FJiOp7/FI0OcP7UD70GQnEjwVmFRa6ghwDT4KRhHem7AX9B4/ML7Eq
         ka+lmoDDSzU82ktK4QpoZq5EqqGNfNOGMhdvM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715190783; x=1715795583;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CDD6cSkxh18P1B/GILc0PBtmaYxZm1FGfsVGarC9pdM=;
        b=koX/yrro19B6963g9YHIi6mjXlWxUZmQRG2BJkmk54Fl+6hTp1oRY31UuFSqO//g0G
         uR9/XSR1eogORwESwy5A0EwnCDhYUm2ygAyMNo/VJRUZ8zjKfw1fInK3TBeNawnltEJZ
         HeQw9cu+djM5BXIgQRb7I6NDnUH3eN1J6TlmhNsWUm28x3CF7S+s5iaa/4BBcRQwM3Q0
         KiiIRracUTvtlrr4gv/YC9nspZZtq5KGEAnDpOOu2HwmzGp5nZXNahBzS2ob67ZGqSvP
         ZDkHdZT+eFbN7xCDPh4s5SXWRJwj7L9jTN7iGwIHrWXoKwKRMqhmsRlAfExitMVMSpyK
         QzHw==
X-Forwarded-Encrypted: i=1; AJvYcCXXuIJPjRFpGTTfUt5EAvpJEQi4ThlPKatXb2NdkXdk5FqXBZMqeLZMnecGkBxKHUPNztAqYhisjjMLPTqtBNPk+A2dwbX9jrzDNJ4Tx4Iz
X-Gm-Message-State: AOJu0YwVAp4pndrkDjEpeJvucCgah8HH9dGhnInG9L5pp3FOuGQtjr5J
	UkjWQPK+V2Jsm37YOqRQS83yykjUZuaCQU+kB+CMSQmWMYndXOC8xHnhEY9MGWhvW1T0PBTMhG8
	V+YoMmA==
X-Google-Smtp-Source: AGHT+IFa8UzBIswdhuTfI733OeBnjiB9xYLGmcxnhCbHhLjlxQOefI6agVYb9rJXBvK0BJCx3XGHkg==
X-Received: by 2002:a17:906:b34b:b0:a59:c52b:9939 with SMTP id a640c23a62f3a-a59fb95a2dfmr173047566b.32.1715190782695;
        Wed, 08 May 2024 10:53:02 -0700 (PDT)
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com. [209.85.218.48])
        by smtp.gmail.com with ESMTPSA id g3-20020a170906394300b00a599c1d46d5sm6403641eje.101.2024.05.08.10.53.01
        for <linux-hardening@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 May 2024 10:53:01 -0700 (PDT)
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-a59a0e4b773so1132466166b.2
        for <linux-hardening@vger.kernel.org>; Wed, 08 May 2024 10:53:01 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCW3Z1hZltf5IZy/P4aCGiq9Cj8rw6toymzlwR+KW77ywsrVTDHnN1Otq2EdlL859pP80i/Zm6gOXZqQgZNbLFGn/Fdy+jeBauMKpMgyXt5C
X-Received: by 2002:a17:906:1153:b0:a59:9eab:1622 with SMTP id
 a640c23a62f3a-a59fb9dc8dbmr211243266b.56.1715190781396; Wed, 08 May 2024
 10:53:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <202404291502.612E0A10@keescook>
In-Reply-To: <202404291502.612E0A10@keescook>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Wed, 8 May 2024 10:52:44 -0700
X-Gmail-Original-Message-ID: <CAHk-=wi5YPwWA8f5RAf_Hi8iL0NhGJeL6MN6UFWwRMY8L6UDvQ@mail.gmail.com>
Message-ID: <CAHk-=wi5YPwWA8f5RAf_Hi8iL0NhGJeL6MN6UFWwRMY8L6UDvQ@mail.gmail.com>
Subject: Re: [RFC] Mitigating unexpected arithmetic overflow
To: Kees Cook <keescook@chromium.org>
Cc: Justin Stitt <justinstitt@google.com>, Peter Zijlstra <peterz@infradead.org>, 
	Mark Rutland <mark.rutland@arm.com>, linux-hardening@vger.kernel.org, 
	linux-kernel@vger.kernel.org, llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

On Tue, 7 May 2024 at 16:27, Kees Cook <keescook@chromium.org> wrote:
>
> When I say "overflow", I mean "overflow and underflow", but more
> specifically I mean "wrap-around". This is not about "undefined
> behavior". We already demand from our compilers that all our arithmetic
> uses a well-defined overflow resolution strategy; overflow results in
> wrap-around (thanks to "-fno-strict-overflow").

I'm still entirely unconvinced.

The thing is, wrap-around is not only well-defined, it's *common*, and
*EXPECTED*.

Example:

   static inline u32 __hash_32_generic(u32 val)
   {
        return val * GOLDEN_RATIO_32;
   }

and dammit, I absolutely DO NOT THINK we should annotate this as some
kind of "special multiply".

I have no idea how many of these exist. But I am 100% convinced that
making humans annotate this and making the source code worse is
absolutely the wrong approach.

Basically, unsigned arithmetic is well-defined as wrapping around, and
it is so for a good reason.

So I'm going to have a HARD REQUIREMENT that any compiler complaints
need to be really really sane. They need to detect when people do
things like this on purpose, and they need to SHUT THE ^&% UP about
the fact that wrap-around happens.

Any tool that is so stupid as to complain about wrap-around in the
above is a BROKEN TOOL THAT NEEDS TO BE IGNORED.

Really. This is non-negotiable.

This is similar to the whole

        unsigned int a, b;

        if (a+b < a) ..

kind of pattern: a tool that complains about wrap-around in the above
is absolutely broken sh*t and needs to be ignored.

So I think you need to limit your wrap-around complaints, and really
think about how to limit them. If you go "wrap-around is wrong" as
some kind of general; rule, I'm going to ignore you, and I'm going to
tell people to ignore you, and refuse any idiotic patches that are the
result of such idiotic rules.

Put another way the absolute first and fundamental thing you should
look at is to make sure tools don't complain about sane behavior.

Until you have done that, and taken this seriously, this discussion is
not going to ever result in anything productive.

                    Linus
