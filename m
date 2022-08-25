Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D014ECAA29
	for <linux-hardening@archiver.kernel.org>; Thu, 25 Aug 2022 18:17:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241669AbiHYSRC (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Thu, 25 Aug 2022 14:17:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242794AbiHYSQp (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Thu, 25 Aug 2022 14:16:45 -0400
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com [IPv6:2607:f8b0:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71291BD2AB
        for <linux-hardening@vger.kernel.org>; Thu, 25 Aug 2022 11:16:14 -0700 (PDT)
Received: by mail-pg1-x529.google.com with SMTP id g189so4518703pgc.0
        for <linux-hardening@vger.kernel.org>; Thu, 25 Aug 2022 11:16:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc;
        bh=UaiqgHwN7QwDf4IOEVa86wivukf0FA6pHqglaq9BlgU=;
        b=LUymUsCUVfzt75h61u7VtSSmc5Rkj2HMPqz13ns4u3yoSD7T0QTAvx2wsB858pgjaZ
         8zdSLZRYJl68R8aTWTJVMwyyOwIwoEyK5jLik3m27AGSAeQGw3DLynFmuhngLiLJiUfi
         tn/WVa40JKjlFq9egNclhEg9azAJh09IcEZBs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
        bh=UaiqgHwN7QwDf4IOEVa86wivukf0FA6pHqglaq9BlgU=;
        b=YbxI10mJixqbTBm+6PUTdeBGTFrLkPHUwiFebtc1jvUezC4hdpv0sJ3ERU/Kwmybmu
         DPkRYrh1jp+5I2R1n6K4pZXXIl4kkVfdSemjpihm5sXNKGVL9A+iwztObzc8w6/NpJBw
         bMny7MVKxxRnJ7YEhxMShJRLX7HJ5XoxUL0pyBoi3UpmQdDRDhyGqRhApZcMhhBJvQpv
         8YMNAnDNiFciLLU34dSV8gNnewvas/nHTSWnwH6GNYxJUSMVLmYkUlboRp/Vg/c+K5J+
         LWnWivOe0NVV7c2EHP83pNn9e6t+z5RcU/o5juuXNd1BoU6caf6UjhLPFi94GCzpAjAt
         SPaQ==
X-Gm-Message-State: ACgBeo3XtEmiQvijYD5xRNUV7k1Y/7DRKtMjNTG46G+ayLOUg5nw++VW
        wqt5cfaRtZ4bKhReM5108LFvDA==
X-Google-Smtp-Source: AA6agR7vXU3/PHLjO46gLQpghsjh4seD/+QIvWck1t+y6lpotqhk+fPvyEJj0b6LgoZ1lGIIRCZGTA==
X-Received: by 2002:a62:1441:0:b0:536:ac1:504b with SMTP id 62-20020a621441000000b005360ac1504bmr304529pfu.71.1661451373900;
        Thu, 25 Aug 2022 11:16:13 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id j7-20020a170903024700b00172ea8ff334sm9173730plh.7.2022.08.25.11.16.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Aug 2022 11:16:13 -0700 (PDT)
Date:   Thu, 25 Aug 2022 11:16:12 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Dave Hansen <dave.hansen@intel.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH] x86/mm: Refuse W^X violations
Message-ID: <202208251113.B5AFA6D@keescook>
References: <YwdpwykpV9RB+4tL@worktop.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YwdpwykpV9RB+4tL@worktop.programming.kicks-ass.net>
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Thu, Aug 25, 2022 at 02:23:31PM +0200, Peter Zijlstra wrote:
> x86 has STRICT_*_RWX, but not even a warning when someone violates it.

Yes please. I assume this is only kernel pages? Doing this globally is
nice too, but runs into annoying problems[1].

-Kees

[1] https://lore.kernel.org/all/20220701130444.2945106-1-ardb@kernel.org/

-- 
Kees Cook
