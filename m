Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CE59C433EF
	for <linux-hardening@archiver.kernel.org>; Mon,  6 Dec 2021 06:04:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237632AbhLFGHb (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Mon, 6 Dec 2021 01:07:31 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:39527 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S237612AbhLFGHa (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Mon, 6 Dec 2021 01:07:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1638770642;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Wo70tjI7q1UAqboatbwLl0h/uu/FTe3Affu+qnLiGkQ=;
        b=LpI1xy0UNuOPFcuDTn0pPM0BdHvhmcDsicrh14B4zh61b9OtlZ6AKN8OUNZL4fsILq7SHT
        b4VJiv1O116z96lUypeGoK0LutqrQeZ5hleo9/zRYeSuSz9pdoWumtAK1wyVYiPBLMeR+T
        Gn2dC5N4N37oJy0e69OVrr9K6H9zmr8=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-575-ev9FnKOLN4yWPoWG11QSYg-1; Mon, 06 Dec 2021 01:03:58 -0500
X-MC-Unique: ev9FnKOLN4yWPoWG11QSYg-1
Received: by mail-qv1-f72.google.com with SMTP id jn10-20020ad45dea000000b003bd74c93df4so10675541qvb.15
        for <linux-hardening@vger.kernel.org>; Sun, 05 Dec 2021 22:03:58 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Wo70tjI7q1UAqboatbwLl0h/uu/FTe3Affu+qnLiGkQ=;
        b=s2SG7Aq0oKAI8waWp+WLZD2SF5VXpaIxaDo/sQxv1A/ZFR+H535JIPuxJrpw4tYfPT
         GoqgJ65/a4usiX0AaZGkU3E+DJM+6ra9OsxvZw4icPb5Giza+O8ycfuCksZNb/GqYbOq
         SSChstIBo+01iMQD2gkWB9CctXKSD1o7SqYI18cMd3uihMPEp7BCNUzhG3W/AqOSL91e
         Ye4Vtr51VmO/t+/tpAEZ6/dMHkjYbvyEQ9RB5QA8twSEUyUgF2F2mZqX08om92j4nyDd
         q6hDlN/SRVYSjMq4q1W0+4+InQSGhWaNoAIDH7Q0WG1ZIWVJ3c6F2JlHQzRGrfrS1gKH
         2VKw==
X-Gm-Message-State: AOAM530dCzk95VxpH2cHb5RPOIKu/e2S8YpwnRFfAeudNYM8onEWiMuW
        A9wZsVAtissS/f5OQcnL+f+25nQrDz+mKGn7cyy7E4PzcKDyMVPeQiz0BynJT7S2WXD4nkmZ+MA
        a0WokAIDTqV8wqcyTN4T1qEkcPPE8
X-Received: by 2002:ac8:5bcf:: with SMTP id b15mr37503554qtb.474.1638770637757;
        Sun, 05 Dec 2021 22:03:57 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwBlcOgv7DcKhfVmXiMUiPn6jj3Lbd0IoNd3WtPjyxukoKwU1wdw7FB6qmJfkTYOfo/DTS8HA==
X-Received: by 2002:ac8:5bcf:: with SMTP id b15mr37503536qtb.474.1638770637542;
        Sun, 05 Dec 2021 22:03:57 -0800 (PST)
Received: from treble ([2600:1700:6e32:6c00::45])
        by smtp.gmail.com with ESMTPSA id y20sm6176312qkj.24.2021.12.05.22.03.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 Dec 2021 22:03:56 -0800 (PST)
Date:   Sun, 5 Dec 2021 22:03:50 -0800
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Alexander Lobakin <alexandr.lobakin@intel.com>,
        linux-hardening@vger.kernel.org, x86@kernel.org,
        Jesse Brandeburg <jesse.brandeburg@intel.com>,
        Kristen Carlson Accardi <kristen@linux.intel.com>,
        Kees Cook <keescook@chromium.org>,
        Miklos Szeredi <miklos@szeredi.hu>,
        Ard Biesheuvel <ardb@kernel.org>,
        Tony Luck <tony.luck@intel.com>,
        Bruce Schlobohm <bruce.schlobohm@intel.com>,
        Jessica Yu <jeyu@kernel.org>,
        kernel test robot <lkp@intel.com>,
        Miroslav Benes <mbenes@suse.cz>,
        Evgenii Shatokhin <eshatokhin@virtuozzo.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Michal Marek <michal.lkml@markovi.net>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        Will Deacon <will@kernel.org>, Ingo Molnar <mingo@redhat.com>,
        Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Andy Lutomirski <luto@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Nathan Chancellor <nathan@kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Marios Pomonis <pomonis@google.com>,
        Sami Tolvanen <samitolvanen@google.com>,
        linux-kernel@vger.kernel.org, linux-kbuild@vger.kernel.org,
        linux-arch@vger.kernel.org, live-patching@vger.kernel.org,
        llvm@lists.linux.dev
Subject: Re: [PATCH v8 08/14] livepatch: only match unique symbols when using
 FG-KASLR
Message-ID: <20211206060350.f4hqug2jhgjlaw3c@treble>
References: <20211202223214.72888-1-alexandr.lobakin@intel.com>
 <20211202223214.72888-9-alexandr.lobakin@intel.com>
 <YansAlTr0/MfNxWc@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
In-Reply-To: <YansAlTr0/MfNxWc@hirez.programming.kicks-ass.net>
Authentication-Results: relay.mimecast.com;
        auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jpoimboe@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Fri, Dec 03, 2021 at 11:05:54AM +0100, Peter Zijlstra wrote:
> On Thu, Dec 02, 2021 at 11:32:08PM +0100, Alexander Lobakin wrote:
> > If any type of function granular randomization is enabled, the sympos
> > algorithm will fail, as it will be impossible to resolve symbols when
> > there are duplicates using the previous symbol position.
> > 
> > We could override sympos to 0, but make it more clear to the user
> > and bail out if the symbol is not unique.
> 
> Since we're going lots of horrendous things already, why can't we fix
> this duplicate nonsense too?

I assume you mean using this new linker flag: "-z unique-symbol"

https://sourceware.org/bugzilla/show_bug.cgi?id=26391

-- 
Josh

