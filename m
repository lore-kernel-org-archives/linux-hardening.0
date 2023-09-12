Return-Path: <linux-hardening-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8F34CA0EF1
	for <linux-hardening@archiver.kernel.org>; Tue, 12 Sep 2023 16:17:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230017AbjILQRF (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Tue, 12 Sep 2023 12:17:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236631AbjILQRE (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Tue, 12 Sep 2023 12:17:04 -0400
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BD1F170B
        for <linux-hardening@vger.kernel.org>; Tue, 12 Sep 2023 09:16:51 -0700 (PDT)
Received: by mail-pl1-x62c.google.com with SMTP id d9443c01a7336-1c0ecb9a075so42329965ad.2
        for <linux-hardening@vger.kernel.org>; Tue, 12 Sep 2023 09:16:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1694535410; x=1695140210; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=3MwTmVCnTEtep42XfZ4TFNmY2WBZrbi61crWobHgN3g=;
        b=Di/pYOvOx6BrbKT0ulFIXzTSJzyRgbbkdiDf9xJFVT9xuSQXHImOAp/YOPRBHuaPWj
         b9t2ACtmrjG+EamXtXVYG+7nUqs7FkicicnvgjFLlBe7IKpLXRvAcK/U4Y1dElJOS9cv
         L3/m+oTetympjCxqiqG4OVaEsP1myv+vC9KlU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694535410; x=1695140210;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3MwTmVCnTEtep42XfZ4TFNmY2WBZrbi61crWobHgN3g=;
        b=RGK8+jbn2/XUhdgg20ZxEONshm+CrOHDFpTYYu7uCf8rgrlpM08pRvoo87+KqIa01B
         K+xYeHahEY77wYD5D3ytZAD2VFcJcjqb2/GogfuFhEiN15csAlfdiE10PCA1gNP0YgO+
         Gv+FTDp4BxUKTXaBXBMvl0heyXFlJQ20iS+RlA1ecXndhvRBNs+i376jxFdBMfh3DFB+
         1xcU3jaLozA4KVE9NPSDMtgadRsCIHjtJruPePBApkqaPV6sxOFROLFAPaDRiYyo0oBH
         qVSa5Ju9VFQ86uVotLLTXu2VV7islXtaoW/X7cOCRswjwfAfGqgfgiXoEKQPaUbXN0RE
         umMA==
X-Gm-Message-State: AOJu0Yx4hClYmxvPCQl82YoIn9Exlb7M2YVxwHDwhifA9X5tGIfrADDU
        RgYdwaey/z7VBZvPls6xr01llg==
X-Google-Smtp-Source: AGHT+IEl/c3bl7m/pr2Ark1A+7Rka01Cb400iuEhzUjlRm3MNTOq7Gn0sjiWvD3rr/lJGDYA1zlGiQ==
X-Received: by 2002:a17:902:ab15:b0:1c1:de3a:d3d7 with SMTP id ik21-20020a170902ab1500b001c1de3ad3d7mr186339plb.68.1694535410652;
        Tue, 12 Sep 2023 09:16:50 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id 5-20020a170902e9c500b001bb04755212sm8608895plk.228.2023.09.12.09.16.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Sep 2023 09:16:50 -0700 (PDT)
Date:   Tue, 12 Sep 2023 09:16:49 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Przemek Kitszel <przemyslaw.kitszel@intel.com>
Cc:     netdev@vger.kernel.org, Jakub Kicinski <kuba@kernel.org>,
        davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
        Jacob Keller <jacob.e.keller@intel.com>,
        intel-wired-lan@lists.osuosl.org,
        Alexander Lobakin <aleksander.lobakin@intel.com>,
        linux-hardening@vger.kernel.org, Steven Zou <steven.zou@intel.com>,
        Anthony Nguyen <anthony.l.nguyen@intel.com>,
        David Laight <David.Laight@aculab.com>
Subject: Re: [PATCH net-next v5 0/7] introduce DEFINE_FLEX() macro
Message-ID: <202309120916.5313AE37C5@keescook>
References: <20230912115937.1645707-1-przemyslaw.kitszel@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230912115937.1645707-1-przemyslaw.kitszel@intel.com>
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Tue, Sep 12, 2023 at 07:59:30AM -0400, Przemek Kitszel wrote:
> Add DEFINE_FLEX() macro, that helps on-stack allocation of structures
> with trailing flex array member.
> Expose __struct_size() macro which reads size of data allocated
> by DEFINE_FLEX().
> 
> Accompany new macros introduction with actual usage,
> in the ice driver - hence targeting for netdev tree.
> 
> Obvious benefits include simpler resulting code, less heap usage,
> less error checking. Less obvious is the fact that compiler has
> more room to optimize, and as a whole, even with more stuff on the stack,
> we end up with overall better (smaller) report from bloat-o-meter:
> add/remove: 8/6 grow/shrink: 7/18 up/down: 2211/-2270 (-59)
> (individual results in each patch).
> 
> v5: same as v4, just not RFC
> v4: _Static_assert() to ensure compiletime const count param
> v3: tidy up 1st patch
> v2: Kees: reusing __struct_size() instead of doubling it as a new macro
> 
> Przemek Kitszel (7):
>   overflow: add DEFINE_FLEX() for on-stack allocs
>   ice: ice_sched_remove_elems: replace 1 elem array param by u32
>   ice: drop two params of ice_aq_move_sched_elems()
>   ice: make use of DEFINE_FLEX() in ice_ddp.c
>   ice: make use of DEFINE_FLEX() for struct ice_aqc_add_tx_qgrp
>   ice: make use of DEFINE_FLEX() for struct ice_aqc_dis_txq_item
>   ice: make use of DEFINE_FLEX() in ice_switch.c

Looks good to me! Feel free to pick up via netdev.

-Kees

-- 
Kees Cook
