Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 731E61863
	for <linux-hardening@vger.kernel.org>; Tue, 24 Oct 2023 02:48:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=embeddedor.com header.i=@embeddedor.com header.b="giuEr0GK"
Received: from omta040.useast.a.cloudfilter.net (omta040.useast.a.cloudfilter.net [44.202.169.39])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC82010C9
	for <linux-hardening@vger.kernel.org>; Mon, 23 Oct 2023 19:48:05 -0700 (PDT)
Received: from eig-obgw-5004a.ext.cloudfilter.net ([10.0.29.221])
	by cmsmtp with ESMTPS
	id v6JwqmbXV6nOZv7SeqBwGI; Tue, 24 Oct 2023 02:48:04 +0000
Received: from gator4166.hostgator.com ([108.167.133.22])
	by cmsmtp with ESMTPS
	id v7SdqKNAjnippv7SdqAj5i; Tue, 24 Oct 2023 02:48:03 +0000
X-Authority-Analysis: v=2.4 cv=VpAwvs6n c=1 sm=1 tr=0 ts=65373063
 a=1YbLdUo/zbTtOZ3uB5T3HA==:117 a=WzbPXH4gqzPVN0x6HrNMNA==:17
 a=OWjo9vPv0XrRhIrVQ50Ab3nP57M=:19 a=dLZJa+xiwSxG16/P+YVxDGlgEgI=:19
 a=IkcTkHD0fZMA:10 a=bhdUkHdE2iEA:10 a=wYkD_t78qR0A:10 a=VwQbUJbxAAAA:8
 a=cm27Pg_UAAAA:8 a=bPvv9e5oV8VUxCXHTe8A:9 a=QEXdDO2ut3YA:10
 a=AjGcO6oz07-iQ99wixmX:22 a=xmb-EsYY8bH0VWELuYED:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=embeddedor.com; s=default; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=t7CKU1w7OpaYK3Ge0/xhJSHPnQiYEEShMZbsXXGJ+VQ=; b=giuEr0GKXviQ84F1K4DT8KjCBk
	JOLBlGXvyuL2n8jvzvfiG6WWNoiT3uOavQzkTuyrE02belY2H1q1dBfQQy8goumLbGznCRUWWmx54
	3rTEeTFDuuWjFvQ1VBbbmsvprjYT9YoR6VBXCCgTLiGx5IuYW3Gd6Er/pd/tfYwzLA2jOg8dMB0uA
	RwNkAgoc0HMyGKfMUUrHjNjpoc5rDggD9GAVaH2UfsRXvSaJtfw0CRo2iCWpPN8IaNarmwRTp1kf7
	i45MHoio39R7hqLmRJ8C/6gZwldh9ofq2dtBVewixPZFxEMhh1UQ3R1E4YhRa0Ic0PeJ25L8s9kwP
	7KrqgGeA==;
Received: from 187-162-21-192.static.axtel.net ([187.162.21.192]:43030 helo=[192.168.15.10])
	by gator4166.hostgator.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.96.2)
	(envelope-from <gustavo@embeddedor.com>)
	id 1qv7Sc-002x6h-0e;
	Mon, 23 Oct 2023 21:48:02 -0500
Message-ID: <21b1ebbe-2bef-4f56-a4d6-3ed898a1e953@embeddedor.com>
Date: Mon, 23 Oct 2023 20:48:00 -0600
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2][next] clk: visconti: Fix undefined behavior bug in
 struct visconti_pll_provider
Content-Language: en-US
To: Stephen Boyd <sboyd@kernel.org>,
 "Gustavo A. R. Silva" <gustavoars@kernel.org>,
 Michael Turquette <mturquette@baylibre.com>,
 Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>
Cc: Kees Cook <keescook@chromium.org>, linux-clk@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-hardening@vger.kernel.org
References: <cover.1697492890.git.gustavoars@kernel.org>
 <57a831d94ee2b3889b11525d4ad500356f89576f.1697492890.git.gustavoars@kernel.org>
 <9ebe2372491a76253e5597086d059b1d.sboyd@kernel.org>
From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
In-Reply-To: <9ebe2372491a76253e5597086d059b1d.sboyd@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4166.hostgator.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - embeddedor.com
X-BWhitelist: no
X-Source-IP: 187.162.21.192
X-Source-L: No
X-Exim-ID: 1qv7Sc-002x6h-0e
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: 187-162-21-192.static.axtel.net ([192.168.15.10]) [187.162.21.192]:43030
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 1
X-Org: HG=hgshared;ORG=hostgator;
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfC+dEZCHXrxvOj0nYL8R6Hs65XD5Q6K5hAg/2YOYAodn1QGd0h7Bic909WCW4o/Y/cCM7yxiAjZ+HlUJuCVVEvVrS+lcSAYnQiTKFh5pVdLVFwUs8zLx
 p8jwekmz7bXMMH1PGAD93tLu5ysDh9gBsws4sgcVG2XABRnvrQ7IudszI5tFmD+RLBMeKpkVgMpaH9z5FHqcrScrwmsDuXSn+CVVFdbkyP8+RxQOAfvmzDGn


>> Fixes: b4cbe606dc36 ("clk: visconti: Add support common clock driver and reset driver")
>> Cc: stable@vger.kernel.org
>> Reviewed-by: Kees Cook <keescook@chromium.org>
>> Acked-by: Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>
>> Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
>> ---
> 
> Applied to clk-next

Hi!

Here is another similar small series, in case you missed it:

https://lore.kernel.org/linux-hardening/cover.1697493574.git.gustavoars@kernel.org/

Thanks
--
Gustavo
