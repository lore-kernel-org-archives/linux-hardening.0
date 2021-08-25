Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F982C4338F
	for <linux-hardening@archiver.kernel.org>; Wed, 25 Aug 2021 16:34:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E699F610A3
	for <linux-hardening@archiver.kernel.org>; Wed, 25 Aug 2021 16:34:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241637AbhHYQeu (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Wed, 25 Aug 2021 12:34:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237393AbhHYQeu (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Wed, 25 Aug 2021 12:34:50 -0400
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com [IPv6:2607:f8b0:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 706D3C0613C1
        for <linux-hardening@vger.kernel.org>; Wed, 25 Aug 2021 09:34:04 -0700 (PDT)
Received: by mail-pg1-x52d.google.com with SMTP id 17so270589pgp.4
        for <linux-hardening@vger.kernel.org>; Wed, 25 Aug 2021 09:34:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=6gejzDovBE5iuyuLz1hruEggadPtmSQG8HRcS9hcb10=;
        b=GbxNR4ElwFyWcJgWo+tCWcZLf00B+Z2Vmtk9ZQCzbpZRuGR+62kJB5UXPUdLfMZ7qe
         8I3BkoiVwC3G1+hadZLEeX/h0WjlD4pX70B8Z13Njs5KI3H4x7xDKgl5zdPDNCkJkAHZ
         dsDLLSPuCR7BNJ1zf42UHS2YUuTtZLC3fG3ys=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=6gejzDovBE5iuyuLz1hruEggadPtmSQG8HRcS9hcb10=;
        b=XeoRXCfqkwTmfhAGp1auhAJiWzxy7PmJqIC4xz90JNFG35IdHU4rAu9fz1KwEVbd6m
         ndJFwvARil8zPoA0lAA9QlY8fmnTjVOChPUDUGntozkT6np/0hUTVyI1jadSVuNz4bO8
         l9QBs7ZMlGcT8x4UrvXvkXMXn+jgipMzcXU6+mlg2KsotWOm/EH7Ge5HZR44uH8PmZ0Y
         AX/nXeMeZakWNm8AsISrz0xHDECNDHZdhdEoxC4HofnDm+LtdDIA7OPg3yHZe92w77o0
         2T7JCwdQnxHmei6GaeLtBMvc7o1/HvD0JDrY9HQRWLqNXISBGZbm4ZCbQPOG2CAhY+Bz
         IbSg==
X-Gm-Message-State: AOAM533zomo5/SQu21EviVOZ5/t8aSMYlKpNJloBfI4L/obcZSoyKsUM
        YWYtMm5z4XI7fJ65HJGftmutDw==
X-Google-Smtp-Source: ABdhPJx0d2gtu/6AIisV6tawjy+0JIqWnbbfAIMeMMyluAgBJFE83MjdsKdasSqsPWqClwNX5kV2Xg==
X-Received: by 2002:a63:705:: with SMTP id 5mr8798958pgh.265.1629909243823;
        Wed, 25 Aug 2021 09:34:03 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id h20sm278384pfn.173.2021.08.25.09.34.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Aug 2021 09:34:03 -0700 (PDT)
Date:   Wed, 25 Aug 2021 09:34:01 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Christoph Lameter <cl@gentwo.de>
Cc:     Daniel Micay <danielmicay@gmail.com>,
        Christoph Hellwig <hch@infradead.org>,
        kernel list <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Miguel Ojeda <ojeda@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Dennis Zhou <dennis@kernel.org>, Tejun Heo <tj@kernel.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Michal Marek <michal.lkml@markovi.net>,
        clang-built-linux@googlegroups.com, Linux-MM <linux-mm@kvack.org>,
        linux-kbuild <linux-kbuild@vger.kernel.org>,
        linux-hardening@vger.kernel.org
Subject: Re: [PATCH 0/5] Add __alloc_size() for better bounds checking
Message-ID: <202108250930.EED99F6@keescook>
References: <20210818050841.2226600-1-keescook@chromium.org>
 <YR4frlpfJQonPuKp@infradead.org>
 <CA+DvKQL6pLfK1vRzaOkEWR7DQLgTh=WZTka2L5yuS8Lf_1ZmoA@mail.gmail.com>
 <alpine.DEB.2.22.394.2108251158420.317806@gentwo.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.22.394.2108251158420.317806@gentwo.de>
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Wed, Aug 25, 2021 at 12:01:42PM +0200, Christoph Lameter wrote:
> On Thu, 19 Aug 2021, Daniel Micay wrote:
> 
> > For example, it will know that kmalloc(n) returns either NULL or an
> > allocation of size n. A simple sample program with calloc in
> > userspace:
> >
> >     #include <stdlib.h>
> >     #include <stdio.h>
> >
> >     int main(void) {
> >         char *p = calloc(64, 1);
> >         if (!p) {
> >             return 1;
> >         }
> >         printf("%zu\n", __builtin_object_size(p, 1));
> >         return 0;
> >     }
> >
> > It will also detect an out-of-bounds access via the allocation with
> > -fsanitize=object-size including with a runtime value as the index.
> >
> > It's not as useful as it should be yet because __builtin_object_size
> > must return a compile-time constant. Clang has a new
> > __builtin_dynamic_object_size that's allowed to return a value that's
> > not a compile-time constant so it can work for kmalloc(n) where n is a
> > runtime value. It might not be quite ready for use yet but it should
> > be able to make it a lot more useful. GCC also seems open to adding it
> > too.
> 
> The other complication with kmalloc etc is that the slab allocators may
> decided to allocate more bytes than needed because it does not support
> that particular allocation size. Some functions check the allocated true
> size and make use of that. See ksize().

Yup, this is known. For the current iteration, this doesn't pose a
problem since the compile-time checking has very limited scope.

-- 
Kees Cook
