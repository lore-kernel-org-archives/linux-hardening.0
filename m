Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 652CF2596
	for <linux-hardening@vger.kernel.org>; Sun,  1 Oct 2023 06:46:11 +0000 (UTC)
Received: from omta36.uswest2.a.cloudfilter.net (omta36.uswest2.a.cloudfilter.net [35.89.44.35])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5790BE
	for <linux-hardening@vger.kernel.org>; Sat, 30 Sep 2023 23:46:08 -0700 (PDT)
Received: from eig-obgw-6010a.ext.cloudfilter.net ([10.0.30.248])
	by cmsmtp with ESMTP
	id mm65qIHlCMZBkmqDQq6Smf; Sun, 01 Oct 2023 06:46:08 +0000
Received: from gator4166.hostgator.com ([108.167.133.22])
	by cmsmtp with ESMTPS
	id mqDPqAN3cPoqfmqDQqusqo; Sun, 01 Oct 2023 06:46:08 +0000
X-Authority-Analysis: v=2.4 cv=BbLLb5h2 c=1 sm=1 tr=0 ts=651915b0
 a=1YbLdUo/zbTtOZ3uB5T3HA==:117 a=P7XfKmiOJ4/qXqHZrN7ymg==:17
 a=OWjo9vPv0XrRhIrVQ50Ab3nP57M=:19 a=dLZJa+xiwSxG16/P+YVxDGlgEgI=:19
 a=IkcTkHD0fZMA:10 a=bhdUkHdE2iEA:10 a=wYkD_t78qR0A:10 a=NEAV23lmAAAA:8
 a=VwQbUJbxAAAA:8 a=1XWaLZrsAAAA:8 a=20KFwNOVAAAA:8 a=cm27Pg_UAAAA:8
 a=0yL73Cyy68KADmUz8mEA:9 a=QEXdDO2ut3YA:10 a=AjGcO6oz07-iQ99wixmX:22
 a=xmb-EsYY8bH0VWELuYED:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=embeddedor.com; s=default; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=D+KDSp0rnEI8tJ5BHsZfNQN2UopqEOST//9+ZQu1af8=; b=o7SZuscvfL2sr94uoquVxZ8K9g
	DQrXk3nUTEWgrGwYg1UKulAhTSSP+cvoRamvTiDCODlU0dUeHsAJTRXlWn70QKWJYiPvOI2pKJ7Wx
	p+MpAt92V/Ik4n2FiEwlrABAREi0eSqRzQC+FUvyFN12NH2TjeRrsTdyuHhff2LoS8pScoHmeYLh6
	aORhOZ4fvlAAqkHKX50e1vzo0JpraT19jzPW9hgdq5xUbOxXm85IBJ0jMkRLrsi5NQQUT5kyZCaZI
	4a2HQLFjEOv4NnwJS84ynAlttawQb+HDDuqNJ8kOkcDLnUBlzvH1GiLs6YjzRUwFcrPh8cagkWddR
	//thnBIA==;
Received: from [94.239.20.48] (port=55984 helo=[192.168.1.98])
	by gator4166.hostgator.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.96)
	(envelope-from <gustavo@embeddedor.com>)
	id 1qmqDO-001QWo-37;
	Sun, 01 Oct 2023 01:46:07 -0500
Message-ID: <6e09d483-810c-dcae-36f9-b0ac8ae04fc4@embeddedor.com>
Date: Sun, 1 Oct 2023 08:46:03 +0200
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH] dmaengine: ep93xx_dma: Annotate struct ep93xx_dma_engine
 with __counted_by
Content-Language: en-US
To: Kees Cook <keescook@chromium.org>, Vinod Koul <vkoul@kernel.org>
Cc: Nathan Chancellor <nathan@kernel.org>,
 Nick Desaulniers <ndesaulniers@google.com>, Tom Rix <trix@redhat.com>,
 dmaengine@vger.kernel.org, llvm@lists.linux.dev,
 "Gustavo A. R. Silva" <gustavoars@kernel.org>, linux-kernel@vger.kernel.org,
 linux-hardening@vger.kernel.org
References: <20230928234334.work.391-kees@kernel.org>
From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
In-Reply-To: <20230928234334.work.391-kees@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4166.hostgator.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - embeddedor.com
X-BWhitelist: no
X-Source-IP: 94.239.20.48
X-Source-L: No
X-Exim-ID: 1qmqDO-001QWo-37
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: ([192.168.1.98]) [94.239.20.48]:55984
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 83
X-Org: HG=hgshared;ORG=hostgator;
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfLwre4bA11DXz182odM6Yy1ZWr17fb5a/L06Y58aV6okgzkVZrJXgeTcqPOA0Ea4vr1hOC5n9iNE3fB//aMmt2HR4d3Cbz45dDWxIbMdA8cJycGkIP8D
 74VoLUmSheu23z0BkbDIv3fG7XKT81ilA/D9uicgrmiZWzNyTYKWwQg+SsQpFkNu6BKpBFq0YyiOd0x1XAtkM+4f72MM6oOMH1yUL5g0AGbhWGKxo12qZBgK
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net



On 9/29/23 01:43, Kees Cook wrote:
> Prepare for the coming implementation by GCC and Clang of the __counted_by
> attribute. Flexible array members annotated with __counted_by can have
> their accesses bounds-checked at run-time via CONFIG_UBSAN_BOUNDS (for
> array indexing) and CONFIG_FORTIFY_SOURCE (for strcpy/memcpy-family
> functions).
> 
> As found with Coccinelle[1], add __counted_by for struct ep93xx_dma_engine.
> 
> [1] https://github.com/kees/kernel-tools/blob/trunk/coccinelle/examples/counted_by.cocci
> 
> Cc: Vinod Koul <vkoul@kernel.org>
> Cc: Nathan Chancellor <nathan@kernel.org>
> Cc: Nick Desaulniers <ndesaulniers@google.com>
> Cc: Tom Rix <trix@redhat.com>
> Cc: dmaengine@vger.kernel.org
> Cc: llvm@lists.linux.dev
> Signed-off-by: Kees Cook <keescook@chromium.org>

Reviewed-by: Gustavo A. R. Silva <gustavoars@kernel.org>

Thanks
-- 
Gustavo

> ---
>   drivers/dma/ep93xx_dma.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/dma/ep93xx_dma.c b/drivers/dma/ep93xx_dma.c
> index 5c4a448a1254..d6c60635e90d 100644
> --- a/drivers/dma/ep93xx_dma.c
> +++ b/drivers/dma/ep93xx_dma.c
> @@ -213,7 +213,7 @@ struct ep93xx_dma_engine {
>   #define INTERRUPT_NEXT_BUFFER	2
>   
>   	size_t			num_channels;
> -	struct ep93xx_dma_chan	channels[];
> +	struct ep93xx_dma_chan	channels[] __counted_by(num_channels);
>   };
>   
>   static inline struct device *chan2dev(struct ep93xx_dma_chan *edmac)
