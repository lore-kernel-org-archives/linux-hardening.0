Return-Path: <linux-hardening-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C0CCC001E0
	for <linux-hardening@archiver.kernel.org>; Wed,  2 Aug 2023 15:27:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233906AbjHBP1R (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Wed, 2 Aug 2023 11:27:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234964AbjHBP1A (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Wed, 2 Aug 2023 11:27:00 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F2E34EF5;
        Wed,  2 Aug 2023 08:24:37 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0779561A1E;
        Wed,  2 Aug 2023 15:24:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6CC64C433C7;
        Wed,  2 Aug 2023 15:24:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690989870;
        bh=AsAwCL7YysIyiApwU0DEZ4rat1nzt2aX13d1nS4nuDM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=bjlME2upSvXRAf/m/cuZiwmo5VnVspD8x1KGckoVYQHKmQplffbUWB1H7uK4qoUbt
         PK8ca8wW+aNrIfdVEofOBhya1CiO7YkGKnDgOYBX8Y/96WuTNBDXaCdKIVoneZ4neu
         4ET1Zs5R64PtWXwfAcZNi/3Xcuwrd8WrG6SGevC3Zrz40MzstmH8cJLFfny/MreVL/
         6r2Vn0UxD1V2B89tmD8j7KnRXqaf/u34yVV8tTxPgCTeQKo6xSeB4QngdPUZt8tsxy
         pbStjBW31lQFPs2Pi74aEJTB+8r0w9LYtn80AZx14nr2St7H1sjMHpiIHUBOBMyhZ4
         Aib0mqDq/8UwQ==
Date:   Wed, 2 Aug 2023 17:24:25 +0200
From:   Simon Horman <horms@kernel.org>
To:     "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc:     Jesse Brandeburg <jesse.brandeburg@intel.com>,
        Tony Nguyen <anthony.l.nguyen@intel.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
        intel-wired-lan@lists.osuosl.org, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org
Subject: Re: [PATCH 4/4][next] i40e: Replace one-element array with
 flex-array member in struct i40e_profile_aq_section
Message-ID: <ZMp1KUZIEli6WL0H@kernel.org>
References: <cover.1690938732.git.gustavoars@kernel.org>
 <8b945fa3afeb26b954c400c5b880c0ae175091ac.1690938732.git.gustavoars@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8b945fa3afeb26b954c400c5b880c0ae175091ac.1690938732.git.gustavoars@kernel.org>
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Tue, Aug 01, 2023 at 11:07:06PM -0600, Gustavo A. R. Silva wrote:
> One-element and zero-length arrays are deprecated. So, replace
> one-element array in struct i40e_profile_aq_section with
> flexible-array member.
> 
> This results in no differences in binary output.
> 
> Link: https://github.com/KSPP/linux/issues/335
> Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>

Reviewed-by: Simon Horman <horms@kernel.org>

