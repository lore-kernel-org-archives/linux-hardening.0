Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD14AC433B4
	for <linux-hardening@archiver.kernel.org>; Tue, 20 Apr 2021 19:48:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 96E9C613EB
	for <linux-hardening@archiver.kernel.org>; Tue, 20 Apr 2021 19:48:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233541AbhDTTs3 (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Tue, 20 Apr 2021 15:48:29 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:28629 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233776AbhDTTs3 (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Tue, 20 Apr 2021 15:48:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1618948077;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=SiFW4cLK3dCh2r8aGQaiYzHAG/F7jfTRpzCXN26gydY=;
        b=X3GK8uqjKCcRUDkBa+Sgh8ztaz5ZTFRXKFqDtlNoNCn/i1BXJ8jL+1rLB45Xzdyqj80sYr
        owlnpZ24rBiMBHD9a6BW+vo1pM1nLUs9FScMtTLCxdvJs7JkHnDmdd6YRq16Yk1uwGkidn
        opx+NacVAlbp++R9A/xiGQXHZbHGG/M=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-200-QlukleblN5-y3fJuwxPo2Q-1; Tue, 20 Apr 2021 15:47:53 -0400
X-MC-Unique: QlukleblN5-y3fJuwxPo2Q-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9B2F01006C83;
        Tue, 20 Apr 2021 19:47:50 +0000 (UTC)
Received: from treble (ovpn-115-229.rdu2.redhat.com [10.10.115.229])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 798B65D9CA;
        Tue, 20 Apr 2021 19:47:49 +0000 (UTC)
Date:   Tue, 20 Apr 2021 14:47:47 -0500
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     Sami Tolvanen <samitolvanen@google.com>
Cc:     x86@kernel.org, Kees Cook <keescook@chromium.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Sedat Dilek <sedat.dilek@gmail.com>,
        linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org,
        clang-built-linux@googlegroups.com
Subject: Re: [PATCH 02/15] objtool: Add CONFIG_CFI_CLANG support
Message-ID: <20210420194747.3snxvaaa4amfnbah@treble>
References: <20210416203844.3803177-1-samitolvanen@google.com>
 <20210416203844.3803177-3-samitolvanen@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210416203844.3803177-3-samitolvanen@google.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Fri, Apr 16, 2021 at 01:38:31PM -0700, Sami Tolvanen wrote:
> +static int fix_cfi_relocs(const struct elf *elf)
> +{
> +	struct section *sec, *tmpsec;
> +	struct reloc *reloc, *tmpreloc;
> +
> +	list_for_each_entry_safe(sec, tmpsec, &elf->sections, list) {
> +		list_for_each_entry_safe(reloc, tmpreloc, &sec->reloc_list, list) {

These loops don't remove structs from the lists, so are the "safe"
iterators really needed?

> +			struct symbol *sym;
> +			struct reloc *func_reloc;
> +
> +			/*
> +			 * CONFIG_CFI_CLANG replaces function relocations to refer
> +			 * to an intermediate jump table. Undo the conversion so
> +			 * objtool can make sense of things.
> +			 */

I think this comment could be clearer if it were placed above the
function.

> +			if (!reloc->sym->sec->cfi_jt)
> +				continue;
> +
> +			if (reloc->sym->type == STT_SECTION)
> +				sym = find_func_by_offset(reloc->sym->sec,
> +							  reloc->addend);
> +			else
> +				sym = reloc->sym;
> +
> +			if (!sym || !sym->sec)
> +				continue;

This should be a fatal error, it probably means something's gone wrong
with the reading of the jump table.

> +
> +			/*
> +			 * The jump table immediately jumps to the actual function,
> +			 * so look up the relocation there.
> +			 */
> +			func_reloc = find_reloc_by_dest_range(elf, sym->sec, sym->offset, 5);

The jump instruction's reloc is always at offset 1, so this can maybe be
optimized to:

			func_reloc = find_reloc_by_dest(elf, sym->sec, sym->offset+1);

though of course that will probably break (future) arm64 objtool.  Maybe
an arch-specific offset from the start of the insn would be good.

> +			if (!func_reloc || !func_reloc->sym)
> +				continue;

This should also be an error.

> +
> +			reloc->sym = func_reloc->sym;

I think we should also do 'reloc->addend = 0', because of the
STT_SECTION case:

  0000000000000025  0000259e0000000b R_X86_64_32S           0000000000000000 .text..L.cfi.jumptable.8047 + 8

which then translates to

  0000000000000009  0000063200000004 R_X86_64_PLT32         0000000000000000 x2apic_prepare_cpu - 4

so the original addend of '8' is no longer valid.  Copying the '-4'
wouldn't be right either, because that only applies to a PLT32 text
reloc.  A '0' should be appropriate for the 32S data reloc.

This addend might not actually be read by any code, so it may not
currently be an actual bug, but better safe than sorry.

-- 
Josh

