Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A19A7C43217
	for <linux-hardening@archiver.kernel.org>; Thu,  1 Dec 2022 16:51:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229775AbiLAQv3 (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Thu, 1 Dec 2022 11:51:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229720AbiLAQv3 (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Thu, 1 Dec 2022 11:51:29 -0500
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com [IPv6:2607:f8b0:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82E3B1DF05
        for <linux-hardening@vger.kernel.org>; Thu,  1 Dec 2022 08:51:28 -0800 (PST)
Received: by mail-pg1-x52b.google.com with SMTP id 6so2152799pgm.6
        for <linux-hardening@vger.kernel.org>; Thu, 01 Dec 2022 08:51:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=frCt6pKGWIhEPpxLesPSV/Mh3cTSx4zBWHAWHmqSudQ=;
        b=DwwmIVJCxrknnFgsAtQfghmeg6nsCZ8RoEEzEVvPbBI+wiM0sY1ZbxrczIzURz/60h
         G8+ccZ3zqtKCwPp2UrvRxEqizKfqh6SQv4BeP2xqCrHbJk9Y4Sz6MxKuuG404UkEWsv7
         8oV4Q0b0J53QS6xITTCYCcyqbBzo42atOFmjE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=frCt6pKGWIhEPpxLesPSV/Mh3cTSx4zBWHAWHmqSudQ=;
        b=lw5gVqA4csvITVUgHgIl2JPMK7u9GrVj7i3ppOhCgyeSro5hXqUbbGefpb2b2p8gZT
         iJ0KgBmuoXhIwlMlLnutqOtqwiHC0ccw3Yat6iiISywDUj7AXwFGZhP0jNgpWpSRCA+5
         LA3ZLzku1UNOcv3i7+woO9Jjp2YnCJnHbJIYsSXo7OWmTyFyBAEQV9rqKNDkfholhFer
         yUxGcIHbjm+b/BZMBt94P480W0w0MTDXPKv/mInIWhzNGeHTJR6FkRchcKs5qoPRnha0
         nTW8DbFO373s2O3Z2j1lPzNk3++qOiO+1tIL56m3OxrhfqnuzMF1WkzngGvbFFwXr+T6
         iZQw==
X-Gm-Message-State: ANoB5pn8qxAz/nwAKc/7MAH4ty6CicnEsi2gE779SDjStpSo7IelwTvi
        CJ1yCyw320kp/MJIqbHfac8FDA==
X-Google-Smtp-Source: AA0mqf7SQT+A6xpC5K3KTNxK3qiYLvhaoNq+xncGf94HScz3Qcx2ku1px8PEYfDLlOXelx/lEs/iXQ==
X-Received: by 2002:a63:5262:0:b0:477:6e5d:4e44 with SMTP id s34-20020a635262000000b004776e5d4e44mr44707636pgl.7.1669913487993;
        Thu, 01 Dec 2022 08:51:27 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id 13-20020a170902c24d00b001745662d568sm3844626plg.278.2022.12.01.08.51.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Dec 2022 08:51:27 -0800 (PST)
Date:   Thu, 1 Dec 2022 08:51:26 -0800
From:   Kees Cook <keescook@chromium.org>
To:     Andrey Konovalov <andreyknvl@gmail.com>
Cc:     Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Hyeonggon Yoo <42.hyeyoo@gmail.com>,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        linux-mm@kvack.org, kasan-dev@googlegroups.com,
        Vlastimil Babka <vbabka@suse.cz>, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org
Subject: Re: [PATCH v2] mm: Make ksize() a reporting-only function
Message-ID: <202212010851.33009FA7@keescook>
References: <20221118035656.gonna.698-kees@kernel.org>
 <CA+fCnZfVZLLmipRBBMn1ju=U6wZL+zqf7S2jpUURPJmH3vPLNw@mail.gmail.com>
 <202211261654.5F276B51B@keescook>
 <CA+fCnZeb_Q==L9V2Cc2JbOfh11ZH+V0FC5C_q0Rs1NQYm74dUg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+fCnZeb_Q==L9V2Cc2JbOfh11ZH+V0FC5C_q0Rs1NQYm74dUg@mail.gmail.com>
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Wed, Nov 30, 2022 at 03:11:35PM +0100, Andrey Konovalov wrote:
> On Sun, Nov 27, 2022 at 1:55 AM Kees Cook <keescook@chromium.org> wrote:
> >
> > > I just realized there's an issue here with the tag-based modes, as
> > > they align the unpoisoned area to 16 bytes.
> > >
> > > One solution would be to change the allocation size to 128 -
> > > KASAN_GRANULE_SIZE - 5, the same way kmalloc_oob_right test does it,
> > > so that the last 16-byte granule won't get unpoisoned for the
> > > tag-based modes. And then check that the ptr[size] access fails only
> > > for the Generic mode.
> >
> > Ah! Good point. Are you able to send a patch? I suspect you know exactly
> > what to change; it might take me a bit longer to double-check all of
> > those details.
> 
> Let's do it like this:
> 
> size_t size = 128 - KASAN_GRANULE_SIZE - 5, real_size.
> 
> ...
> 
> /* These must trigger a KASAN report. */
> if (IS_ENABLED(CONFIG_KASAN_GENERIC))
>     KUNIT_EXPECT_KASAN_FAIL(test, ((volatile char *)ptr)[size]);
> KUNIT_EXPECT_KASAN_FAIL(test, ((volatile char *)ptr)[size + 5]);
> KUNIT_EXPECT_KASAN_FAIL(test, ((volatile char *)ptr)[real_size - 1]);

Done, and tested! Thanks :)

-- 
Kees Cook
