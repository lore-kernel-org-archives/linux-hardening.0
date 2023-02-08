Return-Path: <linux-hardening-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D3BFC636D6
	for <linux-hardening@archiver.kernel.org>; Wed,  8 Feb 2023 19:35:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231881AbjBHTfl (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Wed, 8 Feb 2023 14:35:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231841AbjBHTfk (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Wed, 8 Feb 2023 14:35:40 -0500
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD6474672F
        for <linux-hardening@vger.kernel.org>; Wed,  8 Feb 2023 11:35:38 -0800 (PST)
Received: by mail-pj1-x102d.google.com with SMTP id bx22so16507592pjb.3
        for <linux-hardening@vger.kernel.org>; Wed, 08 Feb 2023 11:35:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=fAJlaNEf9h29bd8ZkCwxz0tgZ1g6+/vtKmnhDMYhw14=;
        b=Z+ropjWaZw/qeE6gBW6+idTTpgNFbXec1UuKtNv+KwRvRqvYww0Qyw82gl8VdUjD1B
         ACJF5dPWNYsUa7aR3pW85ooqgpccPNH1Dp+kQZnlxlvvSNCHRIPzJc8csModV1rzyDMD
         0ekiiqa5qwsESerHQbxFrAQkqMUH4COBTL4XE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fAJlaNEf9h29bd8ZkCwxz0tgZ1g6+/vtKmnhDMYhw14=;
        b=JzL5uBx9+IG8VjJVJbMhWTDJkNSHI8N9/2MjxdiWy97HUChk4oGXnysQRbokyD0DhK
         YGu8Rn2kDSvkC+9vK5a9XzMUdhrDr94bssbGIjKBrGVQCns41vxZdWpEMJYJesXmzdet
         yZJnumTXEQCyEoW8+G67oiBxyLy4NPIXpfv41Ez4hmcaRMdeJwwNfBCREgCfS1s3/c/8
         4iQfjrOyvGzPomVdNvRX9sneeLpV2J6pliUF4b5XkPNOzLUjEb9wKCXfPOJ3O5Hy2Jxt
         9YGGaTUbRwb5B39KU0O/9UbuDEdS+OCzbf1gT68q5HwJkxreUr2Ze17/u0xLb3Eq2o3C
         J7lA==
X-Gm-Message-State: AO0yUKU9/wobwPoUiWFws9ZV0PZ+fKa6hwCALn8RsK3kAMeHr06kUftu
        7e0S2TLSMvxvTKflggskxv17Fg==
X-Google-Smtp-Source: AK7set8GfKiDufztTpkuEDYL1b8u28pgvoPHLFhPAmA2kCMFZHHpGOh1C22kzQkvkpANzp/CQdvA0w==
X-Received: by 2002:a17:902:ced2:b0:199:fc6:9a9b with SMTP id d18-20020a170902ced200b001990fc69a9bmr10210092plg.17.1675884938273;
        Wed, 08 Feb 2023 11:35:38 -0800 (PST)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id iz17-20020a170902ef9100b001990e1aeae4sm7268564plb.47.2023.02.08.11.35.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Feb 2023 11:35:37 -0800 (PST)
Message-ID: <63e3f989.170a0220.60c91.c5ce@mx.google.com>
X-Google-Original-Message-ID: <202302081133.@keescook>
Date:   Wed, 8 Feb 2023 11:35:37 -0800
From:   Kees Cook <keescook@chromium.org>
To:     Dan Li <ashimida.1990@gmail.com>
Cc:     concord@gentoo.org, linux-hardening@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Michal Marek <michal.lkml@markovi.net>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Sami Tolvanen <samitolvanen@google.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Tom Rix <trix@redhat.com>, Mark Rutland <mark.rutland@arm.com>,
        Josh Poimboeuf <jpoimboe@kernel.org>,
        Qing Zhao <qing.zhao@oracle.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Marco Elver <elver@google.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Song Liu <song@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Uros Bizjak <ubizjak@gmail.com>,
        Kumar Kartikeya Dwivedi <memxor@gmail.com>,
        Juergen Gross <jgross@suse.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Borislav Petkov <bp@suse.de>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Aaron Tomlin <atomlin@redhat.com>,
        Kalesh Singh <kaleshsingh@google.com>,
        Yuntao Wang <ytcoode@gmail.com>,
        Changbin Du <changbin.du@intel.com>,
        linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, llvm@lists.linux.dev
Subject: Re: [RFC/RFT] CFI: Add support for gcc CFI in aarch64
References: <20221219061758.23321-1-ashimida.1990@gmail.com>
 <Y6A/k7/KrCCDuux6@hirez.programming.kicks-ass.net>
 <20221219132731.6ng4sz2nv6ujvu7i@ubuntu>
 <202301061929.6881F6CD40@keescook>
 <20230107154213.ocyghxd2k66gbvv6@ubuntu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230107154213.ocyghxd2k66gbvv6@ubuntu>
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Sat, Jan 07, 2023 at 07:42:13AM -0800, Dan Li wrote:
> Hi Kees,
> 
> On 01/06, Kees Cook wrote:
> > On Mon, Dec 19, 2022 at 05:32:04AM -0800, Dan Li wrote:
> > > Hi Peter,
> > Hi!
> > 
> > First of all, thank you thank you for working on this in GCC. This will
> > make a big difference for folks that don't have the option to build with
> > Clang to gain CFI coverage.
> > 
> > As for the implementation details, the core issue is really that this
> > type of CFI is specifically designed for the Linux kernel, and it took a
> > rather long time to figure out all the specifics needed (down to the
> > byte counts and instruction layouts). GCC's version will ultimately need
> > to exactly match the Clang output, or Linux is unlikely to support it.
> > 
> > We're already on our second CFI -- the original Clang CFI was just too
> > clunky for long-term use in Linux, so unless we're going to improve on
> > the latest Clang KCFI implementation in some way, it's better to stick
> > to exactly byte-for-byte identical results. The KCFI support in Linux
> > depends on the arm64 and x86_64 runtimes for catching the traps, and the
> > post-processing done (on x86_64) with objtool that prepares the kernel
> > for IBT use, and converts to the optional FineIBT CFI mechanism. With
> > all those moving parts, there needs to be a very compelling reason to
> > have GCC KCFI implementation differ from Clang's.
> > 
> > Hopefully that context helps a little. I'm excited to try out future
> > versions!
> 
> Thanks for the context, it makes sense and helped me a lot. :)
> 
> In the next version I'll make the gcc implementation consistent with clang.

Hi!

Just checking in on this, since there are a lot of interested folks. :)
What's the status on the next version (and has anyone been found to
tackle the x86 backend part)? Is there anything we can help with?

Thanks!

-Kees

-- 
Kees Cook
