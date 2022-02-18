Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86295C433FE
	for <linux-hardening@archiver.kernel.org>; Fri, 18 Feb 2022 20:08:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238510AbiBRUIk (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Fri, 18 Feb 2022 15:08:40 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:54752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237739AbiBRUIg (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Fri, 18 Feb 2022 15:08:36 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 5ABB524B2A9
        for <linux-hardening@vger.kernel.org>; Fri, 18 Feb 2022 12:08:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1645214898;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=qbD0qiU4RjhqV726jofvBeaOVqKh7JjTJAB5iz2l93M=;
        b=Mf8Z8Wd8jaTEoBCbymEaNPmwb0Do/ZHebvAecu1p4b5+TVNjS3tq3vaEa7LDwqgF40HODp
        OAmS3P4beebQc4Zgy3Vy0x50JvTTFkfKJDI0JhbLZ/cCZdeSI3JRHcyRhclJ7rbp0kVTOw
        AMvmnitulWCo4UVIIgfSjm+/1xyV8v0=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-262-Y9xRb3wsN86LwRdp0fi36w-1; Fri, 18 Feb 2022 15:08:15 -0500
X-MC-Unique: Y9xRb3wsN86LwRdp0fi36w-1
Received: by mail-qk1-f197.google.com with SMTP id i189-20020a3786c6000000b00646d7b30998so888363qkd.10
        for <linux-hardening@vger.kernel.org>; Fri, 18 Feb 2022 12:08:15 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=qbD0qiU4RjhqV726jofvBeaOVqKh7JjTJAB5iz2l93M=;
        b=sD7/wCRgdUgaKIVPrOXZUi7qfF2kRfyrmpJ7kEtkRGx8uBCft9rbBYQ0sXS85BSory
         814qeQbWz2C7MA1/gzHqmAsl2jKplGpHjUKJ8IkhKA7XUnxFW1fQW1ZVKAULYQrZvRU1
         xadPWOGszI9s55ayzx9dN4MmrjW0EB0gHRX9/noOWOtjWexLc52piQ8HOjHPPWEJazrW
         Kvw/1VYFWyTIRj0YkLqjz5t+3XGuZp2gkDMRWPyGdR4b191qGAx3+w3hgOsQGEPvRQOR
         kQkf8F6CPsiwq3bXG7WjVIhQURSimS0M2vdTxDqLo6OnIpii0ZSek71CegvXMynDSng7
         ILpQ==
X-Gm-Message-State: AOAM532+MK5ywq/qmpr1M5NmUqAaZIBjqEvd8q6KHH7rnN7cZmdVaG0i
        vpBLLKC+7/7vIUIn6Z6An7oYUQYJaygk2IJ94InZ3irIj8HLP/YXTyMnVz22qsYUg+eMHG40fRc
        CXPhbdUNVSAaScxZ51ZsqZI22xLJw
X-Received: by 2002:a05:6214:17c2:b0:42c:b915:69f with SMTP id cu2-20020a05621417c200b0042cb915069fmr7009974qvb.95.1645214894990;
        Fri, 18 Feb 2022 12:08:14 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyES3jxSXm6PUQSrWkCWkJOx1aXkyiFLiwQrMEdx8mKix/Dv/YjSGuwkSGrstdFEaba1AKRqg==
X-Received: by 2002:a05:6214:17c2:b0:42c:b915:69f with SMTP id cu2-20020a05621417c200b0042cb915069fmr7009947qvb.95.1645214894772;
        Fri, 18 Feb 2022 12:08:14 -0800 (PST)
Received: from treble ([2600:1700:6e32:6c00::35])
        by smtp.gmail.com with ESMTPSA id e64sm6288522qkd.122.2022.02.18.12.08.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Feb 2022 12:08:14 -0800 (PST)
Date:   Fri, 18 Feb 2022 12:08:08 -0800
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     Alexander Lobakin <alexandr.lobakin@intel.com>
Cc:     Miroslav Benes <mbenes@suse.cz>,
        =?utf-8?B?RsSBbmctcnXDrCBTw7JuZw==?= <maskray@google.com>,
        linux-hardening@vger.kernel.org, x86@kernel.org,
        Borislav Petkov <bp@alien8.de>,
        Jesse Brandeburg <jesse.brandeburg@intel.com>,
        Kristen Carlson Accardi <kristen@linux.intel.com>,
        Kees Cook <keescook@chromium.org>,
        Miklos Szeredi <miklos@szeredi.hu>,
        Ard Biesheuvel <ardb@kernel.org>,
        Tony Luck <tony.luck@intel.com>,
        Bruce Schlobohm <bruce.schlobohm@intel.com>,
        Jessica Yu <jeyu@kernel.org>,
        kernel test robot <lkp@intel.com>,
        Evgenii Shatokhin <eshatokhin@virtuozzo.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Michal Marek <michal.lkml@markovi.net>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        Will Deacon <will@kernel.org>, Ingo Molnar <mingo@redhat.com>,
        Christoph Hellwig <hch@lst.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Nathan Chancellor <nathan@kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Marios Pomonis <pomonis@google.com>,
        Sami Tolvanen <samitolvanen@google.com>,
        "H.J. Lu" <hjl.tools@gmail.com>, Nicolas Pitre <nico@fluxnic.net>,
        linux-kernel@vger.kernel.org, linux-kbuild@vger.kernel.org,
        linux-arch@vger.kernel.org, live-patching@vger.kernel.org,
        llvm@lists.linux.dev
Subject: Re: [PATCH v10 02/15] livepatch: avoid position-based search if `-z
 unique-symbol` is available
Message-ID: <20220218200808.juxnoidtxa7fjsk7@treble>
References: <20220209185752.1226407-1-alexandr.lobakin@intel.com>
 <20220209185752.1226407-3-alexandr.lobakin@intel.com>
 <20220211174130.xxgjoqr2vidotvyw@treble>
 <CAFP8O3KvZOZJqOR8HYp9xZGgnYf3D8q5kNijZKORs06L-Vit1g@mail.gmail.com>
 <20220211183529.q7qi2qmlyuscxyto@treble>
 <alpine.LSU.2.21.2202161606430.1475@pobox.suse.cz>
 <20220218163111.98564-1-alexandr.lobakin@intel.com>
MIME-Version: 1.0
In-Reply-To: <20220218163111.98564-1-alexandr.lobakin@intel.com>
Authentication-Results: relay.mimecast.com;
        auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jpoimboe@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Fri, Feb 18, 2022 at 05:31:11PM +0100, Alexander Lobakin wrote:
> it took 2 minutes to generate the whole map (instead of a split
> second) (on 64-core CPU, but I guess nm runs in one thread).
> I guess it can be optimized? I'm no a binutils master (will take a
> look after sending this), is there a way to do it manually skipping
> this nm lag or maybe make nm emit filenames without such delays?

Hm, yeah, adding 2 minutes to the link time isn't going to fly ;-)  It
probably takes a while to parse all the DWARF.

Based on ther other discussions I think just using the basename (main.o)
in STT_FILE would be good enough.  Some duplicates are probably ok.

-- 
Josh

