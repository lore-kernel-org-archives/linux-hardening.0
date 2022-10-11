Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 437C7C4332F
	for <linux-hardening@archiver.kernel.org>; Tue, 11 Oct 2022 22:21:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229755AbiJKWVH (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Tue, 11 Oct 2022 18:21:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229814AbiJKWUs (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Tue, 11 Oct 2022 18:20:48 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 580463C15C
        for <linux-hardening@vger.kernel.org>; Tue, 11 Oct 2022 15:20:36 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id pq16so13694652pjb.2
        for <linux-hardening@vger.kernel.org>; Tue, 11 Oct 2022 15:20:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=CsnM9u/lLdimA3vKzzsOcLQ3M1ATdHwDz5zxOEZu19M=;
        b=irqSnR0KdOr2iWj0vUE5Q3Ie15C8FSp/JUvWisbhs4kSXQycixw5Nwl+HJvfxByVb/
         2D10Zg3J3+LtszagLUjYrp+RLp9/+yeJwwZfTofqtIh/AiQL4Sm3W6n+BdIeF0qA+t3t
         GNyaWS/ejl/Q7QnhltsT5zt5m9gtCYqFm6NYI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CsnM9u/lLdimA3vKzzsOcLQ3M1ATdHwDz5zxOEZu19M=;
        b=MYpSfQPIFqr2edmEIN9AmcLXe93bkDM7qiD/mlCmdjHB2SY9QveHyVfFrJY/AeqM7E
         erNobaFybeSMKuKY5zXiMtzu2Cl4GSDpqZUSb46qXq/Jx87/4ENS5UQP+N/Wfd1TbhN6
         FZRPPNUZ+FDs6M3K39WGij3RWacV2/QcQwB8XjLC5YbKJHpxUBNY4sQKkJJZ1lQlMEnx
         WGSuHs/0tSxFUAGQESFsXg5HTxHm0R9y9NmoSYVTpuQKQixWL4kH7U1sJ5lw0dV+fFqL
         ehr8HFmlRPu7HzcM0z3pCydoj35obOpy974Vtnlk/LdXX6/0r+pemyuIFh75UA4tijd9
         P/fw==
X-Gm-Message-State: ACrzQf3ryX44+3swVilz0lHUGeNiYhs1y7cYSS/kkidegTgR/IZCvFzT
        q5L1Rj0DWVWC5k7ivngOW8KoVw==
X-Google-Smtp-Source: AMsMyM6n8SCa79y1BKbuXkDGf8q1rDmrilNuIkKNflNqhcb0sni0xsx2n0F9KzWeVDQMHfSgaI4n3w==
X-Received: by 2002:a17:903:284:b0:178:2a94:9b6a with SMTP id j4-20020a170903028400b001782a949b6amr27023176plr.135.1665526813206;
        Tue, 11 Oct 2022 15:20:13 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id h15-20020a170902680f00b0017f7c4e260fsm9134108plk.150.2022.10.11.15.20.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Oct 2022 15:20:12 -0700 (PDT)
Date:   Tue, 11 Oct 2022 15:20:11 -0700
From:   Kees Cook <keescook@chromium.org>
To:     "Guilherme G. Piccoli" <gpiccoli@igalia.com>
Cc:     linux-hardening@vger.kernel.org,
        Anton Vorontsov <anton@enomsg.org>,
        Colin Cross <ccross@android.com>,
        Tony Luck <tony.luck@intel.com>,
        Paramjit Oberoi <pso@chromium.org>,
        Ard Biesheuvel <ardb@kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 5/5] MAINTAINERS: Update pstore maintainers
Message-ID: <202210111518.A626065@keescook>
References: <20221011200112.731334-1-keescook@chromium.org>
 <20221011200112.731334-6-keescook@chromium.org>
 <b06cdd10-3372-0613-6719-21c2fc664d05@igalia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b06cdd10-3372-0613-6719-21c2fc664d05@igalia.com>
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Tue, Oct 11, 2022 at 05:35:48PM -0300, Guilherme G. Piccoli wrote:
> On 11/10/2022 17:01, Kees Cook wrote:
> > +L:	linux-hardening@vger.kernel.org
> 
> Just curious, why linux-hardening was the picked list?

It's where the bulk of other things I work on end up living, and there's
an active patchwork instance, so it'll do patch lifetime tracking for
us:
https://patchwork.kernel.org/project/linux-hardening/list/

-- 
Kees Cook
