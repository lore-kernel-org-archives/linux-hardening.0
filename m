Received: from omta38.uswest2.a.cloudfilter.net (omta38.uswest2.a.cloudfilter.net [35.89.44.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEEB01102
	for <linux-hardening@vger.kernel.org>; Sun, 11 Feb 2024 04:31:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=35.89.44.37
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707625920; cv=none; b=TcfBiR4fE2ZQBG4qX3jLYhBUY9u6nq5PznQBUQ4shXFnK32Krc1d4doIO2vn+ydRy741NqSqeli8tlHEc+JIckk+1sv4Y1C/TVZOonZxKETDJCTS3F2Kgq9Ag3PMC7xvqQUFH1pWvY3rIGusGdfITHNQLcsxUwM3nc1sgqx1g60=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707625920; c=relaxed/simple;
	bh=5ZwnpT8mcXjBFkyjqPTZeh5s0VMPzldNDT4ybxfhyqQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=i2o7YkHzwQTyBMe2qxL0v6iEQd5BghnnJuQXyr6UZCJdZwkEPKnsLUWl1koT9qd/MPkaiBnP/Qp1+B75gOLif+S8NZ09uJPeBH1SMYi5dkRwaDJyIxhZce/DSmRmoXAlEha5r4og5zzD5vfD35uhR8QkCII8bA7LM4OwQgCUrpk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=embeddedor.com; spf=pass smtp.mailfrom=embeddedor.com; dkim=pass (2048-bit key) header.d=embeddedor.com header.i=@embeddedor.com header.b=WfIGol9O; arc=none smtp.client-ip=35.89.44.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=embeddedor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=embeddedor.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=embeddedor.com header.i=@embeddedor.com header.b="WfIGol9O"
Received: from eig-obgw-6001a.ext.cloudfilter.net ([10.0.30.140])
	by cmsmtp with ESMTPS
	id YukSrm0Mbrh9zZ1VQrDdop; Sun, 11 Feb 2024 04:31:52 +0000
Received: from gator4166.hostgator.com ([108.167.133.22])
	by cmsmtp with ESMTPS
	id Z1VPrpooIkXAgZ1VPrXZhW; Sun, 11 Feb 2024 04:31:51 +0000
X-Authority-Analysis: v=2.4 cv=O5uavw9W c=1 sm=1 tr=0 ts=65c84db7
 a=1YbLdUo/zbTtOZ3uB5T3HA==:117 a=VhncohosazJxI00KdYJ/5A==:17
 a=IkcTkHD0fZMA:10 a=k7vzHIieQBIA:10 a=wYkD_t78qR0A:10 a=NEAV23lmAAAA:8
 a=VwQbUJbxAAAA:8 a=pGLkceISAAAA:8 a=SFFPblQYn7CYJzprxtIA:9 a=QEXdDO2ut3YA:10
 a=9cHFzqQdt-sA:10 a=PUnBvhIW4WwA:10 a=AjGcO6oz07-iQ99wixmX:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=embeddedor.com; s=default; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=JB/WeyEbAV7OyjD3c1GyCrBYmyVdRfm89lgXESEF2VM=; b=WfIGol9OItIddg2zBSp23EqrT5
	zc0dF5un58Jy92Zs0udxqIhcXZaG7iF2qgqWS0poWnNLgXM4AI3BkvYc8jX+qbxvsDkR+zJchzJbh
	SuCe4RlhcRtxUeYQnPDRpBdb6x9IuTTDReiGwUY5mTJcvVJPGgtp6cZcfoeIhdjUpx7MWHAUAk3dK
	6kKWA3VcdP6ZFwSfKMjO/n9UrFxUnGa/nihgYD1MfMDmpz6lE8bTTLEa3ztHlFd1+cEoCEYbm1IX6
	r582PhANx4MiQ809bUjVy+QDOFmffrLhT+iz+1i3IC6yv4qF0wHI6hxQGQL1W0P+14IOL+LDohMWm
	Y3p3kuwg==;
Received: from [201.172.172.225] (port=59896 helo=[192.168.15.10])
	by gator4166.hostgator.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.96.2)
	(envelope-from <gustavo@embeddedor.com>)
	id 1rZ1VP-001GeW-00;
	Sat, 10 Feb 2024 22:31:51 -0600
Message-ID: <bb7a8d29-d80d-41b0-8dde-2aba44c3fd90@embeddedor.com>
Date: Sat, 10 Feb 2024 22:31:49 -0600
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] fs/ntfs3: use kcalloc() instead of kzalloc()
Content-Language: en-US
To: Lenko Donchev <lenko.donchev@gmail.com>,
 Konstantin Komarov <almaz.alexandrovich@paragon-software.com>,
 "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc: ntfs3@lists.linux.dev, linux-kernel@vger.kernel.org,
 linux-hardening@vger.kernel.org
References: <Zcgoighe07IahAV8@nixos>
From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
In-Reply-To: <Zcgoighe07IahAV8@nixos>
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
X-Exim-ID: 1rZ1VP-001GeW-00
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: ([192.168.15.10]) [201.172.172.225]:59896
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 1
X-Org: HG=hgshared;ORG=hostgator;
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfD8TiM8OvVZoRLdGfJmYLnyDcppRUwvr8+lL3G2gYiQJVVEMUFWXMmlB5Tx6SmjDaejT21+ZHMcjBwbTHWNY7p7DhlWmJmP02wsLycEIHEouiiptv4ml
 /vkpdIVsfrBElg8dpPztXwMo7AO5OeIENy//mzezzDp35R1xFUTr1ivnnIUqhK6tZzKgfuMsSX8ungHe8K/K39QTeGqwau1y+tQM0upT7211mA6bid0VtSVQ



On 2/10/24 19:53, Lenko Donchev wrote:
> We are trying to get rid of all multiplications from allocation
> functions to prevent integer overflows[1]. Here the multiplication is
> obviously safe, but using kcalloc() is more appropriate and improves
> readability. This patch has no effect on runtime behavior.
> 
> Link: https://github.com/KSPP/linux/issues/162 [1]
> Link: https://www.kernel.org/doc/html/next/process/deprecated.html#open-coded-arithmetic-in-allocator-arguments [2]
> 
> Signed-off-by: Lenko Donchev <lenko.donchev@gmail.com>
> ---
>   fs/ntfs3/frecord.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/fs/ntfs3/frecord.c b/fs/ntfs3/frecord.c
> index 3b42938a9d3b..d435446537ca 100644
> --- a/fs/ntfs3/frecord.c
> +++ b/fs/ntfs3/frecord.c
> @@ -2636,7 +2636,7 @@ int ni_read_frame(struct ntfs_inode *ni, u64 frame_vbo, struct page **pages,
>   		goto out1;
>   	}
>   
> -	pages_disk = kzalloc(npages_disk * sizeof(struct page *), GFP_NOFS);
> +	pages_disk = kcalloc(npages_disk, sizeof(struct page *), GFP_NOFS);

`sizeof(*pages_disk)` is preferable over `sizeof(struct page *)`

Thanks
--
Gustavo

>   	if (!pages_disk) {
>   		err = -ENOMEM;
>   		goto out2;
