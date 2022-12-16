Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2630CC46467
	for <linux-hardening@archiver.kernel.org>; Fri, 16 Dec 2022 20:35:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231414AbiLPUfO (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Fri, 16 Dec 2022 15:35:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230389AbiLPUfN (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Fri, 16 Dec 2022 15:35:13 -0500
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94EA4419B1
        for <linux-hardening@vger.kernel.org>; Fri, 16 Dec 2022 12:35:12 -0800 (PST)
Received: by mail-pl1-x634.google.com with SMTP id w23so3398325ply.12
        for <linux-hardening@vger.kernel.org>; Fri, 16 Dec 2022 12:35:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=r/hPsvfVFhvh9haGKLunftTxDivO3JDSv2xgcZcDsPA=;
        b=HvYgLvzKyB+qontqJaRxw4JCx5keeHG+fJkK4euqza/veNJBrv8ioB2lE6IXO0VI3n
         esNkVZN37PeYArveZqKULuIZn7F1HgLhZ7ZOg+3+Q1JX2YF8qc0w9Jp9AkLmPCAxaHXq
         9NQKhQSoi5qpbGUeWi2a7tg62N+alAyY5VjrQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=r/hPsvfVFhvh9haGKLunftTxDivO3JDSv2xgcZcDsPA=;
        b=Q6PrCQC2vhKDeZhzI3kfSNiuQnpnFXP4G3ycc4uQmN4czg5u7aAVhzdtb//7lFB/8v
         fwXSBJZluMhF3H37Wp+busXJ3Wees9/11jHlFYesQ9UsPjGJFsgMZJjqnBOFAXrFxKoL
         Yeri6xz55TcejL6YowmZPYGAK6y075HgbYaSwIWENvSp5LuJ8TrYi7ImS2HhQaT+VCkQ
         fzdkurcTmrY1HwWMQE4uzXcpRvgK6vlbWNTvsHDUa2jGLWigluadah5EGBcBYca5szXq
         ROt+vqVDSi0bGp87yxwLUvDFWokPhuI+q8Qy4iUKRbiGRvadLqk5tW29rxezXNapuCVH
         TVWg==
X-Gm-Message-State: AFqh2krWBxG/PuqOtb1D7VZ7+Jn22tsOC3t9R/R58jtOCxpzI6esArYr
        yEHcsiV7AkTi7R2VyGeK3DFmbw==
X-Google-Smtp-Source: AMrXdXt8w3fEbmDbvTVO1Z+Z3U9o6ttyQJonRnCieP1HRMjM8XxbOprdtKK2Ib64+zi1S8WdDE+mjA==
X-Received: by 2002:a17:902:d4c6:b0:191:a19:e768 with SMTP id o6-20020a170902d4c600b001910a19e768mr1842628plg.48.1671222912139;
        Fri, 16 Dec 2022 12:35:12 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id i4-20020a17090332c400b0018913417ba2sm2039045plr.130.2022.12.16.12.35.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Dec 2022 12:35:11 -0800 (PST)
Date:   Fri, 16 Dec 2022 12:35:10 -0800
From:   Kees Cook <keescook@chromium.org>
To:     Jeff Xu <jeffxu@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Peter Xu <peterx@redhat.com>, jeffxu@chromium.org,
        skhan@linuxfoundation.org, dmitry.torokhov@gmail.com,
        dverkamp@chromium.org, hughd@google.com, jorgelo@chromium.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-mm@kvack.org, jannh@google.com,
        linux-hardening@vger.kernel.org, kernel test robot <lkp@intel.com>
Subject: Re: [PATCH v6 3/6] mm/memfd: add MFD_NOEXEC_SEAL and MFD_EXEC
Message-ID: <202212161233.85C9783FB@keescook>
References: <20221207154939.2532830-1-jeffxu@google.com>
 <20221207154939.2532830-4-jeffxu@google.com>
 <202212080821.5AE7EE99@keescook>
 <CALmYWFuKR538vHxqYH1p6mb9iShOohf5bpHZXSfUN4KQHYiwaA@mail.gmail.com>
 <Y5yS8wCnuYGLHMj4@x1n>
 <CALmYWFsDhX76zbcyhYAW-u0BBwD+m+TKpt4_pZTMt+22zHhrGQ@mail.gmail.com>
 <20221216094259.bec91e4abd6cf54a05ce2813@linux-foundation.org>
 <CALmYWFsNp87a5uVQUAb4PG0khFN8Xxd=ibh9Q7g-Y0XW1Mn-8Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALmYWFsNp87a5uVQUAb4PG0khFN8Xxd=ibh9Q7g-Y0XW1Mn-8Q@mail.gmail.com>
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Fri, Dec 16, 2022 at 10:11:44AM -0800, Jeff Xu wrote:
> Once per boot seems too little, it would be nice if we can list all processes.
> I agree ratelimited might be too much.
> There is a feature gap here for logging.
> 
> Kees, what do you think ?

I agree once per boot is kind of frustrating "I fixed the one warning,
oh, now it's coming from a different process". But ratelimit is, in
retrospect, still too often.

Let's go with per boot -- this should be noisy "enough" to get the
changes in API into the callers without being too much of a hassle.

-- 
Kees Cook
