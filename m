Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45982C433FE
	for <linux-hardening@archiver.kernel.org>; Thu, 28 Oct 2021 20:15:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 270AC610FC
	for <linux-hardening@archiver.kernel.org>; Thu, 28 Oct 2021 20:15:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230342AbhJ1UR5 (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Thu, 28 Oct 2021 16:17:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:57980 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231178AbhJ1UR5 (ORCPT <rfc822;linux-hardening@vger.kernel.org>);
        Thu, 28 Oct 2021 16:17:57 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 3A5F660C4A;
        Thu, 28 Oct 2021 20:15:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1635452129;
        bh=hgkulfjy2lu/2Pn+/4MoUzzaOqJpiylsYL8YeU6rj6w=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=gdwBhM8acmkSuTfLv7h32T6XXK6nvsZa3HwDi1umz5MmVL4oek/V6ZW1xcGAuq6b5
         bSFcEMEW4CL4ZjZAgkaJsH8DpJ/XG4Fi2jHDYmdmqoq5faO4hn3iy+Gx4QBj2VkXaV
         sLHY+toZ0Q8gK/GJSdJody6HLZwewK5biCNDxOSw=
Date:   Thu, 28 Oct 2021 13:15:26 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Kees Cook <keescook@chromium.org>
Cc:     Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Arnd Bergmann <arnd@kernel.org>,
        linux-hardening@vger.kernel.org, Kees Cook <keescook@chomium.org>,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        Alexander Potapenko <glider@google.com>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Dmitry Vyukov <dvyukov@google.com>, kasan-dev@googlegroups.com,
        Arnd Bergmann <arnd@arndb.de>, Marco Elver <elver@google.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Peter Collingbourne <pcc@google.com>,
        Patricia Alfonso <trishalfonso@google.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] kasan: test: use underlying string helpers
Message-Id: <20211028131526.d63d1074a8faa20e1de5e209@linux-foundation.org>
In-Reply-To: <721BDA47-9998-4F0B-80B4-F4E4765E4885@chromium.org>
References: <20211013150025.2875883-1-arnd@kernel.org>
        <b35768f5-8e06-ebe6-1cdd-65f7fe67ff7a@arm.com>
        <721BDA47-9998-4F0B-80B4-F4E4765E4885@chromium.org>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Thu, 14 Oct 2021 19:40:45 -0700 Kees Cook <keescook@chromium.org> wrote:

> 
> 
> On October 14, 2021 1:12:54 AM PDT, Vincenzo Frascino <vincenzo.frascino@arm.com> wrote:
> >
> >
> >On 10/13/21 5:00 PM, Arnd Bergmann wrote:
> >> From: Arnd Bergmann <arnd@arndb.de>
> >> 
> >> Calling memcmp() and memchr() with an intentional buffer overflow
> >> is now caught at compile time:
> >> 
> >> In function 'memcmp',
> >>     inlined from 'kasan_memcmp' at lib/test_kasan.c:897:2:
> >> include/linux/fortify-string.h:263:25: error: call to '__read_overflow' declared with attribute error: detected read beyond size of object (1st parameter)
> >>   263 |                         __read_overflow();
> >>       |                         ^~~~~~~~~~~~~~~~~
> >> In function 'memchr',
> >>     inlined from 'kasan_memchr' at lib/test_kasan.c:872:2:
> >> include/linux/fortify-string.h:277:17: error: call to '__read_overflow' declared with attribute error: detected read beyond size of object (1st parameter)
> >>   277 |                 __read_overflow();
> >>       |                 ^~~~~~~~~~~~~~~~~
> >> 
> >> Change the kasan tests to wrap those inside of a noinline function
> >> to prevent the compiler from noticing the bug and let kasan find
> >> it at runtime.
> >> 
> >> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> >
> >Reviewed-by: Vincenzo Frascino <vincenzo.frascino@arm.com>
> 
> How about just explicitly making the size invisible to the compiler?
> 
> I did this for similar issues in the same source:
> 
> https://lore.kernel.org/linux-hardening/20211006181544.1670992-1-keescook@chromium.org/T/#u
> 

Arnd?
