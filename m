Return-Path: <SRS0=8UcS=EK=vger.kernel.org=linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6269C388F9
	for <linux-hardening@archiver.kernel.org>; Wed,  4 Nov 2020 15:19:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7D2D82074B
	for <linux-hardening@archiver.kernel.org>; Wed,  4 Nov 2020 15:19:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NptPlEGj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730208AbgKDPT1 (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Wed, 4 Nov 2020 10:19:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730198AbgKDPT0 (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Wed, 4 Nov 2020 10:19:26 -0500
Received: from mail-lf1-x143.google.com (mail-lf1-x143.google.com [IPv6:2a00:1450:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04EBBC0613D3;
        Wed,  4 Nov 2020 07:19:26 -0800 (PST)
Received: by mail-lf1-x143.google.com with SMTP id 126so27588981lfi.8;
        Wed, 04 Nov 2020 07:19:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=IKIIpB9wqyidyjb1EI8WFpMa+/cnKeKADUKKGpWDv08=;
        b=NptPlEGjmoYRgz9gbQS8+xuGz9yZ8ay7KQ+4RLy0Mi9mgRLXLF7eSZri//Wv+ozuMd
         Za11jHGFTilOW2qjOreq4UpZUbqKBdoZtjPfrkHP1vxN+LpehgkkLLUYLQ/wH0RWeB0E
         /lqqxJ4PWBA8iwO39iRsRwKTO9IHld8M2N848B5uF1c7JhloOl5YJaoZjXpW9YC+P5od
         21A50Sqd7K1N7GuWHBbI4fFpUNKFGtX2LrSUcGUiki5jp3wLqtoCPlOeajTVMknzrxLv
         HSkXI7714dQumN5Lp7mTEe0xTA+SLaSfod1Enr6YV38J8rzHmII/CTrnQV73l1i7dKui
         dWAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=IKIIpB9wqyidyjb1EI8WFpMa+/cnKeKADUKKGpWDv08=;
        b=WYYAAYKdcsudkJNa9F+ijk0ONkBpqHys6G9G1Mgc7I6dOXO+yG0Ue2ymcuIZAD/aTJ
         286Yj3p29L1I4Uf631IkOQ3N1bHyrRaoxHiPDSmvrqGU1jGu4fh8o8btgQbDNyB0TCVe
         0RmRVNSbn10gUu6QpBkFqkCPAMPdipEbEWISPrleU5P0j6QcSWHLyo12RAToLM5RxBYA
         gjXhNKKGwUECX55mvCksXNE+B6jnPtgqQBuzbpqiQdLVqXSxQ/LgVcta5mBmG6paCysX
         80+azvO+fpD1KiC0yAleBSWROvDYAuiZA5zAOzzA3WGRpiGYwivepkPCK2fvHMhcHLKA
         eI8w==
X-Gm-Message-State: AOAM531qpLuMCqD4FqYJV1VmW5lnftEbmMUzaPapzt+wiULbZtbEKlxj
        fhKOIjc0dB31n3Hw7/K1+rLY4UwNgWe7Sg==
X-Google-Smtp-Source: ABdhPJxRsNTI+FRktRgXc8IKzV3bqj8ft1XhtV7Y1uPyzyr4gei7EPySND+E7YvldxtAg6TA6B1hkw==
X-Received: by 2002:ac2:58f6:: with SMTP id v22mr10547760lfo.431.1604503163884;
        Wed, 04 Nov 2020 07:19:23 -0800 (PST)
Received: from [192.168.1.112] (88-114-211-119.elisa-laajakaista.fi. [88.114.211.119])
        by smtp.gmail.com with ESMTPSA id f9sm542782ljg.53.2020.11.04.07.19.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 Nov 2020 07:19:23 -0800 (PST)
Subject: Re: [PATCH 0/4] aarch64: avoid mprotect(PROT_BTI|PROT_EXEC) [BZ
 #26831]
To:     Catalin Marinas <catalin.marinas@arm.com>
Cc:     Florian Weimer <fweimer@redhat.com>, Will Deacon <will@kernel.org>,
        Mark Brown <broonie@kernel.org>,
        Szabolcs Nagy <szabolcs.nagy@arm.com>,
        libc-alpha@sourceware.org, Jeremy Linton <jeremy.linton@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Kees Cook <keescook@chromium.org>,
        Salvatore Mesoraca <s.mesoraca16@gmail.com>,
        Lennart Poettering <mzxreary@0pointer.de>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        kernel-hardening@lists.openwall.com,
        linux-hardening@vger.kernel.org
References: <cover.1604393169.git.szabolcs.nagy@arm.com>
 <20201103173438.GD5545@sirena.org.uk>
 <20201104092012.GA6439@willie-the-truck>
 <87h7q54ghy.fsf@oldenburg2.str.redhat.com>
 <d2f51a90-c5d6-99bd-35b8-f4fded073f95@gmail.com>
 <20201104143500.GC28902@gaia>
From:   Topi Miettinen <toiwoton@gmail.com>
Message-ID: <f595e572-40bc-a052-f3f2-763433d6762f@gmail.com>
Date:   Wed, 4 Nov 2020 17:19:19 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <20201104143500.GC28902@gaia>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On 4.11.2020 16.35, Catalin Marinas wrote:
> On Wed, Nov 04, 2020 at 11:55:57AM +0200, Topi Miettinen wrote:
>> On 4.11.2020 11.29, Florian Weimer wrote:
>>> * Will Deacon:
>>>
>>>> Is there real value in this seccomp filter if it only looks at mprotect(),
>>>> or was it just implemented because it's easy to do and sounds like a good
>>>> idea?
>>>
>>> It seems bogus to me.  Everyone will just create alias mappings instead,
>>> just like they did for the similar SELinux feature.  See “Example code
>>> to avoid execmem violations” in:
>>>
>>>     <https://www.akkadia.org/drepper/selinux-mem.html>
> [...]
>>> As you can see, this reference implementation creates a PROT_WRITE
>>> mapping aliased to a PROT_EXEC mapping, so it actually reduces security
>>> compared to something that generates the code in an anonymous mapping
>>> and calls mprotect to make it executable.
> [...]
>> If a service legitimately needs executable and writable mappings (due to
>> JIT, trampolines etc), it's easy to disable the filter whenever really
>> needed with "MemoryDenyWriteExecute=no" (which is the default) in case of
>> systemd or a TE rule like "allow type_t self:process { execmem };" for
>> SELinux. But this shouldn't be the default case, since there are many
>> services which don't need W&X.
> 
> I think Drepper's point is that separate X and W mappings, with enough
> randomisation, would be more secure than allowing W&X at the same
> address (but, of course, less secure than not having W at all, though
> that's not always possible).
> 
>> I'd also question what is the value of BTI if it can be easily circumvented
>> by removing PROT_BTI with mprotect()?
> 
> Well, BTI is a protection against JOP attacks. The assumption here is
> that an attacker cannot invoke mprotect() to disable PROT_BTI. If it
> can, it's probably not worth bothering with a subsequent JOP attack, it
> can already call functions directly.

I suppose that the target for the attacker is to eventually perform 
system calls rather than looping forever in JOP/ROP gadgets.

> I see MDWX not as a way of detecting attacks but rather plugging
> inadvertent security holes in certain programs. On arm64, such hardening
> currently gets in the way of another hardening feature, BTI.

I don't think it has to get in the way at all. Why wouldn't something 
simple like this work:

diff --git a/elf/dl-load.c b/elf/dl-load.c
index 646c5dca40..12a74d15e8 100644
--- a/elf/dl-load.c
+++ b/elf/dl-load.c
@@ -1170,8 +1170,13 @@ _dl_map_object_from_fd (const char *name, const 
char *origname, int fd,
             c->prot |= PROT_READ;
           if (ph->p_flags & PF_W)
             c->prot |= PROT_WRITE;
-         if (ph->p_flags & PF_X)
+         if (ph->p_flags & PF_X) {
             c->prot |= PROT_EXEC;
+#ifdef PROT_BTI
+           if (GLRO(dl_bti) & 1)
+             c->prot |= PROT_BTI;
+#endif
+         }
  #endif
           break;

diff --git a/elf/dl-support.c b/elf/dl-support.c
index 7704c101c5..22c7cc7b81 100644
--- a/elf/dl-support.c
+++ b/elf/dl-support.c
@@ -222,7 +222,7 @@ __rtld_lock_define_initialized_recursive (, 
_dl_load_write_lock)


  #ifdef HAVE_AUX_VECTOR
-int _dl_clktck;
+int _dl_clktck, _dl_bti;

  void
  _dl_aux_init (ElfW(auxv_t) *av)
@@ -294,6 +294,11 @@ _dl_aux_init (ElfW(auxv_t) *av)
        case AT_RANDOM:
         _dl_random = (void *) av->a_un.a_val;
         break;
+#ifdef PROT_BTI
+      case AT_BTI:
+       _dl_bti = (void *) av->a_un.a_val;
+       break;
+#endif
        DL_PLATFORM_AUXV
        }
    if (seen == 0xf)

Kernel sets the aux vector to indicate that BTI should be enabled for 
all segments and main exe is already protected.

-Topi
