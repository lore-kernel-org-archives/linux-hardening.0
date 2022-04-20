Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FEA5C433F5
	for <linux-hardening@archiver.kernel.org>; Wed, 20 Apr 2022 23:25:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358382AbiDTX2m (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Wed, 20 Apr 2022 19:28:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1383201AbiDTX2l (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Wed, 20 Apr 2022 19:28:41 -0400
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 542A72B253
        for <linux-hardening@vger.kernel.org>; Wed, 20 Apr 2022 16:25:54 -0700 (PDT)
Received: by mail-pj1-x1032.google.com with SMTP id ga4-20020a17090b038400b001d4b33c74ccso2335131pjb.1
        for <linux-hardening@vger.kernel.org>; Wed, 20 Apr 2022 16:25:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=e1hyArb/5whGQ4faeg6YhO5mzcFT0LHHgxgGSNRPGMg=;
        b=IzXr0U1vcfIgbzGgGTh6dzx0nqn8WMMdbN9zCGPRHGsgRNwmqpeKdhuU6wGXF5Eus0
         tnX6M+8p1i/EgZPwRUH7d9fyTDOw6+AymUSFKxGYPNNLKlqV+5h4TYcbImd28Zmn5CNk
         uNU0UwQac8mauwk90fO5L4zkY9PezSZxF5t4k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=e1hyArb/5whGQ4faeg6YhO5mzcFT0LHHgxgGSNRPGMg=;
        b=anpTxYCEV2XvkOVWf97irSC0gRgQ9E35qezAVcDQ1iBYjquX2IBgA4RuWWzoOlt4j8
         CGx2WY8BzSbl/VYU5vXXIzQiABVsO6yGvfXKY2lmaqkx9rWbeO5GLrMAE6byh9LGsGoe
         IDopAMs0aFiL/ynbGkoofBLE9pepPsLv4Q0rArENIaTJ7w67HfkY2AJPvUCIkmD9mxW+
         QflA2x/K6UpEsT7aqKlj+JkXqhkAkKWCXecWTe5TpLn7QANd0zRKgdZjPIQWw267kE6T
         PWHs8Lcbe+62hM7D2hkP9bo/4H7BG589SOXOY58yTZe3QEfpgi+2puNCYYk6CJT4H88d
         KvZw==
X-Gm-Message-State: AOAM530Ga7ngh8fbDbrOWxgCLfMb0szKIh5GzGWbdcTDE5+V+lZ5CA+u
        LuYmuB1kvdifXBIqoS6beZ1Kew==
X-Google-Smtp-Source: ABdhPJzW9o2jnlLh8gq/h5f1Xtg7444K7l2n/xm75BoEkh9+XT5HTYM3lQ/QPMNZwG+qExghHvv9ug==
X-Received: by 2002:a17:90b:218d:b0:1d0:90f5:4064 with SMTP id ku13-20020a17090b218d00b001d090f54064mr7158993pjb.95.1650497153809;
        Wed, 20 Apr 2022 16:25:53 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id cp14-20020a17090afb8e00b001cd4989ff55sm266911pjb.28.2022.04.20.16.25.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Apr 2022 16:25:53 -0700 (PDT)
Date:   Wed, 20 Apr 2022 16:25:52 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Joao Moreira <joao@overdrivepizza.com>
Cc:     linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org,
        peterz@infradead.org, jpoimboe@redhat.com,
        andrew.cooper3@citrix.com, samitolvanen@google.com,
        mark.rutland@arm.com, hjl.tools@gmail.com,
        alyssa.milburn@linux.intel.com, ndesaulniers@google.com,
        gabriel.gomes@linux.intel.com, rick.p.edgecombe@intel.com
Subject: Re: [RFC PATCH 11/11] driver/int3400_thermal: Fix prototype matching
Message-ID: <202204201625.5BBB91ADB8@keescook>
References: <20220420004241.2093-1-joao@overdrivepizza.com>
 <20220420004241.2093-12-joao@overdrivepizza.com>
 <202204191946.2843CF71@keescook>
 <06435f0b44681588052d145a17d60316@overdrivepizza.com>
 <202204201601.8291F550@keescook>
 <4dd9a9a3a7fb6f9af0fa04b8d2e3d5a2@overdrivepizza.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4dd9a9a3a7fb6f9af0fa04b8d2e3d5a2@overdrivepizza.com>
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Wed, Apr 20, 2022 at 04:12:26PM -0700, Joao Moreira wrote:
> > 
> > Ah-ha, thanks. I think this will fix it, but I haven't tested it:
> 
> I tried that, and IIRC, there was an error or warning in the assignment that
> happens a bit further in the file. My bad for not having it all properly
> tracked.

This builds for me without warnings, but maybe there is some weird
config I'm missing.

-- 
Kees Cook
