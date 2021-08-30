Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBC6FC432BE
	for <linux-hardening@archiver.kernel.org>; Mon, 30 Aug 2021 22:34:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 93FE061008
	for <linux-hardening@archiver.kernel.org>; Mon, 30 Aug 2021 22:34:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237384AbhH3We7 (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Mon, 30 Aug 2021 18:34:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:44864 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230140AbhH3We6 (ORCPT <rfc822;linux-hardening@vger.kernel.org>);
        Mon, 30 Aug 2021 18:34:58 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id C1B5460E98;
        Mon, 30 Aug 2021 22:34:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1630362844;
        bh=wlr+0GYj5AofoT2qLGQnGAd0De8XaqzW9JKk9OfETXI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=WvvNsgssfkXqpGn/WQqRti1oOg9e3+5keyLeV+h/FY5iMBnW6NGD3RXQOThN5C+dd
         YmmaClMBnqiN0Jug1ruemGzaqGcTxHbCV/bXm0qRdBq8R8SlsXKnfsjWDo2LEK4Ok4
         PZSZd5LgsAukrOFPqaDF7lUSO9NGEXYJ/ZIuiuwRHpjbxyKc4vj/gF5DZ79Ezwe9rZ
         cypetSnlmu3d80ml+4HhrjBuAnH8YQN3JGkTqOb73fnEdnZNJimUPhHTFvlbVRgdep
         LLNFLXEmPoxmlFgmk+Xn7WNxPHPdnNW2ezmTQZbv+XU4YTudIqgxHXmv583MViTvWd
         IDbDQRlDKgT5g==
Date:   Mon, 30 Aug 2021 15:34:01 -0700
From:   Nathan Chancellor <nathan@kernel.org>
To:     Kees Cook <keescook@chromium.org>
Cc:     linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Keith Packard <keithp@keithp.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        clang-built-linux@googlegroups.com,
        linux-hardening@vger.kernel.org, llvm@lists.linux.dev
Subject: Re: [PATCH v3 0/5] Enable -Warray-bounds and -Wzero-length-bounds
Message-ID: <YS1c2UE487rkGnya@Ryzen-9-3900X.localdomain>
References: <20210827163015.3141722-1-keescook@chromium.org>
 <YS0nJtNDCwfbaubZ@Ryzen-9-3900X.localdomain>
 <202108301314.22B3CB015C@keescook>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202108301314.22B3CB015C@keescook>
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Mon, Aug 30, 2021 at 01:16:41PM -0700, Kees Cook wrote:
> On Mon, Aug 30, 2021 at 11:44:54AM -0700, Nathan Chancellor wrote:
> > arch/powerpc/kernel/signal_32.c:780:2: error: array index 3 is past the end of the array (which contains 1 element) [-Werror,-Warray-bounds]
> >         unsafe_put_sigset_t(&frame->uc.uc_sigmask, oldset, failed);
> >         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> 
> Or is this a Clang DCE failure?
> 
> #define unsafe_put_compat_sigset(compat, set, label) do {               \
>         compat_sigset_t __user *__c = compat;                           \
>         const sigset_t *__s = set;                                      \
>                                                                         \
>         switch (_NSIG_WORDS) {                                          \
>         case 4:                                                         \
>                 unsafe_put_user(__s->sig[3] >> 32, &__c->sig[7], label);        \
>                 unsafe_put_user(__s->sig[3], &__c->sig[6], label);      \
>                 fallthrough;                                            \
>         case 3:                                                         \
>                 unsafe_put_user(__s->sig[2] >> 32, &__c->sig[5], label);        \
>                 unsafe_put_user(__s->sig[2], &__c->sig[4], label);      \
>                 fallthrough;                                            \
>         case 2:                                                         \
>                 unsafe_put_user(__s->sig[1] >> 32, &__c->sig[3], label);        \
>                 unsafe_put_user(__s->sig[1], &__c->sig[2], label);      \
>                 fallthrough;                                            \
>         case 1:                                                         \
>                 unsafe_put_user(__s->sig[0] >> 32, &__c->sig[1], label);        \
>                 unsafe_put_user(__s->sig[0], &__c->sig[0], label);      \
>         }                                                               \
> } while (0)
> 
> if "set" has only 1 element, then _NSIG_WORDS must be 1. The warnings
> are coming from cases 4 and 3. (But why not 2, which would also access
> beyond the end?)

