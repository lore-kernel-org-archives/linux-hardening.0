Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46B57ECAAD4
	for <linux-hardening@archiver.kernel.org>; Mon, 29 Aug 2022 21:15:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229450AbiH2VPE (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Mon, 29 Aug 2022 17:15:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229688AbiH2VPC (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Mon, 29 Aug 2022 17:15:02 -0400
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE6B011A29
        for <linux-hardening@vger.kernel.org>; Mon, 29 Aug 2022 14:15:00 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id z2so11764923edc.1
        for <linux-hardening@vger.kernel.org>; Mon, 29 Aug 2022 14:15:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc;
        bh=c95gb6y0VFpG0AKV0K7SdSSrH1lyfJzEM7W94U2j5Hw=;
        b=PmSX3GHGOig78+8gw6wmGzzQiKP/whK3Vtn0Cr0cIDYHwTGl1sf3wZU3G110Q4bR9C
         3kZQAsDM1RehfkQubl7zYrgNLUW84PTXcma8ckW83wJMkzpaUrS3MkLBpbZie2IfpwPU
         KHs0RQctIkcsohVLiSQSyh8LYCeuTKW3dYV+A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=c95gb6y0VFpG0AKV0K7SdSSrH1lyfJzEM7W94U2j5Hw=;
        b=SgbMilQVjzMu9aWNUkld+oNY09h6s7bC/TqjIAdAylSd0boOBIX5NYFSboDp5tfT/H
         P94VxsYrNhEdI+sN6/3BJBSm+MvPtVDSFAnDgh8sNBvmhLFQAULF5+bq47jd14h8zmKu
         Q1yq7PUR/Sc4Zwz9FWTJ4gqaPtS5WfleKL7mxHNY/D4xhTVFN++D1uYm6w6l9MZgoEFf
         hEFcnqTrg3JP3JewAV1w+kp0n4OXNC+WvCPOULDXXDLEguGBCxIL3dGIby9TO5yFZoa4
         sc5s9y/c3r0HOaAAxhTDSZBHnwhzfQIUHDBnb+LqcgBN/KMZiqiqqQ7ExChq8t5+Ab27
         G8VA==
X-Gm-Message-State: ACgBeo1Wiy32MFujnufpOTCtssYeiGUAXIGpIuNrNlQqMu89K7Vcgx5v
        fh10bgmnN71lckFEidXiBgcKiw==
X-Google-Smtp-Source: AA6agR5nhl6art1YTiXjA1XVl1eqh+H0E2p1WIOjqlw+Ylsgmo7ZspNTby3815vKiZ3QCp8UM5Ryiw==
X-Received: by 2002:a05:6402:551a:b0:446:1526:85ea with SMTP id fi26-20020a056402551a00b00446152685eamr18181664edb.188.1661807699459;
        Mon, 29 Aug 2022 14:14:59 -0700 (PDT)
Received: from [192.168.1.149] ([80.208.71.65])
        by smtp.gmail.com with ESMTPSA id n2-20020a170906088200b0073d678f50bfsm4870271eje.164.2022.08.29.14.14.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 29 Aug 2022 14:14:58 -0700 (PDT)
Message-ID: <d325bf21-efa4-b3e9-a0d8-3662a9f7ab1a@rasmusvillemoes.dk>
Date:   Mon, 29 Aug 2022 23:14:56 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH] overflow: Allow mixed type arguments
Content-Language: en-US
To:     Kees Cook <keescook@chromium.org>
Cc:     Gwan-gyeong Mun <gwan-gyeong.mun@intel.com>,
        Andrzej Hajda <andrzej.hajda@intel.com>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        linux-hardening@vger.kernel.org,
        Daniel Latypov <dlatypov@google.com>,
        Vitor Massaru Iha <vitor@massaru.org>,
        linux-kernel@vger.kernel.org
References: <20220829204729.3409270-1-keescook@chromium.org>
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
In-Reply-To: <20220829204729.3409270-1-keescook@chromium.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On 29/08/2022 22.47, Kees Cook wrote:
> When the check_[op]_overflow() helpers were introduced, all arguments were
> required to be the same type to make the fallback macros simpler. However,
> once the fallback macros were removed[1], it is fine to allow mixed
> types, which makes using the helpers much more useful, as they can be
> used to test for type-based overflows (e.g. adding two large ints but
> storing into a u8), as would be handy in the drm core[2].
> 
> Remove the restriction, and add additional self-tests that exercise some
> of the mixed-type overflow cases.

Makes sense. I'm a little worried about the implications for -stable
backports to kernels that can still be built with gcc < 5.1, but we
can't let that dictate what is done in mainline. And even people
building old kernels shouldn't be using ancient compilers.

>  
> -#define DEFINE_TEST_ARRAY(t)			\
> -	static const struct test_ ## t {	\
> -		t a, b;				\
> -		t sum, diff, prod;		\
> -		bool s_of, d_of, p_of;		\
> -	} t ## _tests[]
> +#define DEFINE_TEST_ARRAY_TYPED(t1, t2, t)		\
> +	static const struct test_ ## t1 ## t2 ## t {	\
> +		t1 a;					\
> +		t2 b;					\
> +		t sum, diff, prod;			\
> +		bool s_of, d_of, p_of;			\
> +	} t1 ## t2 ## t ## _tests[]

Can I get you to throw in some extra _, because this...

> +DEFINE_TEST_FUNC_TYPED(u32u32int, int, "%d");

...makes my eyes hurt a little. Maybe even make it u32_u32__int, so it's
emphasized that the order is [src op src -> tgt] and not [tgt = src op src].

Rasmus
