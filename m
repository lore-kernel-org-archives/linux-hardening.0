Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2AEDBCCA47D
	for <linux-hardening@archiver.kernel.org>; Mon, 13 Jun 2022 19:04:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346159AbiFMTES (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Mon, 13 Jun 2022 15:04:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349382AbiFMTEB (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Mon, 13 Jun 2022 15:04:01 -0400
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DAEAC1208C
        for <linux-hardening@vger.kernel.org>; Mon, 13 Jun 2022 09:52:01 -0700 (PDT)
Received: by mail-pf1-x436.google.com with SMTP id c196so6266486pfb.1
        for <linux-hardening@vger.kernel.org>; Mon, 13 Jun 2022 09:52:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=psIrdAxHCtnc6q4IJpJl9Zump1AIOtLpL4hFyqJn+tM=;
        b=J15xHtznkRebeLygk639L7OICpuQRVYHRcHJocri4mA4Nt4sNr4iarQ30xa5wK+bNy
         TI0L1GIE4tP+lw9W6OA7FH4vE69Oj2JAKKDRB71hOar/xeKUxuzFpd9LoxFYfCADpmd+
         TUiO1kRglujYxcaB+5PfE8nuUWTg9bLOIiKTc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=psIrdAxHCtnc6q4IJpJl9Zump1AIOtLpL4hFyqJn+tM=;
        b=qb4+GstnozxFUAUYEorvfAUe6lb9r2vSRQw9Cu8YTU7uFy/2WP69zNYz+Vnth0+iFS
         KpxJHwM1FTWhk+eXF8pMl2ebzgROobGHTlxZssIo1ZwSjoBfPvtn+8FT5ouLdLJViIiw
         D4fsgyL8HsQjeXnOymZI+a1ykJRH+0mIUeGaCxSN92cW7q2fMzwjPjdCk3yOGpK23hy5
         2JvqPUCy6L5s2O/XtKi1y+nC4nZYwXlvBphY0NzEl4UqX7Mooc2t3pGEYPYwalkb3emo
         ui+YtiSwvZH4GK7bYv8t0XR+jrJ94krFhCdgCZoNFTA8kVsproQbHpz/ekvqR7TfgCHO
         g5HQ==
X-Gm-Message-State: AOAM532WzOAlYDGI5EJVt7kiNy6Rw7Rkfr05ueSePSMxRiw4msFLWPY8
        HDt92BClKqdVgSQCQgHOGGPZpA==
X-Google-Smtp-Source: ABdhPJyhBoRgttc7rYISPUYA+Q/co2CGb5UirsMY5xm6BOjJAi3m92tDEutnaY/Vuc3lzAn9YHnveA==
X-Received: by 2002:a63:ff0c:0:b0:3fd:29dd:c478 with SMTP id k12-20020a63ff0c000000b003fd29ddc478mr431918pgi.291.1655139121368;
        Mon, 13 Jun 2022 09:52:01 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id fs23-20020a17090af29700b001df2f8f0a45sm5571473pjb.1.2022.06.13.09.52.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jun 2022 09:52:01 -0700 (PDT)
Date:   Mon, 13 Jun 2022 09:52:00 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org,
        linux-hardening@vger.kernel.org, Marc Zyngier <maz@kernel.org>,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Mark Brown <broonie@kernel.org>,
        Anshuman Khandual <anshuman.khandual@arm.com>
Subject: Re: [PATCH v4 26/26] arm64: kernel: move ID map out of .text mapping
Message-ID: <202206130951.57B5E48736@keescook>
References: <20220613144550.3760857-1-ardb@kernel.org>
 <20220613144550.3760857-27-ardb@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220613144550.3760857-27-ardb@kernel.org>
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Mon, Jun 13, 2022 at 04:45:50PM +0200, Ard Biesheuvel wrote:
> Reorganize the ID map slightly so that only code that is executed via
> the 1:1 mapping remains. This allows to move the ID map out of the .text
> segment, given that it no longer needs exec permissions via the kernel
> mapping.
> 
> Signed-off-by: Ard Biesheuvel <ardb@kernel.org>

This could be done earlier in the series, yes?

Regardless:

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
