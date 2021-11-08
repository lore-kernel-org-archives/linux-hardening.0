Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDE8FC433F5
	for <linux-hardening@archiver.kernel.org>; Mon,  8 Nov 2021 03:16:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BD9EE6128E
	for <linux-hardening@archiver.kernel.org>; Mon,  8 Nov 2021 03:16:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234197AbhKHDS7 (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Sun, 7 Nov 2021 22:18:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229757AbhKHDS6 (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Sun, 7 Nov 2021 22:18:58 -0500
Received: from mail-ot1-x329.google.com (mail-ot1-x329.google.com [IPv6:2607:f8b0:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DD57C061570;
        Sun,  7 Nov 2021 19:16:14 -0800 (PST)
Received: by mail-ot1-x329.google.com with SMTP id r10-20020a056830448a00b0055ac7767f5eso23434568otv.3;
        Sun, 07 Nov 2021 19:16:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to;
        bh=hAHBR6B0lTYq1FCt2xLrAXw/LEZHXtJUNTJn+1xR3jA=;
        b=gj9B7NrZ3vhnuffazOCmTR2bOlO84uL6C5MFyYKz8PEXfGOyFtLoRlMMnUvgH8H8Cv
         hvD9vRIHegUooAZ6K9OWouK2XAqrKZJxd8+x6kUmXu+voIMIlQQCt0GR1kgjnx62xyQw
         6sLO+v74FcjNvo4X7LF79bQgn5dPYivrLl9fKtYNosXVv9j/FgsZK3c+QJZEj5xXESLU
         f3DH3IejOj116aJ5Z8oTcYyRu5MGCiRHkYD4JvFXYES2J7dj4lwmPa+3qA1+axrNzaMa
         Eww0ZA76l/2RRZ5AvDFiDZS5+1ly7Y9w8p7gbFcTmcpHKwcmYhkGiqOtaFm2dE11y8WJ
         s1UA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=hAHBR6B0lTYq1FCt2xLrAXw/LEZHXtJUNTJn+1xR3jA=;
        b=5aT6D4B9Xm1TAhW1AhkjjrXSYbtd+MAeK8U+bsULlR0mdQNw+AiGQ0bZnpINPwMaZ7
         n7qAS6pKD2PpyblBQ/7czu4+kHFGPwOzBjI2Uod427O9kZm0EtckeC1Se7aNHdRRVBjB
         NPmz4Yx36ih0hLWaKyPvRFybKaSWQOL1lCG3xFanIsPVKHcy3wOjFnchHhT2etAWLqws
         W8GwhQYsImsLDBMg6EVNuFy7Ap8AMj5wVIpKAgeGucXeCq2W/mQVLkVSrN1DyLxisVDI
         /K9TybzjiFVbzaAgVweKmWmWdY72tTph2prPCs+rl4ot7OCE7bv3NIbwt3F/syti5e4c
         FQ1g==
X-Gm-Message-State: AOAM532iFMNn9MeuOgnrL1elH/VkbgfAv2fBmsshqE4Nrc8ePV18Kblt
        4GmjATbN/oqtQ+OXfsVy7Vrj+MFPMyVnLYYiG/z2fJrS
X-Google-Smtp-Source: ABdhPJwDtqhd0MB0C5l/jsD76l2TSYi84R8HPVJqkl2Kyjz9FGaWJ3a5mE4faLVCLvns2i+qWAza5BvTcnWL4MIKMEo=
X-Received: by 2002:a9d:6f0e:: with SMTP id n14mr8704953otq.173.1636341373787;
 Sun, 07 Nov 2021 19:16:13 -0800 (PST)
MIME-Version: 1.0
From:   Ajay Garg <ajaygargnsit@gmail.com>
Date:   Mon, 8 Nov 2021 08:46:01 +0530
Message-ID: <CAHP4M8X1ABEhu8kGtRSJHeqQ_m627hNT_N3Q_GGdcr3W_Rfspw@mail.gmail.com>
Subject: RFC for a new string-copy function, using mixtures of strlcpy and strscpy
To:     andy@kernel.org, Kees Cook <keescook@chromium.org>,
        akpm@linux-foundation.org, adobriyan@gmail.com,
        Nick Desaulniers <ndesaulniers@google.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

Hello everyone.

I recently came across the functions strlcpy and strscpy, and it seems
something is missing/unclean.

This email is a RFC for another function, by the name "strlscpy".
Following is a small .ko, which demonstrates the differences in
behaviours of strlcpy/strscpy/strlscpy :

######################################################
#include <linux/module.h>
#include <linux/kernel.h>
#include <linux/slab.h>
#include <linux/string.h>

char *__MODULE__ = "KERN-ajay-hello-world";

char a[10] = {0};
char b[] = "1234567890123456";

typedef size_t (*func_type_1)(char *dest, const char *src, size_t size);
typedef ssize_t (*func_type_2)(char *dest, const char *src, size_t size);

size_t strlscpy(char *dest, const char *src, size_t size)
{
    size_t len = strlen(src);

    if (size) {
            if(len >= size)
                len = size - 1;

        memcpy(dest, src, len);
        dest[len] = '\0';
    }

    return len;
}

void common(const char *fname, int len)
{
        printk("\n\nUsing [%s] ::  \n\n", fname);
        printk("len = [%d]\n", len);
        printk("a = [%s]\n", a);
}

void run_test_type_1(func_type_1 fn, const char *fname)
{
        common(fname, fn(a, b, sizeof(a)));
}

void run_test_type_2(func_type_2 fn, const char *fname)
{
        common(fname, fn(a, b, sizeof(a)));
}

static int __init hello_init(void)
{
        run_test_type_1(strlcpy, "strlcpy");
        run_test_type_2(strscpy, "strscpy");
        run_test_type_1(strlscpy, "strlscpy");

        return 0;
}

static void __exit hello_exit(void)
{
}

module_init(hello_init);
module_exit(hello_exit);

MODULE_LICENSE("GPL");
MODULE_AUTHOR("Ajay Garg <ajaygargnsit@gmail.com>");
MODULE_DESCRIPTION("Hello-World Driver");
######################################################




The output is as follows :

######################################################
Using [strlcpy] ::

len = [16]
a = [123456789]


Using [strscpy] ::

len = [-7]
a = [123456789]


Using [strlscpy] ::

len = [9]
a = [123456789]
######################################################


As is seen, the intended strlscpy function returns the number of bytes
truly copied, whereas the other two functions return values that are
prone to causing overflows/underflows.


== Motivation for the intended new function ==

Currently, strlcpy is being used in the kernel in following ways :

i)
Return-value is not consumed by the client.

ii)
Return-value is consumed by the client, and the overflow-check done on
the return-value.

iii)
Return-value is consumed by the client, but no overflow-check done on
the return-value.


Case i) is error-free, Case ii) is also acceptable.
However, Case iii) is error-prone to overflows (thus defeating the
purpose of using strlcpy at the first place).


Thus, kindly let know your thoughts, on this proposal for the addition
of this new strlscpy function in lib/string.c, so that return-value is
exact and not prone to any overflows/underflows.


Thanks and Regards,
Ajay
