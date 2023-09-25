Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EC6E21370
	for <linux-hardening@vger.kernel.org>; Mon, 25 Sep 2023 17:53:55 +0000 (UTC)
Received: from omta34.uswest2.a.cloudfilter.net (omta34.uswest2.a.cloudfilter.net [35.89.44.33])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F0D1101
	for <linux-hardening@vger.kernel.org>; Mon, 25 Sep 2023 10:53:53 -0700 (PDT)
Received: from eig-obgw-5009a.ext.cloudfilter.net ([10.0.29.176])
	by cmsmtp with ESMTP
	id klxPqpj1WOzKlkpmLqWZ9h; Mon, 25 Sep 2023 17:53:53 +0000
Received: from gator4166.hostgator.com ([108.167.133.22])
	by cmsmtp with ESMTPS
	id kpmKqUhOA8nIokpmKq8gxY; Mon, 25 Sep 2023 17:53:52 +0000
X-Authority-Analysis: v=2.4 cv=MJhzJeVl c=1 sm=1 tr=0 ts=6511c930
 a=1YbLdUo/zbTtOZ3uB5T3HA==:117 a=P7XfKmiOJ4/qXqHZrN7ymg==:17
 a=OWjo9vPv0XrRhIrVQ50Ab3nP57M=:19 a=dLZJa+xiwSxG16/P+YVxDGlgEgI=:19
 a=IkcTkHD0fZMA:10 a=zNV7Rl7Rt7sA:10 a=wYkD_t78qR0A:10 a=VwQbUJbxAAAA:8
 a=cm27Pg_UAAAA:8 a=flhsevb5WwY81NH91GIA:9 a=QEXdDO2ut3YA:10
 a=AjGcO6oz07-iQ99wixmX:22 a=xmb-EsYY8bH0VWELuYED:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=embeddedor.com; s=default; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=1zcEsoNj3mB2OHfdsQCdZfxm3Cdux+jaF05ciaeFNag=; b=xj4SoYvYx/DcUI6XxP8Xxqj4HX
	K+Z1liYGbPbwhkqURB+JeFyGTnlEZ/cb4XR75EP26R6jjjrRg9W30IDA663A6+Pkgr5Mj16omknKW
	TesNXV2+GvH8iQ6DhkhWqz8XrGaqIVrcUWr0RlwoAFTtzh12U13BXSmVK+wIvLwXLF+vlUIOFcjbc
	JwugV0PJAyQ6Ph+MipujkVJfJQP8ES8fXq23Dw7Zu0wNozxfa++SwhGqAY9J7pvSIsdssa2vqR5LP
	Ts8M2im7RQPWzYtpMFz5yS249xmNvsZJUSxvvPYfbwiSOzW/Cn3W6KYT9F5wOhdTw1kKuj0NK+Ufu
	qQlly8uA==;
Received: from [94.239.20.48] (port=46178 helo=[192.168.1.98])
	by gator4166.hostgator.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.96)
	(envelope-from <gustavo@embeddedor.com>)
	id 1qkpmJ-0013zT-1r;
	Mon, 25 Sep 2023 12:53:51 -0500
Message-ID: <a8ac2f9d-764a-d3d0-0a6a-ada626e0a2da@embeddedor.com>
Date: Mon, 25 Sep 2023 19:53:49 +0200
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH] MAINTAINERS: hardening: Add Gustavo as Reviewer
Content-Language: en-US
To: Kees Cook <keescook@chromium.org>,
 "Gustavo A . R . Silva" <gustavoars@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
References: <20230925173211.work.448-kees@kernel.org>
From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
In-Reply-To: <20230925173211.work.448-kees@kernel.org>
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
X-Exim-ID: 1qkpmJ-0013zT-1r
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: ([192.168.1.98]) [94.239.20.48]:46178
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 2
X-Org: HG=hgshared;ORG=hostgator;
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfJ5Zgu2KzDKF3kSEQ/t7OPs2yeorsQBz2LW81IDqMIi5K0KF5mFDa+shZ73gC+9Sog3PCr8VkISep2Hrm4bjSXFm5NQL7N+jlC5gWWLfYjiS2lBhjHY/
 nfJG5aI5JqNzSLbEe3KyMIueIHHAgHy2E3bL1Y2e5eWfyEbbtgR5K2JidLQseUiaQN/qmv19xKXl4CoCLcil8qEkI1JYkLFb5kXgDiAW4GfHK0T5u5bW8yXW
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net



On 9/25/23 11:32, Kees Cook wrote:
> It's an oversight to not have already listed Gustavo here. Add him as a
> Reviewer.
> 
> Cc: Gustavo A. R. Silva <gustavoars@kernel.org>
> Signed-off-by: Kees Cook <keescook@chromium.org>

Accepted-by: Gustavo A. R. Silva <gustavoars@kernel.org> ;P

--
Gustavo

> ---
>   MAINTAINERS | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 741285b8246e..5f18ed0fbd42 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -11393,6 +11393,7 @@ F:	usr/
>   
>   KERNEL HARDENING (not covered by other areas)
>   M:	Kees Cook <keescook@chromium.org>
> +R:	Gustavo A. R. Silva <gustavoars@kernel.org>
>   L:	linux-hardening@vger.kernel.org
>   S:	Supported
>   T:	git git://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git for-next/hardening
