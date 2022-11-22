Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05A2AC4332F
	for <linux-hardening@archiver.kernel.org>; Tue, 22 Nov 2022 04:31:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230139AbiKVEbM (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Mon, 21 Nov 2022 23:31:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229883AbiKVEbL (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Mon, 21 Nov 2022 23:31:11 -0500
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26BDB2251B
        for <linux-hardening@vger.kernel.org>; Mon, 21 Nov 2022 20:31:10 -0800 (PST)
Received: by mail-pl1-x632.google.com with SMTP id 4so12536428pli.0
        for <linux-hardening@vger.kernel.org>; Mon, 21 Nov 2022 20:31:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=MQoC9G5+F/Ju5PfRIYOxwBoO5pKbuPnwuuzZSSIVqIQ=;
        b=ntrjaMOFF4KcRMcRuI/OMTJHDkMcLlQDmb7qkvWl5ufL8qnIt/QiKo/0DNXErjHsKc
         wLl4+tEhemj4Y3R1gD8fzR79SACereQARlyK6w5E7RfsZLLi0RHIAGaKtewUfFKMIuDE
         gHBud7EL1xGOaQLwlHrahzz22C7CUPLRocEg0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MQoC9G5+F/Ju5PfRIYOxwBoO5pKbuPnwuuzZSSIVqIQ=;
        b=phKtSM0RJlUPUZXso4c6zLZMcP2fU4LxrfI1WrBPaLLb6zgCVxjjbpUYILigtjbp8k
         Eobh7IDkLXV93tNLjgopwENoK62/wcfamnnHpwOkOwAccfB1NyaVIkTSavSr90xfpDEd
         AZu3mFJIy2viFUB24D/bAdK56GI2fHg3WTJMX5o7GTHHhegqrZYREyTb1Zukz2+EJvHk
         k0J9O1MmITbou/iqtEmpW/RONTr7Km3snq1bzRKlUXEVMQ5TUiBW7Qt9o/zeicYekgTV
         WnW/saHY4CSJVAaOvX5mEbli840pKS41VOtWbCw9rSflFaaZgq6Xs9sDxwxqxyl5smtE
         Y24Q==
X-Gm-Message-State: ANoB5pmx4Me5N+S9L8IdJRAVmJ7BKaLa2cFRjapFUq0Lpar1XOa8zc9g
        2Qpb6wEvvxQOIt4FAoPm3dSM5g==
X-Google-Smtp-Source: AA0mqf4y3DsoXAZGKeEvsgxTtGZ+Mei0TjiZb4L/folehYpc7k3YX2pDOB7u1A/toObKXGGiEvyIqw==
X-Received: by 2002:a17:90b:3c4c:b0:218:a8a1:933a with SMTP id pm12-20020a17090b3c4c00b00218a8a1933amr10071443pjb.14.1669091469608;
        Mon, 21 Nov 2022 20:31:09 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id h11-20020aa796cb000000b0056c3a0dc65fsm9507750pfq.71.2022.11.21.20.31.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Nov 2022 20:31:08 -0800 (PST)
Date:   Mon, 21 Nov 2022 20:31:07 -0800
From:   Kees Cook <keescook@chromium.org>
To:     Oliver Neukum <oneukum@suse.com>
Cc:     Gregory Greenman <gregory.greenman@intel.com>,
        linux-wireless@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: warning upon association with latest kernel
Message-ID: <202211212026.6959A4CBBC@keescook>
References: <f6cb6803-602f-91e3-8bd3-3bbbd924731d@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f6cb6803-602f-91e3-8bd3-3bbbd924731d@suse.com>
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Wed, Nov 09, 2022 at 04:26:39PM +0100, Oliver Neukum wrote:
> I am getting this warning when I connect to my home
> wifi upon boot:
> 
> [...]
> [ 1321.321889] memcpy: detected field-spanning write (size 16) of single field "&compat_event->pointer" at net/wireless/wext-core.c:624 (size 4)

This should be fixed by commit e3e6e1d16a4c ("wifi: wext: use flex array
destination for memcpy()").

> [...]
> Head commit is:
> 
> commit f141df371335645ce29a87d9683a3f79fba7fd67 (origin/master, origin/HEAD)
> Merge: f49b2d89fb10 986d93f55bde
> Author: Linus Torvalds <torvalds@linux-foundation.org>
> Date:   Tue Nov 8 12:30:29 2022 -0800
> 
>     Merge tag 'audit-pr-20221107' of git://git.kernel.org/pub/scm/linux/kernel/git/pcmoore/audit

Are you sure that's the same kernel? The stated commit no longer has
"&compat_event->pointer" as a memcpy argument...

-- 
Kees Cook
