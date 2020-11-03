Return-Path: <SRS0=r0eN=EJ=vger.kernel.org=linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C7C2C82602
	for <linux-hardening@archiver.kernel.org>; Tue,  3 Nov 2020 10:38:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B80E822384
	for <linux-hardening@archiver.kernel.org>; Tue,  3 Nov 2020 10:38:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="a2b0PFcF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728075AbgKCKiQ (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Tue, 3 Nov 2020 05:38:16 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:55470 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726814AbgKCKiQ (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Tue, 3 Nov 2020 05:38:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1604399894;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ZK7kTdSBJkhWYXO+It5JpZizMtRKkiDqlX6IiABWQ7I=;
        b=a2b0PFcFMHydRjAYBRRLKvuAgUExc6OaEVtNniEa4OI23RQYiQs10jO7bq0Z88346+lJoD
        fhrDweHW2KHYWtwL3BFcBFalfsn7zV087SuJZDu99RoiBv/mNsde5DrPf+iIzvY+sCPcTy
        cnruR8Yn5EJ1jF0icfcUG+ttjVxbi7w=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-130-kGyoSPjNOa2bGC08sRRHMw-1; Tue, 03 Nov 2020 05:38:10 -0500
X-MC-Unique: kGyoSPjNOa2bGC08sRRHMw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 04E471009E3F;
        Tue,  3 Nov 2020 10:38:08 +0000 (UTC)
Received: from oldenburg2.str.redhat.com (ovpn-113-12.ams2.redhat.com [10.36.113.12])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id B3DD4747C6;
        Tue,  3 Nov 2020 10:38:04 +0000 (UTC)
From:   Florian Weimer <fweimer@redhat.com>
To:     Szabolcs Nagy <szabolcs.nagy@arm.com>
Cc:     libc-alpha@sourceware.org, Jeremy Linton <jeremy.linton@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Mark Brown <broonie@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Salvatore Mesoraca <s.mesoraca16@gmail.com>,
        Lennart Poettering <mzxreary@0pointer.de>,
        Topi Miettinen <toiwoton@gmail.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        kernel-hardening@lists.openwall.com,
        linux-hardening@vger.kernel.org, "H.J. Lu" <hjl.tools@gmail.com>
Subject: Re: [PATCH 2/4] elf: Move note processing after l_phdr is updated
 [BZ #26831]
References: <cover.1604393169.git.szabolcs.nagy@arm.com>
        <7b008fd34f802456db3731a043ff56683b569ff7.1604393169.git.szabolcs.nagy@arm.com>
Date:   Tue, 03 Nov 2020 11:38:03 +0100
In-Reply-To: <7b008fd34f802456db3731a043ff56683b569ff7.1604393169.git.szabolcs.nagy@arm.com>
        (Szabolcs Nagy's message of "Tue, 3 Nov 2020 10:26:18 +0000")
Message-ID: <87r1pabu9g.fsf@oldenburg2.str.redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

* Szabolcs Nagy:

> Program headers are processed in two pass: after the first pass
> load segments are mmapped so in the second pass target specific
> note processing logic can access the notes.
>
> The second pass is moved later so various link_map fields are
> set up that may be useful for note processing such as l_phdr.
> ---
>  elf/dl-load.c | 30 +++++++++++++++---------------
>  1 file changed, 15 insertions(+), 15 deletions(-)
>
> diff --git a/elf/dl-load.c b/elf/dl-load.c
> index ceaab7f18e..673cf960a0 100644
> --- a/elf/dl-load.c
> +++ b/elf/dl-load.c
> @@ -1259,21 +1259,6 @@ _dl_map_object_from_fd (const char *name, const char *origname, int fd,
>  				  maplength, has_holes, loader);
>      if (__glibc_unlikely (errstring != NULL))
>        goto call_lose;
> -
> -    /* Process program headers again after load segments are mapped in
> -       case processing requires accessing those segments.  Scan program
> -       headers backward so that PT_NOTE can be skipped if PT_GNU_PROPERTY
> -       exits.  */
> -    for (ph = &phdr[l->l_phnum]; ph != phdr; --ph)
> -      switch (ph[-1].p_type)
> -	{
> -	case PT_NOTE:
> -	  _dl_process_pt_note (l, fd, &ph[-1]);
> -	  break;
> -	case PT_GNU_PROPERTY:
> -	  _dl_process_pt_gnu_property (l, fd, &ph[-1]);
> -	  break;
> -	}
>    }
>  
>    if (l->l_ld == 0)
> @@ -1481,6 +1466,21 @@ cannot enable executable stack as shared object requires");
>      /* Assign the next available module ID.  */
>      l->l_tls_modid = _dl_next_tls_modid ();
>  
> +  /* Process program headers again after load segments are mapped in
> +     case processing requires accessing those segments.  Scan program
> +     headers backward so that PT_NOTE can be skipped if PT_GNU_PROPERTY
> +     exits.  */
> +  for (ph = &l->l_phdr[l->l_phnum]; ph != l->l_phdr; --ph)
> +    switch (ph[-1].p_type)
> +      {
> +      case PT_NOTE:
> +	_dl_process_pt_note (l, fd, &ph[-1]);
> +	break;
> +      case PT_GNU_PROPERTY:
> +	_dl_process_pt_gnu_property (l, fd, &ph[-1]);
> +	break;
> +      }
> +
>  #ifdef DL_AFTER_LOAD
>    DL_AFTER_LOAD (l);
>  #endif

Is this still compatible with the CET requirements?

I hope it is because the CET magic happens in _dl_open_check, so after
the the code in elf/dl-load.c has run.

Thanks,
Florian
-- 
Red Hat GmbH, https://de.redhat.com/ , Registered seat: Grasbrunn,
Commercial register: Amtsgericht Muenchen, HRB 153243,
Managing Directors: Charles Cachera, Brian Klemm, Laurie Krebs, Michael O'Neill

