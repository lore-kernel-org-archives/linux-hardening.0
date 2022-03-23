Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFEBAC433EF
	for <linux-hardening@archiver.kernel.org>; Wed, 23 Mar 2022 16:08:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238528AbiCWQKZ (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Wed, 23 Mar 2022 12:10:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238564AbiCWQKY (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Wed, 23 Mar 2022 12:10:24 -0400
X-Greylist: delayed 1492 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 23 Mar 2022 09:08:51 PDT
Received: from gateway22.websitewelcome.com (gateway22.websitewelcome.com [192.185.47.125])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57B0432993
        for <linux-hardening@vger.kernel.org>; Wed, 23 Mar 2022 09:08:50 -0700 (PDT)
Received: from cm13.websitewelcome.com (cm13.websitewelcome.com [100.42.49.6])
        by gateway22.websitewelcome.com (Postfix) with ESMTP id 2336413EFB
        for <linux-hardening@vger.kernel.org>; Wed, 23 Mar 2022 10:19:36 -0500 (CDT)
Received: from 162-215-252-75.unifiedlayer.com ([208.91.199.152])
        by cmsmtp with SMTP
        id X2lrnEnOkb6UBX2lsnT9m3; Wed, 23 Mar 2022 10:19:36 -0500
X-Authority-Reason: nr=8
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=roeck-us.net; s=default; h=In-Reply-To:Content-Type:MIME-Version:References
        :Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding
        :Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=HIStbkOPq4KmqmDgNBDsGitQzT/C57KQ09sUwOZRSMk=; b=ySmUsaeuUBq33rtPaqlamrBkXM
        S0JULLSndwe4GCVmTtPYfC9A4GmPTPleA3aSm0ibrtL4v2//nN6QTluUExEybGTpsiBnahwMR695d
        0sjZ8UCxtHWUn3amgZYqJx/1PuS67/ll5m482huAkX0cU+kfbp+oSjiUnYf18URiM20DKPV9OjzFI
        Tmp5KemWGJSYU0VOID6o567phCG6rWL4C1lr6tvGO8KtXoyl1Y/+UOkONjKv0dyZ0//bvl2AHpqvB
        gVabAAUvN9OtwOyZj6nlbXq6JOjCQJuQDjOX1jrYBJ86MXBW9SKiBD/LmTmMMPrzadVIX4V2FZV4i
        I3+QVb9g==;
Received: from 108-223-40-66.lightspeed.sntcca.sbcglobal.net ([108.223.40.66]:57636 helo=localhost)
        by bh-25.webhostbox.net with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <linux@roeck-us.net>)
        id 1nX2lr-002q3w-70; Wed, 23 Mar 2022 15:19:35 +0000
Date:   Wed, 23 Mar 2022 08:19:33 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Kees Cook <keescook@chromium.org>
Cc:     David Gow <davidgow@google.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Vitor Massaru Iha <vitor@massaru.org>,
        Daniel Latypov <dlatypov@google.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        linux-kernel@vger.kernel.org,
        KUnit Development <kunit-dev@googlegroups.com>,
        linux-hardening@vger.kernel.org
Subject: Re: [PATCH v2] lib: overflow: Convert to Kunit
Message-ID: <20220323151933.GA1363768@roeck-us.net>
References: <20220224054825.1853314-1-keescook@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220224054825.1853314-1-keescook@chromium.org>
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - bh-25.webhostbox.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - roeck-us.net
X-BWhitelist: no
X-Source-IP: 108.223.40.66
X-Source-L: No
X-Exim-ID: 1nX2lr-002q3w-70
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: 108-223-40-66.lightspeed.sntcca.sbcglobal.net (localhost) [108.223.40.66]:57636
X-Source-Auth: guenter@roeck-us.net
X-Email-Count: 1
X-Source-Cap: cm9lY2s7YWN0aXZzdG07YmgtMjUud2ViaG9zdGJveC5uZXQ=
X-Local-Domain: yes
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

Hi,

On Wed, Feb 23, 2022 at 09:48:25PM -0800, Kees Cook wrote:
> Convert overflow unit tests to KUnit, for better integration into the
> kernel self test framework. Includes a rename of test_overflow.c to
> overflow_kunit.c, and CONFIG_TEST_OVERFLOW to CONFIG_OVERFLOW_KUNIT_TEST.
> 

This patch results in lots of test build failures
due to large frame sizes.

Building i386:allyesconfig ... failed
--------------
Error log:
lib/overflow_kunit.c: In function 'overflow_size_helpers_test':
lib/overflow_kunit.c:644:1: error: the frame size of 2480 bytes is larger than 2048 bytes

Building i386:allmodconfig ... failed
--------------
Error log:
lib/overflow_kunit.c: In function 'overflow_size_helpers_test':
lib/overflow_kunit.c:644:1: error: the frame size of 2480 bytes is larger than 2048 bytes

Building mips:allmodconfig ... failed
--------------
Error log:
lib/overflow_kunit.c: In function 'overflow_size_helpers_test':
lib/overflow_kunit.c:644:1: error: the frame size of 2864 bytes is larger than 2048 bytes

Building powerpc:allmodconfig ... failed
--------------
Error log:
lib/overflow_kunit.c: In function 'overflow_size_helpers_test':
lib/overflow_kunit.c:644:1: error: the frame size of 3904 bytes is larger than 2048 bytes

Guenter
