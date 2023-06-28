Return-Path: <linux-hardening-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65296EB64D7
	for <linux-hardening@archiver.kernel.org>; Wed, 28 Jun 2023 16:30:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230100AbjF1QaK (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Wed, 28 Jun 2023 12:30:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232099AbjF1Q3q (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Wed, 28 Jun 2023 12:29:46 -0400
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C31E2733
        for <linux-hardening@vger.kernel.org>; Wed, 28 Jun 2023 09:29:45 -0700 (PDT)
Received: by mail-pl1-x629.google.com with SMTP id d9443c01a7336-1b7fb1a82c4so750475ad.1
        for <linux-hardening@vger.kernel.org>; Wed, 28 Jun 2023 09:29:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1687969785; x=1690561785;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=sqKrDSgd4uFuqB+8yGDCf1EvrfOgDuHhZYf9n2oqenA=;
        b=lQpayUTyjUp2A3gMubF0kw1VV3wpmvbGoT9P5eueQR0YRfymWkoTa+nRzmgPdH2pOi
         BYTRLCEi3IRVDdUO9YEwrpp709o9iNkTa1tXPo96mY945Ni/iJSBEWl9WjfcEMV6IxHi
         GO5fjMVQH/jGjoYH+UVlbhK+DSPKrId9uMcFg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687969785; x=1690561785;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sqKrDSgd4uFuqB+8yGDCf1EvrfOgDuHhZYf9n2oqenA=;
        b=kJ5UkhWPiwf+fqhr6PBQLHW1SSckmRfz5d6LAYEOGTl+3gP+KJ2CT2JWaL4Li5cPId
         JoJV+Bb3f70GrjjlR9d1lGKfglfibMJteAe5ub1ad6kf8oxsIFPvMBfLqY1FOhmxnkRs
         waci+ShX4mfZ63x6ydrxg2AopHL/o/f9CXBheh7+qXyLvzL5BsuI+xW/PmIFQN880Czu
         QOzs+F7IL2r4Hv0DDoQbFFGt9wJQETrURQjjXmfTpqg/EzAEeh3qb5TTFl3+5DoayxTl
         ZXZfz022KNJUqh0BDcJEEGaBeLfzui/9agjE2Ffth9cYjrcbxjI+jJkz57+wozYsALUr
         QuLg==
X-Gm-Message-State: AC+VfDwvVerZEjfgDkAey82zvz6c9fwo8zO6E3xEfFznKkGke0VEf6F1
        DxzOd7bih+87PCP8Zut+C/kn3A==
X-Google-Smtp-Source: ACHHUZ5RyEP72eBVHjbEP+KjEVKNgHCOmAIxs2p5S+EWBaAbypM5cXIocfGTAzvGLZYTuHlytZyHBg==
X-Received: by 2002:a17:902:ab95:b0:1af:ffda:855a with SMTP id f21-20020a170902ab9500b001afffda855amr9488995plr.9.1687969784812;
        Wed, 28 Jun 2023 09:29:44 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id c3-20020a170902848300b001b53d3d8f3dsm7932959plo.299.2023.06.28.09.29.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Jun 2023 09:29:43 -0700 (PDT)
Date:   Wed, 28 Jun 2023 09:29:42 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Alexander Lobakin <aleksander.lobakin@intel.com>,
        Alexander Potapenko <glider@google.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Arne Welzel <arne.welzel@corelight.com>,
        Azeem Shaikh <azeemshaikh38@gmail.com>,
        Bill Wendling <morbo@google.com>,
        Conor Dooley <conor.dooley@microchip.com>,
        "Darrick J. Wong" <djwong@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Fangrui Song <maskray@google.com>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Hans de Goede <hdegoede@redhat.com>,
        Jakub Kicinski <kuba@kernel.org>, Jan Kara <jack@suse.cz>,
        Joe Perches <joe@perches.com>,
        John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
        John Stultz <jstultz@google.com>,
        Jozsef Kadlecsik <kadlec@netfilter.org>,
        Marco Elver <elver@google.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Miguel Ojeda <ojeda@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Palmer Dabbelt <palmer@rivosinc.com>,
        Simon Horman <simon.horman@corigine.com>,
        Song Liu <song@kernel.org>,
        Thorsten Leemhuis <linux@leemhuis.info>,
        Tyrel Datwyler <tyreld@linux.ibm.com>,
        Wyes Karny <wyes.karny@amd.com>, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org
Subject: Re: [GIT PULL] hardening updates for v6.5-rc1
Message-ID: <202306280920.CB69D0F75@keescook>
References: <202306271729.813C8788@keescook>
 <ZJvRFZeYq6ZWLAWj@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZJvRFZeYq6ZWLAWj@infradead.org>
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Tue, Jun 27, 2023 at 11:20:05PM -0700, Christoph Hellwig wrote:
> On Tue, Jun 27, 2023 at 05:34:57PM -0700, Kees Cook wrote:
> > - The under-development compiler attribute __counted_by has been added
> >   so that we can start annotating flexible array members with their
> >   associated structure member that tracks the count of flexible array
> >   elements at run-time. It is possible (likely?) that the exact syntax
> >   of the attribute will change before it is finalized, but GCC and Clang
> >   are working together to sort it out. Any changes can be made to the
> >   macro while we continue to add annotations. As an example, I have a
> >   treewide commit waiting with such annotations found via Coccinelle:
> >   https://git.kernel.org/linus/adc5b3cb48a049563dc673f348eab7b6beba8a9b
> >   See commit dd06e72e68bcb4070ef211be100d2896e236c8fb for more details.
> 
> So I've been following the discussion of that feature for clang and
> I can't wait to actually be able to use it.

Me too! :)

> But this feels a bit premature to me, not only due to the ongoing
> discussions on the syntax, but more importantly because I fear it

I was on the fence about this too, and in the end, I decided that any
syntax changes are going to be mostly mechanical, and in the meantime
we needed a way to capture the associations. This has been a pain point
for years as we've been doing flexible array conversions, since when
doing the work it usually becomes clear which struct member is tracking
the element count, but that information couldn't be reliably recorded
anywhere. Now we can include the annotation (which is the really important
part). If/when the exact syntax changes, we can either adjust the macro,
or at worst we can easily do a tree-wide change. But I really want to
start capturing the associations _now_, and get us all into the habit
of doing it, and I want it to be through some kind of regular syntax
(now that there are patches to both GCC and Clang that can validate the
results), not just comments.

> will be completely misued before we have a compiler actually supporting
> available widely enough that we have it in the usual test bots.

How do you see it being misused? Your mention of the test bots, I think,
means you're worried the annotations will go unchecked for valid syntax?
FWIW, I've got builders with the GCC and Clang patches that should catch
this.

-- 
Kees Cook
