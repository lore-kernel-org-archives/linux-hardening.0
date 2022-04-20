Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CF8DC433EF
	for <linux-hardening@archiver.kernel.org>; Wed, 20 Apr 2022 17:44:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1381253AbiDTRqy (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Wed, 20 Apr 2022 13:46:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1381259AbiDTRqx (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Wed, 20 Apr 2022 13:46:53 -0400
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13CF647397
        for <linux-hardening@vger.kernel.org>; Wed, 20 Apr 2022 10:44:06 -0700 (PDT)
Received: by mail-pl1-x636.google.com with SMTP id s17so2442235plg.9
        for <linux-hardening@vger.kernel.org>; Wed, 20 Apr 2022 10:44:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Rx+BcE/gSceiKr/zTECjP4EwFSfIzQ9iSKcxGEqhZ8E=;
        b=S+jeltxbAM3NoFlwTYpJWXeazpb8JERjrM1BTuTkj5LB0pDMpt8FbrJbHowAG9ESGx
         bF3K1477oF5SMjqvKdyQyw5RvTRXY8zWS3R4UbhQ0goj60wthxhIKo4p3mAIZ3o4hK2S
         uFVIERf5sWiA4L+yQp4Dau9kCtCAGescfc61A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Rx+BcE/gSceiKr/zTECjP4EwFSfIzQ9iSKcxGEqhZ8E=;
        b=oxHjWhwnBOtf68UvaeRRf85GGr01KoLHBgdob0CQD7CrKW0VGucjEvb1JoD1lE9gQh
         YyvuqhZpo4W3/YjBD8aNSK3u2+KTvWqLOMRhlLQIRMPN9CeGOlNdpvmZj87svEKxHF/7
         +mx9Z68qFXkYM5E3aHPYEpebPopjWT7Y0K/aCbRyLreITlFNitXl944QzLr/hBn7D6Mp
         Uehrgwc9uDHL/eLqA9MDT9UPuOm2YW1cjXGYMDMejCgP5lheaTvqWASHz+kNB1qtDOyw
         8UVTqI8eb9ELTwhXzsOGvVmdTqxry/TsAheWL6QUox/IZG35dj8gpfa3iHutJ46s0MUc
         +fOw==
X-Gm-Message-State: AOAM532A5+i6aqC33pZAPt99uvM71PUum4S4mG4USGMswIcstZq082gh
        Tk3gxzD+hUG1FqX/GCjIxdENew==
X-Google-Smtp-Source: ABdhPJzHXgBTMlSzaXENo42O6xuwYeC0Yi0z/Itbb3PnHI+h5sdz1fnNSuD5YgXE9SazzmYGLZ0n/g==
X-Received: by 2002:a17:902:c205:b0:15a:2e1b:6360 with SMTP id 5-20020a170902c20500b0015a2e1b6360mr3945500pll.152.1650476645567;
        Wed, 20 Apr 2022 10:44:05 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id p10-20020a637f4a000000b00373a2760775sm20402378pgn.2.2022.04.20.10.44.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Apr 2022 10:44:05 -0700 (PDT)
Date:   Wed, 20 Apr 2022 10:44:04 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Catalin Marinas <catalin.marinas@arm.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Christoph Hellwig <hch@infradead.org>,
        Lennart Poettering <lennart@poettering.net>,
        Zbigniew =?utf-8?Q?J=C4=99drzejewski-Szmek?= <zbyszek@in.waw.pl>,
        Will Deacon <will@kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Eric Biederman <ebiederm@xmission.com>,
        Szabolcs Nagy <szabolcs.nagy@arm.com>,
        Mark Brown <broonie@kernel.org>,
        Jeremy Linton <jeremy.linton@arm.com>,
        Topi Miettinen <toiwoton@gmail.com>, linux-mm@kvack.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-abi-devel@lists.sourceforge.net,
        linux-hardening@vger.kernel.org, Jann Horn <jannh@google.com>,
        Salvatore Mesoraca <s.mesoraca16@gmail.com>,
        Igor Zhbanov <izh1979@gmail.com>
Subject: Re: [PATCH RFC 0/4] mm, arm64: In-kernel support for
 memory-deny-write-execute (MDWE)
Message-ID: <202204200952.F2B1F58D6B@keescook>
References: <20220413134946.2732468-1-catalin.marinas@arm.com>
 <202204141028.0482B08@keescook>
 <YmAEDsGtxhim46UI@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YmAEDsGtxhim46UI@arm.com>
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Wed, Apr 20, 2022 at 02:01:02PM +0100, Catalin Marinas wrote:
> I agree we should look at what we want to cover, though trying to avoid
> re-inventing SELinux. With this patchset I went for the minimum that
> systemd MDWE does with BPF.

Right -- and I don't think we're at any risk of slippery-sloping into a
full MAC system. :)

I'm fine with doing the implementation in stages, if we've attempted to
design the steps (which I think you've got a good start on below).

> I think JITs get around it using something like memfd with two separate
> mappings to the same page. We could try to prevent such aliases but
> allow it if an ELF note is detected (or get the JIT to issue a prctl()).

Right -- I'd rather JITs carry some hard-coded property (i.e. ELF note)
to indicate the fact that they're expecting to do these kinds of things
rather than leaving it open for all processes.

> Anyway, with a prctl() we can allow finer-grained control starting with
> anonymous and file mappings and later extending to vma aliases,
> writeable files etc. On top we can add a seal mask so that a process
> cannot disable a control was set. Something like (I'm not good at
> names):
> 
> 	prctl(PR_MDWX_SET, flags, seal_mask);
> 	prctl(PR_MDWX_GET);
> 
> with flags like:
> 
> 	PR_MDWX_MMAP - basics, should cover mmap() and mprotect()
> 	PR_MDWX_ALIAS - vma aliases, allowed with an ELF note
> 	PR_MDWX_WRITEABLE_FILE

The SARA proposal lists a lot of behavioral details to consider.
Quoting it[1] here:
>> - W^X enforcement will cause problems to any programs that needs
>>   memory pages mapped both as writable and executable at the same time e.g.
>>   programs with executable stack markings in the PT_GNU_STACK segment.

IMO, executable stack markings should be considered completely
deprecated. In fact, we've been warning about it since 2020:
47a2ebb7f505 ("execve: warn if process starts with executable stack")

So with execstack, under W^X, I think we should either:
- refuse to exec the process (default)
- disable W^X for the process (but not its children)

>> - W!->X restriction will cause problems to any program that
>>   needs to generate executable code at run time or to modify executable
>>   pages e.g. programs with a JIT compiler built-in or linked against a
>>   non-PIC library.

This seems solvable with an ELF flag.

>> - Executable MMAP prevention can work only with programs that have at least
>>   partial RELRO support. It's disabled automatically for programs that
>>   lack this feature. It will cause problems to any program that uses dlopen
>>   or tries to do an executable mmap. Unfortunately this feature is the one
>>   that could create most problems and should be enabled only after careful
>>   evaluation.

This seems like a variation on the execstack case, and we should be
able to detect the state and choose a behavior based on system settings,
and a smarter version (as SARA has) would track RELRO pages waiting for
the loader to make them read-only.

SARA was proposed with a set of feature flags[2]; quoting here:
>> | W^X                          |  0x0008  |

This is the basic property, refusing PROT_WRITE | PROT_EXEC. I note that
SARA also rejects opening /proc/$pid/mem with FMODE_WRITE when this is
enabled for a process. (It likely should extend to process_vm_write()
too.)

>> | W!->X Heap                   |  0x0001  |
>> | W!->X Stack                  |  0x0002  |
>> | W!->X Other memory           |  0x0004  |

This is for the vma history tracking, and I don't think we need to
separate this by memory type? It's nice to have the granularity, but for
a first-pass it seems like overkill? Maybe I'm missing some detail.

>> | Don't enforce, just complain |  0x0010  |
>> | Be Verbose                   |  0x0020  |

Unclear if these would work well with a non-LSM approach.

>> | Executable MMAP prevention   |  0x0040  |

This is the relro detection piece.

>> | Trampoline emulation         |  0x0100  |

This is a more advanced case for emulating execstack, but if we can just
ignore execstack entirely, this can go away?

>> | Children will inherit flags  |  0x0200  |

Should a process have that control?

>> | Force W^X on setprocattr     |  0x0080  |

This is a "seal" trigger, which could be done through prctl().


It looks like a bunch of the features are designed around having as much
as possible enabled at exec time, and then tightening it further as
various things are finished (e.g. execstack, relro, sealing, etc), which
is, I think, what would still be needed for a process launcher to be
able to enable this kind of protection. (i.e. hoping the process calls a
prctl() to enable the protection isn't going to work well with systemd.)

So, I *think* we could have a minimal form with these considerations:
 - execstack: declare it distinctly incompatible.
 - relro: I think this is solved with BIND_NOW. It's been a while since
   I looked deeply at this, but I think under BIND_NOW, the (executable)
   PLT doesn't ever need to be writable (since it points into the GOT),
   and the (initially writable) GOT is already never executable. This
   needs to be verified...
 - JITs can be allowed with a ELF flag and can choose to opt-in with
   a prctl().

-Kees

[1] https://lore.kernel.org/lkml/1562410493-8661-1-git-send-email-s.mesoraca16@gmail.com/
[2] https://lore.kernel.org/lkml/1562410493-8661-2-git-send-email-s.mesoraca16@gmail.com/

-- 
Kees Cook
