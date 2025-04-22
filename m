Received: from omta40.uswest2.a.cloudfilter.net (omta40.uswest2.a.cloudfilter.net [35.89.44.39])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C38128EA74
	for <linux-hardening@vger.kernel.org>; Tue, 22 Apr 2025 14:59:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=35.89.44.39
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745333981; cv=none; b=tGm+04Y3zHpwByas5HalHGkhFUqTHqrZ8Ttha9pptICLfdhbq9b+zAqOPT1BCIIOO7NpojPgXpEyCekytUm7Xw5iaw2KGFqvb2JAmarrCnRzkoelwoEzrp9O8p5i6dYALPqhdd3ccQE12/WHCMQVOD1VmM7PymhIIZFl9Pi6p4g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745333981; c=relaxed/simple;
	bh=ijxCjkZeIFm9DRJecTSclNShVpoCO4ajmdE/y0iy4yw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=H9Wm2OonjD65s4/pxf9zN+Zm/t+7XicKkKOd5c4xtvxKZO4GcZj4qLnp+qM64/wm9qnQX+EZs+REwJ5ctAi1wnw9xeXEY8hm2h4zCYR5MLzKxS0DePioBrkWNIvuTZds3V9g+uyeMp+RH4AMz+siLhrMnCnUAze3GgchBVwcBSw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=embeddedor.com; spf=pass smtp.mailfrom=embeddedor.com; dkim=pass (2048-bit key) header.d=embeddedor.com header.i=@embeddedor.com header.b=XcGilj0A; arc=none smtp.client-ip=35.89.44.39
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=embeddedor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=embeddedor.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=embeddedor.com header.i=@embeddedor.com header.b="XcGilj0A"
Received: from eig-obgw-5008a.ext.cloudfilter.net ([10.0.29.246])
	by cmsmtp with ESMTPS
	id 713UuKHWmf1UX7F5xuht2h; Tue, 22 Apr 2025 14:59:33 +0000
Received: from gator4166.hostgator.com ([108.167.133.22])
	by cmsmtp with ESMTPS
	id 7F5wuqp0wUxvT7F5wuR6yc; Tue, 22 Apr 2025 14:59:32 +0000
X-Authority-Analysis: v=2.4 cv=SqKW6uO0 c=1 sm=1 tr=0 ts=6807aed4
 a=1YbLdUo/zbTtOZ3uB5T3HA==:117 a=DefJii25N9YVshmqbOOoLg==:17
 a=IkcTkHD0fZMA:10 a=XR8D0OoHHMoA:10 a=7T7KSl7uo7wA:10
 a=53fDKlUhlIHvPVJ8cPUA:9 a=QEXdDO2ut3YA:10 a=Xt_RvD8W3m28Mn_h3AK8:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=embeddedor.com; s=default; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=u8I91YH/aI9uF9ro2Vg6hlbwmxJoyFD3QHMBrx88C5M=; b=XcGilj0AjEwgk6rztMMfyPftaW
	B4A3NhWYhtaqCeAFDSCvxxYK91FvBzq847M06Th72r1Evfd43gHmOwLS6LhO3kaVIJyrz65eW2uoe
	Qudq3438pOfktav5RGhh0/FHHJMI6gvk+eheLqP+PEyCXMaX71cSp4CIkZeTtuUb6cGfSk9TiPACs
	PWKipByUkvFDpcj7ydgYkfjwISDU9mIeCSC3nsBp7DzfxXNYN9sLryOK64v8t7+Np84DIdNkW0y2c
	jV0ple0xqkWCmGiDPsjgMY5bviyG3AH7s2GdVSt5bTa/LUNia4aMl6VEUGwoX7ObfxgliNww3iOBM
	ppl0aY0Q==;
Received: from [201.172.174.139] (port=59040 helo=[192.168.15.14])
	by gator4166.hostgator.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.98.1)
	(envelope-from <gustavo@embeddedor.com>)
	id 1u7F5v-00000003hmo-1KqF;
	Tue, 22 Apr 2025 09:59:31 -0500
Message-ID: <a478dbd6-402b-47ef-897d-3e73abf80a97@embeddedor.com>
Date: Tue, 22 Apr 2025 08:59:26 -0600
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH][next] nvme-loop: Avoid -Wflex-array-member-not-at-end
 warning
To: Christoph Hellwig <hch@lst.de>
Cc: "Gustavo A. R. Silva" <gustavoars@kernel.org>,
 Sagi Grimberg <sagi@grimberg.me>, Chaitanya Kulkarni <kch@nvidia.com>,
 linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-hardening@vger.kernel.org, Kees Cook <keescook@chromium.org>
References: <Z-axRObjXYjIHGQC@kspp>
 <a1c6fd4e-69b4-4698-bc5d-ef02cf7312e4@embeddedor.com>
 <20250416054352.GA25107@lst.de>
Content-Language: en-US
From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
In-Reply-To: <20250416054352.GA25107@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4166.hostgator.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - embeddedor.com
X-BWhitelist: no
X-Source-IP: 201.172.174.139
X-Source-L: No
X-Exim-ID: 1u7F5v-00000003hmo-1KqF
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: ([192.168.15.14]) [201.172.174.139]:59040
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 15
X-Org: HG=hgshared;ORG=hostgator;
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfBuV3EW0MIac/aa892cDll3EY7YDJGU5DcJp4MgQUlyUt3/dvkd2KfK6RQsapvYQUpYnLXntOuEpkTA8YAUNpVKz2Oql1CADbpMKSQdYEF10initVZ6w
 5EPTp3zQPM7qV5qwSnBfYcCMetxUESYerQqLgZczihswKDHHLd5qpcSkunQrRRmlGAazstILKwJZlWLpg708wWXNukGliU5MCDwlMROSl7CDKMKSNr4iA4kB



On 15/04/25 23:43, Christoph Hellwig wrote:
> On Tue, Apr 15, 2025 at 06:20:03PM -0600, Gustavo A. R. Silva wrote:
>> Hi all,
>>
>> Friendly ping: who can take this patch, please? :)
> 
> This will go into the 6.16 nvme branch as soon as it opens.

Awesome. :)

Thanks

-Gustavo

