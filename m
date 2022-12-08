Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6839C4332F
	for <linux-hardening@archiver.kernel.org>; Thu,  8 Dec 2022 16:30:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230205AbiLHQak (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Thu, 8 Dec 2022 11:30:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230206AbiLHQaa (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Thu, 8 Dec 2022 11:30:30 -0500
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1600470B91
        for <linux-hardening@vger.kernel.org>; Thu,  8 Dec 2022 08:30:30 -0800 (PST)
Received: by mail-pj1-x1033.google.com with SMTP id hd14-20020a17090b458e00b0021909875bccso6099573pjb.1
        for <linux-hardening@vger.kernel.org>; Thu, 08 Dec 2022 08:30:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=k4tmfXAitcgkSlUsd80rpXrMdUZPjLhK1NcCQ+49+g8=;
        b=IfAhwPlyRtM85i8rguQOmP7CnTCezl5zNw1zvLw2K9t/3snzqJ13XzN33EuGXVmdL7
         kuGJCxBQ0DAIKjAwY35ZND7i0UIklkDsfJ1LCwZaoQB3sJw5qQRG9YGF/gn42W4DMLem
         DkKozVqyjHBsuR1CAhF3Xu981CEhsvXZWHGPQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=k4tmfXAitcgkSlUsd80rpXrMdUZPjLhK1NcCQ+49+g8=;
        b=VlVFMEKYLTiovEdH3KZXHxR1cocWaxSHBGx4AFBirnknSskxt5a68AAqazoJiB5nB6
         yO4Qc9rPu3jiR2B92KO1mTIEvvr8JI8imZR/daOZzWamZw5G9oi1DJg3PumKRGp1G7st
         +DUUFC3aLZRFlMLKzE9L5hw5j3UGn2crd4u8b11LCtvNxmImV9qrGkNPJPvGKEdPrAmo
         FYU2j/vFveQKTnUcCj9pTioHveQEdRrpvwYR6Jd6nE2eOF9P4f+YZrKLZ+75Idht3LvI
         uyNyMUsJ3ysC87V6cwDF4brpTIXs6C6eMLo8MJOutiH5R1BKPmESd6Qe4a/PgOCqL0aw
         xWZA==
X-Gm-Message-State: ANoB5pn9jyzoEaO989ZZPOSRdG3V7QdMc5LiF+HyQ9ip5zlVu2bGs/wi
        9P7EtNbZnh6XZs1cbPcrjSL0bm7l9phniolH
X-Google-Smtp-Source: AA0mqf57k6PyE3EokGT1H+zjRGQDn0VQYsc/0IIGVvGFWMnZS6uaAnbVF+b/XI2sHwbsUpcdDciiPQ==
X-Received: by 2002:a17:902:a505:b0:189:e149:a1a6 with SMTP id s5-20020a170902a50500b00189e149a1a6mr14708502plq.58.1670517029595;
        Thu, 08 Dec 2022 08:30:29 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id h15-20020a170902680f00b00186cd4a8aedsm16697608plk.252.2022.12.08.08.30.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Dec 2022 08:30:29 -0800 (PST)
Date:   Thu, 8 Dec 2022 08:30:28 -0800
From:   Kees Cook <keescook@chromium.org>
To:     jeffxu@chromium.org
Cc:     skhan@linuxfoundation.org, akpm@linux-foundation.org,
        dmitry.torokhov@gmail.com, dverkamp@chromium.org, hughd@google.com,
        jeffxu@google.com, jorgelo@chromium.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-mm@kvack.org, jannh@google.com,
        linux-hardening@vger.kernel.org
Subject: Re: [PATCH v6 5/6] selftests/memfd: add tests for MFD_NOEXEC_SEAL
 MFD_EXEC
Message-ID: <202212080830.EB9070F758@keescook>
References: <20221207154939.2532830-1-jeffxu@google.com>
 <20221207154939.2532830-6-jeffxu@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221207154939.2532830-6-jeffxu@google.com>
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Wed, Dec 07, 2022 at 03:49:38PM +0000, jeffxu@chromium.org wrote:
> From: Jeff Xu <jeffxu@google.com>
> 
> Tests to verify MFD_NOEXEC, MFD_EXEC and vm.memfd_noexec sysctl.
> 
> Co-developed-by: Daniel Verkamp <dverkamp@chromium.org>
> Signed-off-by: Daniel Verkamp <dverkamp@chromium.org>

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
