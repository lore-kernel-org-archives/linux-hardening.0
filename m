Return-Path: <linux-hardening-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14E48C4708E
	for <linux-hardening@archiver.kernel.org>; Thu,  5 Jan 2023 23:34:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235950AbjAEXev (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Thu, 5 Jan 2023 18:34:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235726AbjAEXer (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Thu, 5 Jan 2023 18:34:47 -0500
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5EC9A72D0C
        for <linux-hardening@vger.kernel.org>; Thu,  5 Jan 2023 15:34:44 -0800 (PST)
Received: by mail-pj1-x1034.google.com with SMTP id n65-20020a17090a2cc700b0021bc5ef7a14so107536pjd.0
        for <linux-hardening@vger.kernel.org>; Thu, 05 Jan 2023 15:34:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=MA5FpAoor/X9X4ZcIOIcH0RLPWb1EdHduuT3aSWvngo=;
        b=i07iiD7SHvOYpThWCInIqJK0jGhisZlLdZbgsCn0g5/TgXf11QG7WBr7+QRd14Vgfa
         TGZSVOxENfl9EHSe+RgoTwS3lTVxoxOuEC5tNmF/riDp7GsJm5wCAxlfqnr8kbxUWli5
         VLGhmH7jZpeaN5DYUjp0anPMnPWEYP4DxZzmw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MA5FpAoor/X9X4ZcIOIcH0RLPWb1EdHduuT3aSWvngo=;
        b=UKJfjfYJd3IWlb/cUGjLc5atpuaH5CkN2/zGxtCVuSVn49YbEheMscdEB+QhDcksFG
         DEo2R9ph40wJx0DhH1HdlLra11pKs1WCvwAB+J7lYXod+nwtvZQpPfEoNiWF52NZyJLD
         4R+OYjyFBpyuSWATQX8Vz6BgKhKyJC+yhiPRKC6W45+smVhSFhQGAtlxzZ0IZ1VaFarS
         7mDeEjpYzjJRi/IXUCOTCbfO5VcaAJGpq2KjY42UAzOM8ZD58xqCCsvUMWE0JZNSwVjt
         4NQ1xofBTsG8LlhLpZNd2H3e+lN9uPax0gvB8gLuXQk92CWyRASAnmmAR0RH0Sy9E2Ta
         h5Dg==
X-Gm-Message-State: AFqh2kpm/JcfdPTg4a6zzVl5X35BXAaZcSPo1lIcC3J584gsv2KWvbJJ
        jmBqBvovjNnzXl/N8YL/CCpPGg==
X-Google-Smtp-Source: AMrXdXsLpWlWqOEF+eN4NMnfrxYYqZ2EM5TLt8TAFqfbhUq/UQouWDTLf0ANVSWUWm1Z1WB6NIsMbQ==
X-Received: by 2002:a17:902:aa8f:b0:189:e55d:ec72 with SMTP id d15-20020a170902aa8f00b00189e55dec72mr51873694plr.20.1672961683913;
        Thu, 05 Jan 2023 15:34:43 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id f15-20020a170902ab8f00b001769206a766sm26314836plr.307.2023.01.05.15.34.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Jan 2023 15:34:43 -0800 (PST)
Date:   Thu, 5 Jan 2023 15:34:42 -0800
From:   Kees Cook <keescook@chromium.org>
To:     Jakub Kicinski <kuba@kernel.org>
Cc:     "David S. Miller" <davem@davemloft.net>,
        Andrew Lunn <andrew@lunn.ch>,
        kernel test robot <lkp@intel.com>,
        Oleksij Rempel <linux@rempel-privat.de>,
        Sean Anderson <sean.anderson@seco.com>,
        Alexandru Tachici <alexandru.tachici@analog.com>,
        Amit Cohen <amcohen@nvidia.com>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Vincent Mailhol <mailhol.vincent@wanadoo.fr>,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH] ethtool: Replace 0-length array with flexible array
Message-ID: <202301051534.D850BE8734@keescook>
References: <20230105214126.never.757-kees@kernel.org>
 <20230105152731.44d4cbfb@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230105152731.44d4cbfb@kernel.org>
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Thu, Jan 05, 2023 at 03:27:31PM -0800, Jakub Kicinski wrote:
> On Thu,  5 Jan 2023 13:41:34 -0800 Kees Cook wrote:
> > Zero-length arrays are deprecated[1]. Replace struct ethtool_rxnfc's
> > "rule_locs" 0-length array with a flexible array. Detected with GCC 13,
> > using -fstrict-flex-arrays=3:
> 
> You gotta CC netdev to get it into patchwork etc.

Oops, thanks. I'm not sure how that went missing. v2 sent.

-- 
Kees Cook
