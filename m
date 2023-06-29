Return-Path: <linux-hardening-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 364EDEB64DD
	for <linux-hardening@archiver.kernel.org>; Thu, 29 Jun 2023 19:56:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230353AbjF2T4L (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Thu, 29 Jun 2023 15:56:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231543AbjF2T4J (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Thu, 29 Jun 2023 15:56:09 -0400
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0D642D4C
        for <linux-hardening@vger.kernel.org>; Thu, 29 Jun 2023 12:56:02 -0700 (PDT)
Received: by mail-pf1-x436.google.com with SMTP id d2e1a72fcca58-666e6541c98so1014162b3a.2
        for <linux-hardening@vger.kernel.org>; Thu, 29 Jun 2023 12:56:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1688068562; x=1690660562;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=79zP5YHFLGBu1+jfogz5W0vV+Z/KFoVgf5MKidFMDlI=;
        b=COCl/U/c9SsKrj00+ygesw3WObTx3Osmqaz88cXeEi0v16GehgR4AlXwfn6v4ktv5I
         C10xGRe6FXsRNz9GEZSDN0VUenIdW6qee5G9xjkEUo9iK7AYDUHEUJP+LhlE4uP5GoTc
         yWmHeuNNBPf3DUPsveyOZm//CrDB/mUonJ6zE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688068562; x=1690660562;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=79zP5YHFLGBu1+jfogz5W0vV+Z/KFoVgf5MKidFMDlI=;
        b=LW8xYdHXPLZeJM25JS0rz9XRhTEeJBtD6nofVD4QwrbJ9yntuRju8g0bFyzMM67iAp
         bQT9DptANXxVHuCxyp5R9GOCaEOX/FiCjuLCvu0yvMTbyQ4dpS/TozRmWdUxwNYS7TEo
         HEw5El3IZtGZxPs+ttyxBPsF2nebQ9TnbFiC8X7PMFIsBsFGNulpjqRcVyGOA5f5GYx6
         uUX/2Qtv8gYEDcqqzmqAGOXwcjlkjDphHE0i3KRPeqkkdTCFVKhEt02C4gEBYdb36mfR
         UVvKpp/ArgF26F6kfogNKjmc07B4sOkmq9O3GS+42tOBDldvErxEKn82kd0a69omveWL
         VEGQ==
X-Gm-Message-State: ABy/qLY3Zn9wv5xX+lE5ABSJqGk03A8d0TA92dvl86+52XX77LhEgmce
        zH4iUiGhvdNvlRckGwc3bjLgVg==
X-Google-Smtp-Source: APBJJlEbzji2f8hgYz10MuxdvDgsWischUCXYiFpjLORWOWrkG+Dgz+uKmmLCE30mTNIIFno7FxPWQ==
X-Received: by 2002:a05:6a00:2d1d:b0:680:98c:c595 with SMTP id fa29-20020a056a002d1d00b00680098cc595mr1171263pfb.13.1688068562212;
        Thu, 29 Jun 2023 12:56:02 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id h18-20020a62b412000000b0067c9ff80b64sm4590241pfn.113.2023.06.29.12.56.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Jun 2023 12:56:01 -0700 (PDT)
Date:   Thu, 29 Jun 2023 12:56:00 -0700
From:   Kees Cook <keescook@chromium.org>
To:     "GONG, Ruiqi" <gongruiqi@huaweicloud.com>
Cc:     Vlastimil Babka <vbabka@suse.cz>,
        Andrew Morton <akpm@linux-foundation.org>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        David Rientjes <rientjes@google.com>,
        Pekka Enberg <penberg@kernel.org>,
        Christoph Lameter <cl@linux.com>, Tejun Heo <tj@kernel.org>,
        Dennis Zhou <dennis@kernel.org>,
        Alexander Potapenko <glider@google.com>,
        Marco Elver <elver@google.com>, Jann Horn <jannh@google.com>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Hyeonggon Yoo <42.hyeyoo@gmail.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Alexander Lobakin <aleksander.lobakin@intel.com>,
        Pedro Falcato <pedro.falcato@gmail.com>,
        Paul Moore <paul@paul-moore.com>,
        James Morris <jmorris@namei.org>,
        "Serge E . Hallyn" <serge@hallyn.com>,
        Markus Elfring <Markus.Elfring@web.de>,
        Wang Weiyang <wangweiyang2@huawei.com>,
        Xiu Jianfeng <xiujianfeng@huawei.com>, linux-mm@kvack.org,
        linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org,
        gongruiqi1@huawei.com
Subject: Re: [PATCH v4] Randomized slab caches for kmalloc()
Message-ID: <202306291252.F916884987@keescook>
References: <20230626031835.2279738-1-gongruiqi@huaweicloud.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230626031835.2279738-1-gongruiqi@huaweicloud.com>
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Mon, Jun 26, 2023 at 11:18:35AM +0800, GONG, Ruiqi wrote:
> When exploiting memory vulnerabilities, "heap spraying" is a common
> technique targeting those related to dynamic memory allocation (i.e. the
> "heap"), and it plays an important role in a successful exploitation.
> Basically, it is to overwrite the memory area of vulnerable object by
> triggering allocation in other subsystems or modules and therefore
> getting a reference to the targeted memory location. It's usable on
> various types of vulnerablity including use after free (UAF), heap out-
> of-bound write and etc.
> 
> There are (at least) two reasons why the heap can be sprayed: 1) generic
> slab caches are shared among different subsystems and modules, and
> 2) dedicated slab caches could be merged with the generic ones.
> Currently these two factors cannot be prevented at a low cost: the first
> one is a widely used memory allocation mechanism, and shutting down slab
> merging completely via `slub_nomerge` would be overkill.
> 
> To efficiently prevent heap spraying, we propose the following approach:
> to create multiple copies of generic slab caches that will never be
> merged, and random one of them will be used at allocation. The random
> selection is based on the address of code that calls `kmalloc()`, which
> means it is static at runtime (rather than dynamically determined at
> each time of allocation, which could be bypassed by repeatedly spraying
> in brute force). In other words, the randomness of cache selection will
> be with respect to the code address rather than time, i.e. allocations
> in different code paths would most likely pick different caches,
> although kmalloc() at each place would use the same cache copy whenever
> it is executed. In this way, the vulnerable object and memory allocated
> in other subsystems and modules will (most probably) be on different
> slab caches, which prevents the object from being sprayed.
> 
> Meanwhile, the static random selection is further enhanced with a
> per-boot random seed, which prevents the attacker from finding a usable
> kmalloc that happens to pick the same cache with the vulnerable
> subsystem/module by analyzing the open source code. In other words, with
> the per-boot seed, the random selection is static during each time the
> system starts and runs, but not across different system startups.
> 
> The overhead of performance has been tested on a 40-core x86 server by
> comparing the results of `perf bench all` between the kernels with and
> without this patch based on the latest linux-next kernel, which shows
> minor difference. A subset of benchmarks are listed below:
> 
>                 sched/  sched/  syscall/       mem/       mem/
>              messaging    pipe     basic     memcpy     memset
>                  (sec)   (sec)     (sec)   (GB/sec)   (GB/sec)
> 
> control1         0.019   5.459     0.733  15.258789  51.398026
> control2         0.019   5.439     0.730  16.009221  48.828125
> control3         0.019   5.282     0.735  16.009221  48.828125
> control_avg      0.019   5.393     0.733  15.759077  49.684759
> 
> experiment1      0.019   5.374     0.741  15.500992  46.502976
> experiment2      0.019   5.440     0.746  16.276042  51.398026
> experiment3      0.019   5.242     0.752  15.258789  51.398026
> experiment_avg   0.019   5.352     0.746  15.678608  49.766343
> 
> The overhead of memory usage was measured by executing `free` after boot
> on a QEMU VM with 1GB total memory, and as expected, it's positively
> correlated with # of cache copies:
> 
>            control  4 copies  8 copies  16 copies
> 
> total       969.8M    968.2M    968.2M     968.2M
> used         20.0M     21.9M     24.1M      26.7M
> free        936.9M    933.6M    931.4M     928.6M
> available   932.2M    928.8M    926.6M     923.9M
> 
> Co-developed-by: Xiu Jianfeng <xiujianfeng@huawei.com>
> Signed-off-by: Xiu Jianfeng <xiujianfeng@huawei.com>
> Signed-off-by: GONG, Ruiqi <gongruiqi@huaweicloud.com>
> Reviewed-by: Kees Cook <keescook@chromium.org>

Thanks for the v4; this looks good. :)

-- 
Kees Cook
