Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C956AC433E6
	for <linux-hardening@archiver.kernel.org>; Thu,  4 Mar 2021 19:14:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8F78964F72
	for <linux-hardening@archiver.kernel.org>; Thu,  4 Mar 2021 19:14:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233710AbhCDTN4 (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Thu, 4 Mar 2021 14:13:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233837AbhCDTNn (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Thu, 4 Mar 2021 14:13:43 -0500
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1153C061756
        for <linux-hardening@vger.kernel.org>; Thu,  4 Mar 2021 11:13:02 -0800 (PST)
Received: by mail-lf1-x12b.google.com with SMTP id q25so24863093lfc.8
        for <linux-hardening@vger.kernel.org>; Thu, 04 Mar 2021 11:13:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=3VGWnxMaYg51SC+CxXKHH3eAPL9wuuzDkZF08z83fw8=;
        b=YjEV8ZKjqX5sDh5Hyzb1VXQwrKtsCFgC3DUoJnWlSMmU+/Ymq5zQZGQvCpBUGj6XAF
         cKGiYfDOxUHayg993eCDtsDljJANZOJzsD1f4SbxY7aEqrunpDihnbvQL719yQnZ2XPe
         Pb3HPXMnMRstiN8DRtWeiWiENVa48hs7Ibo8g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3VGWnxMaYg51SC+CxXKHH3eAPL9wuuzDkZF08z83fw8=;
        b=RoX18LE9MFQCO0iOAiYpMdeekS+yB1thp1GdGa9pzkn08HnlcUBqKTmRyNwNCuZMx/
         weuQZI+Tmvn7buPE5kakP4/X65dJSM1fln1d5BmFCFbajUHN32cQiTnetiJ0GuHf6KDM
         e3jSM9W+K6fZYV7oRIK0+mLM/tt+PtPhJtaTcpqzMIcDsJMvS2IPOdUoGF0Rja5JODbX
         hNbvjsWLTeTOhR50SKSKxFxBzXuGMBA5NKu171DV+68RUYuoi0okSfD3cqyGFL2vC0dt
         cqBcSbji+Fqm3pUCgiqlVDzBQb2iiuWeRuLCat6EVJyhUOVZss5Nis+A4sQh/X53N/3Y
         Khzg==
X-Gm-Message-State: AOAM531vF4ql2JbrarGWF3dx1tLBsH954wdk+N1POsxWTENojuXBVKQE
        mWGdXk8bUAykHF/lNj6hwWbDGOsdEK7bzQ==
X-Google-Smtp-Source: ABdhPJxRgdx38IDkzaEf4xvR8jKNS571ZSWQYOvhK6tLNhtluhjJ/U53mrqEulVAVk2iXHvPeh3zGA==
X-Received: by 2002:a19:c14a:: with SMTP id r71mr3090216lff.358.1614885180658;
        Thu, 04 Mar 2021 11:13:00 -0800 (PST)
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com. [209.85.167.50])
        by smtp.gmail.com with ESMTPSA id t16sm35220ljj.137.2021.03.04.11.12.59
        for <linux-hardening@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 04 Mar 2021 11:12:59 -0800 (PST)
Received: by mail-lf1-f50.google.com with SMTP id b1so34308264lfb.7
        for <linux-hardening@vger.kernel.org>; Thu, 04 Mar 2021 11:12:59 -0800 (PST)
X-Received: by 2002:ac2:41d5:: with SMTP id d21mr2980850lfi.487.1614885178880;
 Thu, 04 Mar 2021 11:12:58 -0800 (PST)
MIME-Version: 1.0
References: <20210302232649.y2tutffhxsblwqlb@treble> <CAK7LNAReuB5zUq_7S8ZG25+tdQowECDOK1rApYvkPCpHhPjK5w@mail.gmail.com>
 <20210303191516.6ksxmng4pis7ue4p@treble> <CAHk-=wjR0CyaKU=6mXW9W+65L8h8DQuBdA2ZY2CfrPe6qurz3A@mail.gmail.com>
 <20210303193806.oovupl4ubtkkyiih@treble> <CAHk-=whA6zru0BaNm4uu5KyZe+aQpRScOnmc9hdOpO3W+xN9Xw@mail.gmail.com>
 <20210303202406.bxgdx5a25j6wc43b@treble> <CAHk-=wi9J3mM8y+aH9e=HRo95giK4BRyyasayAimB0gdvbvDsQ@mail.gmail.com>
 <20210303214534.guyoxcwrgxgcqzy4@treble> <CAK7LNAQaAgg+mVSw_U3_FuuqcqJNnonyhVD1M-ezv71Y+dyAww@mail.gmail.com>
 <20210304150812.rzya7ewmerwhe4m4@treble> <CAK7LNAR0kNJ=DLuvRzRG+-rgMfcrSOZu8Mn6JBJ5do7TzJWLcA@mail.gmail.com>
In-Reply-To: <CAK7LNAR0kNJ=DLuvRzRG+-rgMfcrSOZu8Mn6JBJ5do7TzJWLcA@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 4 Mar 2021 11:12:42 -0800
X-Gmail-Original-Message-ID: <CAHk-=wiT3FGuKuqLniBN2T_PZwD0GH4kf3XNCzq2tfChqn0+SQ@mail.gmail.com>
Message-ID: <CAHk-=wiT3FGuKuqLniBN2T_PZwD0GH4kf3XNCzq2tfChqn0+SQ@mail.gmail.com>
Subject: Re: [PATCH RFC] gcc-plugins: Handle GCC version mismatch for OOT modules
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     Josh Poimboeuf <jpoimboe@redhat.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Michal Marek <michal.lkml@markovi.net>,
        linux-hardening@vger.kernel.org,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Justin Forbes <jforbes@redhat.com>,
        Ondrej Mosnacek <omosnace@redhat.com>,
        Frank Eigler <fche@redhat.com>,
        Kees Cook <keescook@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Thu, Mar 4, 2021 at 7:36 AM Masahiro Yamada <masahiroy@kernel.org> wrote:
>
> All the kernel-space objects are rebuilt
> when the compiler is upgraded.

I very much NAK'ed that one. Why did that go in?

Or maybe I NAK'ed another version of it (I think the one I NAK'ed was
from Josh), and didn't realize that there were multiple ones.

> Linus complaint about GCC plugins not being rebuilt.

Yes, and that was a separate complaint and not at all tied to the other objects.

Gcc plugins aren't kernel object files at all. They are very much like
dynamically loadable libraries to gcc itself.

               Linus
