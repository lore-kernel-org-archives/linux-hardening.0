Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2948C433F5
	for <linux-hardening@archiver.kernel.org>; Mon, 22 Nov 2021 20:47:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234341AbhKVUui (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Mon, 22 Nov 2021 15:50:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233926AbhKVUuh (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Mon, 22 Nov 2021 15:50:37 -0500
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5ECCAC061714
        for <linux-hardening@vger.kernel.org>; Mon, 22 Nov 2021 12:47:30 -0800 (PST)
Received: by mail-pj1-x1035.google.com with SMTP id h24so14815366pjq.2
        for <linux-hardening@vger.kernel.org>; Mon, 22 Nov 2021 12:47:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=9FObduEZbWdjUpMXz60aZqufbQdzvSRG3lPMBJb7SJ0=;
        b=JneIEC9cvLJCbdtDu2vtG7jOReTI8ksmr7YGpy14cmKopDG1WNnzN9vyEAQ5ZFY1Ll
         wLrz0I8fq9UmpvvAfe8h8Dm9aKo2h0iPbnV+aXW1yLKcF9165JU7Nw0SLTEFehyBU+vN
         6QUq5HYvX2wTw8c3Eu9q6Z+6Y1Ty/R6fmPa7Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=9FObduEZbWdjUpMXz60aZqufbQdzvSRG3lPMBJb7SJ0=;
        b=gc9JmSW3qSTWg+l9Zp+3VCwSS10Ie8X1r5+UpZJIBLA+A3PYbkFAsuMv9zG6Xe38E5
         tYgxjmpPBZQvahTJsAN583x62THLyaM/OJ8dKrNIwOjil2YyWylmfh/PpkyfoPKY/aWl
         Xl+J0AfVhsfhwpLFjIYVacZEJHQWVDBALchhW0iVW588y0H1LfoluRaBD6+riJILkSU0
         VomUDo4qSe6An6vR3Qh5Pb/UOlSkxvAoAVGas/E/01I73dJmRZmVNB8vQMSqwoGLOfBl
         +dL7PLEhBxSDYXcRwh1AgsTBu+UkXZev2e4za0w2ub4SJXqcEnXrWpvaUw+snRSs8OIK
         VVDw==
X-Gm-Message-State: AOAM531fPHHfOU5jr5j8Fo3Qzsiu8mz79b5zaFd6/Pf29gnuW118fPSL
        yMg9/UM7B0XFHjNI/dWusZjWQg==
X-Google-Smtp-Source: ABdhPJwcHprzgfWpUQCUPhpzVPFnI4WiDGxFFLzGSTeGQcOoYiccm8mTTcquO4kALyNvrKtHzcsEvw==
X-Received: by 2002:a17:90b:1c8d:: with SMTP id oo13mr36323110pjb.239.1637614049808;
        Mon, 22 Nov 2021 12:47:29 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id v10sm9796801pfu.123.2021.11.22.12.47.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Nov 2021 12:47:29 -0800 (PST)
Date:   Mon, 22 Nov 2021 12:47:28 -0800
From:   Kees Cook <keescook@chromium.org>
To:     Michael Ellerman <mpe@ellerman.id.au>
Cc:     LEROY Christophe <christophe.leroy@csgroup.eu>,
        kernel test robot <lkp@intel.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Nicholas Piggin <npiggin@gmail.com>,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
        "linux-hardening@vger.kernel.org" <linux-hardening@vger.kernel.org>
Subject: Re: [PATCH] powerpc/signal32: Use struct_group() to zero spe regs
Message-ID: <202111221247.B385EA2A8@keescook>
References: <20211118203604.1288379-1-keescook@chromium.org>
 <1e312cbd-cd52-ddce-f839-db765173c526@csgroup.eu>
 <87ilwkrbhz.fsf@mpe.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87ilwkrbhz.fsf@mpe.ellerman.id.au>
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Mon, Nov 22, 2021 at 04:43:36PM +1100, Michael Ellerman wrote:
> LEROY Christophe <christophe.leroy@csgroup.eu> writes:
> > Le 18/11/2021 à 21:36, Kees Cook a écrit :
> >> In preparation for FORTIFY_SOURCE performing compile-time and run-time
> >> field bounds checking for memset(), avoid intentionally writing across
> >> neighboring fields.
> >> 
> >> Add a struct_group() for the spe registers so that memset() can correctly reason
> >> about the size:
> >> 
> >>     In function 'fortify_memset_chk',
> >>         inlined from 'restore_user_regs.part.0' at arch/powerpc/kernel/signal_32.c:539:3:
> >>     >> include/linux/fortify-string.h:195:4: error: call to '__write_overflow_field' declared with attribute warning: detected write beyond size of field (1st parameter); maybe use struct_group()? [-Werror=attribute-warning]
> >>       195 |    __write_overflow_field();
> >>           |    ^~~~~~~~~~~~~~~~~~~~~~~~
> >> 
> >> Reported-by: kernel test robot <lkp@intel.com>
> >> Signed-off-by: Kees Cook <keescook@chromium.org>
> >
> > Reviewed-by: Christophe Leroy <christophe.leroy@csgroup.eu>
> 
> Acked-by: Michael Ellerman <mpe@ellerman.id.au>

Thanks! Should I take this via my tree, or do you want to take it via
ppc?

-Kees

-- 
Kees Cook
