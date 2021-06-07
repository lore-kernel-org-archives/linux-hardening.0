Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,UNPARSEABLE_RELAY autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FBAFC47082
	for <linux-hardening@archiver.kernel.org>; Mon,  7 Jun 2021 20:57:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0FB4861185
	for <linux-hardening@archiver.kernel.org>; Mon,  7 Jun 2021 20:57:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231147AbhFGU7E (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Mon, 7 Jun 2021 16:59:04 -0400
Received: from smtprelay0219.hostedemail.com ([216.40.44.219]:46632 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S230333AbhFGU7C (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Mon, 7 Jun 2021 16:59:02 -0400
Received: from omf16.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay08.hostedemail.com (Postfix) with ESMTP id 06D02182CF670;
        Mon,  7 Jun 2021 20:57:10 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: joe@perches.com) by omf16.hostedemail.com (Postfix) with ESMTPA id 3303C255114;
        Mon,  7 Jun 2021 20:57:08 +0000 (UTC)
Message-ID: <179e1e6a1c383650b65d73a4ea98d5e22c34e562.camel@perches.com>
Subject: Re: [PATCH][next] drm/i915/gem: Fix fall-through warning for Clang
From:   Joe Perches <joe@perches.com>
To:     "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>
Cc:     intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org,
        Kees Cook <keescook@chromium.org>
Date:   Mon, 07 Jun 2021 13:57:06 -0700
In-Reply-To: <20210607203229.GA60476@embeddedor>
References: <20210607203229.GA60476@embeddedor>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.38.1-1 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: rspamout01
X-Rspamd-Queue-Id: 3303C255114
X-Stat-Signature: pgm14zeb35swy91hjkipde1pgsrpsfgb
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Session-ID: U2FsdGVkX19L9gsetg5NN1XIjN0ilmq/oYUJ5kbZDSw=
X-HE-Tag: 1623099428-943858
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Mon, 2021-06-07 at 15:32 -0500, Gustavo A. R. Silva wrote:
> In preparation to enable -Wimplicit-fallthrough for Clang, fix a
> warning by explicitly adding a fallthrough; statement.
[]
> diff --git a/drivers/gpu/drm/i915/gem/i915_gem_shrinker.c b/drivers/gpu/drm/i915/gem/i915_gem_shrinker.c
[]
> @@ -62,6 +62,7 @@ static void try_to_writeback(struct drm_i915_gem_object *obj,
>  	switch (obj->mm.madv) {
>  	case I915_MADV_DONTNEED:
>  		i915_gem_object_truncate(obj);
> +		fallthrough;
>  	case __I915_MADV_PURGED:
>  		return;
>  	}

I think fallthrough to return is not particularly nice to follow.

This is the current function:

static void try_to_writeback(struct drm_i915_gem_object *obj,
			     unsigned int flags)
{
	switch (obj->mm.madv) {
	case I915_MADV_DONTNEED:
		i915_gem_object_truncate(obj);
	case __I915_MADV_PURGED:
		return;
	}

	if (flags & I915_SHRINK_WRITEBACK)
		i915_gem_object_writeback(obj);
}

One of these might be more typical:

static void try_to_writeback(struct drm_i915_gem_object *obj,
			     unsigned int flags)
{
	switch (obj->mm.madv) {
	case I915_MADV_DONTNEED:
		i915_gem_object_truncate(obj);
		break;
	case __I915_MADV_PURGED:
		break;
	default:
		if (flags & I915_SHRINK_WRITEBACK)
			i915_gem_object_writeback(obj);
		break;
	}
}

or maybe:

static void try_to_writeback(struct drm_i915_gem_object *obj,
			     unsigned int flags)
{
	switch (obj->mm.madv) {
	case I915_MADV_DONTNEED:
		i915_gem_object_truncate(obj);
		return;
	case __I915_MADV_PURGED:
		return;
	}

	if (flags & I915_SHRINK_WRITEBACK)
		i915_gem_object_writeback(obj);
}


