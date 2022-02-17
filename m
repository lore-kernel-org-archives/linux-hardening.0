Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D076BC4332F
	for <linux-hardening@archiver.kernel.org>; Thu, 17 Feb 2022 17:24:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236689AbiBQRZC (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Thu, 17 Feb 2022 12:25:02 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:43792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243689AbiBQRZC (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Thu, 17 Feb 2022 12:25:02 -0500
Received: from mail-io1-xd34.google.com (mail-io1-xd34.google.com [IPv6:2607:f8b0:4864:20::d34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46A1E2B1677
        for <linux-hardening@vger.kernel.org>; Thu, 17 Feb 2022 09:24:47 -0800 (PST)
Received: by mail-io1-xd34.google.com with SMTP id h5so4520889ioj.3
        for <linux-hardening@vger.kernel.org>; Thu, 17 Feb 2022 09:24:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=7fIcF7s81zkutMwfNwbf5zubVlDI9OaU5K9fy74Q9B4=;
        b=CbjKEehp+SO97pE4gjqRCL2QIc1uqC9YLBDOV46DzEWiC3Sqbnz4CABRm+m/ca4Eqv
         buTZ31TloBpK6VM7Z587Ywiyaf6uTxjFAEhwDX5nJSV1CS2+0w6L72L7j8WSQi53hABT
         4QAI7u4+Ju3wP+USmHOrd0+P76dMc+h6l4SO0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=7fIcF7s81zkutMwfNwbf5zubVlDI9OaU5K9fy74Q9B4=;
        b=OpRZwOnUKedl4VospjubE6eVGOmH60D6bUnNl7pNdXt8tLOs4W13VHJ92MDpfZmmNn
         fAtAQntRXrECRF58ipm8Rz9LbA8XMrNNGdrQPxeKyrVACIa8uc8yndCn7CutlhF1r2sh
         XuzhQ0+eM6czkK23LBA88kcmg0rwLC508Z1EGy5iRfSYycoO3uc6IsCSoEwTxvtu9oFz
         ZqJYzVEdVXVKGEk+buE6KmrH5M6VXH3pV4zgemNBJXYiW+lZDCbXt86hJ7vuQ8sy25b0
         I2HLP+D55X9DWrJ9gegq5zyTYzqbrZkfxiea3fopvJLCv7zzuNJ5f/lMzI9V2xgM2Eb3
         7hBQ==
X-Gm-Message-State: AOAM533IPkai1oCKuzQI2ifPvV/MKSoSQl7Tmhcxt2Mc5402pqi5Het9
        YRVQworwU+gQPdl/8pwq6Tnbdg==
X-Google-Smtp-Source: ABdhPJwTbgrJwmhagULfptTjSGm9yEX+5FBRDBMNvfShq/9n6pwvePv1NzgE2fojGGA2T6QifJdoQA==
X-Received: by 2002:a02:700e:0:b0:2ff:7cac:bd09 with SMTP id f14-20020a02700e000000b002ff7cacbd09mr2696324jac.32.1645118685905;
        Thu, 17 Feb 2022 09:24:45 -0800 (PST)
Received: from [192.168.1.128] ([71.205.29.0])
        by smtp.gmail.com with ESMTPSA id y7sm2105136ila.7.2022.02.17.09.24.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 17 Feb 2022 09:24:45 -0800 (PST)
Subject: Re: [PATCH] lib: overflow: Convert to Kunit
To:     Kees Cook <keescook@chromium.org>,
        Daniel Latypov <dlatypov@google.com>
Cc:     David Gow <davidgow@google.com>,
        Vitor Massaru Iha <vitor@massaru.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org,
        KUnit Development <kunit-dev@googlegroups.com>,
        linux-kselftest@vger.kernel.org, linux-hardening@vger.kernel.org,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20220216224153.2242451-1-keescook@chromium.org>
 <CAGS_qxoOYjOtX6BQm-ozcarnazyED2vocd4iV+VdDVnMWpjWjg@mail.gmail.com>
 <202202170903.E39554DF@keescook>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <68057bea-7bf7-afb9-4c99-aa3b2c024133@linuxfoundation.org>
Date:   Thu, 17 Feb 2022 10:24:44 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <202202170903.E39554DF@keescook>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On 2/17/22 10:09 AM, Kees Cook wrote:
> On Wed, Feb 16, 2022 at 02:57:12PM -0800, Daniel Latypov wrote:
>> On Wed, Feb 16, 2022 at 2:42 PM Kees Cook <keescook@chromium.org> wrote:
>>>
>>> Convert overflow unit tests to KUnit, for better integration into the
>>> kernel self test framework. Includes a rename of test_overflow.c to
>>> overflow_kunit.c, and CONFIG_TEST_OVERFLOW to CONFIG_OVERFLOW_KUNIT_TEST.
>>>
>>> $ ./tools/testing/kunit/kunit.py config
>>> ...
>>> $ ./tools/testing/kunit/kunit.py run overflow
>>
>> JFYI, you can run this as a one-liner via
>>
>> $ ./tools/testing/kunit/kunit.py run --kunitconfig /dev/stdin <<EOF
>> CONFIG_KUNIT=y
>> CONFIG_TEST_OVERFLOW=y
>> EOF
>>
>> The above is taken from my own duplicate version of this patch
>> [1] https://lore.kernel.org/linux-kselftest/20210503211536.1384578-1-dlatypov@google.com/
> 
> Ah-ha! I thought I remembered this conversion being proposed before but
> I totally failed to find it. Thank you! I'll compare/adjust this patch
> and add you as Co-developed-by.
> 
>>> ...
>>> [14:33:51] Starting KUnit Kernel (1/1)...
>>> [14:33:51] ============================================================
>>> [14:33:51] ================== overflow (11 subtests) ==================
>>> [14:33:51] [PASSED] u8_overflow_test
>>> [14:33:51] [PASSED] s8_overflow_test
>>> [14:33:51] [PASSED] u16_overflow_test
>>> [14:33:51] [PASSED] s16_overflow_test
>>> [14:33:51] [PASSED] u32_overflow_test
>>> [14:33:51] [PASSED] s32_overflow_test
>>> [14:33:51] [PASSED] u64_overflow_test
>>> [14:33:51] [PASSED] s64_overflow_test
>>> [14:33:51] [PASSED] overflow_shift_test
>>> [14:33:51] [PASSED] overflow_allocation_test
>>> [14:33:51] [PASSED] overflow_size_helpers_test
>>> [14:33:51] ==================== [PASSED] overflow =====================
>>> [14:33:51] ============================================================
>>> [14:33:51] Testing complete. Passed: 11, Failed: 0, Crashed: 0, Skipped: 0, Errors: 0
>>> [14:33:51] Elapsed time: 12.525s total, 0.001s configuring, 12.402s building, 0.101s running
>>>
>>> Cc: David Gow <davidgow@google.com>
>>> Cc: Vitor Massaru Iha <vitor@massaru.org>
>>> Cc: Rasmus Villemoes <linux@rasmusvillemoes.dk>
>>> Cc: Nick Desaulniers <ndesaulniers@google.com>
>>> Co-developed-by: Vitor Massaru Iha <vitor@massaru.org>
>>> Signed-off-by: Vitor Massaru Iha <vitor@massaru.org>
>>> Link: https://lore.kernel.org/lkml/20200720224418.200495-1-vitor@massaru.org/
>>> Signed-off-by: Kees Cook <keescook@chromium.org>
>>
>> Reviewed-by: Daniel Latypov <dlatypov@google.com>
>>

Looks good to me. I recall reviewing this when Vitor was working on this.
Glad to this happen.

Reviewed-by: Shuah Khan <skhan@linuxfoundation.org>

thanks,
-- Shuah
