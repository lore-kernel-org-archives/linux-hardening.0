Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45AADC43219
	for <linux-hardening@archiver.kernel.org>; Fri, 18 Nov 2022 16:49:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235509AbiKRQtb (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Fri, 18 Nov 2022 11:49:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235408AbiKRQt0 (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Fri, 18 Nov 2022 11:49:26 -0500
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com [IPv6:2607:f8b0:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D965D70A1D
        for <linux-hardening@vger.kernel.org>; Fri, 18 Nov 2022 08:49:25 -0800 (PST)
Received: by mail-pg1-x52b.google.com with SMTP id 62so5428735pgb.13
        for <linux-hardening@vger.kernel.org>; Fri, 18 Nov 2022 08:49:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-disposition:mime-version:message-id:subject:cc:to:date:from
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ehUyg9og+6g03rh9x9ts9jERlST9RZLtaqEmFDxKGMc=;
        b=L35mCNVIZNLiioNel/sW2fV4ieca4G2sXtR9lRBysm0PPqP3SFS0FLNmN8Pea7Zmbv
         tDwxDHIiDpeQ6gWL1H+yPvNjqinYeC71M4fdxdlOjiXQcofY6SpelDE6VqUFkvmHdGu9
         WXTxrvdq6Su4POXtCphZuJDBBBKqzcEdSnJDI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-disposition:mime-version:message-id:subject:cc:to:date:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ehUyg9og+6g03rh9x9ts9jERlST9RZLtaqEmFDxKGMc=;
        b=Xe6JogLLoWHNyN0V48U+KHWoM2dCpq9oj6JsX2zUD+TN2pdGml64W2x5hsy7B/EDkL
         8yLLTnQgkjIi+/G+oDeZtM4a9n/pJeSA/HdSsC2k4JybnfNuIIP4hWGaJpU4UMorHiq9
         omlvmnQqqZlvx2NNaGPJzmgiVj+pqoeWWKBce677vtanH+5H3Or+g25AunfLY2NNvRou
         iHPnI2pgDl4oMMmXdy1/fzEEgHr3q3LccIGSD27SxASszHRzkhW5832vtJhMfUAwBJxJ
         TF1nebjKPvL+qe+UuwJzuASbjISQlGvKQchEZiK118r+yeGOVWcADdl/fT7h8bAy+mIp
         bhTQ==
X-Gm-Message-State: ANoB5pnSlsugx/4dnwG8mgrJUbn659ZcDykeCOsYoNQ5mZB66xWq4EC8
        ZunpjJdnTBQxO8TLA+LGCc4XuQ==
X-Google-Smtp-Source: AA0mqf60R75nwNvLu1XMvAA/HsqOTSPrQI5sXAOc+NHgyvwwAhweU9UnGjVFQ7VloaXUCUCft31vGQ==
X-Received: by 2002:a63:f354:0:b0:476:db6f:e79d with SMTP id t20-20020a63f354000000b00476db6fe79dmr7426913pgj.399.1668790165373;
        Fri, 18 Nov 2022 08:49:25 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id q4-20020a17090311c400b001865c298588sm3878961plh.258.2022.11.18.08.49.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Nov 2022 08:49:25 -0800 (PST)
From:   coverity-bot <keescook@chromium.org>
X-Google-Original-From: coverity-bot <keescook+coverity-bot@chromium.org>
Date:   Fri, 18 Nov 2022 08:49:24 -0800
To:     Jani Nikula <jani.nikula@intel.com>
Cc:     Jani Nikula <jani.nikula@linux.intel.com>,
        David Airlie <airlied@gmail.com>,
        Ville =?iso-8859-1?Q?Syrj=E4l=E4?= 
        <ville.syrjala@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Lucas De Marchi <lucas.demarchi@intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        intel-gfx@lists.freedesktop.org,
        Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Daniel Vetter <daniel@ffwll.ch>,
        Arun R Murthy <arun.r.murthy@intel.com>,
        Imre Deak <imre.deak@intel.com>,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        linux-next@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Coverity: intel_hti_uses_phy(): Integer handling issues
Message-ID: <202211180848.D39006C@keescook>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

Hello!

This is an experimental semi-automated report about issues detected by
Coverity from a scan of next-20221118 as part of the linux-next scan project:
https://scan.coverity.com/projects/linux-next-weekly-scan

You're getting this email because you were associated with the identified
lines of code (noted below) that were touched by commits:

  Thu Nov 17 16:12:56 2022 +0200
    62749912540b ("drm/i915/display: move hti under display sub-struct")

Coverity reported the following:

*** CID 1527374:  Integer handling issues  (BAD_SHIFT)
drivers/gpu/drm/i915/display/intel_hti.c:24 in intel_hti_uses_phy()
18     	if (INTEL_INFO(i915)->display.has_hti)
19     		i915->display.hti.state = intel_de_read(i915, HDPORT_STATE);
20     }
21
22     bool intel_hti_uses_phy(struct drm_i915_private *i915, enum phy phy)
23     {
vvv     CID 1527374:  Integer handling issues  (BAD_SHIFT)
vvv     In expression "1UL << 2 * phy + 1", shifting by a negative amount has undefined behavior.  The shift amount, "2 * phy + 1", is as little as -1.
24     	return i915->display.hti.state & HDPORT_ENABLED &&
25     		i915->display.hti.state & HDPORT_DDI_USED(phy);
26     }
27
28     u32 intel_hti_dpll_mask(struct drm_i915_private *i915)
29     {

If this is a false positive, please let us know so we can mark it as
such, or teach the Coverity rules to be smarter. If not, please make
sure fixes get into linux-next. :) For patches fixing this, please
include these lines (but double-check the "Fixes" first):

Reported-by: coverity-bot <keescook+coverity-bot@chromium.org>
Addresses-Coverity-ID: 1527374 ("Integer handling issues")
Fixes: 62749912540b ("drm/i915/display: move hti under display sub-struct")

This code appears to be safe currently (intel_hti_uses_phy() is never
called with PHY_NONE), but perhaps add an explicit check?

	if (WARN_ON(phy == PHY_NONE))
		return false;

Thanks for your attention!

-- 
Coverity-bot
