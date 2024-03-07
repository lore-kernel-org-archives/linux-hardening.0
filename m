Received: from omta34.uswest2.a.cloudfilter.net (omta34.uswest2.a.cloudfilter.net [35.89.44.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5CD41391
	for <linux-hardening@vger.kernel.org>; Thu,  7 Mar 2024 00:41:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=35.89.44.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709772066; cv=none; b=M0CGKhbyvHaG2apekMhXcokZQfWwk/wDDoGeNuSrcFdlK/c/y29iRRhpVzwk/9h6RdMOIT25MGFCUE+E2G+FEEPWiKTLKVZEs1o/VJaVgkd9IycEunRpnG8Z0a7zoyeXMULXsJIUADCLGJXsqMTiKCN/tkbSZcbue1x7oNE0bqQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709772066; c=relaxed/simple;
	bh=EbCRrC7D836n3/gfVrkt21cUTLd++USvTDfHPhMW0+w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mqEeM/5ygYsiWHdIP82NBU3oljkEhhf3aeqed0PjPcQHmm0g50+h/N7UyMsbP11DQ7BRhM1rEcKB8qFyvoCFgMkknQGFKym7eq3iwKjkW2FpSxIc52Uti5XuUe/zEPrI62CHuz3yktZflHe+hvgBBeATcT9qiHLZpfdeAhEF4Pw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=embeddedor.com; spf=pass smtp.mailfrom=embeddedor.com; dkim=pass (2048-bit key) header.d=embeddedor.com header.i=@embeddedor.com header.b=KU46e9cx; arc=none smtp.client-ip=35.89.44.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=embeddedor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=embeddedor.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=embeddedor.com header.i=@embeddedor.com header.b="KU46e9cx"
Received: from eig-obgw-6004a.ext.cloudfilter.net ([10.0.30.197])
	by cmsmtp with ESMTPS
	id i0vernSmIHXmAi1omrWIXs; Thu, 07 Mar 2024 00:41:04 +0000
Received: from gator4166.hostgator.com ([108.167.133.22])
	by cmsmtp with ESMTPS
	id i1olr6yfaJ8Qmi1olrVrmw; Thu, 07 Mar 2024 00:41:04 +0000
X-Authority-Analysis: v=2.4 cv=KNZcDkFo c=1 sm=1 tr=0 ts=65e90d20
 a=1YbLdUo/zbTtOZ3uB5T3HA==:117 a=VhncohosazJxI00KdYJ/5A==:17
 a=IkcTkHD0fZMA:10 a=K6JAEmCyrfEA:10 a=wYkD_t78qR0A:10 a=cm27Pg_UAAAA:8
 a=VwQbUJbxAAAA:8 a=vznqr7mipjY0YkA7v-cA:9 a=QEXdDO2ut3YA:10
 a=xmb-EsYY8bH0VWELuYED:22 a=AjGcO6oz07-iQ99wixmX:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=embeddedor.com; s=default; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=5BVrUIvBfOEk6nFXkFrEkJGrcbLKTx3N+QLOz2Ii6fA=; b=KU46e9cxXRHxCpm2jlbl/bYAGv
	3QO4r2zEV4/MVLI/+DgJSKHhOuGD6putlxEfPmr3mE+S72URrEbonRTC5l4C6arewij3hE0bDSYcr
	4fICckYkdF4Q+Kpk01lNNNSvoot+pNWMwiY5D1Pqv6N0imQAeYgbUXUkAgIBrjW62oGjouS4oAF2h
	MrWsRiT5oqzyi9wsKutmBFsyQ1V3eBHiFWbqi3qcfloky9O81heGE8bRHZG6b+9PuNTJMCHOuMDa/
	qre1mj//RwuYb4dnyBSx4HOBF03/5MkX4uimbVSS+FvdB2WI55CEp2IFgRS3zxNmMmBTCfOTALUKv
	b1fCumUg==;
Received: from [201.172.172.225] (port=38044 helo=[192.168.15.10])
	by gator4166.hostgator.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.96.2)
	(envelope-from <gustavo@embeddedor.com>)
	id 1ri1oj-003fVW-27;
	Wed, 06 Mar 2024 18:41:01 -0600
Message-ID: <22b99862-5889-4acb-96e5-7552c06e362b@embeddedor.com>
Date: Wed, 6 Mar 2024 18:40:59 -0600
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] overflow: Change DEFINE_FLEX to take __counted_by
 member
Content-Language: en-US
To: Kees Cook <keescook@chromium.org>,
 Przemek Kitszel <przemyslaw.kitszel@intel.com>
Cc: Jesse Brandeburg <jesse.brandeburg@intel.com>,
 Tony Nguyen <anthony.l.nguyen@intel.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 "Gustavo A. R. Silva" <gustavoars@kernel.org>,
 intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
 linux-hardening@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>,
 linux-kernel@vger.kernel.org
References: <20240306235128.it.933-kees@kernel.org>
From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
In-Reply-To: <20240306235128.it.933-kees@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4166.hostgator.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - embeddedor.com
X-BWhitelist: no
X-Source-IP: 201.172.172.225
X-Source-L: No
X-Exim-ID: 1ri1oj-003fVW-27
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: ([192.168.15.10]) [201.172.172.225]:38044
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 3
X-Org: HG=hgshared;ORG=hostgator;
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfDqFxWcFdyjNbZite/FwqUxjSQLCIMIj9OfIJw7xDLYm1Ulywd6rUbK68LTlQL+Vc2kjLa4Z0nCR3PH9q4pQq5F6/v9NZirnwndrmYM++cyzbxN3bBo9
 qdERCVgjnA00lcEZIFos9xKwtfXdwYjfw6XebgJJ9RFDIcCtoQPBKU1DlVisB/bcMj+XwLl+C29ogMIdBolhlU4uE6u/ABnBUuYGzKr1tfQr7yrgSxHxWvoK



On 3/6/24 17:51, Kees Cook wrote:
> The norm should be flexible array structures with __counted_by
> annotations, so DEFINE_FLEX() is updated to expect that. Rename
> the non-annotated version to DEFINE_RAW_FLEX(), and update the
> few existing users.
> 
> Signed-off-by: Kees Cook <keescook@chromium.org>

LGTM:

Reviewed-by: Gustavo A. R. Silva <gustavoars@kernel.org>

Thanks!
-- 
Gustavo
