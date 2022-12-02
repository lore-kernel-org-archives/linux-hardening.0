Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74E14C47088
	for <linux-hardening@archiver.kernel.org>; Fri,  2 Dec 2022 22:41:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233548AbiLBWlm (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Fri, 2 Dec 2022 17:41:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234390AbiLBWll (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Fri, 2 Dec 2022 17:41:41 -0500
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com [IPv6:2607:f8b0:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5497BF3C2A
        for <linux-hardening@vger.kernel.org>; Fri,  2 Dec 2022 14:41:40 -0800 (PST)
Received: by mail-pg1-x534.google.com with SMTP id r18so5492690pgr.12
        for <linux-hardening@vger.kernel.org>; Fri, 02 Dec 2022 14:41:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=RPMshK7tVLl5Lle8RoOXHHhv2DXWHlF2R9uHvQRM5Bc=;
        b=merJ+GaoyeIA1krzJpTvcAlWx2q4jrDPmzZsBdSBPsN2auuRted+2l9PmyqmnDRjMX
         GwKijFgomVRFjyD8dqtOB/DijExpw/+dFZMDUTxIDeqZC76u/xiWq5r9t0vylHKYxY8l
         Z7ETLvpzXA2XcSSwRDWGOCSWe5grGDPrOZI9o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RPMshK7tVLl5Lle8RoOXHHhv2DXWHlF2R9uHvQRM5Bc=;
        b=3Ca9QwAWBy9r2rpn0pEnV0uf4vOR4KnXUAIEK+s4zJbqI40XCh6soiRxJWXlRpff+G
         M2SDgmQb37DD78r+yuPehDOi7hUXeuhP8VCOJ2aSaK2sfdf3nAQW/XHYEvV/MSs6XTA7
         smOqQMyx3EgMLU1QHedbgSnKE+t2F3jn3lMLPCc5g+Pq4DcTguerMd3hyUy9c99EINmG
         wQkdA2gX1kipw9+ERgO3IiBbIuzgQph8q/HHvU33pahcHzUlbA60B5/VE+ynjeLHhc7a
         6ctOAjNKO5CH208r/yv8NZ5gw3VCsI+ibY8KFpNum9eFt59f64egoKHIuWkV7p7uyVRn
         AgJg==
X-Gm-Message-State: ANoB5pnspT9c74hiZD/UtD6pzGc6ZhlWNvF9JQBnl3e2kWGsbRsl1jKc
        k9NnpQ0tOk2lQR0+XybgG/+OXQ==
X-Google-Smtp-Source: AA0mqf4SuLL8KvtdI3fAxn2zB2XRgbdM9yw+U277XBIdZDVunRVgl+uywFPSqtnji0ZuzQi358w7CQ==
X-Received: by 2002:aa7:810e:0:b0:56b:f23a:7854 with SMTP id b14-20020aa7810e000000b0056bf23a7854mr59505812pfi.66.1670020899834;
        Fri, 02 Dec 2022 14:41:39 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id z20-20020a63c054000000b00439c6a4e1ccsm4475973pgi.62.2022.12.02.14.41.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Dec 2022 14:41:39 -0800 (PST)
Date:   Fri, 2 Dec 2022 14:41:38 -0800
From:   Kees Cook <keescook@chromium.org>
To:     jeffxu@chromium.org
Cc:     skhan@linuxfoundation.org, akpm@linux-foundation.org,
        dmitry.torokhov@gmail.com, dverkamp@chromium.org, hughd@google.com,
        jeffxu@google.com, jorgelo@chromium.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-mm@kvack.org, mnissler@chromium.org, jannh@google.com,
        linux-hardening@vger.kernel.org
Subject: Re: [PATCH v3] mm/memfd: MFD_NOEXEC_SEAL and MFD_EXEC
Message-ID: <202212021437.C1FCD63D@keescook>
References: <20221202013404.163143-1-jeffxu@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221202013404.163143-1-jeffxu@google.com>
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Fri, Dec 02, 2022 at 01:33:58AM +0000, jeffxu@chromium.org wrote:
> From: Jeff Xu <jeffxu@chromium.org>

Hi! Thanks for this update! For future versions, please also use "-n"
with "git format-patch" so the patches are numbered, otherwise it's more
difficult to figure out what order they should be applied in, etc.

-- 
Kees Cook
