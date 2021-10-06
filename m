Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D12BC433EF
	for <linux-hardening@archiver.kernel.org>; Wed,  6 Oct 2021 16:33:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7AC6F610EA
	for <linux-hardening@archiver.kernel.org>; Wed,  6 Oct 2021 16:33:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229835AbhJFQfM (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Wed, 6 Oct 2021 12:35:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229548AbhJFQfM (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Wed, 6 Oct 2021 12:35:12 -0400
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 112F7C061753
        for <linux-hardening@vger.kernel.org>; Wed,  6 Oct 2021 09:33:19 -0700 (PDT)
Received: by mail-pj1-x1031.google.com with SMTP id g13-20020a17090a3c8d00b00196286963b9so4829457pjc.3
        for <linux-hardening@vger.kernel.org>; Wed, 06 Oct 2021 09:33:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=7bOzvzte6+zR7QYRdFhrICgWaXgsnkrZk1AsUn5dUkM=;
        b=DpEgsgBSI1hWXfuKPZSHTTNYUXjXlrfB3e6Vtmfo6dehm5A3vqjOviSZlbUdCoT1BR
         /g1TrBGRLjjUEaqUI/IvNn+NFuImGJheACS0FmT4XHDkf+Jlb2oM+vFmlqQ7YPBRilRE
         p4CF5qLSCBoHukyqymOpRaA4zTiAhSWJ4TGnI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=7bOzvzte6+zR7QYRdFhrICgWaXgsnkrZk1AsUn5dUkM=;
        b=m2EB3sF4Ee7I8sKlrTPm6VaTCIwLG1TEyQ2SuH+kmUhMj2QZZMQHfN+6BAAC7VlMtZ
         9FQ9V+U7JlXwS6wnS88m3e8DEwKaqgLZgA8nihnyqKlEIODi07KxZavwC5YV4zpfl6fv
         +teSy0IYWXpG5CoJ782VckO9ea3hi4PHt7/VpdcoNX4qXL1+fl9KKfXJbeJAKnlphB6u
         94Dy5NLpCL3D2cxeo13397It8+moVDcqxo15+srae1HB4XI44hML7uYNwCWkIn5G+tcB
         a60tUw6DOEPEvHZlHpQsueUD5lL0UwDzEdeU8grRHDoj8zmxFMjt7hVURprPmIyEhRm4
         fLqg==
X-Gm-Message-State: AOAM530c9LqHYYzKQ6IeY3O38wnwmEr+HpCizOxxxN5dmB21hU4C6MRO
        Ua/CJvm9c2A0nPZ+t0SUJDKPAw==
X-Google-Smtp-Source: ABdhPJydlDRZrDdTBs23vVvsyAwsVVgK4CVGdj5JU9XRF10+EPKmZm6voo8K7NGVu4eX79n5EWeDNg==
X-Received: by 2002:a17:902:8686:b0:13e:dade:e88c with SMTP id g6-20020a170902868600b0013edadee88cmr12057386plo.70.1633537999329;
        Wed, 06 Oct 2021 09:33:19 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id gn11sm5459105pjb.36.2021.10.06.09.33.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Oct 2021 09:33:19 -0700 (PDT)
Date:   Wed, 6 Oct 2021 09:33:18 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Mark Rutland <mark.rutland@arm.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        Alexander Potapenko <glider@google.com>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Dmitry Vyukov <dvyukov@google.com>, kasan-dev@googlegroups.com,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH] kasan: test: Bypass __alloc_size checks
Message-ID: <202110060932.0808BD6500@keescook>
References: <20211006035522.539346-1-keescook@chromium.org>
 <20211006113732.GA14159@C02TD0UTHF1T.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211006113732.GA14159@C02TD0UTHF1T.local>
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Wed, Oct 06, 2021 at 12:38:36PM +0100, Mark Rutland wrote:
> Hi Kees,
> 
> On Tue, Oct 05, 2021 at 08:55:22PM -0700, Kees Cook wrote:
> > Intentional overflows, as performed by the KASAN tests, are detected
> > at compile time[1] (instead of only at run-time) with the addition of
> > __alloc_size. Fix this by forcing the compiler into not being able to
> > trust the size used following the kmalloc()s.
> 
> It might be better to use OPTIMIZER_HIDE_VAR(), since that's intended to
> make the value opaque to the compiler, and volatile might not always do
> that depending on how the compiler tracks the variable.

Given both you and Jann[1] have suggested this, I'll send a v2 with that.
:) Thanks!

-Kees

[1] https://lore.kernel.org/lkml/CAG48ez19raco+s+UF8eiXqTvaDEoMAo6_qmW2KdO24QDpmZpFQ@mail.gmail.com/

-- 
Kees Cook
