Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56373C433EF
	for <linux-hardening@archiver.kernel.org>; Wed, 20 Apr 2022 02:42:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358965AbiDTCp3 (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Tue, 19 Apr 2022 22:45:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344734AbiDTCp2 (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Tue, 19 Apr 2022 22:45:28 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BD6437BD6
        for <linux-hardening@vger.kernel.org>; Tue, 19 Apr 2022 19:42:44 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id md4so594789pjb.4
        for <linux-hardening@vger.kernel.org>; Tue, 19 Apr 2022 19:42:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Vfe+Bo823sceHSMTTMCrGjAFXbrqNJngyy3/uN1hL1I=;
        b=MUANZlDdci93YXmyvk7nXE97lb09WlyFylCgklEfOHlREsE5OkC7hfuVnPnuyPpKjC
         JzLygb+5F8nGWablsLdvHDn2ZTpGPyEeVR1Zxa38DsbCW+NLeNn1i3vKMvvZqoEcpDtT
         MvpgTGV40uu+7drFOoCFkbwuFa7nqFXT+o7TQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Vfe+Bo823sceHSMTTMCrGjAFXbrqNJngyy3/uN1hL1I=;
        b=pV1J1l9NX5ZygEGETl83MuPwMayvyPJNxr9jkhgu+vYnP/DVg39vhlmibu++ukobA5
         cabTSWfnc30IQDvW8mKv4FMkl7ouFgY2QwNbU1NlT9VL2tkrntcZ/gFwsAiSRRo4R7v9
         V8iMSjJGzL6vf70Kn1v/PqTw7cT8H1/YRTwwk0JupmoiJnCc4YaQRGmhCfcXSG7HLn2c
         OHfz8E7ZBVmSHYCvN2dlHR3dkA0Zd4IE3WYP+TuNkHcUm6dfwBKBDJc7Mgh1F/KYqmO6
         6iuVzTds/lDB7bYNvEPgfmM1lCbpHatMIsWlt+ddMWgEBLDWPQCKcSjFegRAhHcynWjJ
         EiCg==
X-Gm-Message-State: AOAM533IyYWfo6YuxNwgHyGozV4YoSx17vSe01/fAv4bHBZ3bXopUbth
        B9h5LhxBQFYcnCfShkCNSX+JNw==
X-Google-Smtp-Source: ABdhPJwcbF3zvvNRv1yktmDfMhCKXAAAPtr8AO3e++qx5yZz54gLhHTMNEUZXAV+ruHi2jGCY5n6tQ==
X-Received: by 2002:a17:902:7489:b0:158:8868:5030 with SMTP id h9-20020a170902748900b0015888685030mr19057499pll.132.1650422563800;
        Tue, 19 Apr 2022 19:42:43 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id p27-20020a056a000a1b00b004f3f63e3cf2sm19763951pfh.58.2022.04.19.19.42.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Apr 2022 19:42:43 -0700 (PDT)
Date:   Tue, 19 Apr 2022 19:42:42 -0700
From:   Kees Cook <keescook@chromium.org>
To:     joao@overdrivepizza.com
Cc:     linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org,
        peterz@infradead.org, jpoimboe@redhat.com,
        andrew.cooper3@citrix.com, samitolvanen@google.com,
        mark.rutland@arm.com, hjl.tools@gmail.com,
        alyssa.milburn@linux.intel.com, ndesaulniers@google.com,
        gabriel.gomes@linux.intel.com, rick.p.edgecombe@intel.com
Subject: Re: [RFC PATCH 00/11] Kernel FineIBT Support
Message-ID: <202204191937.2720E7E@keescook>
References: <20220420004241.2093-1-joao@overdrivepizza.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220420004241.2093-1-joao@overdrivepizza.com>
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

Hi!

On Tue, Apr 19, 2022 at 05:42:30PM -0700, joao@overdrivepizza.com wrote:
> I'm considering detaching the prototype fixes from this series and reworking
> them to submit actual fixes (patches 10 and 11). Any specific suggestions for
> these specific patches? Maybe you want to take a look and help in co-authorship
> as we did with the void*-in-x86-crypto patches in the past? I guess these are
> useful for whatever CFI scheme is in place.

Yeah, if 10 and 11 are general prototype-based fixes, let's get them in.
I would expect regular CFI and kCFI to trip over those too. I'll comment
on those patches directly.

> Any other major concerns, ideas, or suggestions? :)

I think it'd be good to get kCFI landed in Clang first (since it is
effectively architecture agnostic), and then get FineIBT landed. But
that doesn't mean we can't be working on the kernel side of things at
the same time.

And just thinking generally, for other architecture-specific stuff,
I do wonder what an arm64 PAC-based CFI might look like. I prefer things
be hard-coded as kCFI is doing, but it'd be nice to be able to directly
measure performance and size overheads comparing the various methods.

-- 
Kees Cook
