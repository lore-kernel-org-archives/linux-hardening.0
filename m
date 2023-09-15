Return-Path: <linux-hardening-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73CB1EE021D
	for <linux-hardening@archiver.kernel.org>; Fri, 15 Sep 2023 03:40:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231808AbjIODk5 (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Thu, 14 Sep 2023 23:40:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231776AbjIODk4 (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Thu, 14 Sep 2023 23:40:56 -0400
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8C562134
        for <linux-hardening@vger.kernel.org>; Thu, 14 Sep 2023 20:40:52 -0700 (PDT)
Received: by mail-pf1-x42e.google.com with SMTP id d2e1a72fcca58-68c576d35feso1516718b3a.2
        for <linux-hardening@vger.kernel.org>; Thu, 14 Sep 2023 20:40:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1694749252; x=1695354052; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Wc99nGQEALaOKSDIv77AhBK5hwBb20YJz7YOm9x4L4E=;
        b=XEhpL1Cj3P5lfDWoPdowuEYT+4HHVhVw2VWxjzsfzbtTPQdCELPGJOozCOlcm91fBr
         29BiMQBcw8QA3BvCvdMA3ikYrJkTPe2SfsgC02GqJtUZx9/SxFzIKol0Gyk+FCVKcfNs
         +cA/bF7NZPXj1QHd4dD6txKFGVwZYc74Fdstw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694749252; x=1695354052;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Wc99nGQEALaOKSDIv77AhBK5hwBb20YJz7YOm9x4L4E=;
        b=DhMQAbLwjoESmOex1RTMdJ4jBtTGl1j2WnQWlyM/B1mp/4OBlZqMWwrMadpsOKaSCP
         oyVqpa1Kidp43ePfLvl43FkcmhQMvwbMMIUoPrils9VUhpbginIbx8gQ84ZD77/RWYPu
         K/hFisQCoALtXhrwc0ABptP4On+3KwXp5f+pypDyZcG0maHqklMHgT+J10SF7Hyl4dSV
         5oPVnaEfhUkFxXE9p4jOT8J2y/REWgNZrsoIkQN2GjdxclDT/yX4E7Kas0q0FzvkZlsQ
         zSkEnP5lySQQ5h8vViP3JKFYYIYnGLSAMB5PvTmOwPF6gPuS0HpXH6E9T78q6u8G1DiN
         uUGA==
X-Gm-Message-State: AOJu0YxVzOCrB7n8iTUZhasf1sChZFuJVnmHmHEVaegXSeI7m9bS81gI
        Br1Lqhor3PP34AQgxD0fERR7aTSi+F5obvSrYcA=
X-Google-Smtp-Source: AGHT+IGUVQH82U3M6N+LIrmpbwDAgOk8qDJI3k10x+RZOm4I6k7dxUmPvfPK9RmDvzM1gsHxP/20aw==
X-Received: by 2002:a05:6a00:22d0:b0:68f:d320:58bb with SMTP id f16-20020a056a0022d000b0068fd32058bbmr631169pfj.8.1694749252213;
        Thu, 14 Sep 2023 20:40:52 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id x14-20020a056a00270e00b0068fe7c4148fsm2016065pfv.57.2023.09.14.20.40.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Sep 2023 20:40:51 -0700 (PDT)
Date:   Thu, 14 Sep 2023 20:40:51 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Justin Stitt <justinstitt@google.com>
Cc:     Dan Williams <dan.j.williams@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Dave Jiang <dave.jiang@intel.com>, nvdimm@lists.linux.dev,
        linux-cxl@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org
Subject: Re: [PATCH] dax: refactor deprecated strncpy
Message-ID: <202309142040.7FCE9E230A@keescook>
References: <20230913-strncpy-drivers-dax-bus-c-v1-1-bee91f20825b@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230913-strncpy-drivers-dax-bus-c-v1-1-bee91f20825b@google.com>
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Wed, Sep 13, 2023 at 01:10:24AM +0000, Justin Stitt wrote:
> `strncpy` is deprecated for use on NUL-terminated destination strings [1].
> 
> We should prefer more robust and less ambiguous string interfaces.
> 
> `dax_id->dev_name` is expected to be NUL-terminated and has been zero-allocated.
> 
> A suitable replacement is `strscpy` [2] due to the fact that it
> guarantees NUL-termination on the destination buffer. Moreover, due to
> `dax_id` being zero-allocated the padding behavior of `strncpy` is not
> needed and a simple 1:1 replacement of strncpy -> strscpy should
> suffice.
> 
> Link: https://www.kernel.org/doc/html/latest/process/deprecated.html#strncpy-on-nul-terminated-strings [1]
> Link: https://manpages.debian.org/testing/linux-manual-4.8/strscpy.9.en.html [2]
> Link: https://github.com/KSPP/linux/issues/90
> Cc: linux-hardening@vger.kernel.org
> Signed-off-by: Justin Stitt <justinstitt@google.com>

Looks correct to me.

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
