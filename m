Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8EFF6C433FE
	for <linux-hardening@archiver.kernel.org>; Wed, 27 Oct 2021 15:06:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 716C060EFF
	for <linux-hardening@archiver.kernel.org>; Wed, 27 Oct 2021 15:06:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242643AbhJ0PJD (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Wed, 27 Oct 2021 11:09:03 -0400
Received: from mga09.intel.com ([134.134.136.24]:57451 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S242006AbhJ0PJC (ORCPT <rfc822;linux-hardening@vger.kernel.org>);
        Wed, 27 Oct 2021 11:09:02 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10150"; a="230038494"
X-IronPort-AV: E=Sophos;i="5.87,187,1631602800"; 
   d="scan'208";a="230038494"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Oct 2021 08:06:36 -0700
X-IronPort-AV: E=Sophos;i="5.87,187,1631602800"; 
   d="scan'208";a="447254481"
Received: from smaharan-mobl.gar.corp.intel.com (HELO localhost) ([10.251.214.195])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Oct 2021 08:06:30 -0700
From:   Jani Nikula <jani.nikula@linux.intel.com>
To:     Len Baker <len.baker@gmx.com>
Cc:     Len Baker <len.baker@gmx.com>, Daniel Vetter <daniel@ffwll.ch>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        David Airlie <airlied@linux.ie>,
        Kees Cook <keescook@chromium.org>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drm/i915: Prefer struct_size over open coded arithmetic
In-Reply-To: <20211023115020.GC4145@titan>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
References: <20211003104258.18550-1-len.baker@gmx.com> <20211011092304.GA5790@titan> <87k0ihxj56.fsf@intel.com> <YWbIQmD1TGikpRm2@phenom.ffwll.local> <20211016111602.GA1996@titan> <877deatzz2.fsf@intel.com> <20211023115020.GC4145@titan>
Date:   Wed, 27 Oct 2021 18:06:28 +0300
Message-ID: <87ee86h5hn.fsf@intel.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Sat, 23 Oct 2021, Len Baker <len.baker@gmx.com> wrote:
> Sorry, but I'm missing something here. In linux-next this is the commit
> history of include/linux/stddef.h file:
>
> 3080ea5553cc stddef: Introduce DECLARE_FLEX_ARRAY() helper
> 50d7bd38c3aa stddef: Introduce struct_group() helper macro
> e7f18c22e6be stddef: Fix kerndoc for sizeof_field() and offsetofend()
> 4229a470175b stddef.h: Introduce sizeof_field()
> ...
>
> But in drm-tip this is the commit history:
>
> 4229a470175b stddef.h: Introduce sizeof_field()
> ...
>
> For this patch the DECLARE_FLEX_ARRAY() helper is needed. But the build
> fails due to the last tree commits for stddef.h file are not present.
> So, if I understand correctly, drm-tip is not up to date with linux-next.

linux-next is an ephemeral integration branch for most arch, subsystem
and driver -next branches.

drm-tip is an ephemeral integration branch for drm subsystem and driver
-next branches.

They contain different sets of branches. They are constantly
rebuilt. They are not the end result or end goal.

If a problem (or a solution, for that matter) only exists in the merge
of some of those branches, you can't actually fix it until such a merge
exists somewhere more permanent than an ephemeral integration branch.


BR,
Jani.


-- 
Jani Nikula, Intel Open Source Graphics Center
