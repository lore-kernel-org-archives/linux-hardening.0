Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1ECDDC433DB
	for <linux-hardening@archiver.kernel.org>; Mon, 22 Feb 2021 15:22:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BDC4464E57
	for <linux-hardening@archiver.kernel.org>; Mon, 22 Feb 2021 15:22:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230454AbhBVPVm (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Mon, 22 Feb 2021 10:21:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231469AbhBVPTF (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Mon, 22 Feb 2021 10:19:05 -0500
Received: from mail-ot1-x32b.google.com (mail-ot1-x32b.google.com [IPv6:2607:f8b0:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F71FC06174A;
        Mon, 22 Feb 2021 07:18:21 -0800 (PST)
Received: by mail-ot1-x32b.google.com with SMTP id h22so3942740otr.6;
        Mon, 22 Feb 2021 07:18:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:autocrypt:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=zHUFcNQUogP4EIRrnsReE9FsSSUfOs19Rul8T8qqyIQ=;
        b=iBX09sICI9WSYSpU0Rm/K/U8yKAmOrIRvEFBjru80nbNlznm6XmKRi/hv7ILHaYW8q
         zvTTRGc+xrqT60apHcE2eJvbT/m49TUYfuG0wl4jJgHOes4lIe4KObsy1/xa3NAilqZX
         2k1QVYEjY/lDyxREgyO/d50IVzPkorYZ8OSx9OuZcnmKY9ck/TByzYRU6lsbqvog5Izc
         HiQ1wIyfPKroLiCS2CjE/eTGLz3YQyqHnkcALBPmQ5++cO1CJduTSnTEVtB9t4KTpMR0
         lMXErYT3uqRHs7n6JF5d15evX+KvvG4nsctj1gts43iWcHBcaQXvxF1rbAseZvdVGCny
         DHCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=zHUFcNQUogP4EIRrnsReE9FsSSUfOs19Rul8T8qqyIQ=;
        b=Cy2+hF7S3+uNbVtPaLbNR6STYmWrsY3qtDbhhv37D/HTXAv9CixR8cF+mPmNaS810p
         DDYCTiris+oXUyIIspeU64V0RaKev4tmSgyQQPsCEqY0I/11IRnqANtV6PikLGhBGyfM
         JkVEsOMn2DEHveRj2Hzp6jWslZ8uvmNzefeb3TjqCGXKCasNQRx8NUDaRlGJ+r/hq7Fw
         d2MxVxDKqxYCw41AlvicjTpyFFCTJ9DsM01kycboHrhUoqA8MU47A0VDUSuwEH7QKfN+
         xFTTx/eSRSOqmaW4f2+4e+m3H90xcEqPtE1uMAKf3/3dJzztH95sVYbd2JAKhMGBeHY7
         HEfw==
X-Gm-Message-State: AOAM532zu9wNKxHXpgTATMDvbXFUikOdA6hsA64uAfALv3mXCg2ntMf8
        kYjH+fIJAdKJIlTYt1ed8oM=
X-Google-Smtp-Source: ABdhPJzeWFCFV2X7NWSyIdVhvEUB8d8l5norFJl8hBgf8eisEsix/o9juLGYNQ30UzH28pkMF8/6Bg==
X-Received: by 2002:a05:6830:140a:: with SMTP id v10mr16909486otp.355.1614007100741;
        Mon, 22 Feb 2021 07:18:20 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id k21sm581350ood.13.2021.02.22.07.18.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 22 Feb 2021 07:18:19 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Subject: Re: [PATCH] gcc-plugins: Disable GCC_PLUGIN_CYC_COMPLEXITY for s390
To:     Heiko Carstens <hca@linux.ibm.com>
Cc:     Kees Cook <keescook@chromium.org>, linux-hardening@vger.kernel.org,
        linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@kernel.org>,
        Masahiro Yamada <masahiroy@kernel.org>
References: <20210221225650.33134-1-linux@roeck-us.net>
 <YDOeI5+1H3T1ocmQ@osiris>
From:   Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 xsFNBE6H1WcBEACu6jIcw5kZ5dGeJ7E7B2uweQR/4FGxH10/H1O1+ApmcQ9i87XdZQiB9cpN
 RYHA7RCEK2dh6dDccykQk3bC90xXMPg+O3R+C/SkwcnUak1UZaeK/SwQbq/t0tkMzYDRxfJ7
 nyFiKxUehbNF3r9qlJgPqONwX5vJy4/GvDHdddSCxV41P/ejsZ8PykxyJs98UWhF54tGRWFl
 7i1xvaDB9lN5WTLRKSO7wICuLiSz5WZHXMkyF4d+/O5ll7yz/o/JxK5vO/sduYDIlFTvBZDh
 gzaEtNf5tQjsjG4io8E0Yq0ViobLkS2RTNZT8ICq/Jmvl0SpbHRvYwa2DhNsK0YjHFQBB0FX
 IdhdUEzNefcNcYvqigJpdICoP2e4yJSyflHFO4dr0OrdnGLe1Zi/8Xo/2+M1dSSEt196rXaC
 kwu2KgIgmkRBb3cp2vIBBIIowU8W3qC1+w+RdMUrZxKGWJ3juwcgveJlzMpMZNyM1jobSXZ0
 VHGMNJ3MwXlrEFPXaYJgibcg6brM6wGfX/LBvc/haWw4yO24lT5eitm4UBdIy9pKkKmHHh7s
 jfZJkB5fWKVdoCv/omy6UyH6ykLOPFugl+hVL2Prf8xrXuZe1CMS7ID9Lc8FaL1ROIN/W8Vk
 BIsJMaWOhks//7d92Uf3EArDlDShwR2+D+AMon8NULuLBHiEUQARAQABzTJHdWVudGVyIFJv
 ZWNrIChMaW51eCBhY2NvdW50KSA8bGludXhAcm9lY2stdXMubmV0PsLBgQQTAQIAKwIbAwYL
 CQgHAwIGFQgCCQoLBBYCAwECHgECF4ACGQEFAlVcphcFCRmg06EACgkQyx8mb86fmYFg0RAA
 nzXJzuPkLJaOmSIzPAqqnutACchT/meCOgMEpS5oLf6xn5ySZkl23OxuhpMZTVX+49c9pvBx
 hpvl5bCWFu5qC1jC2eWRYU+aZZE4sxMaAGeWenQJsiG9lP8wkfCJP3ockNu0ZXXAXwIbY1O1
 c+l11zQkZw89zNgWgKobKzrDMBFOYtAh0pAInZ9TSn7oA4Ctejouo5wUugmk8MrDtUVXmEA9
 7f9fgKYSwl/H7dfKKsS1bDOpyJlqhEAH94BHJdK/b1tzwJCFAXFhMlmlbYEk8kWjcxQgDWMu
 GAthQzSuAyhqyZwFcOlMCNbAcTSQawSo3B9yM9mHJne5RrAbVz4TWLnEaX8gA5xK3uCNCeyI
 sqYuzA4OzcMwnnTASvzsGZoYHTFP3DQwf2nzxD6yBGCfwNGIYfS0i8YN8XcBgEcDFMWpOQhT
 Pu3HeztMnF3HXrc0t7e5rDW9zCh3k2PA6D2NV4fews9KDFhLlTfCVzf0PS1dRVVWM+4jVl6l
 HRIAgWp+2/f8dx5vPc4Ycp4IsZN0l1h9uT7qm1KTwz+sSl1zOqKD/BpfGNZfLRRxrXthvvY8
 BltcuZ4+PGFTcRkMytUbMDFMF9Cjd2W9dXD35PEtvj8wnEyzIos8bbgtLrGTv/SYhmPpahJA
 l8hPhYvmAvpOmusUUyB30StsHIU2LLccUPPOwU0ETofVZwEQALlLbQeBDTDbwQYrj0gbx3bq
 7kpKABxN2MqeuqGr02DpS9883d/t7ontxasXoEz2GTioevvRmllJlPQERVxM8gQoNg22twF7
 pB/zsrIjxkE9heE4wYfN1AyzT+AxgYN6f8hVQ7Nrc9XgZZe+8IkuW/Nf64KzNJXnSH4u6nJM
 J2+Dt274YoFcXR1nG76Q259mKwzbCukKbd6piL+VsT/qBrLhZe9Ivbjq5WMdkQKnP7gYKCAi
 pNVJC4enWfivZsYupMd9qn7Uv/oCZDYoBTdMSBUblaLMwlcjnPpOYK5rfHvC4opxl+P/Vzyz
 6WC2TLkPtKvYvXmdsI6rnEI4Uucg0Au/Ulg7aqqKhzGPIbVaL+U0Wk82nz6hz+WP2ggTrY1w
 ZlPlRt8WM9w6WfLf2j+PuGklj37m+KvaOEfLsF1v464dSpy1tQVHhhp8LFTxh/6RWkRIR2uF
 I4v3Xu/k5D0LhaZHpQ4C+xKsQxpTGuYh2tnRaRL14YMW1dlI3HfeB2gj7Yc8XdHh9vkpPyuT
 nY/ZsFbnvBtiw7GchKKri2gDhRb2QNNDyBnQn5mRFw7CyuFclAksOdV/sdpQnYlYcRQWOUGY
 HhQ5eqTRZjm9z+qQe/T0HQpmiPTqQcIaG/edgKVTUjITfA7AJMKLQHgp04Vylb+G6jocnQQX
 JqvvP09whbqrABEBAAHCwWUEGAECAA8CGwwFAlVcpi8FCRmg08MACgkQyx8mb86fmYHNRQ/+
 J0OZsBYP4leJvQF8lx9zif+v4ZY/6C9tTcUv/KNAE5leyrD4IKbnV4PnbrVhjq861it/zRQW
 cFpWQszZyWRwNPWUUz7ejmm9lAwPbr8xWT4qMSA43VKQ7ZCeTQJ4TC8kjqtcbw41SjkjrcTG
 wF52zFO4bOWyovVAPncvV9eGA/vtnd3xEZXQiSt91kBSqK28yjxAqK/c3G6i7IX2rg6pzgqh
 hiH3/1qM2M/LSuqAv0Rwrt/k+pZXE+B4Ud42hwmMr0TfhNxG+X7YKvjKC+SjPjqp0CaztQ0H
 nsDLSLElVROxCd9m8CAUuHplgmR3seYCOrT4jriMFBtKNPtj2EE4DNV4s7k0Zy+6iRQ8G8ng
 QjsSqYJx8iAR8JRB7Gm2rQOMv8lSRdjva++GT0VLXtHULdlzg8VjDnFZ3lfz5PWEOeIMk7Rj
 trjv82EZtrhLuLjHRCaG50OOm0hwPSk1J64R8O3HjSLdertmw7eyAYOo4RuWJguYMg5DRnBk
 WkRwrSuCn7UG+qVWZeKEsFKFOkynOs3pVbcbq1pxbhk3TRWCGRU5JolI4ohy/7JV1TVbjiDI
 HP/aVnm6NC8of26P40Pg8EdAhajZnHHjA7FrJXsy3cyIGqvg9os4rNkUWmrCfLLsZDHD8FnU
 mDW4+i+XlNFUPUYMrIKi9joBhu18ssf5i5Q=
Message-ID: <f35196cc-969f-21ef-0c38-dc6e13831fb0@roeck-us.net>
Date:   Mon, 22 Feb 2021 07:18:17 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <YDOeI5+1H3T1ocmQ@osiris>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On 2/22/21 4:05 AM, Heiko Carstens wrote:
> On Sun, Feb 21, 2021 at 02:56:50PM -0800, Guenter Roeck wrote:
>> Commit 334ef6ed06fa ("init/Kconfig: make COMPILE_TEST depend on !S390") disabled
>> COMPILE_TEST for s390. At the same time, "make allmodconfig/allyesconfig" for
>> s390 is still supported. However, it generates thousands of compiler
>> messages such as the following, making it highly impractical to run.
>>
>> Cyclomatic Complexity 1 scripts/mod/devicetable-offsets.c:main
>> Cyclomatic Complexity 1 scripts/mod/devicetable-offsets.c:_GLOBAL__sub_I_00100_0_main
>>
>> Since GCC_PLUGIN_CYC_COMPLEXITY is primarily used for testing, disable it
>> when building s390 images.
>>
>> Cc: Arnd Bergmann <arnd@kernel.org>
>> Cc: Heiko Carstens <hca@linux.ibm.com>
>> Fixes: 334ef6ed06fa ("init/Kconfig: make COMPILE_TEST depend on !S390")
>> Signed-off-by: Guenter Roeck <linux@roeck-us.net>
>> ---
>>  scripts/gcc-plugins/Kconfig | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/scripts/gcc-plugins/Kconfig b/scripts/gcc-plugins/Kconfig
>> index ab9eb4cbe33a..5e9bb500f443 100644
>> --- a/scripts/gcc-plugins/Kconfig
>> +++ b/scripts/gcc-plugins/Kconfig
>> @@ -21,7 +21,7 @@ if GCC_PLUGINS
>>  
>>  config GCC_PLUGIN_CYC_COMPLEXITY
>>  	bool "Compute the cyclomatic complexity of a function" if EXPERT
>> -	depends on !COMPILE_TEST	# too noisy
>> +	depends on !COMPILE_TEST && !S390	# too noisy
> 
> I don't see a reason to disable this in general for s390. COMPILE_TEST
> was only disabled for s390 because a lot of irrelevant configs didn't
> compile and it would cause a lot of unnecessary work to fix that.
> 
> However the !COMPILE_TEST dependency here looks more like it was
> misused in lack of a possibility to detect if the config was generated
> with allyesconfig/allmodconfig. Maybe that could be added somehow to
> Kconfig?
> 

That is what COMPILE_TEST used to be for. Not setting it for s390 doesn't
just cause this config to be disabled. Lots of other compile tests
for s390 are now disabled as well, and code which should be disabled
is now enabled. Looking at it, I'd be a bit surprised if allmodconfig/
allyesconfig with COMPILE_TEST=y still builds for s390.

I agree that COMPILE_TEST it is being misused. However, I think what
you'd be looking for is something like COMPILE_TEST_RANDCONFIG.
FWIW, in my opinion, randconfig should not enable COMPILE_TEST
to start with. But that is a different discussion.

Anyway, I can disable GCC_PLUGIN_CYC_COMPLEXITY manually in my own
build tests, so this isn't that much of a problem for me, so feel
free to drop this patch.

Guenter
