Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05455C433F5
	for <linux-hardening@archiver.kernel.org>; Thu, 12 May 2022 12:10:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353559AbiELMKt (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Thu, 12 May 2022 08:10:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351652AbiELMKs (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Thu, 12 May 2022 08:10:48 -0400
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA7C3109D
        for <linux-hardening@vger.kernel.org>; Thu, 12 May 2022 05:10:44 -0700 (PDT)
Received: by mail-lf1-x12b.google.com with SMTP id p10so8641242lfa.12
        for <linux-hardening@vger.kernel.org>; Thu, 12 May 2022 05:10:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=qy28eExUKPB+7e1xCoRBDK23LQhgAXf1HH1BZA8J3b0=;
        b=L2XWQIvfJoYLzJjGk02ULr+jJ5iqK3TOxVfbIUivdafGg1D83Tj+Oek8a6jBxDXOU3
         rvnVdNdal140KxA3ZSVf3Smb6osxoZFlekMuZaVNR+N6jc2oN31+EvBdOn1q1BVM9U6O
         X7PJwyat0BScW+HbAfYZSKrTdq2d39wiM/NpM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=qy28eExUKPB+7e1xCoRBDK23LQhgAXf1HH1BZA8J3b0=;
        b=Ci+GoOz4tuoRERIjd+lxS+b7Pz0YU12wq9U8SQf/zwEODQx4l59q8JXaqurhgkcF05
         NgZErLNkJKhGdEbXLoJUf595fAbxeQ4N6htkNY9HeCuE+GUhY98+NgUKRfyEMdEqu4/g
         ZcRCiehl7oozU84EHaO8aRNSqfocGOfyqo0ER2aSUJe1bGpa/rBm1N7rs3PQOg60StNH
         OQuik150a9NIoZ4AmcpJVPi9t7En05hyUVPx8IZmincqDJeTIlSryy26czc0LBXiUXXV
         jIqD5XA6wxVGeed41kmvqjwBYANSxqCz27Nk/FvhiNHz2Yf/kdRALNfZEY7qU+kfY4A8
         G9Qw==
X-Gm-Message-State: AOAM531CUbn1SO4JVf1YVon+Mjzo0tn0XVe3Vo37y/KW3yvf3EinQsRf
        1BTbGiW1bi7q7DcCc3QAcKQE0Q==
X-Google-Smtp-Source: ABdhPJyHbMcC+9oVxC8CSrkUBTQAqLZRvaUUJWNSUu7K3hxiGnUCQ4hjma6zdRn627DUM/WHyrsVRQ==
X-Received: by 2002:a05:6512:b08:b0:46b:a876:3009 with SMTP id w8-20020a0565120b0800b0046ba8763009mr23451314lfu.378.1652357443199;
        Thu, 12 May 2022 05:10:43 -0700 (PDT)
Received: from [172.16.11.74] ([81.216.59.226])
        by smtp.gmail.com with ESMTPSA id m20-20020a0565120a9400b0047255d211a1sm756411lfu.208.2022.05.12.05.10.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 May 2022 05:10:42 -0700 (PDT)
Message-ID: <5304dada-51d2-e955-b620-c5c97f3b0dbd@rasmusvillemoes.dk>
Date:   Thu, 12 May 2022 14:10:40 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH] lib: overflow: Always build 64-bit test cases
Content-Language: en-US
To:     Kees Cook <keescook@chromium.org>,
        Nick Desaulniers <ndesaulniers@google.com>
Cc:     kernel test robot <lkp@intel.com>,
        Vitor Massaru Iha <vitor@massaru.org>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Daniel Latypov <dlatypov@google.com>,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
References: <20220511174531.1098548-1-keescook@chromium.org>
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
In-Reply-To: <20220511174531.1098548-1-keescook@chromium.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On 11/05/2022 19.45, Kees Cook wrote:
> There shouldn't be a reason to not build the 64-bit test cases on 32-bit
> systems; the types exist there too. Remove the #ifdefs.
> 
> Reported-by: kernel test robot <lkp@intel.com>
> Link: https://lore.kernel.org/lkml/202205110324.7GrtxG8u-lkp@intel.com
> Fixes: 455a35a6cdb6 ("lib: add runtime test of check_*_overflow functions")

The patch is fine, but I disagree with that Fixes tag. Back then, i.e.
when the overflow checkers were implemented via macros on old enough
compilers, they simply didn't work for 64 bit types (because of the
usual 64 bit division problems) - so anybody trying to use the multiply
overflow checker, including of course the test suite, would get a build
error on old compilers. You yourself did that: "[kees: add output to
commit log, drop u64 tests on 32-bit]"

Nowadays, where they are always merely thin wrappers around the compiler
builtin because we assume gcc >= 5.1 and whatever new enough clang,
sure, I think the 64 bit ones always work (though I don't think I want
to know what horrible code the compiler must generate to do the multiply
overflow checks).

So please fix the commit message so that it instead says that this
restriction is no longer necessary because such and such history.

Rasmus
