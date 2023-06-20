Return-Path: <linux-hardening-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52898EB64D7
	for <linux-hardening@archiver.kernel.org>; Tue, 20 Jun 2023 20:16:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229879AbjFTUQR (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Tue, 20 Jun 2023 16:16:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229973AbjFTUQO (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Tue, 20 Jun 2023 16:16:14 -0400
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC7821FC6
        for <linux-hardening@vger.kernel.org>; Tue, 20 Jun 2023 13:15:44 -0700 (PDT)
Received: by mail-pf1-x42a.google.com with SMTP id d2e1a72fcca58-666eba6f3d6so2156892b3a.3
        for <linux-hardening@vger.kernel.org>; Tue, 20 Jun 2023 13:15:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1687292117; x=1689884117;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ugg5Bn6O5nwawhDuTl20N+YQmkiNRZWUsdUMwl/ozoM=;
        b=eisvxZmVwycNuQOHor0Vhx2McMYxaUxYRyBHGhZapsWz+dARtltTBA9muZw0VNx8O5
         KI7Cnhbi7j+8/K/SRnIj9Mp9UpWH3l/vApI+5jovdL1d3YtofCxK/0h+5RAC8vKW0MWQ
         ZjgoYQS62LU+Ci7mZEGBpePdyojjDbX60jhH0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687292117; x=1689884117;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ugg5Bn6O5nwawhDuTl20N+YQmkiNRZWUsdUMwl/ozoM=;
        b=FgKurXPXXkbzCcGCY25Zq+Ih0Tw230Ocq80q/s9wZ7he15C3XJmumXbLZcqJjKInqo
         H3HKDQNmFYEKsrPF4J9YD3hyXTjeU9v75tdmjtkGuLfsubPggT/r9VTeuM3tvowuuax5
         whA8pXjpQ/mXYLnH55STuTKOqsTbmcU1HdiUm3ZHfEQmHlYPsXC0Ci+B9QpSYcmXq0ew
         8N9+c00rxQ2FG2VIfk4Gr8/XgsL0uFdU7j1rIMvfYc+x0NWGGqrDOP1dT3/azDN0ZVJZ
         /vaDgaDvGCzXCZsqgrWm+uR9i7v/hpz1uhTB1vfPJ4c26IcYtCEF63ddWnrkxedt8FMb
         8fSQ==
X-Gm-Message-State: AC+VfDyZ5LpQCZmkAvA9ZjaT0y/TPoKW2ot5qyc5nOY2KwMdqzvSynT+
        KhMCh6ef/Ri8nakzEGPgHQoYKQ==
X-Google-Smtp-Source: ACHHUZ7DHmliAxTvQVIqBr73bQmGkR82MdiWfo2PN+3zZtYfizCQt7jsEa85Fp+cEDXJ6T7X+ljRXw==
X-Received: by 2002:a05:6a20:394d:b0:122:2bc1:8855 with SMTP id r13-20020a056a20394d00b001222bc18855mr4355231pzg.10.1687292117365;
        Tue, 20 Jun 2023 13:15:17 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id g11-20020aa7818b000000b0064fd4a6b306sm1671184pfi.76.2023.06.20.13.15.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Jun 2023 13:15:16 -0700 (PDT)
Date:   Tue, 20 Jun 2023 13:15:15 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Dinh Nguyen <dinguyen@kernel.org>
Cc:     Azeem Shaikh <azeemshaikh38@gmail.com>,
        linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] nios2: Replace all non-returning strlcpy with strscpy
Message-ID: <202306201313.C425BCB@keescook>
References: <20230530162358.984149-1-azeemshaikh38@gmail.com>
 <202305301620.346CC541@keescook>
 <45ed31e0-9ecd-56ea-c0d4-3c68a3fd8cf5@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <45ed31e0-9ecd-56ea-c0d4-3c68a3fd8cf5@kernel.org>
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Tue, Jun 13, 2023 at 05:15:41PM -0500, Dinh Nguyen wrote:
> 
> 
> On 5/30/23 18:20, Kees Cook wrote:
> > On Tue, May 30, 2023 at 04:23:58PM +0000, Azeem Shaikh wrote:
> > > strlcpy() reads the entire source buffer first.
> > > This read may exceed the destination size limit.
> > > This is both inefficient and can lead to linear read
> > > overflows if a source string is not NUL-terminated [1].
> > > In an effort to remove strlcpy() completely [2], replace
> > > strlcpy() here with strscpy().
> > > No return values were used, so direct replacement is safe.
> > > 
> > > [1] https://www.kernel.org/doc/html/latest/process/deprecated.html#strlcpy
> > > [2] https://github.com/KSPP/linux/issues/89
> > > 
> > > Signed-off-by: Azeem Shaikh <azeemshaikh38@gmail.com>
> > 
> > Reviewed-by: Kees Cook <keescook@chromium.org>
> > 
> 
> Applied!

Thanks for taking this patch! I just wanted to double-check, though; I
haven't seen it show up in -next yet. Is this still queued?

Thanks!

-Kees

-- 
Kees Cook
