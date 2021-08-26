Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BE8DC432BE
	for <linux-hardening@archiver.kernel.org>; Thu, 26 Aug 2021 16:54:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 762FA60F6F
	for <linux-hardening@archiver.kernel.org>; Thu, 26 Aug 2021 16:54:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243062AbhHZQzD (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Thu, 26 Aug 2021 12:55:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:52216 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229986AbhHZQzB (ORCPT <rfc822;linux-hardening@vger.kernel.org>);
        Thu, 26 Aug 2021 12:55:01 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id AA38560FD9;
        Thu, 26 Aug 2021 16:54:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1629996854;
        bh=klpBCF3eOV7RWryCWxBXMbfoU4bGxqdvQgWtryTGOPg=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=EAJWiRYZSnbbMdKzWCPaNizrHYnsjksDCPp9AwFg7nuQbaz7N8zd9M5neTt5PKry8
         5lQ3DLc6ithwKg29EpbGzfmID84HBXppPXLsji5katHz0i/4rLSbrusb+t0Ppy2Wnr
         vfEDpnId106PPWYj2OK3NJr0Emvdnv4H8tRpr56nxpxG9LMeb/BNKCpjCfaVL5AAIp
         gXtwkeUTzmHeeAn8w2DueXdcjLxDd12Ce2E+T3kCEiahQf8otkKL/fCJab/tjQZoyH
         WfHsyeq/Tq8IiwxPLFnqFbhmw8ZBFhY3jRvuCbraMndavDv1y8/vRo2KDy21ITHYpf
         PU3cvEjWLez7A==
Subject: Re: [PATCH v2 07/14] x86: Use an opaque type for functions not
 callable from C
To:     Sami Tolvanen <samitolvanen@google.com>, x86@kernel.org
Cc:     Kees Cook <keescook@chromium.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Sedat Dilek <sedat.dilek@gmail.com>,
        linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org,
        clang-built-linux@googlegroups.com
References: <20210823171318.2801096-1-samitolvanen@google.com>
 <20210823171318.2801096-8-samitolvanen@google.com>
From:   Andy Lutomirski <luto@kernel.org>
Message-ID: <b2b0247a-39ad-097b-8fab-023ee378c806@kernel.org>
Date:   Thu, 26 Aug 2021 09:54:11 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210823171318.2801096-8-samitolvanen@google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On 8/23/21 10:13 AM, Sami Tolvanen wrote:
> The kernel has several assembly functions that are not directly callable
> from C. Use an opaque type for these function prototypes to make misuse
> harder, and to avoid the need to annotate references to these functions
> for Clang's Control-Flow Integrity (CFI).

You have:

typedef const u8 *asm_func_t;

This is IMO a bit confusing.  asm_func_t like this is an *address* of a
function, not a function.

To be fair, C is obnoxious, but I think this will lead to more confusion
than is idea.  For example:

> -extern void __fentry__(void);
> +DECLARE_ASM_FUNC_SYMBOL(__fentry__);

Okay, __fentry__ is the name of a symbol, and the expression __fentry__
is a pointer (or an array that decays to a pointer, thanks C), which is
at least somewhat sensible.  But:

> -extern void (*paravirt_iret)(void);
> +extern asm_func_t paravirt_iret;

Now paravirt_iret is a global variable that points to an asm func.  I
bet people will read this wrong and, worse, type it wrong.

I think that there a couple ways to change this that would be a bit nicer.

1. typedef const u8 asm_func_t[];

This is almost nice, but asm_func_t will still be accepted as a function
argument, and the automatic decay rules will probably be confusing.

2. Rename asm_func_t to asm_func_ptr.  Then it's at least a bit more clear.

3. Use an incomplete struct:

struct asm_func;

typedef struct asm_func asm_func;

extern asm_func some_func;

void *get_ptr(void)
{
    return &some_func;
}

No macros required, and I think it's quite hard to misuse this by
accident.  asm_func can't be passed as an argument or used as a variable
because it has incomplete type, and there are no arrays so the decay
rules aren't in effect.

--Andy
