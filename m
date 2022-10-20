Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4928FC4332F
	for <linux-hardening@archiver.kernel.org>; Thu, 20 Oct 2022 00:03:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230359AbiJTADA (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Wed, 19 Oct 2022 20:03:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229991AbiJTAC7 (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Wed, 19 Oct 2022 20:02:59 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 383F21849AF;
        Wed, 19 Oct 2022 17:02:58 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B0DC3614FF;
        Thu, 20 Oct 2022 00:02:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AEB58C433C1;
        Thu, 20 Oct 2022 00:02:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666224177;
        bh=3WZ2iI3JSbdiGO82F48z0PDTc+IlkDy5f/eVwcmZMvg=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=rVAY6P0PKE+JcxO0iwyQ7EYx9XO94ILyBpExQpbWIXKIsUsSkHo9V3vGwtDUZ1im8
         ZbkPzxuFt7mc2IA+RtRdQQ6IQAbImY0qAJMdFpI9L94cHMtz1dt1WMxHHWGH4hX1eB
         1HXbbB/UrPxqb2SOiK7OOIJ6lKXzfojVzlxZgLWhpKo2XLdwsCqYhlNrujWKFxIizQ
         Z0AVhPwOqz2JdpdrRfL/EcywCcO+0rwOndx9n50Nnutfk2KdGhV55REBziuzixLfCg
         5W/CS/LiQSacNxrzfmq1FNlhWFYcPhNnijM/b0KkZ9DEkYyje5hK8JH3B+wn0AjV9F
         qk6Z2ilM1M2ug==
Date:   Wed, 19 Oct 2022 17:02:55 -0700
From:   Jakub Kicinski <kuba@kernel.org>
To:     Kees Cook <keescook@chromium.org>
Cc:     Rasesh Mody <rmody@marvell.com>, GR-Linux-NIC-Dev@marvell.com,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH] bnx2: Pass allocation size to build_skb()
Message-ID: <20221019170255.100f41c7@kernel.org>
In-Reply-To: <20221018085911.never.761-kees@kernel.org>
References: <20221018085911.never.761-kees@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Tue, 18 Oct 2022 01:59:29 -0700 Kees Cook wrote:
> In preparation for requiring that build_skb() have a non-zero size
> argument, pass the actual data allocation size explicitly into
> build_skb().

build_skb(, 0) has the special meaning of "head buf has been kmalloc'd",
rather than alloc_page(). Was this changed and I missed it?
