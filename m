Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56202C433F5
	for <linux-hardening@archiver.kernel.org>; Wed, 16 Feb 2022 20:36:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232329AbiBPUhA (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Wed, 16 Feb 2022 15:37:00 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:57944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229823AbiBPUhA (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Wed, 16 Feb 2022 15:37:00 -0500
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB09D18D014
        for <linux-hardening@vger.kernel.org>; Wed, 16 Feb 2022 12:36:47 -0800 (PST)
Received: by mail-pl1-x631.google.com with SMTP id w20so2874463plq.12
        for <linux-hardening@vger.kernel.org>; Wed, 16 Feb 2022 12:36:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=PEXMMTYC1FVGPA5+aOj0q5CSmQ9v9RUX9ecJLilAcPc=;
        b=bGWQFfWY+GOCY9ajK+jUK4dJTPTv2kIB0Yq1hbme80ItJPDtVUuCrducyub/97EQ0a
         GThVGEfbIU6o1qenCjxJXD50S6/ObQWidSyhO1XjNEw7iQRU3mYiOLPWLzMEtydU+TOg
         XrEVvwY9SVG0TkiKWWRS2pgrzzhEh02Lo8/FM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=PEXMMTYC1FVGPA5+aOj0q5CSmQ9v9RUX9ecJLilAcPc=;
        b=7P6H5+hipiDRAz3K457leahDLhb9i/p0G5LzStjSnKbDWIo0J6wSX7jqEV0jkQRbL6
         hrR7tr/Ooz4dIjFwGth+HLlyNRi/NfMC8kocrNx3pB5Pchspbesyu4Na5+fZGB1d0p1t
         XX2GGk/T8m0EZwP1MzNpeoi8Lg2r4NrBIohXm7V7GldhHtFwiQEUEGLjCdrhh2H5ZdMe
         ALRfwqvirgJcTaOzoiXzkh6cLnTEKXWC1qqgoaj51I5srKf23XeDxEwkI5KE5c/t4+LZ
         PW6/z1ZXu53S9E7uPIdcWXAV7TJ0HXV4YeJa9Nk3TkMFkYvTjCjgFTjQrB/3N0CE1RCE
         UGcQ==
X-Gm-Message-State: AOAM532UBVT8wsZHx59PJUE1PbfYhoDmlnMeBrgEp5fnEKlfK0tNTl8v
        LOErpz4otyFjxFPU2GE+obddUw==
X-Google-Smtp-Source: ABdhPJzJF/YEfH5OONFh8EpYA13PwFuw+6/qJPkCze+i5HDTetsTW9VKrS9AD6KT8uYwRyvr45KVbw==
X-Received: by 2002:a17:90b:2496:b0:1b9:a6dd:ae7 with SMTP id nt22-20020a17090b249600b001b9a6dd0ae7mr3717687pjb.35.1645043807401;
        Wed, 16 Feb 2022 12:36:47 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id lw3sm18168488pjb.24.2022.02.16.12.36.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Feb 2022 12:36:47 -0800 (PST)
Date:   Wed, 16 Feb 2022 12:36:46 -0800
From:   Kees Cook <keescook@chromium.org>
To:     "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc:     Robert Moore <robert.moore@intel.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org,
        devel@acpica.org, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org
Subject: Re: [PATCH][next] ACPICA: iASL: Replace zero-length array with
 flexible-array member
Message-ID: <202202161236.FBD5D268@keescook>
References: <20220216203240.GA918517@embeddedor>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220216203240.GA918517@embeddedor>
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Wed, Feb 16, 2022 at 02:32:40PM -0600, Gustavo A. R. Silva wrote:
> There is a regular need in the kernel to provide a way to declare
> having a dynamically sized set of trailing elements in a structure.
> Kernel code should always use “flexible array members”[1] for these
> cases. The older style of one-element or zero-length arrays should
> no longer be used[2].
> 
> [1] https://en.wikipedia.org/wiki/Flexible_array_member
> [2] https://www.kernel.org/doc/html/v5.16/process/deprecated.html#zero-length-and-one-element-arrays
> 
> Link: https://github.com/KSPP/linux/issues/78
> Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
