Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34ADAC433F5
	for <linux-hardening@archiver.kernel.org>; Thu, 10 Feb 2022 18:42:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234415AbiBJSl6 (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Thu, 10 Feb 2022 13:41:58 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:33390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232299AbiBJSl6 (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Thu, 10 Feb 2022 13:41:58 -0500
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 530B310EA
        for <linux-hardening@vger.kernel.org>; Thu, 10 Feb 2022 10:41:59 -0800 (PST)
Received: by mail-pj1-x1030.google.com with SMTP id c5-20020a17090a1d0500b001b904a7046dso7930039pjd.1
        for <linux-hardening@vger.kernel.org>; Thu, 10 Feb 2022 10:41:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=2Qay4SXcXqCUQIXOF09+29cliVC/ppwG39SV706o69I=;
        b=CG3CEgac/J7CcLrLpcqwqD15ezQ2qtSXIz2G+GP7H2CENISZlNph3GVBcqiTWrJWAg
         ozVzbw04bERVTLcgz7tlsYeaFsLuMp2ozTwZKwgZRHNhON220yOAiKPyVJ/LC/RQlaFh
         xuB/Cb9frKW+g45VBMYRNYiQgGoc1AgyDh338=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=2Qay4SXcXqCUQIXOF09+29cliVC/ppwG39SV706o69I=;
        b=kSHBtY+yWVszNEISeEEZjTcji401s5VvmZjUOJYCae69YtbJDXIL48kBj4ZOrybXGY
         67wZzkFvFjffGPcryKz+f5NCkllK16cFtntj+gBSM3uHkUb3uSdX1wrPEgkdk0NTN7b9
         +4dKThQ/QKtJ7ithPEIKymvJrBsXhsUY5LV8Kfiw2KJWBg0WCpvCTJKzloLMOYrKwBxQ
         8njgJndOsbjuzD0uJ2eCnFFSX/Qy4510LIKCBmvAUgUiiAW/HH+HXBgm0phC3GkbriTr
         1Xs7Y4KSXESfBbFzJfH+USm7IA1lRMI7EGWlvoj7X7SidPORfK8alrY34gaxb/G0vPIk
         PmxQ==
X-Gm-Message-State: AOAM531c3N+BjSrdyN8zn2xFLqehoZ3yzvrS+GJd8JpiwVk2nwFKHoVD
        YmRmB1SI6b6FK8CW1OeZjQDMuA==
X-Google-Smtp-Source: ABdhPJx8vXCERw7Ukm1fdGhH0SwTAfJ/rtCE6uJFQOX6nt6tQkueL2Z6K0ZXM6/XxeiEyjesCAHnQA==
X-Received: by 2002:a17:903:40ca:: with SMTP id t10mr8817172pld.121.1644518518816;
        Thu, 10 Feb 2022 10:41:58 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id c14sm23138622pfm.169.2022.02.10.10.41.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Feb 2022 10:41:58 -0800 (PST)
Date:   Thu, 10 Feb 2022 10:41:57 -0800
From:   Kees Cook <keescook@chromium.org>
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     Robert =?utf-8?B?xZp3acSZY2tp?= <robert@swiecki.net>,
        Andy Lutomirski <luto@amacapital.net>,
        Will Drewry <wad@chromium.org>, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org
Subject: Re: [PATCH 0/3] signal: HANDLER_EXIT should clear SIGNAL_UNKILLABLE
Message-ID: <202202101033.9C04563D9@keescook>
References: <20220210025321.787113-1-keescook@chromium.org>
 <871r0a8u29.fsf@email.froward.int.ebiederm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <871r0a8u29.fsf@email.froward.int.ebiederm.org>
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Thu, Feb 10, 2022 at 12:17:50PM -0600, Eric W. Biederman wrote:
> Kees Cook <keescook@chromium.org> writes:
> 
> > Hi,
> >
> > This fixes the signal refactoring to actually kill unkillable processes
> > when receiving a fatal SIGSYS from seccomp. Thanks to Robert for the
> > report and Eric for the fix! I've also tweaked seccomp internal a bit to
> > fail more safely. This was a partial seccomp bypass, in the sense that
> > SECCOMP_RET_KILL_* didn't kill the process, but it didn't bypass other
> > aspects of the filters. (i.e. the syscall was still blocked, etc.)
> 
> Any luck on figuring out how to suppress the extra event?

I haven't found a good single indicator of a process being in an "I am dying"
state, and even if I did, it seems every architecture's exit path would
need to add a new test.

The best approach seems to be clearing the TIF_*WORK* bits, but that's
still a bit arch-specific. And I'm not sure which layer would do that.
At what point have we decided the process will not continue? More
than seccomp was calling do_exit() in the middle of a syscall, but those
appear to have all been either SIGKILL or SIGSEGV?

-- 
Kees Cook
