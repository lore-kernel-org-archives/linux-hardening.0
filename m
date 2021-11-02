Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 731CAC433F5
	for <linux-hardening@archiver.kernel.org>; Tue,  2 Nov 2021 17:26:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 513FB61051
	for <linux-hardening@archiver.kernel.org>; Tue,  2 Nov 2021 17:26:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233684AbhKBR3H (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Tue, 2 Nov 2021 13:29:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229684AbhKBR3G (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Tue, 2 Nov 2021 13:29:06 -0400
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com [IPv6:2607:f8b0:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8380C061714
        for <linux-hardening@vger.kernel.org>; Tue,  2 Nov 2021 10:26:31 -0700 (PDT)
Received: by mail-pg1-x529.google.com with SMTP id n23so39722pgh.8
        for <linux-hardening@vger.kernel.org>; Tue, 02 Nov 2021 10:26:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=myOqWBgPG0dYfqkI8IYrHgAqLHnpCmExkocszUv5gww=;
        b=TKwPsswmiw8iIlN1erYAlJRZrSd5BMqlzwhXBspryv7/sxW7ziYzUFwoZX6v4eQ/Fd
         PdZbQv7+JzzhecFEW5a2g9Evt9CAEYO++aysSRwuoeHh/z03VJxQzNSwYEbWAlMuPj+h
         HRvYBwb9ss0Z7OgrkxA2LuKPm+MCxDPu7MB1I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=myOqWBgPG0dYfqkI8IYrHgAqLHnpCmExkocszUv5gww=;
        b=FMgKEKKxDKJGqWQxIHeREMDUrSij9Hv6dZX0RyvBNE2eBSAYHCYzIPDOtu2fW2Nane
         joDygG0pV1aM4fvfsqJm4kNUcXlEIGLY6P3m+o3naFzJeBhmKc40qmxPOW6CCXfQAyVi
         adqL91o89t9edXU+AwFAA6fOltHtYDL/UpjHgEDrfGL6z59fDMK7CInr3GV39gY0OrG+
         UlHIKT8ZR92xc0apjzQqL9V5dhgKcgsZD0Zm8+vSbltPudckWrjQ+OfKROwTs5eUZVcR
         8AyKr2Sk3pts1dTGdd+R5YIq5wb7scWlDa5ig08digdLId88aoon2i8I2k0b/yrtcaA1
         dmRQ==
X-Gm-Message-State: AOAM533mnbf0H8/+30oJUbWubmdvRNKN7tS1/Dy3cT0Ql/Rv3BisBTeI
        gzxHgxjXigg2ja7NkEF7I9R6U+oZNsm0xw==
X-Google-Smtp-Source: ABdhPJwLYDZ3ZZw4s7Wt60qq+CXfv1queIcc4LvOeOnn7QGtFFd/es8sKHi4AlS4TSNX7iu1+FPp2Q==
X-Received: by 2002:a63:4b58:: with SMTP id k24mr21454195pgl.326.1635873991315;
        Tue, 02 Nov 2021 10:26:31 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id c8sm3078586pjr.38.2021.11.02.10.26.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Nov 2021 10:26:30 -0700 (PDT)
Date:   Tue, 2 Nov 2021 10:26:29 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Ard Biesheuvel <ardb@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Sami Tolvanen <samitolvanen@google.com>,
        X86 ML <x86@kernel.org>, Josh Poimboeuf <jpoimboe@redhat.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Sedat Dilek <sedat.dilek@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        linux-hardening@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        llvm@lists.linux.dev
Subject: Re: [PATCH v5 00/15] x86: Add support for Clang CFI
Message-ID: <202111021023.0E5188EC60@keescook>
References: <20211027120515.GC54628@C02TD0UTHF1T.local>
 <CAMj1kXEx10gC8eH7rV-GbZZj2M3uDue6HYsKb+A5J01zOxm_FA@mail.gmail.com>
 <20211027124852.GK174703@worktop.programming.kicks-ass.net>
 <YXlOd1lyKZKAcJfA@hirez.programming.kicks-ass.net>
 <202110270939.F5C79CC@keescook>
 <YXnC1jqwR2ZKfMdk@hirez.programming.kicks-ass.net>
 <202110271430.2A3980217@keescook>
 <YXqE82jQh4S79uVL@hirez.programming.kicks-ass.net>
 <202110280958.22E5F74@keescook>
 <20211028202905.GO174703@worktop.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211028202905.GO174703@worktop.programming.kicks-ass.net>
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Thu, Oct 28, 2021 at 10:29:05PM +0200, Peter Zijlstra wrote:
> Now, since code (on x86) is variable length, there are no spare bits in
> the code address, but since static_call_key is aligned, we have spare
> bits. It is those bits we use to encode TAIL (Bit0) and INIT (Bit1).
> 
> If INIT, the address points to an __init section and we shouldn't try
> and touch if after those have been freed or bad stuff happens.
> 
> If TAIL, it's a tail-call and we get to write a jump instruction instead
> of a call instruction.

I think this is the part that I was missing: the information is about
the _address_, but it's stored in the _key_'s low bits (regardless of
the key's actual/masked key pointer).

> [...]
> Hope that clarifies things, instead of making it worse :-)

It does help, yes, thanks! I will need to read it again and go follow
along in the code, but yes, that helps explain it.

-- 
Kees Cook
