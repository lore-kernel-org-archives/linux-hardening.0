Return-Path: <linux-hardening-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5790EC001E0
	for <linux-hardening@archiver.kernel.org>; Wed,  2 Aug 2023 20:47:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231521AbjHBUrR (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Wed, 2 Aug 2023 16:47:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229534AbjHBUrQ (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Wed, 2 Aug 2023 16:47:16 -0400
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DB251FF0
        for <linux-hardening@vger.kernel.org>; Wed,  2 Aug 2023 13:47:15 -0700 (PDT)
Received: by mail-pf1-x433.google.com with SMTP id d2e1a72fcca58-686c06b806cso163439b3a.2
        for <linux-hardening@vger.kernel.org>; Wed, 02 Aug 2023 13:47:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20221208.gappssmtp.com; s=20221208; t=1691009235; x=1691614035;
        h=message-id:to:from:cc:in-reply-to:subject:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=xCeI4cJM5i/F1g7PTNSHGiGltpi2DPORCAOXe5MxMI4=;
        b=4dpu5FcCNCNRIyqjOzWmgL+NQSi4gYkmtcikJLhem4DJKp7bF2as4gU6+ek8eDxshQ
         pgFoE3rV9JVD/M8in3QjCrCvkcekpvSzciVT22TjMLAE3O3wrcK/TtbL4Sh9kbqDAWba
         xpjhQ/VuZLvlfZcxte6bI9tyAtiNQ+1xq8jwNCn55eMrG4AaeKjIRRYfIVr5rF0cg6y4
         aajuwqzz/F+O/8NnTRJX+/fXOsaEbW4+tJ+u1nG2YZD79SwC7VBQZT8kOyAKJvH7tMlR
         orrDNtcbh55emdbGrx5asBu7QIxNqdhGBd4RSFkJl3fQCRIi5JuEfbOIwJWYmebYvnKy
         b86A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691009235; x=1691614035;
        h=message-id:to:from:cc:in-reply-to:subject:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=xCeI4cJM5i/F1g7PTNSHGiGltpi2DPORCAOXe5MxMI4=;
        b=WthlSqUlwcN9X8lc8j8xXfX9yKTF3iPzd6+mh/3+OYgBl7WyG5/VSO95VYG01PZwZ6
         wYZotoxlRyEgb+vpMM5O3yHejLXupceWhBCmNgX0lCSaxwTdULJERGZe8ElKnylmCo45
         ODAasBY13rQgfaW8euLT/CMR5+65sxbUg0p8J+ePwAAKsGSHZ7xRUEtNmz9zgc8Cg3Jk
         fNmNyX/RCSQEaFHd05EtgECMW/62QWzaBJ5V4F/vgmFhzdyrea/h9XEyMquQi/ME8NqY
         ZdyeLR7TbAqpz7Nb8mdyvrRLao7lbiCXbY7Wu7g3MNNCFH3N6iEzdPpSQYWPb7bMlves
         CF4A==
X-Gm-Message-State: ABy/qLbTnR4VSwXTYPv5pEOlYRLCXfsAeQ1jSXTqD4Eg395nyCwqGS7A
        Sh00Zzp2+fGuhwBIyzNqnYZk+w==
X-Google-Smtp-Source: APBJJlFjxO+AHPyhX+rLY3nb8bkP8ra4T4tKVG4BPwAGhMlm1XsJK9F47UMjzYiGC9qC+vSrulmZIA==
X-Received: by 2002:a05:6a00:1687:b0:668:83b7:fd02 with SMTP id k7-20020a056a00168700b0066883b7fd02mr20214796pfc.31.1691009234798;
        Wed, 02 Aug 2023 13:47:14 -0700 (PDT)
Received: from localhost ([135.180.227.0])
        by smtp.gmail.com with ESMTPSA id e7-20020aa78247000000b0066f37665a63sm5852206pfn.73.2023.08.02.13.47.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Aug 2023 13:47:14 -0700 (PDT)
Date:   Wed, 02 Aug 2023 13:47:14 -0700 (PDT)
X-Google-Original-Date: Wed, 02 Aug 2023 13:47:11 PDT (-0700)
Subject:     Re: [PATCH v2] RISC-V: cpu: refactor deprecated strncpy
In-Reply-To: <mhng-93dd039a-f342-4239-a0a8-f1e31f7d8b5e@palmer-ri-x1c9>
CC:     justinstitt@google.com, Paul Walmsley <paul.walmsley@sifive.com>,
        aou@eecs.berkeley.edu, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org, ndesaulniers@google.com,
        linux-hardening@vger.kernel.org
From:   Palmer Dabbelt <palmer@dabbelt.com>
To:     keescook@chromium.org
Message-ID: <mhng-724de287-da99-4f58-af50-5d728a28d4ab@palmer-ri-x1c9>
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Wed, 02 Aug 2023 13:41:52 PDT (-0700), Palmer Dabbelt wrote:
> On Wed, 02 Aug 2023 13:36:03 PDT (-0700), keescook@chromium.org wrote:
>> On Wed, Aug 02, 2023 at 12:21:58AM +0000, Justin Stitt wrote:
>>> `strncpy` is deprecated for use on NUL-terminated destination strings [1].
>>>
>>> Favor not copying strings onto stack and instead use strings directly.
>>> This avoids hard-coding sizes and buffer lengths all together.
>>>
>>> Link: https://github.com/KSPP/linux/issues/90
>>> Cc: linux-hardening@vger.kernel.org
>>> Suggested-by: Kees Cook <keescook@chromium.org>
>>> Signed-off-by: Justin Stitt <justinstitt@google.com>
>>
>> I like it! ;)
>>
>> Reviewed-by: Kees Cook <keescook@chromium.org>
>
> Thanks, I just queue it up for fixes (might take a bit to build test,
> I'm a bit backed up).
>
> Reviewed-by: Palmer Dabbelt <palmer@rivosinc.com>
> Acked-by: Palmer Dabbelt <palmer@rivosinc.com>
> 
> If you wanted to take it for some hardening thing, though -- otherwise
> it'll likely end up on my fixes later today.

Sorry this is for-next as it's not a fix, I was just looking at other 
fixes.  It's queued up aimed at for-next.