I trimmed the warnings down otherwise it would have been 400 lines long
:) it did warn for the 2 case.

Clang does not like the use of asm goto in unsafe_put_user on powerpc it
seems:

$ cat warray-bounds.c
#define NSIG_WORDS      1

typedef struct {
        unsigned long sig[NSIG_WORDS];
} sigset_t;

int handle_rt_signal32_bad(sigset_t *);
int handle_rt_signal32_bad(sigset_t *oldset)
{
	switch (NSIG_WORDS) {
	case 4:
			__asm__ goto("" : : "r"(oldset->sig[3] >> 32) : : failed);
			__asm__ goto("" : : "r"(oldset->sig[3]) : : failed);
			__attribute__((fallthrough));
	case 3:
			__asm__ goto("" : : "r"(oldset->sig[2] >> 32) : : failed);
			__asm__ goto("" : : "r"(oldset->sig[2]) : : failed);
			__attribute__((fallthrough));
	case 2:
			__asm__ goto("" : : "r"(oldset->sig[1] >> 32) : : failed);
			__asm__ goto("" : : "r"(oldset->sig[1]) : : failed);
			__attribute__((fallthrough));
	case 1:
			__asm__ goto("" : : "r"(oldset->sig[0] >> 32) : : failed);
			__asm__ goto("" : : "r"(oldset->sig[0]) : : failed);
	}

	return 0;
failed:
	return 1;
}

void normal_array_access(unsigned long);
int handle_rt_signal32_good(sigset_t *);
int handle_rt_signal32_good(sigset_t *oldset)
{
	switch (NSIG_WORDS) {
	case 4:
			normal_array_access(oldset->sig[3] >> 32);
			normal_array_access(oldset->sig[3]);
			__attribute__((fallthrough));
	case 3:
			normal_array_access(oldset->sig[2] >> 32);
			normal_array_access(oldset->sig[2]);
			__attribute__((fallthrough));
	case 2:
			normal_array_access(oldset->sig[1] >> 32);
			normal_array_access(oldset->sig[1]);
			__attribute__((fallthrough));
	case 1:
			normal_array_access(oldset->sig[0] >> 32);
			normal_array_access(oldset->sig[0]);
	}

	return 0;
}

$ clang -fsyntax-only -Weverything warray-bounds.c
warray-bounds.c:12:27: warning: array index 3 is past the end of the array (which contains 1 element) [-Warray-bounds]
                __asm__ goto("" : : "r"(oldset->sig[3] >> 32) : : failed);
                                        ^           ~
warray-bounds.c:4:2: note: array 'sig' declared here
        unsigned long sig[NSIG_WORDS];
        ^
warray-bounds.c:16:27: warning: array index 2 is past the end of the array (which contains 1 element) [-Warray-bounds]
                __asm__ goto("" : : "r"(oldset->sig[2] >> 32) : : failed);
                                        ^           ~
warray-bounds.c:4:2: note: array 'sig' declared here
        unsigned long sig[NSIG_WORDS];
        ^
warray-bounds.c:20:27: warning: array index 1 is past the end of the array (which contains 1 element) [-Warray-bounds]
                __asm__ goto("" : : "r"(oldset->sig[1] >> 32) : : failed);
                                        ^           ~
warray-bounds.c:4:2: note: array 'sig' declared here
        unsigned long sig[NSIG_WORDS];
        ^
3 warnings generated.

$ gcc -fsyntax-only -Wall -Wextra -Wpedantic warray-bounds.c

godbolt link: https://godbolt.org/z/8xYojs1WY

I've reported this on LLVM's bug tracker to see what the clang
developers can do with you on CC:

https://bugs.llvm.org/show_bug.cgi?id=51682

Cheers,
Nathan
