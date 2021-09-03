Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B38AFC433EF
	for <linux-hardening@archiver.kernel.org>; Fri,  3 Sep 2021 05:57:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 91A0A60FE6
	for <linux-hardening@archiver.kernel.org>; Fri,  3 Sep 2021 05:57:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235494AbhICF6C (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Fri, 3 Sep 2021 01:58:02 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:44695 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234575AbhICF6B (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Fri, 3 Sep 2021 01:58:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1630648622;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=bDvgsokZwzrcNUaLieJR18ZGVjKpNWnq/qMS3t3kGKI=;
        b=bDR2sbcE06mO17dljQ8YYGjRam+zR16BLHuynm3MrfTlXelXxYMDOxXXxDZeMzxVfyGMUl
        M65TdPioI8GU0UyVAKCVWnKcDLg9DOs8ZqmxpaQt4qTT/DXBgQYajbj/NegvBtxbOu5w02
        nCRZ6lZK+Oi6vfzRxgAeP0NOV9hRKls=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-27-NiHTXLmEOeyW0gMesrV4NA-1; Fri, 03 Sep 2021 01:55:46 -0400
X-MC-Unique: NiHTXLmEOeyW0gMesrV4NA-1
Received: by mail-qv1-f69.google.com with SMTP id r3-20020a0cc403000000b00377a3318261so5050931qvi.11
        for <linux-hardening@vger.kernel.org>; Thu, 02 Sep 2021 22:55:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=bDvgsokZwzrcNUaLieJR18ZGVjKpNWnq/qMS3t3kGKI=;
        b=X89A6hxbqUTu13DCYtspyzyp6B0HA3Vd7Xsgv+XSKmVs22nu9ryutB5cc5KzYKf90V
         GHIcp9XRSyS38yctpr7bdjOnXMBjhB2RH1KFv5pdwh4urzigALemQYpmVf1g91Q08slO
         f8g1msUPwTC+7adLcF9RiitdHp292qXqmiDFSrWFrIK10S5qUcsqwZzdpGYluP/T62b/
         aR4yjIbt0z29qu4uPFhEnXPSE7fCypUDhQx2dkwQXqlRC+5pmmU1yVnT1ME5zW05vgQi
         DMLLMVjDkfmVpQOnkjwPztHG3vRZR/3SlRteJrFjSE70/+1x1Sq487+BJgmpiUMtAQwv
         zXgg==
X-Gm-Message-State: AOAM531umMcurgPH++oNEL7VazjRywj+TJcGrLjaG5BFsm0cRrEl+OSG
        hUJ9ZBGswW8UnVBpjxlGZaJVUbEZSAgVWORUzFUAcfrrW2/4+yJT57YSzOHHzAvnh5OVJw5K27Z
        vm3in34Ao5z0RPT8DTxPgGvVtu+ZM
X-Received: by 2002:ad4:47cc:: with SMTP id p12mr1967383qvw.16.1630648545822;
        Thu, 02 Sep 2021 22:55:45 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJy2rfokB35RHoytkOenvkXEQNhy0zoJ+Ni5jGU5Fpr4Gqpd31z62no5fBtGg9o+rq+iUgaKgw==
X-Received: by 2002:ad4:47cc:: with SMTP id p12mr1967372qvw.16.1630648545652;
        Thu, 02 Sep 2021 22:55:45 -0700 (PDT)
Received: from treble ([2600:1700:6e32:6c00::d])
        by smtp.gmail.com with ESMTPSA id x23sm3180733qkn.29.2021.09.02.22.55.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Sep 2021 22:55:45 -0700 (PDT)
Date:   Thu, 2 Sep 2021 22:55:41 -0700
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     Kees Cook <keescook@chromium.org>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Peter Zijlstra <peterz@infradead.org>,
        linux-arch@vger.kernel.org, Jessica Yu <jeyu@kernel.org>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Alexander Egorenkov <egorenar@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Ilya Leoshkevich <iii@linux.ibm.com>,
        "Steven Rostedt (VMware)" <rostedt@goodmis.org>,
        Ingo Molnar <mingo@kernel.org>,
        Sami Tolvanen <samitolvanen@google.com>,
        linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org,
        linux-hardening@vger.kernel.org
Subject: Re: [PATCH 2/4] vmlinux.lds.h: Split .static_call_sites from
 .static_call_tramp_key
Message-ID: <20210903055541.b3dk5yqwkslklvsa@treble>
References: <20210901233757.2571878-1-keescook@chromium.org>
 <20210901233757.2571878-3-keescook@chromium.org>
MIME-Version: 1.0
In-Reply-To: <20210901233757.2571878-3-keescook@chromium.org>
Authentication-Results: relay.mimecast.com;
        auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jpoimboe@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Wed, Sep 01, 2021 at 04:37:55PM -0700, Kees Cook wrote:
> These two sections are ro_after_init and .rodata respectively. While
> they will ultimately become read-only, there's no reason to confuse
> their macro names.
> 
> Cc: Arnd Bergmann <arnd@arndb.de>
> Cc: Josh Poimboeuf <jpoimboe@redhat.com>
> Cc: Peter Zijlstra (Intel) <peterz@infradead.org>
> Cc: linux-arch@vger.kernel.org
> Signed-off-by: Kees Cook <keescook@chromium.org>

Acked-by: Josh Poimboeuf <jpoimboe@redhat.com>

-- 
Josh

