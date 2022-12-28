Return-Path: <linux-hardening-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87C09C46467
	for <linux-hardening@archiver.kernel.org>; Wed, 28 Dec 2022 01:47:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229632AbiL1BrD (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Tue, 27 Dec 2022 20:47:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232500AbiL1Bqn (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Tue, 27 Dec 2022 20:46:43 -0500
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6887ADFC6
        for <linux-hardening@vger.kernel.org>; Tue, 27 Dec 2022 17:46:42 -0800 (PST)
Received: by mail-pf1-x429.google.com with SMTP id c9so4963800pfj.5
        for <linux-hardening@vger.kernel.org>; Tue, 27 Dec 2022 17:46:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=1VAg9I6sGgystoJ3TQ/I1KhSIRtbmfENt04grq0O1eU=;
        b=ka7NTMQ0c8GwGaYNC4TLnUyVjpW/DOHmjrxHXinFVEpU9D9Duc65ev4L/I5G73dWFo
         chfrWJakpcYJmHmRro4TIZeN1yLCHJb/DDm2nSOO4GLssDl7OCu1793DakqfQqVt/GN0
         6mmm3+zJsoTSrWcARVMJNzTS6JnSpgk966ZpD+Vw5s7TTxvX0gV5PkvRUGT+1x75lnaR
         jSuEiVKum/kJ6BHwWnMwYKo40m+jhgnT4J48TJ06rTkYD/+fjnvOWcvA9thKZIIEnikH
         ndI2b7DduJ3WmXKQobI2rErE52wlocqfmB77yUXPlOIX7HoGskdAKk83uK5OMHrB6WJm
         Bt3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1VAg9I6sGgystoJ3TQ/I1KhSIRtbmfENt04grq0O1eU=;
        b=k8alViwOp4juZfTGDmZLh5nnENeoRtd+I2mSx7i0LmqsPawCyDZetDW2ZbtBsRiMEe
         z91NQC19vu0bFyMPLOJiX1xxwyS+R+myNCCopGjqVlTQG4leorrhQiAdMQHDRQZOZ+qR
         eG49mq1Nd02ixjRSEmFLUo0VUn+3YZ2cOY3FziniXsjn/1YacqAXA6B2juRUrUOpEeq3
         Z9J6sOayxJ0g5c/aXpskckV1KHhz6fM6mBAwlrfYkfiyCPTDbYg0nkNZSeEHJgACNA1f
         rP7rsKVrbfEVQ/JLMfwJV0sG7th6enAq20wHQTvqu4ocJ/P/3iaE85JuX2bnUJ+MPKVq
         K7+A==
X-Gm-Message-State: AFqh2kpqC47w4m/V2/xm0MyqJYW6JjBhKOeMGIe/mW8cNpH4KNyoWgGD
        evnnXWufxSbYDSR58yKzO7yRGw==
X-Google-Smtp-Source: AMrXdXs5gFho3jeOXwhmodws3dxxhHKTouLxX4u+ck0jgPmPtTo/nc3FPPXMYElaqZB+vWfHJzxyyg==
X-Received: by 2002:a62:6486:0:b0:576:22d7:fd9e with SMTP id y128-20020a626486000000b0057622d7fd9emr1989207pfb.0.1672192001796;
        Tue, 27 Dec 2022 17:46:41 -0800 (PST)
Received: from [2620:15c:29:203:93f7:84:3b7b:8294] ([2620:15c:29:203:93f7:84:3b7b:8294])
        by smtp.gmail.com with ESMTPSA id h135-20020a62838d000000b005754106e364sm9060069pfe.199.2022.12.27.17.46.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Dec 2022 17:46:41 -0800 (PST)
Date:   Tue, 27 Dec 2022 17:46:40 -0800 (PST)
From:   David Rientjes <rientjes@google.com>
To:     Gou Hao <gouhao@uniontech.com>
cc:     cl@linux.com, penberg@kernel.org, iamjoonsoo.kim@lge.com,
        akpm@linux-foundation.org, vbabka@suse.cz,
        roman.gushchin@linux.dev, 42.hyeyoo@gmail.com,
        keescook@chromium.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org,
        mingo@elte.hu
Subject: Re: [PATCH V2] mm/slab: remove unused slab_early_init
In-Reply-To: <20221218123127.23810-1-gouhao@uniontech.com>
Message-ID: <544c9bd1-c262-1915-de79-d6e00109eff4@google.com>
References: <20221218123127.23810-1-gouhao@uniontech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Sun, 18 Dec 2022, gouhao@uniontech.com wrote:

> From: Gou Hao <gouhao@uniontech.com>
> 
> 'slab_early_init' was introduced by 'commit e0a42726794f
> ("[PATCH] mm/slab.c: fix early init assumption")', this
> flag was used to prevent off-slab caches being created
> so early during bootup.
> 
> The only user of 'slab_early_init' was removed in 'commit
>  3217fd9bdf00 ("mm/slab: make criteria for off slab
> determination robust and simple")'.
> 
> Signed-off-by: Gou Hao <gouhao@uniontech.com>
> Acked-by: Hyeonggon Yoo <42.hyeyoo@gmail.com>

Acked-by: David Rientjes <rientjes@google.com>
