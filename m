Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B18CCA68
	for <linux-hardening@vger.kernel.org>; Sat, 23 Sep 2023 08:27:38 +0000 (UTC)
Received: from omta38.uswest2.a.cloudfilter.net (omta38.uswest2.a.cloudfilter.net [35.89.44.37])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DCE11A8
	for <linux-hardening@vger.kernel.org>; Sat, 23 Sep 2023 01:27:36 -0700 (PDT)
Received: from eig-obgw-5003a.ext.cloudfilter.net ([10.0.29.159])
	by cmsmtp with ESMTP
	id jjIJqHLxuQFHRjxzEquQb0; Sat, 23 Sep 2023 08:27:36 +0000
Received: from gator4166.hostgator.com ([108.167.133.22])
	by cmsmtp with ESMTPS
	id jxzDqJgMwVpk9jxzEqQ6Wk; Sat, 23 Sep 2023 08:27:36 +0000
X-Authority-Analysis: v=2.4 cv=CLw54DnD c=1 sm=1 tr=0 ts=650ea178
 a=1YbLdUo/zbTtOZ3uB5T3HA==:117 a=P7XfKmiOJ4/qXqHZrN7ymg==:17
 a=OWjo9vPv0XrRhIrVQ50Ab3nP57M=:19 a=dLZJa+xiwSxG16/P+YVxDGlgEgI=:19
 a=IkcTkHD0fZMA:10 a=zNV7Rl7Rt7sA:10 a=wYkD_t78qR0A:10 a=NEAV23lmAAAA:8
 a=Br2UW1UjAAAA:8 a=P-IC7800AAAA:8 a=JfrnYn6hAAAA:8 a=cm27Pg_UAAAA:8
 a=VwQbUJbxAAAA:8 a=HvF037n1xESchLcPDVoA:9 a=QEXdDO2ut3YA:10
 a=WmXOPjafLNExVIMTj843:22 a=d3PnA9EDa4IxuAV0gXij:22 a=1CNFftbPRP8L7MoqJWF3:22
 a=xmb-EsYY8bH0VWELuYED:22 a=AjGcO6oz07-iQ99wixmX:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=embeddedor.com; s=default; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=EwHnq9I0ZYfBC9SDu/UVPRBfrk7HElWovqnm5r2GxWA=; b=YzUh/LDMRIGUk67Yuyv1IzBbaa
	6EokWx7gUQjHkRhjyAh4KuuD5VpiDenUXMHqLB64Br95oh0hEh1d0VTmzgNCu5HRSmJ8gI1wSo9ot
	dEUamL+lKMt/pk/nWXarWm0+Yni2ZmaghyoXa3N0STXx08UR14NDt3orMVnXTlqCctdm8D98Wo9TW
	gqkUadawfosqh+VG2ZnVIybcc6qrsQcAfihIqX2b51ckVKStWiIyjVW1UE+E9NpV0iG77XCxAFoqS
	H1GuiQhZ2FqmO0z9aZQOpeaL277gk/SNjS64IY2uEnw9gsIEt+gcnZz7GoFyXaBuKZlXVVFuBd7tq
	yOHxgZAw==;
Received: from [94.239.20.48] (port=50186 helo=[192.168.1.98])
	by gator4166.hostgator.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.96)
	(envelope-from <gustavo@embeddedor.com>)
	id 1qjxzC-003X6p-3B;
	Sat, 23 Sep 2023 03:27:35 -0500
Message-ID: <a93452ff-6611-d14d-37b1-09afbf0d7348@embeddedor.com>
Date: Sat, 23 Sep 2023 10:28:40 -0600
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH] i3c: master: cdns: Annotate struct cdns_i3c_xfer with
 __counted_by
Content-Language: en-US
To: Kees Cook <keescook@chromium.org>, =?UTF-8?Q?Przemys=c5=82aw_Gaj?=
 <pgaj@cadence.com>
Cc: Alexandre Belloni <alexandre.belloni@bootlin.com>,
 linux-i3c@lists.infradead.org, Nathan Chancellor <nathan@kernel.org>,
 Nick Desaulniers <ndesaulniers@google.com>, Tom Rix <trix@redhat.com>,
 linux-kernel@vger.kernel.org, llvm@lists.linux.dev,
 linux-hardening@vger.kernel.org
References: <20230922175014.work.637-kees@kernel.org>
From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
In-Reply-To: <20230922175014.work.637-kees@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4166.hostgator.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - embeddedor.com
X-BWhitelist: no
X-Source-IP: 94.239.20.48
X-Source-L: No
X-Exim-ID: 1qjxzC-003X6p-3B
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: ([192.168.1.98]) [94.239.20.48]:50186
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 56
X-Org: HG=hgshared;ORG=hostgator;
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfPm3fLqW6Jdq2u/glq6x3FUC5pbwb69RPN/4oDFMqZu00WgphkeqgKcxXRe7fxOEyJ5Hhq4NRsHtuIH0kHCzV2rBJoJhMZToZ/yFy7TqI3m3ok5yvVuL
 iRPa2b/IKWD9f0BT3CI3MsSJu5ADPEeLH53xBk86+QQwq3IZtESCt9dJs+x04wO3XlVQmEgSosSx8XE9XSaerulLFc16q1AqcuCZvK98P/dBeNMCWx4vIM4r
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,DATE_IN_FUTURE_06_12,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net



On 9/22/23 11:50, Kees Cook wrote:
> Prepare for the coming implementation by GCC and Clang of the __counted_by
> attribute. Flexible array members annotated with __counted_by can have
> their accesses bounds-checked at run-time checking via CONFIG_UBSAN_BOUNDS
> (for array indexing) and CONFIG_FORTIFY_SOURCE (for strcpy/memcpy-family
> functions).
> 
> As found with Coccinelle[1], add __counted_by for struct cdns_i3c_xfer.
> 
> [1] https://github.com/kees/kernel-tools/blob/trunk/coccinelle/examples/counted_by.cocci
> 
> Cc: "Przemysław Gaj" <pgaj@cadence.com>
> Cc: Alexandre Belloni <alexandre.belloni@bootlin.com>
> Cc: linux-i3c@lists.infradead.org
> Signed-off-by: Kees Cook <keescook@chromium.org>

Reviewed-by: Gustavo A. R. Silva <gustavoars@kernel.org>

Thanks
-- 
Gustavo

> ---
>   drivers/i3c/master/i3c-master-cdns.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/i3c/master/i3c-master-cdns.c b/drivers/i3c/master/i3c-master-cdns.c
> index 49551db71bc9..97c1010956a0 100644
> --- a/drivers/i3c/master/i3c-master-cdns.c
> +++ b/drivers/i3c/master/i3c-master-cdns.c
> @@ -387,7 +387,7 @@ struct cdns_i3c_xfer {
>   	struct completion comp;
>   	int ret;
>   	unsigned int ncmds;
> -	struct cdns_i3c_cmd cmds[];
> +	struct cdns_i3c_cmd cmds[] __counted_by(ncmds);
>   };
>   
>   struct cdns_i3c_data {
