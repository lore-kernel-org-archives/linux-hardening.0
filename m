Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6924E62F
	for <linux-hardening@vger.kernel.org>; Thu, 12 Oct 2023 01:22:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=embeddedor.com header.i=@embeddedor.com header.b="voqti2ph"
Received: from omta038.useast.a.cloudfilter.net (omta038.useast.a.cloudfilter.net [44.202.169.37])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AEC1F98
	for <linux-hardening@vger.kernel.org>; Wed, 11 Oct 2023 18:22:48 -0700 (PDT)
Received: from eig-obgw-5003a.ext.cloudfilter.net ([10.0.29.159])
	by cmsmtp with ESMTP
	id qj7Tq2OmxqBU3qkPXqAR4r; Thu, 12 Oct 2023 01:22:47 +0000
Received: from gator4166.hostgator.com ([108.167.133.22])
	by cmsmtp with ESMTPS
	id qkPWqjn9m1WadqkPXqSox1; Thu, 12 Oct 2023 01:22:47 +0000
X-Authority-Analysis: v=2.4 cv=HfkH8wI8 c=1 sm=1 tr=0 ts=65274a67
 a=1YbLdUo/zbTtOZ3uB5T3HA==:117 a=WzbPXH4gqzPVN0x6HrNMNA==:17
 a=OWjo9vPv0XrRhIrVQ50Ab3nP57M=:19 a=dLZJa+xiwSxG16/P+YVxDGlgEgI=:19
 a=IkcTkHD0fZMA:10 a=bhdUkHdE2iEA:10 a=wYkD_t78qR0A:10 a=VwQbUJbxAAAA:8
 a=cm27Pg_UAAAA:8 a=mGr3e_0Gbe7lDU3fz68A:9 a=QEXdDO2ut3YA:10 a=jV56Vji_GFUA:10
 a=AjGcO6oz07-iQ99wixmX:22 a=xmb-EsYY8bH0VWELuYED:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=embeddedor.com; s=default; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=d6OvVPeBTsOJjUr7F9qF5Dit3itsHTv3Ro6bkvwY6sY=; b=voqti2phSibUEn844PvdHGZaMt
	E5P1aCedm15ujhCxFowQJ3tgX3+DzMHmzzX/DASaFVg0bh15/DIRtGvLRflAiDBGGMUvelJx81HWe
	rMl5jWW8jlW6aINDg4kDPfJzesF0QVkeArRcEnc7ZLdhLHIbgvyCHcLIinzSFieMve6CcOmOLaxvA
	mK6HGwjACunlB7X2qmAF9RfsUBomiW/Tjmn5/Az0nf1gn75IZj1gWQaFqWa4eyInRsUjxIJvi8ldS
	1AcqAKmeY3wY6JuuqXlfYHz57nMpjQhK4yGiywPvMmLikIw84dJ5nrfGX6uivEnAnhPeXfQNPEsEr
	lih393rw==;
Received: from 187-162-21-192.static.axtel.net ([187.162.21.192]:37884 helo=[192.168.15.7])
	by gator4166.hostgator.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.96.1)
	(envelope-from <gustavo@embeddedor.com>)
	id 1qqkPW-003PfN-18;
	Wed, 11 Oct 2023 20:22:46 -0500
Message-ID: <4eae9ce0-177b-4c47-8116-fe1fcf3d9d0f@embeddedor.com>
Date: Wed, 11 Oct 2023 19:22:45 -0600
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2][next] clk: socfpga: Fix undefined behavior bug in
 struct stratix10_clock_data
Content-Language: en-US
To: Kees Cook <keescook@chromium.org>,
 "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc: Dinh Nguyen <dinguyen@kernel.org>,
 Michael Turquette <mturquette@baylibre.com>, Stephen Boyd
 <sboyd@kernel.org>, linux-kernel@vger.kernel.org,
 linux-hardening@vger.kernel.org
References: <cover.1697059539.git.gustavoars@kernel.org>
 <5dd8483177dc8cd91d021170b6717f2e570bab03.1697059539.git.gustavoars@kernel.org>
 <202310111438.2D0168C@keescook>
From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
In-Reply-To: <202310111438.2D0168C@keescook>
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
X-Exim-ID: 1qqkPW-003PfN-18
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: 187-162-21-192.static.axtel.net ([192.168.15.7]) [187.162.21.192]:37884
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 8
X-Org: HG=hgshared;ORG=hostgator;
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfK7Iavt1O9VGE71w/8o8VEbRm7f77vCtkq6i9kT4h6MFNluw7aami4Kv3dbbF6c0c8ACNC0HxDCkstSOW2tr8lsdOrg3dOn8dBMmGC0cRHjuG+kYbD0w
 KGbclrn+NT14oKPAmQ4LFI09KHkLyoKiIjcfVcRDLCPdl3lqS68NlKZ00zzeSvOzRTCBP+9aXhpCq3T5jJB1dUTcoLU6j26g6S8dGUNbXPdvd/d3k1YuDV/9
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net


>> Fixes: ba7e258425ac ("clk: socfpga: Convert to s10/agilex/n5x to use clk_hw")
>> Cc: stable@vger.kernel.org
>> Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
> 
> Nice find!

:D

> 
> Reviewed-by: Kees Cook <keescook@chromium.org>
> 

Thanks!
--
Gustavo
