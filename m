Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A85E2C433FE
	for <linux-hardening@archiver.kernel.org>; Mon, 14 Feb 2022 18:10:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236350AbiBNSKS (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Mon, 14 Feb 2022 13:10:18 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:56650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235368AbiBNSKR (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Mon, 14 Feb 2022 13:10:17 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id E448C65171
        for <linux-hardening@vger.kernel.org>; Mon, 14 Feb 2022 10:10:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1644862209;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=CGNOFCt1MU85Ts1xBeqV0FyWp/WQxMTDQKYlq49a4uc=;
        b=QM6ImguIZ8zc4cCkdJFURHD34Ls3owlDOTdkpmfFPgjf55xKBNBA68rwYbbjrIYv/QDw+v
        i6wOfxzcl2LAc+dz8o8yepmuHSQ3n0axurH5sFJdnctgJkXXp6Q4I2GmZaOOEUsy68xWzO
        rnAC4vYaOXo+04ubSRO5X2yxRAoGoY8=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-340-2I99wgCZPGaQ_3ud0oyHCQ-1; Mon, 14 Feb 2022 13:10:07 -0500
X-MC-Unique: 2I99wgCZPGaQ_3ud0oyHCQ-1
Received: by mail-qt1-f199.google.com with SMTP id c15-20020ac87dcf000000b002d0a849c0beso13084950qte.16
        for <linux-hardening@vger.kernel.org>; Mon, 14 Feb 2022 10:10:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=CGNOFCt1MU85Ts1xBeqV0FyWp/WQxMTDQKYlq49a4uc=;
        b=j9w8IFHU07ilwtvjIu5rRj85GPYOia56zMQJ8gDz6ZuTQ6heumB7d8GK7SLW++qfs0
         fFQ4XTBdKWxC/Ly6KhBV4od3TunP2MpuTq0qCZlwThcjUad7KV34XHG6YLgHGkB6DpKG
         r1NfdPcg5mCfLOHe60pAsEIKVICoKbxIa6YJTKSAZOuwTF+uXibdMa1fTEDA3YjZQZX5
         OvD5RSUIb6ah04rZ4WDfLHrTQVkzYbJcmBSgKmHYJUXI2aT11IBUj8msJXmM9TkF7m0h
         vQtts1xj8yaEmN78LgL2lgs3Umd82mlT5VBrHJ4rWijGMfl2K4WGWvCIusgr9qeJhHlI
         M6Jg==
X-Gm-Message-State: AOAM530k4i3te3zrb7EWEyDRzaEyEp7wq8j8+/lYUw6Hej8fXnlqhfCC
        MKH/WxnJnwWceZahs9QkMWovkb58zMgp/5HwxEnqlp1HwEa8uqhLHLlHAjDQ8kxQWei61FImd6S
        Rg4kavNpgDPNI4r1YJ/SO2iCpWUx4
X-Received: by 2002:a05:6214:762:: with SMTP id f2mr693709qvz.24.1644862206837;
        Mon, 14 Feb 2022 10:10:06 -0800 (PST)
X-Google-Smtp-Source: ABdhPJx/vy40rnBwdMoVvt1Kva6lhknBX3yMZ/S5wMQcb4vy84dEW8nb/n8AHTcudHMUidnRHHxsJw==
X-Received: by 2002:a05:6214:762:: with SMTP id f2mr693693qvz.24.1644862206520;
        Mon, 14 Feb 2022 10:10:06 -0800 (PST)
Received: from treble ([2600:1700:6e32:6c00::35])
        by smtp.gmail.com with ESMTPSA id br30sm16056253qkb.67.2022.02.14.10.10.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Feb 2022 10:10:05 -0800 (PST)
Date:   Mon, 14 Feb 2022 10:10:00 -0800
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     Alexander Lobakin <alexandr.lobakin@intel.com>
Cc:     =?utf-8?B?RsSBbmctcnXDrCBTw7JuZw==?= <maskray@google.com>,
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
Message-ID: <20220214181000.xln2qgyzgswjxwcz@treble>
References: <20220209185752.1226407-1-alexandr.lobakin@intel.com>
 <20220209185752.1226407-3-alexandr.lobakin@intel.com>
 <20220211174130.xxgjoqr2vidotvyw@treble>
 <CAFP8O3KvZOZJqOR8HYp9xZGgnYf3D8q5kNijZKORs06L-Vit1g@mail.gmail.com>
 <20220211183529.q7qi2qmlyuscxyto@treble>
 <20220214122433.288910-1-alexandr.lobakin@intel.com>
MIME-Version: 1.0
In-Reply-To: <20220214122433.288910-1-alexandr.lobakin@intel.com>
Authentication-Results: relay.mimecast.com;
        auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jpoimboe@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Mon, Feb 14, 2022 at 01:24:33PM +0100, Alexander Lobakin wrote:
> > One idea I mentioned before, it may be worth exploring changing the "F"
> > in FGKASLR to "File" instead of "Function".  In other words, only
> > shuffle at an object-file granularity.  Then, even with duplicates, the
> > <file+function> symbol pair doesn't change in the symbol table.  And as
> > a bonus, it should help FGKASLR i-cache performance, significantly.
> 
> Yeah, I keep that in mind. However, this wouldn't solve the
> duplicate static function names problem, right?
> Let's say you have a static function f() in file1 and f() in file2,
> then the layout each boot can be
> 
> .text.file1  or  .text.file2
> f()              f()
> .text.file2      .text.file1
> f()              f()
> 
> and position-based search won't work anyway, right?

Right, so we'd have to abandon position-based search in favor of
file+func based search.

It's not perfect because there are still a few file+func duplicates.
But it might be good enough.  We would presumably just refuse to patch a
duplicate.  Or we could remove them (and enforce their continued removal
with tooling-based warnings).

Another variant of this which I described here

  https://lore.kernel.org/all/20210125172124.awabevkpvq4poqxf@treble/

would be to keep it function-granular, but have kallsyms keep track of
what file each func belongs to.  Then livepatch could still do the
file+func based search.

-- 
Josh

