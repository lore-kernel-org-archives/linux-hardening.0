Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F217C433F5
	for <linux-hardening@archiver.kernel.org>; Thu, 21 Oct 2021 17:05:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1F97A61037
	for <linux-hardening@archiver.kernel.org>; Thu, 21 Oct 2021 17:05:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232263AbhJURH5 (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Thu, 21 Oct 2021 13:07:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232229AbhJURHo (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Thu, 21 Oct 2021 13:07:44 -0400
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95F05C0613B9
        for <linux-hardening@vger.kernel.org>; Thu, 21 Oct 2021 10:05:26 -0700 (PDT)
Received: by mail-pf1-x436.google.com with SMTP id x66so1167318pfx.13
        for <linux-hardening@vger.kernel.org>; Thu, 21 Oct 2021 10:05:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=7rSlILWSLtNm1l/dt0JGZldq939/2rynRrUJ8zKeXI0=;
        b=Na/vDPjgNlUzBFN4GMNIo3Shs5X6jSidKQISyssc1oT1WZZKdpKmy7O6AP6kNzB37C
         MRItv1idJFk6vxcNVM8YVNM/Lrnh/CmkC0RRngCO/jWtB9rY/j3tN+VEJE9qooifV0QA
         EOu3swvOtOuEojO2uvMd06RceQRYd4JwoosKE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=7rSlILWSLtNm1l/dt0JGZldq939/2rynRrUJ8zKeXI0=;
        b=cd4XIuyzGPQX2daVN6c4UbbByMiGly/JXhP3P6atmo0x6Ctr3UXTTiooiiBOaqQDI7
         hf8Q5fddp+KBX8CNpEWj83PNTI2iWznqQfR85+KqWP6byyvvzpamHTeElUj4zWX4h7Ws
         RGN+pqc4i42R3J0XlRPjbSn6a1aKy/hE81wGmiMqJGWtT02PBVMzg39Pp9JnNhx7/2G+
         602FBVu/FnEcBdR6Usv+cbHdF9VIhDqnjEnQ/vZuFD7+vkNOFkZT0bhr2l0fcXcdJJIl
         /RxWAhRp1+gmpBeX3dZtK5E4A4BTjt5auwRhwFYmwgVr2CteYx7TCJXI4eJWMHxBvwKL
         p3ew==
X-Gm-Message-State: AOAM531OrnCN1YBU+CsvacPIU9zq9K65FAUVDDJG6MLbcgKtg/S/Nkz0
        mQeLh86esq4AwAhCec7rAsb4Mw==
X-Google-Smtp-Source: ABdhPJxmNKBuSkVoniTw8LzyJ+Fy1Bl7BtYgxDGsoPz2D7Gsganf5l6nVApI7jU/y9OwrwP8onE3/Q==
X-Received: by 2002:a62:61c3:0:b0:44d:2518:cdf1 with SMTP id v186-20020a6261c3000000b0044d2518cdf1mr6805487pfb.31.1634835926105;
        Thu, 21 Oct 2021 10:05:26 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id oa4sm7004169pjb.13.2021.10.21.10.05.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Oct 2021 10:05:25 -0700 (PDT)
Date:   Thu, 21 Oct 2021 10:05:25 -0700
From:   Kees Cook <keescook@chromium.org>
To:     "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc:     Jesse Brandeburg <jesse.brandeburg@intel.com>,
        Tony Nguyen <anthony.l.nguyen@intel.com>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH][next] ice: use devm_kcalloc() instead of devm_kzalloc()
Message-ID: <202110211004.6CF2B2C5D@keescook>
References: <20211006180908.GA913430@embeddedor>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211006180908.GA913430@embeddedor>
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Wed, Oct 06, 2021 at 01:09:08PM -0500, Gustavo A. R. Silva wrote:
> Use 2-factor multiplication argument form devm_kcalloc() instead
> of devm_kzalloc().
> 
> Link: https://github.com/KSPP/linux/issues/162
> Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>

Reviewed-by: Kees Cook <keescook@chromium.org>

Similar patch state here, it seems? Who needs to Ack this?
https://patchwork.kernel.org/project/netdevbpf/patch/20211006180908.GA913430@embeddedor/

Thanks!

-- 
Kees Cook
