Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF60AC433EF
	for <linux-hardening@archiver.kernel.org>; Fri,  3 Sep 2021 05:55:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BB99E60FC0
	for <linux-hardening@archiver.kernel.org>; Fri,  3 Sep 2021 05:55:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234681AbhICF4e (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Fri, 3 Sep 2021 01:56:34 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:29955 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234575AbhICF4d (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Fri, 3 Sep 2021 01:56:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1630648533;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=YVcqIhLjK1aLZFmGstA8aMe5xkC0R7kiAZwq3yD/UZo=;
        b=Uwe3MMXm5P+7/RNxK+csOwaFx7Jvjh12Pu5e5mjmXrDzWXTiMbuXUA6egTBkMxw3Z8C6aX
        VjVuS6R+5j9qvz2+6YhL+aoBNbXWqT/6tiwu0hs5UCKWyQwiPyYcZsViZb/qdqheoGMbBE
        l370ildiNt+NBKWYCk0hIxj119TTGX0=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-308-BNiawID-NP-cGicQVX8KnQ-1; Fri, 03 Sep 2021 01:55:31 -0400
X-MC-Unique: BNiawID-NP-cGicQVX8KnQ-1
Received: by mail-qt1-f197.google.com with SMTP id l22-20020a05622a175600b0029d63a970f6so4459969qtk.23
        for <linux-hardening@vger.kernel.org>; Thu, 02 Sep 2021 22:55:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=YVcqIhLjK1aLZFmGstA8aMe5xkC0R7kiAZwq3yD/UZo=;
        b=snuqDa2L9vXVrMjYWT1Bxn90LKOqf2qt1PvvsnxweXS6ahQzcAvOwh3un674WP+nGA
         HbhN+m+A5eN5S+fDxo1KVVkslV/3UT0Bzxxiciv6qe3/3FG1wyVTFhnt2cSG5Vv261f/
         e2DFz9n6P1cvW23ox8TirC0tUkfAx18DALIMVTTbTH8G08oqKcedyP21Rctmduw8i90X
         7QiHTO0tss2ab8HvuSaJBp/CREkvIx7BxEwnkVRrogGLTwtjaJQXo/pjiXs2IJc6tCCg
         Nu1CjdjX9uG11RaI2lM6TSTdGnfc04D84jj4h1uHlKNkG6dbbAQwSW2bRdvOkNtmFc23
         u/5Q==
X-Gm-Message-State: AOAM530Dz1zjHIjPV9rMOZ8Z6skS+2y/LtC9zeRuuEOictyyv9n7xRC9
        gzC+xfi220InIoYdAvZSVZRXzsN2LexeTcaZYuiyPOY94d5vCTkPUEAVNAhqE7zrd4owimO/3FH
        EG4E2qKX9fMuGKU21hxHJsLkJOdEV
X-Received: by 2002:a05:620a:1529:: with SMTP id n9mr1829198qkk.322.1630648530598;
        Thu, 02 Sep 2021 22:55:30 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyBA2PPgx2ogxp7sl4eBWoxXxd8xybtAdlH2aAWqzoyoFquWEXA675Jbr2q0U4tlJxGlHbFOw==
X-Received: by 2002:a05:620a:1529:: with SMTP id n9mr1829187qkk.322.1630648530395;
        Thu, 02 Sep 2021 22:55:30 -0700 (PDT)
Received: from treble ([2600:1700:6e32:6c00::d])
        by smtp.gmail.com with ESMTPSA id g8sm3144077qkm.25.2021.09.02.22.55.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Sep 2021 22:55:29 -0700 (PDT)
Date:   Thu, 2 Sep 2021 22:55:26 -0700
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
Subject: Re: [PATCH 1/4] vmlinux.lds.h: Use regular *RODATA and
 *RO_AFTER_INIT_DATA suffixes
Message-ID: <20210903055526.mmi6hoomawavkbsp@treble>
References: <20210901233757.2571878-1-keescook@chromium.org>
 <20210901233757.2571878-2-keescook@chromium.org>
MIME-Version: 1.0
In-Reply-To: <20210901233757.2571878-2-keescook@chromium.org>
Authentication-Results: relay.mimecast.com;
        auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jpoimboe@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Wed, Sep 01, 2021 at 04:37:54PM -0700, Kees Cook wrote:
> Rename the various section macros that live in RODATA and
> RO_AFTER_INIT_DATA. Just being called "DATA" implies they are expected
> to be writable.
> 
> Cc: Arnd Bergmann <arnd@arndb.de>
> Cc: Josh Poimboeuf <jpoimboe@redhat.com>
> Cc: Peter Zijlstra (Intel) <peterz@infradead.org>
> Cc: linux-arch@vger.kernel.org
> Signed-off-by: Kees Cook <keescook@chromium.org>

Acked-by: Josh Poimboeuf <jpoimboe@redhat.com>

-- 
Josh

