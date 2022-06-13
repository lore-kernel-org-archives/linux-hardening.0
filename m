Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90020C43334
	for <linux-hardening@archiver.kernel.org>; Mon, 13 Jun 2022 19:06:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346301AbiFMTGo (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Mon, 13 Jun 2022 15:06:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346818AbiFMTGZ (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Mon, 13 Jun 2022 15:06:25 -0400
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com [IPv6:2607:f8b0:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24B8FBC6C4
        for <linux-hardening@vger.kernel.org>; Mon, 13 Jun 2022 09:57:25 -0700 (PDT)
Received: by mail-pg1-x531.google.com with SMTP id 129so6073711pgc.2
        for <linux-hardening@vger.kernel.org>; Mon, 13 Jun 2022 09:57:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=RijQ486Pj7q1I6Yn38ALOcEcbplPaBqHCcWTxz/xuwI=;
        b=F4cdR7lmoEVgQ5oNVOvniEhFcq0Sqs3otn0KnzTEIosNhmxwfi2m/cpXENay4DtgN9
         ckqzCU1yUcS+zzYRn43VOsUa3UurRwtwR+YZcGkcOk7VxD7lDmAWoCjGd1yypTY15JJX
         9rlp5+dbHMhjkTqjAcssQY777evhibHLI1Xzw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=RijQ486Pj7q1I6Yn38ALOcEcbplPaBqHCcWTxz/xuwI=;
        b=usOuQeQMddS6C3AXs5UmL51yYMgQ3qj2Xe/reiR2lbGt/TY7CyEBshcTQlnIeA5v4g
         /o/CUmMR2a8rFsBVbHpXitdghr3lpD4hcGpS0N3P538Yn84fbeZ4K/TiBEewhKL2ByGS
         aVA7zTQdzYoqdeDNOJuyiqVq6FddvTEWu5gj9N+haNyaFm0l80nNJyDyyGdTSHZ1mS54
         uN+SB8xsRk9MeBXyTiVVVubqJ1HZr3SKcKsHbAE5AcqPdVxJpJp0omUJry5T6crCzMK+
         CtJOEYCJuH5PPTHOv0VUM14YoAzORK7enA+AwelOFQlX7ukAiccNHjhZh2zeMDbkVzTw
         J1mw==
X-Gm-Message-State: AJIora/N/EHtZj5WgE5TzrAeqj7g8L/R/GeETbSO9jPPNMG/cH6YG4GK
        2dP89iBMVvFDIjsYOgfs3Boqhw==
X-Google-Smtp-Source: ABdhPJx7wMh/w7qZeXeEt0i3+2QliWtdYlrwdf96qW1SBleLkvmH6QXGKVBdQqF3BdDV9oCh/rFknw==
X-Received: by 2002:a62:8e11:0:b0:51c:445b:5ae6 with SMTP id k17-20020a628e11000000b0051c445b5ae6mr280560pfe.48.1655139444566;
        Mon, 13 Jun 2022 09:57:24 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id w76-20020a627b4f000000b0051bc5f4df1csm5644741pfc.154.2022.06.13.09.57.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jun 2022 09:57:24 -0700 (PDT)
Date:   Mon, 13 Jun 2022 09:57:23 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org,
        linux-hardening@vger.kernel.org, Marc Zyngier <maz@kernel.org>,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Mark Brown <broonie@kernel.org>,
        Anshuman Khandual <anshuman.khandual@arm.com>
Subject: Re: [PATCH v4 23/26] arm64: head: remap the kernel text/inittext
 region read-only
Message-ID: <202206130957.8C06460@keescook>
References: <20220613144550.3760857-1-ardb@kernel.org>
 <20220613144550.3760857-24-ardb@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220613144550.3760857-24-ardb@kernel.org>
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Mon, Jun 13, 2022 at 04:45:47PM +0200, Ard Biesheuvel wrote:
> In order to be able to run with WXN from boot (which could potentially
> be under a hypervisor regime that mandates this), update the temporary
> kernel page tables with read-only attributes for the text regions before
> attempting to execute from them.
> 
> This is rather straight-forward for 16k and 64k granule configurations,
> as the split between executable and writable regions is guaranteed to be
> aligned to the granule used for the early kernel page tables. For 4k, it
> involves installing a single table entry and populating it accordingly.
> 
> Signed-off-by: Ard Biesheuvel <ardb@kernel.org>

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
