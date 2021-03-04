Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-21.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34F16C433E0
	for <linux-hardening@archiver.kernel.org>; Thu,  4 Mar 2021 22:54:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F163564FF3
	for <linux-hardening@archiver.kernel.org>; Thu,  4 Mar 2021 22:54:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230511AbhCDWyL (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Thu, 4 Mar 2021 17:54:11 -0500
Received: from mail.kernel.org ([198.145.29.99]:39256 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229505AbhCDWyK (ORCPT <rfc822;linux-hardening@vger.kernel.org>);
        Thu, 4 Mar 2021 17:54:10 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 1D67064FE9;
        Thu,  4 Mar 2021 22:54:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1614898450;
        bh=8OPfb+m2YP/MAo5C+K44izWc8zCgLju6+B4AERoiGWo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=tIWOH1Cpa2YpsdO/GiYv55SJrS6px30ZxTAUH534kwV7OhKMeEuaKYwEnY0iQAbrW
         o/LJYq8uwJ7jhnbIbOmfi76UTOHpadowtWRPFeCxdkBGWuY7Ta9/gw5+8dvh4Vb0eD
         REqXSLsK1qd7jHnkQEZ+CMtralsP7P4zgJ0ZGh5mNkkjULPFAyvHZRmynOq8+O/IAX
         BNCP9LdZNyWKnkDc/6f2bdAs0xkXqcrPGtNls+OqeoDQud6m3g1JV/+Eds3fKtszS9
         9BSBsBNdKE6xBYZfSYsU7fDyYd/4VwfwMAf4su7EE8EzqzuL/761GnbNZZO/JjN7A7
         I7AKZIDwin2rA==
Date:   Thu, 4 Mar 2021 16:54:08 -0600
From:   "Gustavo A. R. Silva" <gustavoars@kernel.org>
To:     "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>
Cc:     linux-decnet-user@lists.sourceforge.net, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH 076/141] decnet: Fix fall-through warnings for Clang
Message-ID: <20210304225408.GD105908@embeddedor>
References: <cover.1605896059.git.gustavoars@kernel.org>
 <c0b4dfadf61968028e9265fca33d537817e0771c.1605896059.git.gustavoars@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c0b4dfadf61968028e9265fca33d537817e0771c.1605896059.git.gustavoars@kernel.org>
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

Hi all,

It's been more than 3 months; who can take this, please? :)

Thanks
--
Gustavo

On Fri, Nov 20, 2020 at 12:35:01PM -0600, Gustavo A. R. Silva wrote:
> In preparation to enable -Wimplicit-fallthrough for Clang, fix a warning
> by explicitly adding a break statement instead of letting the code fall
> through to the next case.
> 
> Link: https://github.com/KSPP/linux/issues/115
> Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
> ---
>  net/decnet/dn_route.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/net/decnet/dn_route.c b/net/decnet/dn_route.c
> index 4cac31d22a50..2f3e5c49a221 100644
> --- a/net/decnet/dn_route.c
> +++ b/net/decnet/dn_route.c
> @@ -1407,7 +1407,7 @@ static int dn_route_input_slow(struct sk_buff *skb)
>  			flags |= RTCF_DOREDIRECT;
>  
>  		local_src = DN_FIB_RES_PREFSRC(res);
> -
> +		break;
>  	case RTN_BLACKHOLE:
>  	case RTN_UNREACHABLE:
>  		break;
> -- 
> 2.27.0
> 
