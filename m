Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E733C433F5
	for <linux-hardening@archiver.kernel.org>; Wed, 16 Feb 2022 19:57:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236461AbiBPT6B (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Wed, 16 Feb 2022 14:58:01 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:44516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237078AbiBPT57 (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Wed, 16 Feb 2022 14:57:59 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 1A669222F15
        for <linux-hardening@vger.kernel.org>; Wed, 16 Feb 2022 11:57:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1645041466;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=xiLxVyN59oqE7A7718SqSgkuduNadRNJgJwK2/lq92E=;
        b=YLe1zyKjBBq4/N4O04UJRwLjiPZBdNh4E6hg0Sh1QUryLp50qKmtsd4QlKa4D4Lvmcr2Bt
        hChdT0nBIolIhClL7B4EStfUXVIoQl5LwUZrHsfAvVNSpgdZ+JLfLgEt6ndQiAKnzW4E35
        /bzomFteh4+wPaQ3NKJu5TEcp31/ko4=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-448-vhdhs0mUMNO3-GuFU5Htww-1; Wed, 16 Feb 2022 14:57:45 -0500
X-MC-Unique: vhdhs0mUMNO3-GuFU5Htww-1
Received: by mail-qk1-f200.google.com with SMTP id bi17-20020a05620a319100b0050850bdcbb2so2118635qkb.17
        for <linux-hardening@vger.kernel.org>; Wed, 16 Feb 2022 11:57:45 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=xiLxVyN59oqE7A7718SqSgkuduNadRNJgJwK2/lq92E=;
        b=VGsrWoF47iJGQszP6KgF2JSZtcHIhaTUoul48BqxHL2MG+t5fJCPuCsvrdskRbrrg/
         v8/SELC5oara6gvmSniNCOovY4eAeJbN8IY+l5tGoHXMUkIbuY/6rEqzZWjs8hJ+kPTL
         e2b4oQjfSbWLe3vg40K1vD07NqOhX70tujp3tkWipdmoCEGOeI0V5wL0AMFeAU5ZRmkK
         OwzqH1gyEOQqHwow6uHZrLctu1AS6SOaLvSPcMDMYEz8uxswqjvUpUj46VPXWp4tUsv+
         BatVx3FFw2iW8C0MPkPjNYWocChz4BKIcTizuU3rKJ9j/KHVuOLJRx/taHG8XZJatXT0
         2nYw==
X-Gm-Message-State: AOAM5307EkFzDQUOi57qiwfHGZv4lw4ODN6ie+oS1Kus1zHHu7O8ziS7
        XKhOv0RQAGgwlP/0WEM/0c1Zb9nxgGQPfPQVfPR2ziv3yuWM+yJPwGVw0JvuiMX0LgLCpdowQh2
        iQtTqXxI0y+6GgeGMfbXWcmC3/m6R
X-Received: by 2002:a05:622a:1349:b0:2d4:7253:a515 with SMTP id w9-20020a05622a134900b002d47253a515mr3268835qtk.602.1645041464739;
        Wed, 16 Feb 2022 11:57:44 -0800 (PST)
X-Google-Smtp-Source: ABdhPJygWGLG5sUSJg9RfvApTNNy6TjsndVIBgztpxG68wFuUHr83ZsEZ3BHwvjzof67oYJOV+7Ieg==
X-Received: by 2002:a05:622a:1349:b0:2d4:7253:a515 with SMTP id w9-20020a05622a134900b002d47253a515mr3268787qtk.602.1645041464385;
        Wed, 16 Feb 2022 11:57:44 -0800 (PST)
Received: from treble ([2600:1700:6e32:6c00::15])
        by smtp.gmail.com with ESMTPSA id c7sm3530034qtp.61.2022.02.16.11.57.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Feb 2022 11:57:43 -0800 (PST)
Date:   Wed, 16 Feb 2022 11:57:38 -0800
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     Miroslav Benes <mbenes@suse.cz>
Cc:     Alexander Lobakin <alexandr.lobakin@intel.com>,
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
Message-ID: <20220216195738.vhlot4udoqga4ndm@treble>
References: <20220209185752.1226407-1-alexandr.lobakin@intel.com>
 <20220209185752.1226407-3-alexandr.lobakin@intel.com>
 <20220211174130.xxgjoqr2vidotvyw@treble>
 <alpine.LSU.2.21.2202161601010.1475@pobox.suse.cz>
MIME-Version: 1.0
In-Reply-To: <alpine.LSU.2.21.2202161601010.1475@pobox.suse.cz>
Authentication-Results: relay.mimecast.com;
        auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jpoimboe@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Wed, Feb 16, 2022 at 04:06:24PM +0100, Miroslav Benes wrote:
> > > +	/*
> > > +	 * If the LD's `-z unique-symbol` flag is available and enabled,
> > > +	 * sympos checks are not relevant.
> > > +	 */
> > > +	if (IS_ENABLED(CONFIG_LD_HAS_Z_UNIQUE_SYMBOL))
> > > +		sympos = 0;
> > > +
> > 
> > Similarly, I don't see a need for this.  If the patch is legit then
> > sympos should already be zero.  If not, an error gets reported and the
> > patch fails to load.
> 
> My concern was that if the patch is not legit (that is, sympos is > 0 for 
> some reason), the error would be really cryptic and would not help the 
> user at all. So zeroing sympos seems to be a good idea to me. There is no 
> harm and the change is very small and compact.

But wouldn't a cryptic error be better than no error at all?  A bad
sympos might be indicative of some larger issue, like the wrong symbol
getting patched.

-- 
Josh

