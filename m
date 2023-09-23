Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7671ECA5C
	for <linux-hardening@vger.kernel.org>; Sat, 23 Sep 2023 08:27:29 +0000 (UTC)
Received: from omta34.uswest2.a.cloudfilter.net (omta34.uswest2.a.cloudfilter.net [35.89.44.33])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 461111A5
	for <linux-hardening@vger.kernel.org>; Sat, 23 Sep 2023 01:27:28 -0700 (PDT)
Received: from eig-obgw-5003a.ext.cloudfilter.net ([10.0.29.159])
	by cmsmtp with ESMTP
	id jjIJqfzoaOzKljxz5qHCbN; Sat, 23 Sep 2023 08:27:27 +0000
Received: from gator4166.hostgator.com ([108.167.133.22])
	by cmsmtp with ESMTPS
	id jxz5qJgCXVpk9jxz5qQ6SB; Sat, 23 Sep 2023 08:27:27 +0000
X-Authority-Analysis: v=2.4 cv=CLw54DnD c=1 sm=1 tr=0 ts=650ea16f
 a=1YbLdUo/zbTtOZ3uB5T3HA==:117 a=P7XfKmiOJ4/qXqHZrN7ymg==:17
 a=OWjo9vPv0XrRhIrVQ50Ab3nP57M=:19 a=dLZJa+xiwSxG16/P+YVxDGlgEgI=:19
 a=IkcTkHD0fZMA:10 a=zNV7Rl7Rt7sA:10 a=wYkD_t78qR0A:10 a=NEAV23lmAAAA:8
 a=KKAkSRfTAAAA:8 a=c-n4J4-pAAAA:8 a=VwQbUJbxAAAA:8 a=JfrnYn6hAAAA:8
 a=cm27Pg_UAAAA:8 a=HvF037n1xESchLcPDVoA:9 a=QEXdDO2ut3YA:10
 a=cvBusfyB2V15izCimMoJ:22 a=L0NDqeB7ZLmQzAogN4cw:22 a=AjGcO6oz07-iQ99wixmX:22
 a=1CNFftbPRP8L7MoqJWF3:22 a=xmb-EsYY8bH0VWELuYED:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=embeddedor.com; s=default; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=08UecPEuAbG0l+x/YFl55F1N++K/4bmSxvCFHQB9S5g=; b=WZJsv7aLhUeUqdRKWMwr7Z/VBe
	aw0zDu/2rwadgrRSu0C/OBrB2VFYO2VZo3Do6d2eMPb+cmHrF1NbrhQ+Ohct4/llYYmk5CpHs2EOS
	sK/fC43uSRgN3uPeTnLZdyxX32SNxvC/5BcrhuJA2ihoGDpkFVNh5P1DsTms5MLT+Ipd9M56sL8+K
	WRPYkL8Xip6fib/rJUbCmkLhW49oZcLigaZ/WqRnHVEt8PsitJcnPpLfDUyvyqlvFTdhLO/afX6bD
	5lE7D3uh0zA4l2p1hKkpxV9DA20Z+N/1Gc6j4KAaeH7Ym4rkDKSKp4KvJqCYpwbKEz1+2NLNUgMn6
	7wShJruw==;
Received: from [94.239.20.48] (port=39284 helo=[192.168.1.98])
	by gator4166.hostgator.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.96)
	(envelope-from <gustavo@embeddedor.com>)
	id 1qjxz3-003WvM-11;
	Sat, 23 Sep 2023 03:27:25 -0500
Message-ID: <49eab142-35ba-bc75-9af8-9dfed8b96f00@embeddedor.com>
Date: Sat, 23 Sep 2023 10:28:29 -0600
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH] pinctrl: uniphier: Annotate struct
 uniphier_pinctrl_reg_region with __counted_by
Content-Language: en-US
To: Kees Cook <keescook@chromium.org>,
 Linus Walleij <linus.walleij@linaro.org>
Cc: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>,
 Masami Hiramatsu <mhiramat@kernel.org>, linux-gpio@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, Nathan Chancellor <nathan@kernel.org>,
 Nick Desaulniers <ndesaulniers@google.com>, Tom Rix <trix@redhat.com>,
 linux-kernel@vger.kernel.org, llvm@lists.linux.dev,
 linux-hardening@vger.kernel.org
References: <20230922175006.work.421-kees@kernel.org>
From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
In-Reply-To: <20230922175006.work.421-kees@kernel.org>
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
X-Exim-ID: 1qjxz3-003WvM-11
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: ([192.168.1.98]) [94.239.20.48]:39284
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 44
X-Org: HG=hgshared;ORG=hostgator;
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfKLzkNG7fmyWigDS/oY1NTrsUbDJ0qUTYWiY2hGX9WNFNwwe2VH1uMQq+uWm090hhX9JPySIn+vGfuDW0N/oO0FIKkSgHNCjGeqhb2wjomYhdwUfZqMJ
 m1dYbpt8YaX75pGBT3qXOfuCcGaGClHBParGzAD41u6JSBvRwl0AtR0aaqv2qI2qqeeOcI6U8yIQQqfXbGuafGAVuZsTzkZq9+EFMOQANxztgbHx5hyewTnX
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
> As found with Coccinelle[1], add __counted_by for struct uniphier_pinctrl_reg_region.
> 
> [1] https://github.com/kees/kernel-tools/blob/trunk/coccinelle/examples/counted_by.cocci
> 
> Cc: Linus Walleij <linus.walleij@linaro.org>
> Cc: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
> Cc: Masami Hiramatsu <mhiramat@kernel.org>
> Cc: linux-gpio@vger.kernel.org
> Cc: linux-arm-kernel@lists.infradead.org
> Signed-off-by: Kees Cook <keescook@chromium.org>

Reviewed-by: Gustavo A. R. Silva <gustavoars@kernel.org>

Thanks
-- 
Gustavo

> ---
>   drivers/pinctrl/uniphier/pinctrl-uniphier-core.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/pinctrl/uniphier/pinctrl-uniphier-core.c b/drivers/pinctrl/uniphier/pinctrl-uniphier-core.c
> index 18d3a4f69e63..fbd0fcdb42c8 100644
> --- a/drivers/pinctrl/uniphier/pinctrl-uniphier-core.c
> +++ b/drivers/pinctrl/uniphier/pinctrl-uniphier-core.c
> @@ -31,7 +31,7 @@ struct uniphier_pinctrl_reg_region {
>   	struct list_head node;
>   	unsigned int base;
>   	unsigned int nregs;
> -	u32 vals[];
> +	u32 vals[] __counted_by(nregs);
>   };
>   
>   struct uniphier_pinctrl_priv {
