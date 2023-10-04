Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 430751B29D
	for <linux-hardening@vger.kernel.org>; Wed,  4 Oct 2023 19:45:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=embeddedor.com header.i=@embeddedor.com header.b="Kap34x0o"
Received: from omta038.useast.a.cloudfilter.net (omta038.useast.a.cloudfilter.net [44.202.169.37])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 875D5BF
	for <linux-hardening@vger.kernel.org>; Wed,  4 Oct 2023 12:45:09 -0700 (PDT)
Received: from eig-obgw-6005a.ext.cloudfilter.net ([10.0.30.201])
	by cmsmtp with ESMTP
	id o2RuqPVQOqBU3o7nwqBWu3; Wed, 04 Oct 2023 19:45:08 +0000
Received: from gator4166.hostgator.com ([108.167.133.22])
	by cmsmtp with ESMTPS
	id o7nvqJkZWGi8jo7nvqq5hH; Wed, 04 Oct 2023 19:45:07 +0000
X-Authority-Analysis: v=2.4 cv=Asn9YcxP c=1 sm=1 tr=0 ts=651dc0c3
 a=1YbLdUo/zbTtOZ3uB5T3HA==:117 a=Dx1Zrv+1i3YEdDUMOX3koA==:17
 a=OWjo9vPv0XrRhIrVQ50Ab3nP57M=:19 a=dLZJa+xiwSxG16/P+YVxDGlgEgI=:19
 a=IkcTkHD0fZMA:10 a=bhdUkHdE2iEA:10 a=wYkD_t78qR0A:10 a=VwQbUJbxAAAA:8
 a=1XWaLZrsAAAA:8 a=cm27Pg_UAAAA:8 a=gDw6DpxkxgdD51dURPUA:9 a=QEXdDO2ut3YA:10
 a=AjGcO6oz07-iQ99wixmX:22 a=xmb-EsYY8bH0VWELuYED:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=embeddedor.com; s=default; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=anYsrMBVpJk91YyTJNycNRtxZORGmKUYN5KZZKzlb0o=; b=Kap34x0o9igNLIQhVI90uQhneJ
	Sg2O9YfHoeuLC0SvUZQXEvWFfs9iHUnHa5+fvByNoJHS4Ncu9dcLwfcApr+JTi/ddpBQDrk9JKsmD
	X9YpSAIEh5SEtRWMFHM3ZPcUKem1aBFs3oJzJp/gc8mR4tt6vfscGpIEwdSk6lsHv+0NJUg0PxVR9
	Yw6xiLHzNBQoKUXpYPEv/cE84AyizKwtceGiyTqXd6f6oZs/7zuJfwSYqAbVp0CzkS7pTtsBylR5z
	7A/PZhbkPClxffo3ASexlioRZECxa9S0NZv+Jcv6LHtwMdIZehxKt75mQoIauDbbkyD1diOJkPygj
	VJ6kt+7w==;
Received: from 94-238-9-39.abo.bbox.fr ([94.238.9.39]:53198 helo=[192.168.1.98])
	by gator4166.hostgator.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.96.1)
	(envelope-from <gustavo@embeddedor.com>)
	id 1qo7nv-002Qsv-0B;
	Wed, 04 Oct 2023 14:45:07 -0500
Message-ID: <0cae6f7e-845f-f76b-1594-46df17cf20be@embeddedor.com>
Date: Wed, 4 Oct 2023 21:45:03 +0200
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH] MAINTAINERS: Include additional ASoC paths
Content-Language: en-US
To: Kees Cook <keescook@chromium.org>, Mark Brown <broonie@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
References: <20231004193441.work.109-kees@kernel.org>
From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
In-Reply-To: <20231004193441.work.109-kees@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4166.hostgator.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - embeddedor.com
X-BWhitelist: no
X-Source-IP: 94.238.9.39
X-Source-L: No
X-Exim-ID: 1qo7nv-002Qsv-0B
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: 94-238-9-39.abo.bbox.fr ([192.168.1.98]) [94.238.9.39]:53198
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 1
X-Org: HG=hgshared;ORG=hostgator;
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfMsebNMvwxkr9LM7gHFOA/Z7Dzqdfae5pNVuAnIyoP8daeWJ7eX7EH5fH8c5DJOMG4MGRHqusTGEjTaGBGBAiz17iHm/tisvyX+bmbuEuk+v7NNvg9a0
 P4OgasQiQeBEOzNPFS8vFikdDImq8qMEprpNfUAyXn/QZh26wz18fUenNHlFRGieHKGl9InAVj7xzJUW2QS2PIxyFPBWSxpwHXoasm7b6KeOPUu6bxz/WCrr
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net



On 10/4/23 21:34, Kees Cook wrote:
> Make sure a few other paths are correctly sent to the ASoC maintainers.
> 
> Link: https://lore.kernel.org/lkml/63dd3676.170a0220.1f1b2.3244@mx.google.com/
> Cc: Mark Brown <broonie@kernel.org>
> Signed-off-by: Kees Cook <keescook@chromium.org>

Acked-by: Gustavo A. R. Silva <gustavoars@kernel.org>

Thanks!
--
Gustavo

> ---
>   MAINTAINERS | 2 ++
>   1 file changed, 2 insertions(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 5f18ed0fbd42..585a13b9b52a 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -20116,6 +20116,8 @@ F:	Documentation/devicetree/bindings/sound/
>   F:	Documentation/sound/soc/
>   F:	include/dt-bindings/sound/
>   F:	include/sound/soc*
> +F:	include/sound/sof/
> +F:	include/uapi/sound/asoc.h
>   F:	sound/soc/
>   
>   SOUND - SOUND OPEN FIRMWARE (SOF) DRIVERS
