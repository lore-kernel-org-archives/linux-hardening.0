Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABF2B208BC
	for <linux-hardening@vger.kernel.org>; Sat, 23 Sep 2023 23:01:45 +0000 (UTC)
Received: from omta40.uswest2.a.cloudfilter.net (omta40.uswest2.a.cloudfilter.net [35.89.44.39])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 802A9193
	for <linux-hardening@vger.kernel.org>; Sat, 23 Sep 2023 16:01:44 -0700 (PDT)
Received: from eig-obgw-6009a.ext.cloudfilter.net ([10.0.30.184])
	by cmsmtp with ESMTP
	id k7QgqKgMKbK1VkBdAqnMu3; Sat, 23 Sep 2023 23:01:44 +0000
Received: from gator4166.hostgator.com ([108.167.133.22])
	by cmsmtp with ESMTPS
	id kBd9qAt0GTFO2kBdAqhQtJ; Sat, 23 Sep 2023 23:01:44 +0000
X-Authority-Analysis: v=2.4 cv=A8l/goaG c=1 sm=1 tr=0 ts=650f6e58
 a=1YbLdUo/zbTtOZ3uB5T3HA==:117 a=P7XfKmiOJ4/qXqHZrN7ymg==:17
 a=OWjo9vPv0XrRhIrVQ50Ab3nP57M=:19 a=dLZJa+xiwSxG16/P+YVxDGlgEgI=:19
 a=IkcTkHD0fZMA:10 a=zNV7Rl7Rt7sA:10 a=wYkD_t78qR0A:10 a=NEAV23lmAAAA:8
 a=VwQbUJbxAAAA:8 a=KKAkSRfTAAAA:8 a=1XWaLZrsAAAA:8 a=20KFwNOVAAAA:8
 a=cm27Pg_UAAAA:8 a=gq5M5jF_6ledRb6gi8cA:9 a=QEXdDO2ut3YA:10
 a=AjGcO6oz07-iQ99wixmX:22 a=cvBusfyB2V15izCimMoJ:22 a=xmb-EsYY8bH0VWELuYED:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=embeddedor.com; s=default; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=6XNtLAcX2bV1r7Mr2It1UMDwR628Me8xKbndakP8KgI=; b=uBY6xRQtco0mzzUXHn9nXYx97E
	c0Q51HeQzHlCZ8miRyd5908r9WG70hE+sCHSQIm97VSqStyFa7FWz17WxUIct4tcvVB+iyF2JKb6q
	AyTvnQnAOt5QYmoJl+rP7c57gH8m5S+DQfJbLEb/2P+xyWU8BYVBAo61LHdzrCxUzco3NmeroL+Db
	IUTt6CSjOTu4bcaTykAOwA+z/5kZ3a2Tcr7Ds3NPMKBSNW3HND5jh+kCFMQv5fjazME3nCj8fRtI5
	/JhbZORtQ+Qp9mfHvc6bFBIvi/4X7pltqXxuASQsBzYpSwQnZ1v8RACWX+tBno/pN3deRfKajRzub
	2POZ8HSw==;
Received: from [94.239.20.48] (port=46368 helo=[192.168.1.98])
	by gator4166.hostgator.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.96)
	(envelope-from <gustavo@embeddedor.com>)
	id 1qjy8b-003iId-1n;
	Sat, 23 Sep 2023 03:37:17 -0500
Message-ID: <1c7ca4d2-e411-07d6-d4d2-eb6e00e47e9d@embeddedor.com>
Date: Sat, 23 Sep 2023 10:38:22 -0600
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH] soc: qcom: smem: Annotate struct qcom_smem with
 __counted_by
Content-Language: en-US
To: Kees Cook <keescook@chromium.org>, Andy Gross <agross@kernel.org>
Cc: Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konrad.dybcio@linaro.org>,
 Nathan Chancellor <nathan@kernel.org>,
 Nick Desaulniers <ndesaulniers@google.com>, Tom Rix <trix@redhat.com>,
 linux-arm-msm@vger.kernel.org, llvm@lists.linux.dev,
 linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
References: <20230922175413.work.929-kees@kernel.org>
From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
In-Reply-To: <20230922175413.work.929-kees@kernel.org>
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
X-Exim-ID: 1qjy8b-003iId-1n
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: ([192.168.1.98]) [94.239.20.48]:46368
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 0
X-Org: HG=hgshared;ORG=hostgator;
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfB2CvtsA3nC5FarN2tgi5H81WIUusgyuTiRjEnLuwcXlvFWy9LJXVQ4K3A+o6mxyE2NACDhEeLpps/eDgfF0O80bCwjU12EqjBeFgaEKXBYAY809wKUa
 lAa85qhYYru/NgK/EFiJP6q62+dPl1xw2IYWySjOgHA0avkXRT3vB6nYUw+EVsyXzj/vWsyTOl7hb59uy4aMWi+TLgFnPvO30uTs+VvqoW0kRYAhhTUhyWOb
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DATE_IN_PAST_06_12,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net



On 9/22/23 11:54, Kees Cook wrote:
> Prepare for the coming implementation by GCC and Clang of the __counted_by
> attribute. Flexible array members annotated with __counted_by can have
> their accesses bounds-checked at run-time checking via CONFIG_UBSAN_BOUNDS
> (for array indexing) and CONFIG_FORTIFY_SOURCE (for strcpy/memcpy-family
> functions).
> 
> As found with Coccinelle[1], add __counted_by for struct qcom_smem.
> 
> [1] https://github.com/kees/kernel-tools/blob/trunk/coccinelle/examples/counted_by.cocci
> 
> Cc: Andy Gross <agross@kernel.org>
> Cc: Bjorn Andersson <andersson@kernel.org>
> Cc: Konrad Dybcio <konrad.dybcio@linaro.org>
> Cc: Nathan Chancellor <nathan@kernel.org>
> Cc: Nick Desaulniers <ndesaulniers@google.com>
> Cc: Tom Rix <trix@redhat.com>
> Cc: linux-arm-msm@vger.kernel.org
> Cc: llvm@lists.linux.dev
> Signed-off-by: Kees Cook <keescook@chromium.org>

Reviewed-by: Gustavo A. R. Silva <gustavoars@kernel.org>

Thanks
-- 
Gustavo

> ---
>   drivers/soc/qcom/smem.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/soc/qcom/smem.c b/drivers/soc/qcom/smem.c
> index d4a89d2bb43b..4ce9cf1477ac 100644
> --- a/drivers/soc/qcom/smem.c
> +++ b/drivers/soc/qcom/smem.c
> @@ -285,7 +285,7 @@ struct qcom_smem {
>   	struct smem_partition partitions[SMEM_HOST_COUNT];
>   
>   	unsigned num_regions;
> -	struct smem_region regions[];
> +	struct smem_region regions[] __counted_by(num_regions);
>   };
>   
>   static void *
