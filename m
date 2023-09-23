Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 952ECCA7C
	for <linux-hardening@vger.kernel.org>; Sat, 23 Sep 2023 08:28:56 +0000 (UTC)
Received: from omta38.uswest2.a.cloudfilter.net (omta38.uswest2.a.cloudfilter.net [35.89.44.37])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B3B119B
	for <linux-hardening@vger.kernel.org>; Sat, 23 Sep 2023 01:28:55 -0700 (PDT)
Received: from eig-obgw-5008a.ext.cloudfilter.net ([10.0.29.246])
	by cmsmtp with ESMTP
	id jjN2qHNNxQFHRjy0UquQpl; Sat, 23 Sep 2023 08:28:55 +0000
Received: from gator4166.hostgator.com ([108.167.133.22])
	by cmsmtp with ESMTPS
	id jy0UqaZ2O22LNjy0UqgEgu; Sat, 23 Sep 2023 08:28:54 +0000
X-Authority-Analysis: v=2.4 cv=c7O4/Dxl c=1 sm=1 tr=0 ts=650ea1c6
 a=1YbLdUo/zbTtOZ3uB5T3HA==:117 a=P7XfKmiOJ4/qXqHZrN7ymg==:17
 a=OWjo9vPv0XrRhIrVQ50Ab3nP57M=:19 a=dLZJa+xiwSxG16/P+YVxDGlgEgI=:19
 a=IkcTkHD0fZMA:10 a=zNV7Rl7Rt7sA:10 a=wYkD_t78qR0A:10 a=NEAV23lmAAAA:8
 a=pGLkceISAAAA:8 a=VwQbUJbxAAAA:8 a=cm27Pg_UAAAA:8 a=HvF037n1xESchLcPDVoA:9
 a=QEXdDO2ut3YA:10 a=AjGcO6oz07-iQ99wixmX:22 a=xmb-EsYY8bH0VWELuYED:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=embeddedor.com; s=default; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=7X3N3S0CtQ0yoaLIyLFyRALGnJXdvWUgaGNBb3LWgKo=; b=G5DD3BWb3ZIU6s65WKEzTkAN8+
	htrxNN2Vqhm+iHnjWEYUmuwLjGn8waXgz0bwWgcK/Z4cTdpwGWjCBqAEja/17q9tPZ104dnqm/9Ot
	b0EJUAyVlfdhHLL/ImHSHbf7r/HNc+ScfUIDrWF2NFc/RuriPrXmIEe78rJWCsU7xBBfwDFJV/pmv
	CKlBxKDRMETXk8EVNh5H+N3mCUWQxeWxIYRtdcozH3nwXHFHK3GS7CuGYB7+fKY0JoptNxuk3TYif
	FmKahPUv5aOIGvs60K9sMDfd7Zq9802bCKRWMC2CgOSaiNsEy69eODzdV404SDzy7PdFBx5Vddo5T
	mI1r3VSw==;
Received: from [94.239.20.48] (port=33546 helo=[192.168.1.98])
	by gator4166.hostgator.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.96)
	(envelope-from <gustavo@embeddedor.com>)
	id 1qjy0S-003XvM-2Z;
	Sat, 23 Sep 2023 03:28:53 -0500
Message-ID: <33441f01-d1a5-a6de-5e2b-364ac4ba8c31@embeddedor.com>
Date: Sat, 23 Sep 2023 10:29:52 -0600
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH] input: mt: Annotate struct input_mt with __counted_by
Content-Language: en-US
To: Kees Cook <keescook@chromium.org>,
 Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org, Nathan Chancellor <nathan@kernel.org>,
 Nick Desaulniers <ndesaulniers@google.com>, Tom Rix <trix@redhat.com>,
 linux-kernel@vger.kernel.org, llvm@lists.linux.dev,
 linux-hardening@vger.kernel.org
References: <20230922175036.work.762-kees@kernel.org>
From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
In-Reply-To: <20230922175036.work.762-kees@kernel.org>
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
X-Exim-ID: 1qjy0S-003XvM-2Z
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: ([192.168.1.98]) [94.239.20.48]:33546
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 96
X-Org: HG=hgshared;ORG=hostgator;
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfMGgV++ajrJdNvaSg8J0qI2UViJVJc9u0FNgOPwMt2pl3fM+bfHi+yqTqDVLKo2hSSM6E6lqlEZV1/mfJy87QBlz+7qxLAb22LzB4A8igcMo4g7R1GB9
 sAgm2mlj84VxSHxmsBA+XEohKuJ8xFqs3SokYh86oBmDAVC3qMmWD3ANWHYFIk3cX5PSvhGwm0U5o62mhFhzMaOuLcLl+glGmxtQMDQBNiNqkQnRwdM7KBBA
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,DATE_IN_FUTURE_06_12,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net



On 9/22/23 11:50, Kees Cook wrote:
> Prepare for the coming implementation by GCC and Clang of the __counted_by
> attribute. Flexible array members annotated with __counted_by can have
> their accesses bounds-checked at run-time checking via CONFIG_UBSAN_BOUNDS
> (for array indexing) and CONFIG_FORTIFY_SOURCE (for strcpy/memcpy-family
> functions).
> 
> As found with Coccinelle[1], add __counted_by for struct input_mt.
> 
> [1] https://github.com/kees/kernel-tools/blob/trunk/coccinelle/examples/counted_by.cocci
> 
> Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> Cc: linux-input@vger.kernel.org
> Signed-off-by: Kees Cook <keescook@chromium.org>

Reviewed-by: Gustavo A. R. Silva <gustavoars@kernel.org>

Thanks
-- 
Gustavo

> ---
>   include/linux/input/mt.h | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/include/linux/input/mt.h b/include/linux/input/mt.h
> index 3b8580bd33c1..2cf89a538b18 100644
> --- a/include/linux/input/mt.h
> +++ b/include/linux/input/mt.h
> @@ -47,7 +47,7 @@ struct input_mt {
>   	unsigned int flags;
>   	unsigned int frame;
>   	int *red;
> -	struct input_mt_slot slots[];
> +	struct input_mt_slot slots[] __counted_by(num_slots);
>   };
>   
>   static inline void input_mt_set_value(struct input_mt_slot *slot,
