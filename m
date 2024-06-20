Received: from omta34.uswest2.a.cloudfilter.net (omta34.uswest2.a.cloudfilter.net [35.89.44.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D05DA4CE13
	for <linux-hardening@vger.kernel.org>; Thu, 20 Jun 2024 19:02:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=35.89.44.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718910181; cv=none; b=nZgjtIQyaT7YzXYoJAUQN1cFpSDfpE48/3OJPO/spF1YiS/oB3+eNQ21p+sdxPEaITI/tUwIqdmU2Kf8kgwqI/yDuf4tKefkeEcIPCDK9BYXTruwV3TgsRVC+EmAjNVxEXeXPllTsGIxCNA9g/zL8VDu0vZQpF6l0GwGOkCzYm8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718910181; c=relaxed/simple;
	bh=+Jj2iyrjvgazskQSxghCtRl5yuPRiI5t6yni7Yjz8Y8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nJQBpIbbOT+R4bj8szDXkk77s+jkLOM4ul9EvnViWW07Qv5puULWJ2jzDvXYmLpHRlB9dSFf051dEYQeoY5yWgPQSV6HXlecZH7RJ2haWo595YwAWW5aBVn/mHcOiXdk7e5vtVQYxDmFRiIsHcU0hwbtJ0d0mkWgP+u+66HYdA8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=embeddedor.com; spf=pass smtp.mailfrom=embeddedor.com; dkim=pass (2048-bit key) header.d=embeddedor.com header.i=@embeddedor.com header.b=jvmowCZX; arc=none smtp.client-ip=35.89.44.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=embeddedor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=embeddedor.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=embeddedor.com header.i=@embeddedor.com header.b="jvmowCZX"
Received: from eig-obgw-6007a.ext.cloudfilter.net ([10.0.30.247])
	by cmsmtp with ESMTPS
	id KLNLsPThnkQe8KN3jsb62V; Thu, 20 Jun 2024 19:02:59 +0000
Received: from gator4166.hostgator.com ([108.167.133.22])
	by cmsmtp with ESMTPS
	id KN3isJt7yVW3yKN3jsc6YH; Thu, 20 Jun 2024 19:02:59 +0000
X-Authority-Analysis: v=2.4 cv=VLHbncPX c=1 sm=1 tr=0 ts=66747ce3
 a=1YbLdUo/zbTtOZ3uB5T3HA==:117 a=frY+GlAHrI6frpeK1MvySw==:17
 a=IkcTkHD0fZMA:10 a=T1WGqf2p2xoA:10 a=wYkD_t78qR0A:10
 a=YnLhUqmXxxwrq80so2UA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=QYH75iMubAgA:10
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=embeddedor.com; s=default; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=W5Sd7FdHakQhG3LkErMyF9EONJJIZEQHFSsJXeCMdcw=; b=jvmowCZXAPZXwN71QtV56/f/2t
	OgMWzfsKABm/jZfdV6sxtYD/1ZpuF7qoFCl/zk0XFls2Hn6CverV/XuR9wdS7u7I210A3qoN3VI/x
	NoUm81K8WFt2l0N+y5EFhauq84MJSbpxXrOcvK0rJ2iqNEhxXYX9O+elYynryhMlUH0DGlJ79OJZ1
	JZMQrVDB7npUIWd65TfGvkQE0yOjAnF+fOHLPc51qq/XZb9/KnQMmwBA8heUgaP5KUcEV76YCwDlZ
	taCEVPIJ1gLPAjtf7s4VrF1KJy3YTfKaUSbdpep1kPQoQUASywrs5ZkoANo7EGKn2Hu5h6CePQQyi
	EoRu27NA==;
Received: from [201.172.173.139] (port=38462 helo=[192.168.15.10])
	by gator4166.hostgator.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.96.2)
	(envelope-from <gustavo@embeddedor.com>)
	id 1sKN3h-000CZj-3B;
	Thu, 20 Jun 2024 14:02:58 -0500
Message-ID: <b0569cd6-83a4-4b5c-a31e-340bba452473@embeddedor.com>
Date: Thu, 20 Jun 2024 13:02:55 -0600
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] wifi: iwlwifi: mvm: Fix __counted_by usage in
 cfg80211_wowlan_nd_*
To: Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
 Kees Cook <kees@kernel.org>
Cc: benjamin.berg@intel.com, dmantipov@yandex.ru, gregory.greenman@intel.com,
 gustavoars@kernel.org, haim.dreyfuss@intel.com, johannes.berg@intel.com,
 kvalo@kernel.org, linux-hardening@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-wireless@vger.kernel.org,
 luciano.coelho@intel.com, miriam.rachel.korenblit@intel.com,
 shaul.triebitz@intel.com, yedidya.ben.shimol@intel.com
References: <20240619211233.work.355-kees@kernel.org>
 <d9bdb9c1-689e-4b3f-8325-8ee813257d8f@wanadoo.fr>
 <c8404725-e4c4-453b-b72d-19ab0761da70@embeddedor.com>
 <47a71c03-0306-4239-b77c-cb63a1760d19@embeddedor.com>
 <0f7d2d25-5c7c-4a19-8af7-ce38ee630d4d@wanadoo.fr>
Content-Language: en-US
From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
In-Reply-To: <0f7d2d25-5c7c-4a19-8af7-ce38ee630d4d@wanadoo.fr>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4166.hostgator.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - embeddedor.com
X-BWhitelist: no
X-Source-IP: 201.172.173.139
X-Source-L: No
X-Exim-ID: 1sKN3h-000CZj-3B
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: ([192.168.15.10]) [201.172.173.139]:38462
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 7
X-Org: HG=hgshared;ORG=hostgator;
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfEWaxu+Ji1u+GKJrB6a/uThN5QqrXhFuGz/X2Kiama85qfCj4ndfIBpSYa4fKcYblo+Wbse4Bgu9VlmBgbSiXRJU8t1S2wqdmOxhayracycTQNlH0mZx
 eMO22mLAmt0UWcxyfyD6cKQushS9EXHK5lc13fgSi220rgLVaLIeJQqVcpN7NxlObLxpLonWoQdMBMxGWlZHTrZ4FnUK/Dq16+/g4ClRAj1KJSIjUpmxqLDw


>> then match->n_channels updated here:
>>
>>           if (!match)
>>               goto out_report_nd;
>> +        match->n_channels = n_channels;
> 
> Thanks for the explanation.
> This is what I was looking for, and I missed this line.
> 
> Sorry for the noise.

No worries. Glad to help. :)

--
Gustavo
