Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-20.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12081C433B4
	for <linux-hardening@archiver.kernel.org>; Tue, 20 Apr 2021 20:32:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B82AA613C0
	for <linux-hardening@archiver.kernel.org>; Tue, 20 Apr 2021 20:32:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233619AbhDTUcu (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Tue, 20 Apr 2021 16:32:50 -0400
Received: from gateway30.websitewelcome.com ([192.185.184.48]:16659 "EHLO
        gateway30.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233548AbhDTUct (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Tue, 20 Apr 2021 16:32:49 -0400
Received: from cm11.websitewelcome.com (cm11.websitewelcome.com [100.42.49.5])
        by gateway30.websitewelcome.com (Postfix) with ESMTP id 73D92C073
        for <linux-hardening@vger.kernel.org>; Tue, 20 Apr 2021 15:10:48 -0500 (CDT)
Received: from gator4166.hostgator.com ([108.167.133.22])
        by cmsmtp with SMTP
        id YwhsllftPPkftYwhslzWzf; Tue, 20 Apr 2021 15:10:48 -0500
X-Authority-Reason: nr=8
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=embeddedor.com; s=default; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=CkRrAR3rCpK4uliJ7LJ71iNQodpgSH1kYlP/RKhfhGo=; b=Ueb+udY2kyoTD5pHw4Y8wqYIni
        nIQy8U6Ne3ALQYgfy/x0h1iEGgKxTEWlmbOT/CI/7GCpn6hu14Wa0b+PoORM7ZKHKKggosQA+Ip9l
        CcmjjD4Wp+ApERE6f8OCqMO5l/xH92PHIlJReKlxuC+TL06N/NOvLkkOoVVV/4KIslHMQhAgFUI0j
        taGG9CVVtPFUlvBTNxstk+vwd3dEcbymBOM0ye//KqaG0NHaY/JrVYYi6inJJMadKIFkqfUelRjs3
        mkHzi4B1oT9bPCPX2CzNlq3seQW0Xo1CtEzEya8CQuieGZxSrRpUAphnfejKyT5oOuOSBp+7GH7Ie
        qG+8DPuw==;
Received: from 187-162-31-110.static.axtel.net ([187.162.31.110]:48952 helo=[192.168.15.8])
        by gator4166.hostgator.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.94)
        (envelope-from <gustavo@embeddedor.com>)
        id 1lYwho-002gkB-S1; Tue, 20 Apr 2021 15:10:44 -0500
Subject: Re: [PATCH RESEND][next] net: netrom: Fix fall-through warnings for
 Clang
To:     "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>
Cc:     linux-hams@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
References: <20210305092210.GA139864@embeddedor>
From:   "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Message-ID: <5047001a-e5a8-ec64-0dc7-662e7cb0d100@embeddedor.com>
Date:   Tue, 20 Apr 2021 15:11:00 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <20210305092210.GA139864@embeddedor>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4166.hostgator.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - embeddedor.com
X-BWhitelist: no
X-Source-IP: 187.162.31.110
X-Source-L: No
X-Exim-ID: 1lYwho-002gkB-S1
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: 187-162-31-110.static.axtel.net ([192.168.15.8]) [187.162.31.110]:48952
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 68
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

Hi all,

Friendly ping: who can take this, please?

Thanks
--
Gustavo

On 3/5/21 03:22, Gustavo A. R. Silva wrote:
> In preparation to enable -Wimplicit-fallthrough for Clang, fix multiple
> warnings by explicitly adding multiple break statements instead of
> letting the code fall through to the next case.
> 
> Link: https://github.com/KSPP/linux/issues/115
> Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
> ---
>  net/netrom/nr_route.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/net/netrom/nr_route.c b/net/netrom/nr_route.c
> index 78da5eab252a..de9821b6a62a 100644
> --- a/net/netrom/nr_route.c
> +++ b/net/netrom/nr_route.c
> @@ -266,6 +266,7 @@ static int __must_check nr_add_node(ax25_address *nr, const char *mnemonic,
>  		fallthrough;
>  	case 2:
>  		re_sort_routes(nr_node, 0, 1);
> +		break;
>  	case 1:
>  		break;
>  	}
> @@ -359,6 +360,7 @@ static int nr_del_node(ax25_address *callsign, ax25_address *neighbour, struct n
>  					fallthrough;
>  				case 1:
>  					nr_node->routes[1] = nr_node->routes[2];
> +					break;
>  				case 2:
>  					break;
>  				}
> @@ -482,6 +484,7 @@ static int nr_dec_obs(void)
>  					fallthrough;
>  				case 1:
>  					s->routes[1] = s->routes[2];
> +					break;
>  				case 2:
>  					break;
>  				}
> @@ -529,6 +532,7 @@ void nr_rt_device_down(struct net_device *dev)
>  							fallthrough;
>  						case 1:
>  							t->routes[1] = t->routes[2];
> +							break;
>  						case 2:
>  							break;
>  						}
> 
