Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7890C433EF
	for <linux-hardening@archiver.kernel.org>; Thu, 30 Sep 2021 18:12:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 843A86140F
	for <linux-hardening@archiver.kernel.org>; Thu, 30 Sep 2021 18:12:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353207AbhI3SOR (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Thu, 30 Sep 2021 14:14:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353144AbhI3SOP (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Thu, 30 Sep 2021 14:14:15 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C29EC06176A
        for <linux-hardening@vger.kernel.org>; Thu, 30 Sep 2021 11:12:32 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id qe4-20020a17090b4f8400b0019f663cfcd1so964418pjb.1
        for <linux-hardening@vger.kernel.org>; Thu, 30 Sep 2021 11:12:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=/jP68Qb3IOmFZtyBmCWtI8sRKP1bO4xuJlNxJXxFMLo=;
        b=eEsa6HUQ1ug8JocDGdLB7jS8rTRNf4nqyY/oodN6m4TktfoLZ4ty8Nb+FwT5sZ/zkF
         sMO73naAZDcBp4UQBX3l3Wunm9J9cMJrljTMO5D0Ch/WSk8j2E+ZZ5dpjxsFahZZewX3
         mPfNaddSe5vK2Ko8GUCIHmjLbKcAxLL058uts=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=/jP68Qb3IOmFZtyBmCWtI8sRKP1bO4xuJlNxJXxFMLo=;
        b=5YW+WpDvJLpDTxYT7iOyxtHQl+xdieXfUFr3MT1qJfOX29a2D7UmoWsst38IoGCcDk
         FwqM8TdbZpLN9u0ohEVW8tSgNkf5KtODgRf2IEpqPIAHrejnYE4/j5PmONyUAOnx9Lzj
         yeA74U6eaSJgmnawUZ51gg0pwsUcKRZFy+jBMJLewb0QJ2yWY9vVbo97KrKSLcrBqREU
         lpYJQonZdWvgJjupEffk5ZjAyBVrbROvqq+YLK12INTp88eQgX7Tjwke/JMsRElp8309
         I4SxCj7K5w8M0bKPnTJN5aYKxDbaVeeXMmgesS2Etw2tzklOstZG7KuYdxZjEhocd+8E
         7+UQ==
X-Gm-Message-State: AOAM533DpQ61NcBv1sklDMeEyjAQZgyG8Uba9/DfF5J7EcebKFwApgcP
        kNDL54+zwNjU8/hllYKpiTarOA==
X-Google-Smtp-Source: ABdhPJwA6GX/vcgv5ngu+bjUf2n7PrKcV867/lIhgcPiU4+jQau4QO3qCBLPDhd9B03CglGFhKlpuA==
X-Received: by 2002:a17:902:b193:b029:11a:a179:453a with SMTP id s19-20020a170902b193b029011aa179453amr5469195plr.69.1633025551776;
        Thu, 30 Sep 2021 11:12:31 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id o3sm5391243pjq.34.2021.09.30.11.12.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Sep 2021 11:12:31 -0700 (PDT)
Date:   Thu, 30 Sep 2021 11:12:30 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Stephen Brennan <stephen.s.brennan@oracle.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Vito Caputo <vcaputo@pengaru.com>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, Jens Axboe <axboe@kernel.dk>,
        Mark Rutland <mark.rutland@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Stefan Metzmacher <metze@samba.org>,
        Andy Lutomirski <luto@kernel.org>,
        Lai Jiangshan <laijs@linux.alibaba.com>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Kenta.Tada@sony.com" <Kenta.Tada@sony.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Michael =?iso-8859-1?Q?Wei=DF?= 
        <michael.weiss@aisec.fraunhofer.de>,
        Anand K Mistry <amistry@google.com>,
        Alexey Gladkov <legion@kernel.org>,
        Michal Hocko <mhocko@suse.com>, Helge Deller <deller@gmx.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andrea Righi <andrea.righi@canonical.com>,
        Ohhoon Kwon <ohoono.kwon@samsung.com>,
        Kalesh Singh <kaleshsingh@google.com>,
        YiFei Zhu <yifeifz2@illinois.edu>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        linux-kernel@vger.kernel.org, x86@kernel.org,
        linux-fsdevel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH] proc: Disable /proc/$pid/wchan
Message-ID: <202109301109.4E172219@keescook>
References: <20210923233105.4045080-1-keescook@chromium.org>
 <c283c978-2563-06b9-4c21-59bedceda9ea@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c283c978-2563-06b9-4c21-59bedceda9ea@oracle.com>
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Thu, Sep 30, 2021 at 11:05:35AM -0700, Stephen Brennan wrote:
> On 9/23/21 4:31 PM, Kees Cook wrote:
> > The /proc/$pid/wchan file has been broken by default on x86_64 for 4
> > years now[1]. As this remains a potential leak of either kernel
> > addresses (when symbolization fails) or limited observation of kernel
> > function progress, just remove the contents for good.
> > 
> > Unconditionally set the contents to "0" and also mark the wchan
> > field in /proc/$pid/stat with 0.
> 
> Hi all,
> 
> It looks like there's already been pushback on this idea, but I wanted
> to add another voice from a frequent user of /proc/$pid/wchan (via PS).
> Much of my job involves diagnosing kernel issues and performance issues
> on stable kernels, frequently on production systems where I can't do
> anything too invasive. wchan is incredibly useful for these situations,
> so much so that we store regular snapshots of ps output, and we expand
> the size of the WCHAN column to fit more data (e.g. ps -e -o
> pid,wchan=WCHAN-WIDE-COLUMN). Disabling wchan would remove a critical
> tool for me and my team.

Thanks for speaking up! Yes, we've moved to fixing wchan correctly as
it's clear it's still very much in use. :) Current thread is here:
https://lore.kernel.org/lkml/20210929220218.691419-1-keescook@chromium.org/

-- 
Kees Cook
