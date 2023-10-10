Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80406315B3
	for <linux-hardening@vger.kernel.org>; Tue, 10 Oct 2023 23:24:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=embeddedor.com header.i=@embeddedor.com header.b="utjopGZ7"
Received: from omta40.uswest2.a.cloudfilter.net (omta40.uswest2.a.cloudfilter.net [35.89.44.39])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6401C93
	for <linux-hardening@vger.kernel.org>; Tue, 10 Oct 2023 16:24:35 -0700 (PDT)
Received: from eig-obgw-6008a.ext.cloudfilter.net ([10.0.30.227])
	by cmsmtp with ESMTP
	id qJuFqlcBaQUgRqM5Zqw1jm; Tue, 10 Oct 2023 23:24:33 +0000
Received: from gator4166.hostgator.com ([108.167.133.22])
	by cmsmtp with ESMTPS
	id qM5YqdAg0CZgIqM5ZqPpNs; Tue, 10 Oct 2023 23:24:33 +0000
X-Authority-Analysis: v=2.4 cv=fLMqYLWe c=1 sm=1 tr=0 ts=6525dd31
 a=1YbLdUo/zbTtOZ3uB5T3HA==:117 a=WzbPXH4gqzPVN0x6HrNMNA==:17
 a=OWjo9vPv0XrRhIrVQ50Ab3nP57M=:19 a=dLZJa+xiwSxG16/P+YVxDGlgEgI=:19
 a=IkcTkHD0fZMA:10 a=bhdUkHdE2iEA:10 a=wYkD_t78qR0A:10 a=cm27Pg_UAAAA:8
 a=G-lt6N7Yx29dGf9IkNAA:9 a=QEXdDO2ut3YA:10 a=t_Z6pCN3e-wA:10
 a=xmb-EsYY8bH0VWELuYED:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=embeddedor.com; s=default; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=sYBsanTMELU9eC2s0PIPTCW6urGWz8biLYZfCgY3QAM=; b=utjopGZ7CaIL1u6/a/GzwVrjg2
	DNDLoVvXCP9CmpaETVFerGq4v6W/BBP57Jq0gUco7gI30b24KOy9nbw4iiT3SfG2F/mvSh/r1FoVD
	OWEyoYJZ3eGY0QyFpwdmDSkKWKyJQMkGGCfJSAgEjjkMtlYN+tgOyQipb9ed778NWRKs80AvfDPQ/
	ozPlUPwp/XE+ISXPoCGUD/DDhGH//GNPh+5MLVl41t53LxBWN+tvVN3LjxJlXod3wgmjOKBRusP87
	ZHLDdOagkWPK4mDea/9ZLXObhhSb/1q7e6opW40AmzkpnXmHINLXQgU+NZKwJJ2JDrS3PTR50/Ngy
	0YiiFq3A==;
Received: from 187-162-21-192.static.axtel.net ([187.162.21.192]:48998 helo=[192.168.15.7])
	by gator4166.hostgator.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.96.1)
	(envelope-from <gustavo@embeddedor.com>)
	id 1qqM5Y-003zTy-0x;
	Tue, 10 Oct 2023 18:24:32 -0500
Message-ID: <a3336eae-a24d-48c8-9c91-e9c989ec89db@embeddedor.com>
Date: Tue, 10 Oct 2023 17:24:30 -0600
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH][next] hostap: Add __counted_by for struct
 prism2_download_data and use struct_size()
Content-Language: en-US
To: Kees Cook <keescook@chromium.org>,
 "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc: Kalle Valo <kvalo@kernel.org>, linux-wireless@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
References: <ZSRXXvWMMkm7qqRW@work> <202310101549.E09DE6F@keescook>
From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
In-Reply-To: <202310101549.E09DE6F@keescook>
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
X-Exim-ID: 1qqM5Y-003zTy-0x
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: 187-162-21-192.static.axtel.net ([192.168.15.7]) [187.162.21.192]:48998
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 1
X-Org: HG=hgshared;ORG=hostgator;
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfAZhfRIJisfl6K1dnBUytWit2biz8wS+ABmij/e1LCxYRe6UuoTqjxaUWtL0pVSnhcFTdpyutxq4qHe9s6yMENWHqEa5O8VWRvkCkB2DSlL6ITHLWcef
 vG9OvsO8ToOn/uAtJgL5PWK5TWp9pqOQYQo70L1rabJ7t8ir3wIm5o61NMO0eZ2HC8heSRNMY84hNkD72OOmQ4ob287FDcLiy7JKqxkBVBwlnVfFbZpoakaD
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
	RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net


> I realize I didn't actually send my R-b for this thread, so here it is:
> 
> Reviewed-by: Kees Cook <keescook@chromium.org>
> 
> :)
> 

Thanks! :)

--
Gustavo
