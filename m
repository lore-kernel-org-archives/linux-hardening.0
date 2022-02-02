Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9EE4CC433EF
	for <linux-hardening@archiver.kernel.org>; Wed,  2 Feb 2022 17:39:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346305AbiBBRjA (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Wed, 2 Feb 2022 12:39:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236238AbiBBRi7 (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Wed, 2 Feb 2022 12:38:59 -0500
Received: from mail-io1-xd36.google.com (mail-io1-xd36.google.com [IPv6:2607:f8b0:4864:20::d36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5933DC06173D
        for <linux-hardening@vger.kernel.org>; Wed,  2 Feb 2022 09:38:59 -0800 (PST)
Received: by mail-io1-xd36.google.com with SMTP id y84so52897iof.0
        for <linux-hardening@vger.kernel.org>; Wed, 02 Feb 2022 09:38:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=5ZgUDIIYZb0p0sGt1ruE6r7EKduNuE6iJPlnBrAIoKA=;
        b=cUKtZGMEPyShwOxkBLK4TT6kN7iU9FHiF/YbNpPfqYjw0okt5j1OVTXSJqqaOO1qic
         /YNUuFlCbUAaGudiS8lOBDA3wHToNsrSsxYGp1MlhN6AGhKBfd3tQ42rHsivBJ0Xao5K
         Ny30q3/1w0SYI7sr4pWArpxIagMxVCqYJcmwo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=5ZgUDIIYZb0p0sGt1ruE6r7EKduNuE6iJPlnBrAIoKA=;
        b=qBOGkFvmurnhivfUJDFUkSIbF3rhEWBnvS1gMhJOaPWTqEdMSeyUZ3DxIKHdBv9YPa
         7ddeQKJ/X8XtCLfovzkT2bZpd6qFDWMEOOmZpVWYidoyZgh+zf3RAYJZFiKztOlnxAoD
         NmiBC91n+MFDd0WBXbMJNxtsevXavwAQ65XmmaK2PnjilaydjwfQaCuRkrbDSm0FYR0K
         si2AcASgWAeFvAmn6BUpWs9yjSiA3AI7r46QKztFCAapRI9zR9ZiXsnvm1y0HkMqjzRm
         EujKcgaXb9ZtcPxW5Y0VpsyAQGZMiskCqRblnciiJ4ygoAEBY1s3j1LifdN5jqCBzt8f
         hR7A==
X-Gm-Message-State: AOAM530Pz/dk9Cg3wRqbcLhPrn+kCy4EMe3IOIBMyu5QKE2KRKsNTSGi
        pkO1ng7OGVLrIsLR9uLENRDovg==
X-Google-Smtp-Source: ABdhPJywVmU21xcaWcoRexhtWbe7YKkj4yex5iylSdnFCIHBDrhD2VplYVOBvZUOkDTituScSgE0Hw==
X-Received: by 2002:a05:6638:4105:: with SMTP id ay5mr16415785jab.186.1643823538745;
        Wed, 02 Feb 2022 09:38:58 -0800 (PST)
Received: from [192.168.1.128] ([71.205.29.0])
        by smtp.gmail.com with ESMTPSA id y22sm3767548iow.2.2022.02.02.09.38.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 02 Feb 2022 09:38:58 -0800 (PST)
Subject: Re: [PATCH] selftests/exec: Avoid future NULL argv execve warning
To:     Alexey Dobriyan <adobriyan@gmail.com>,
        Kees Cook <keescook@chromium.org>
Cc:     Eric Biederman <ebiederm@xmission.com>,
        Shuah Khan <shuah@kernel.org>, linux-kselftest@vger.kernel.org,
        Ariadne Conill <ariadne@dereferenced.org>,
        Michael Kerrisk <mtk.manpages@gmail.com>,
        Matthew Wilcox <willy@infradead.org>,
        Christian Brauner <brauner@kernel.org>,
        Rich Felker <dalias@libc.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20220201000807.2453486-1-keescook@chromium.org>
 <Yfqfo0rbq/B/l6IP@localhost.localdomain>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <7af32164-dbdf-26f1-1aaa-b720365f9743@linuxfoundation.org>
Date:   Wed, 2 Feb 2022 10:38:57 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <Yfqfo0rbq/B/l6IP@localhost.localdomain>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On 2/2/22 8:13 AM, Alexey Dobriyan wrote:
> On Mon, Jan 31, 2022 at 04:08:07PM -0800, Kees Cook wrote:
>> Build actual argv for launching recursion test to avoid future warning
>> about using an empty argv in execve().
> 
>> --- a/tools/testing/selftests/exec/recursion-depth.c
>> +++ b/tools/testing/selftests/exec/recursion-depth.c
>> @@ -24,8 +24,14 @@
>>   #include <sys/mount.h>
>>   #include <unistd.h>
>>   
>> +#define FILENAME "/tmp/1"
>> +#define HASHBANG "#!" FILENAME "\n"
>> +
>>   int main(void)
>>   {
>> +	char * const argv[] = { FILENAME, NULL };
>> +	int rv;
> 
> Can we move out of -Wdeclaration-after-statement mentality in tests at least?

selftest like the rest of the kernel follows the same coding guidelines.
It will follow the moving "-Wdeclaration-after-statement mentality" when
the rest of the kernel does.

Looks like this topic was discussed in the following:
https://patchwork.kernel.org/project/linux-kbuild/patch/c6fda26e8d134264b04fadc3386d6c32@gmail.com/

thanks,
-- Shuah
