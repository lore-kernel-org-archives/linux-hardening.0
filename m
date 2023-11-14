Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 242595669
	for <linux-hardening@vger.kernel.org>; Tue, 14 Nov 2023 01:24:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=embeddedor.com header.i=@embeddedor.com header.b="K/VG0wXm"
Received: from omta36.uswest2.a.cloudfilter.net (omta36.uswest2.a.cloudfilter.net [35.89.44.35])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A219196
	for <linux-hardening@vger.kernel.org>; Mon, 13 Nov 2023 17:24:14 -0800 (PST)
Received: from eig-obgw-5006a.ext.cloudfilter.net ([10.0.29.179])
	by cmsmtp with ESMTPS
	id 2PzQr3sBzhqFd2iA1rd5Cq; Tue, 14 Nov 2023 01:24:13 +0000
Received: from gator4166.hostgator.com ([108.167.133.22])
	by cmsmtp with ESMTPS
	id 2iA0r0aou1J282iA1rtFEn; Tue, 14 Nov 2023 01:24:13 +0000
X-Authority-Analysis: v=2.4 cv=Tqz1ORbh c=1 sm=1 tr=0 ts=6552cc3d
 a=1YbLdUo/zbTtOZ3uB5T3HA==:117 a=WzbPXH4gqzPVN0x6HrNMNA==:17
 a=OWjo9vPv0XrRhIrVQ50Ab3nP57M=:19 a=dLZJa+xiwSxG16/P+YVxDGlgEgI=:19
 a=IkcTkHD0fZMA:10 a=BNY50KLci1gA:10 a=wYkD_t78qR0A:10 a=VwQbUJbxAAAA:8
 a=n9Sqmae0AAAA:8 a=9VXzpLBs2m9k5JNODz8A:9 a=QEXdDO2ut3YA:10
 a=AjGcO6oz07-iQ99wixmX:22 a=UmAUUZEt6-oIqEbegvw9:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=embeddedor.com; s=default; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=doC+LBatWPId0UyWA3LyXgIK5aM8JnD/Z9O3xHc/vRc=; b=K/VG0wXm1192jg2fa7ctTi3Yim
	HiR7beYT6gKdFz6CC0KWevnLLnCVcR0woSbwD0MoI/dSkgmgx7d67AHTDp8iWmow5RFNDtrOyvZ/5
	BTWy3hRnVKvtdDtSnAKWXx56EMj0cLF3nmwUykfCGDqNuAf47bXBwdpV+zSmib6l/aF+w10b8KRix
	GkaShNn8Hvhei72Y3X3ni+Oix95Fhd6B6iy+fU0ZI5XKC6W3sWKavoEhBjLfedco+YcBhRw6r+poL
	lpszecQS38OP9ZWpfcOyYaPUaw9DxFMe2efNOkYXUOi3KQ0UrQ6oRyLEPojef9aN2ZpU3VlKc+78V
	JJchBMUg==;
Received: from 187-162-21-192.static.axtel.net ([187.162.21.192]:48806 helo=[192.168.15.10])
	by gator4166.hostgator.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.96.2)
	(envelope-from <gustavo@embeddedor.com>)
	id 1r2iA0-0026pL-0p;
	Mon, 13 Nov 2023 19:24:12 -0600
Message-ID: <192fbb0d-f4f6-4384-98d8-b7422349dafb@embeddedor.com>
Date: Mon, 13 Nov 2023 19:23:49 -0600
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH][next] wifi: rtw89: coex: Fix -Wstringop-overflow warnings
 in _append_tdma()
To: Ping-Ke Shih <pkshih@realtek.com>,
 "Gustavo A. R. Silva" <gustavoars@kernel.org>, Kalle Valo <kvalo@kernel.org>
Cc: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-hardening@vger.kernel.org" <linux-hardening@vger.kernel.org>
References: <ZVJ6lRCRaywGktxJ@work>
 <fd0d79048efa47868173c5fd8950b956@realtek.com>
Content-Language: en-US
From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
In-Reply-To: <fd0d79048efa47868173c5fd8950b956@realtek.com>
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
X-Exim-ID: 1r2iA0-0026pL-0p
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: 187-162-21-192.static.axtel.net ([192.168.15.10]) [187.162.21.192]:48806
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 1
X-Org: HG=hgshared;ORG=hostgator;
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfFCUBMq0S5I1h9Rd8gGfEzqlHhuxnAKHSJHZXKtIFaQfs/w/vGao79n8ov1/0iynDsS3sbByrr7BO7T7Ywctq5ThngezIup4LetKrhYHCrOSPWZ5OwID
 Q9qOk3bccYXl30E2p3CSXynzv1mfEwKeZQx5l12ks4ZqO7Kb/iZivooAOhFiJn980jWEtVYfSepgDLUvaJHGAaLCjk6ZjwmxdkWGNUjCh9jPoMyOzYHe0rje



On 11/13/23 18:37, Ping-Ke Shih wrote:
> 
> 
>> -----Original Message-----
>> From: Gustavo A. R. Silva <gustavoars@kernel.org>
>> Sent: Tuesday, November 14, 2023 3:36 AM
>> To: Ping-Ke Shih <pkshih@realtek.com>; Kalle Valo <kvalo@kernel.org>
>> Cc: linux-wireless@vger.kernel.org; linux-kernel@vger.kernel.org; Gustavo A. R. Silva
>> <gustavoars@kernel.org>; linux-hardening@vger.kernel.org
>> Subject: [PATCH][next] wifi: rtw89: coex: Fix -Wstringop-overflow warnings in _append_tdma()
>>
>> Copy a couple of structures directly, instead of using `memcpy()`.
>>
> 
> wireless-next has taken my patch [1] that is identical to yours.

Great!

I had mine ready on Oct 31, but I was waiting for the merge window to close
before sending it.

Glad to see that the issue is fixed already. :)

Thanks
--
Gustavo

> 
> [1] https://lore.kernel.org/all/20231102003716.25815-1-pkshih@realtek.com/
> 
> 
