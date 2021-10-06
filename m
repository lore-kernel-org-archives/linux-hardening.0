Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5E1FC433EF
	for <linux-hardening@archiver.kernel.org>; Wed,  6 Oct 2021 21:24:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 81B7261040
	for <linux-hardening@archiver.kernel.org>; Wed,  6 Oct 2021 21:24:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239635AbhJFVZz (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Wed, 6 Oct 2021 17:25:55 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:43941 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S239548AbhJFVZz (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Wed, 6 Oct 2021 17:25:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1633555442;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=nMhlWQDUo0vwZMwpBx3DUiplgyhVN+4E+Q4rD6EPGbY=;
        b=M/j4Omo/qu4/wa4MzdTy946vOkgUjwYeW4rIEL7cMI2/4wZipV9E56i8/UH7ITF9PuISMG
        jB31KjWN+hUdm7xrhJdvBpCVfkKX71O3Rq65IP5R/9RYaMR06dZNrZaW0raHfkI7djsmMO
        W1ea9Tl3OVCZfiohsHpUV7Klq/3Qfcc=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-156-pXD0BRGTNCm-_j01CpSEzg-1; Wed, 06 Oct 2021 17:24:00 -0400
X-MC-Unique: pXD0BRGTNCm-_j01CpSEzg-1
Received: by mail-qk1-f198.google.com with SMTP id t2-20020a05620a450200b0045e34e4f9c7so3194547qkp.18
        for <linux-hardening@vger.kernel.org>; Wed, 06 Oct 2021 14:24:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=nMhlWQDUo0vwZMwpBx3DUiplgyhVN+4E+Q4rD6EPGbY=;
        b=ML9f8rHenjwTEYl7+9aoT7N1RCmTcNDjIsoJsUXxAGtJN5UkqXtONv9jWJ4imO0Re/
         bYJU/ccXEKQBBzPkOFLZwGTAfZAQFOCUN++pJrRU0cMTU77RUCe1qmmfCRW8gHwhERo0
         2He/vfhP6Vv3SA4cJlAe7ZhM11CvVB5XHhPE0L1KBv4KeIWFaNKgCwrSqHlCqyRbC57G
         ZkIx5y/iXi3vwsxRDBTI4ibnkdXGvIqP+PfZr+yoqNjGzvKd254AmAGlNl5rAtW4lM5i
         TcPa34WnOHAcTtjQcX0puHL9jIIOgVUqba1C6GbDpU7nAxnGQ2Pd16IbE2QzygKzSMnw
         Vt5w==
X-Gm-Message-State: AOAM531N3gCIEUfIkOkCKjlfoyot5N/J+Sf7MQ0TFMlw6pcsLQbQZhk7
        yIAgGlSBuUmyVWWzad7zLQEhfW9KNg2pj5QM4jqy5HV2SXrHvkUzqiqjXeLD8n6LpsVp8OYexNC
        mfCbtLGYKLC2khvRyIjNwwxLL7TXT
X-Received: by 2002:ac8:3b5a:: with SMTP id r26mr559475qtf.171.1633555439682;
        Wed, 06 Oct 2021 14:23:59 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwR4ZiTzRKhdg2yBOE47khg3o2YOwYDTXGAsQFQpTdvjyZx4Ml+W7b4bwjUo8Xxd2UMo1aJUQ==
X-Received: by 2002:ac8:3b5a:: with SMTP id r26mr559454qtf.171.1633555439465;
        Wed, 06 Oct 2021 14:23:59 -0700 (PDT)
Received: from treble ([2600:1700:6e32:6c00::49])
        by smtp.gmail.com with ESMTPSA id c1sm12366518qka.128.2021.10.06.14.23.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Oct 2021 14:23:59 -0700 (PDT)
Date:   Wed, 6 Oct 2021 14:23:55 -0700
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Sami Tolvanen <samitolvanen@google.com>, X86 ML <x86@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Sedat Dilek <sedat.dilek@gmail.com>,
        linux-hardening@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>, llvm@lists.linux.dev
Subject: Re: [PATCH v4 06/15] ftrace: Use an opaque type for functions not
 callable from C
Message-ID: <20211006212355.mfuyci3pnsdlbp3w@treble>
References: <20210930180531.1190642-1-samitolvanen@google.com>
 <20210930180531.1190642-7-samitolvanen@google.com>
 <20211006032945.axlqh3vehgar6adr@treble>
 <20211006090249.248c65b0@gandalf.local.home>
 <CABCJKueL4Ebaan=JBUyO3oewq7RTHHXWUQpixgf2AfC_r5T3uA@mail.gmail.com>
 <20211006125809.5389b2a3@gandalf.local.home>
 <CABCJKudTuheEd5jyhXmfJHup7iYzOz3_OcO92hFnpRK1MapJSg@mail.gmail.com>
 <20211006204335.xtymxt6wk4akx6fc@treble>
 <20211006171016.07d90b59@gandalf.local.home>
MIME-Version: 1.0
In-Reply-To: <20211006171016.07d90b59@gandalf.local.home>
Authentication-Results: relay.mimecast.com;
        auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jpoimboe@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Wed, Oct 06, 2021 at 05:10:16PM -0400, Steven Rostedt wrote:
> On Wed, 6 Oct 2021 13:43:35 -0700
> Josh Poimboeuf <jpoimboe@redhat.com> wrote:
> 
> > On Wed, Oct 06, 2021 at 10:45:41AM -0700, Sami Tolvanen wrote:
> > > On Wed, Oct 6, 2021 at 9:58 AM Steven Rostedt <rostedt@goodmis.org> wrote:  
> > > >
> > > > On Wed, 6 Oct 2021 09:31:04 -0700
> > > > Sami Tolvanen <samitolvanen@google.com> wrote:
> > > >  
> > > > > > > On Thu, Sep 30, 2021 at 11:05:22AM -0700, Sami Tolvanen wrote:  
> > > > > > > > With CONFIG_CFI_CLANG, the compiler changes function references to point
> > > > > > > > to the CFI jump table. As ftrace_call, ftrace_regs_call, and mcount_call
> > > > > > > > are not called from C, use DECLARE_ASM_FUNC_SYMBOL to declare them.  
> > > > > >
> > > > > > "not called from C" is a bit confusing.  
> > > > >
> > > > > Any thoughts on how to make this less confusing?  
> > > >
> > > >  "Not called by C code, but injected by the compiler."
> > > >
> > > > ?  
> > > 
> > > Sure, sounds good to me. I'll update this in v5.  
> > 
> > "injected by the compiler" sounds even more confusing.  It almost sounds
> > like those functions are generated by GCC, which they are most
> > definitely not.
> > 
> 
> Heh, I was thinking of the locations that are injected (mcount / fentry) as
> these are just replacements for them. Those injections are added by GCC.
>
> So, continuing the bikeshedding, what about "not called by C code, but are
> trampolines injected as calls replacing the nops at the start of
> functions added by the compiler." ?

I'm not quite sure what that means, but I'll allow it ;-)

-- 
Josh

