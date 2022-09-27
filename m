Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A2DCC07E9D
	for <linux-hardening@archiver.kernel.org>; Tue, 27 Sep 2022 00:26:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229611AbiI0A0K (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Mon, 26 Sep 2022 20:26:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229483AbiI0A0I (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Mon, 26 Sep 2022 20:26:08 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F4B0481D5;
        Mon, 26 Sep 2022 17:26:06 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 09D246150E;
        Tue, 27 Sep 2022 00:26:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 028D1C433C1;
        Tue, 27 Sep 2022 00:26:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664238365;
        bh=FHkcN7R9GGHmGrOxMAmo1xDiazo90Bo1Ak/FokHEzxI=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=TiZ/X3kWH15nUxMpsaW2hKW6bL/xC0XOajsQzyRYQnjTVOf/D6hYva9Sdu2GJX2rS
         TOerVUZmh4CM3YoBmHhLeekv4iihXbMpS/94kmf8Vjj8QuncDt9GvJDvPIb5xtA93y
         T33wh1jbfKj90QU9RkhbHDmSnEUTa4G2Wpn5qqw+CfvjFohvJhdWiqokyOVFOiVvgh
         9hPKQjFH5YlhrERfsSL9EDUaAZAcIlzNl+/qjCtYwhejsxYKjUmUKkdOiVsMZAQdVF
         C3+5lbUw7PD6LYL3XNyFpYIKTK/1Zfiy0V3NH+4EeayKu3jaPk0lKtCz/hxvpnndTX
         31+z0XaIRb5xQ==
Date:   Mon, 26 Sep 2022 17:26:04 -0700
From:   Jakub Kicinski <kuba@kernel.org>
To:     Kees Cook <keescook@chromium.org>
Cc:     "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Subash Abhinov Kasiviswanathan <quic_subashab@quicinc.com>,
        Sean Tranchetti <quic_stranche@quicinc.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH][next] net: ethernet: rmnet: Replace zero-length array
 with DECLARE_FLEX_ARRAY() helper
Message-ID: <20220926172604.71a20b7d@kernel.org>
In-Reply-To: <202209261502.7DB9C7119@keescook>
References: <YzIei3tLO1IWtMjs@work>
        <202209261502.7DB9C7119@keescook>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Mon, 26 Sep 2022 15:02:48 -0700 Kees Cook wrote:
> On Mon, Sep 26, 2022 at 04:50:03PM -0500, Gustavo A. R. Silva wrote:
> > Zero-length arrays are deprecated and we are moving towards adopting
> > C99 flexible-array members, instead. So, replace zero-length arrays
> > declarations in anonymous union with the new DECLARE_FLEX_ARRAY()
> > helper macro.
> > 
> > This helper allows for flexible-array members in unions.
> > 
> > Link: https://github.com/KSPP/linux/issues/193
> > Link: https://github.com/KSPP/linux/issues/221
> > Link: https://gcc.gnu.org/onlinedocs/gcc/Zero-Length.html
> > Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>  
> 
> Reviewed-by: Kees Cook <keescook@chromium.org>

Not directly related to this patch, but I just had to look at pahole
output for sk_buff and the struct_group() stuff makes is really painful
to read :/ Offsets for the members are relative to the "group" and they
are all repeated.

Is there any chance you could fix that? Before we sprinkle more pixie
dust around, perhaps?
