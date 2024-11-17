Received: from omta38.uswest2.a.cloudfilter.net (omta38.uswest2.a.cloudfilter.net [35.89.44.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A3161D95B3
	for <linux-hardening@vger.kernel.org>; Sun, 17 Nov 2024 19:14:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=35.89.44.37
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731870901; cv=none; b=mBc/v0OvNmqUa9ggxjnNHXxMDZu5bsFcNrFN7ptWHqdzjkTS+gDUih7OIDuz1cicMmIEs+paecMfb8/H8b6tTiN6h/1A7yYIazlDM4c5kpoc5Avyn5nM+ZVJcEdaBMiq6+X1U+uHGHAmDex5x4AqmABLqWqEAsGiI2R+wgOdXU0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731870901; c=relaxed/simple;
	bh=rXA/vPgxjUoqHgknDoFQDXruwjTp5SZhTnujywXzb2w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XQgWQFRi5kLMG1jV5LU+jeiRQhjJ2Ln60aJCDK+Azir1H05u7/N0acEcz4/XV59eo2VYlpH4kwMxGwKjCtv0lHKy6zLtkORYr8l7ZIwSRB8Pj9hqZTX7Gg7R3MGTjd+ndOjZym7JSCcqNZ3hyv/TWfP6gIyXYS2MetTZKFAqIMk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=embeddedor.com; spf=pass smtp.mailfrom=embeddedor.com; dkim=pass (2048-bit key) header.d=embeddedor.com header.i=@embeddedor.com header.b=LMElTk6y; arc=none smtp.client-ip=35.89.44.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=embeddedor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=embeddedor.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=embeddedor.com header.i=@embeddedor.com header.b="LMElTk6y"
Received: from eig-obgw-5006a.ext.cloudfilter.net ([10.0.29.179])
	by cmsmtp with ESMTPS
	id CWmetv78AumtXCkjVtWI3c; Sun, 17 Nov 2024 19:14:53 +0000
Received: from gator4166.hostgator.com ([108.167.133.22])
	by cmsmtp with ESMTPS
	id CkjUtS0OFXVlKCkjUtOAoA; Sun, 17 Nov 2024 19:14:53 +0000
X-Authority-Analysis: v=2.4 cv=E43Lp7dl c=1 sm=1 tr=0 ts=673a40ad
 a=1YbLdUo/zbTtOZ3uB5T3HA==:117 a=GtNDhlRIH4u8wNL3EA3KcA==:17
 a=IkcTkHD0fZMA:10 a=VlfZXiiP6vEA:10 a=7T7KSl7uo7wA:10 a=VwQbUJbxAAAA:8
 a=hGzw-44bAAAA:8 a=Li1AiuEPAAAA:8 a=pGLkceISAAAA:8 a=yMhMjlubAAAA:8
 a=SEc3moZ4AAAA:8 a=nkaA2WqVLt1YesQtww0A:9 a=QEXdDO2ut3YA:10
 a=HvKuF1_PTVFglORKqfwH:22 a=qGKPP_lnpMOaqR3bcYHU:22 a=5oRCH6oROnRZc2VpWJZ3:22
 a=Xt_RvD8W3m28Mn_h3AK8:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=embeddedor.com; s=default; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=q1wR3poj1XS/Qb3R0h3X2RGerMhs3utXQCxG307IBkM=; b=LMElTk6ywLN06KeZ5rxbAV2wY5
	h1H0qYEIs6ppuXADxoTU9HQHzi4xhaSP147sdJV/hEwhrTttOmjbU2+rOBtAdin2UbHYypnTgdvzt
	SWtqKUB3smLOvbZr+2jsjuwp9DCsAKXmNolPxv9eSfEbh4ih5M1bFq5xZxNWc89DhL3yzFDCC6jDt
	4yq1oYC2zzOlBDlgQXbtVI6UgvP6dqTgqplDnqHPEbtHZ1VaTBIzNsVXOZMMuGMDU2tEg8ShZoOHv
	o6yb7TylB+GhWGj/hPJNpThCJeXKLIzB8LpAyD7CXsOIwCjGGXjNMG0Cul8aqjKe6IusTC9b8DP0b
	jrU6mmiA==;
Received: from [177.238.21.80] (port=44616 helo=[192.168.0.21])
	by gator4166.hostgator.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.96.2)
	(envelope-from <gustavo@embeddedor.com>)
	id 1tCkjS-000o5T-22;
	Sun, 17 Nov 2024 13:14:50 -0600
Message-ID: <bcd4fb0f-47ee-4676-8e71-6b06973e9b65@embeddedor.com>
Date: Sun, 17 Nov 2024 13:14:41 -0600
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] smb: client: memcpy() with surrounding object base
 address
To: Kees Cook <kees@kernel.org>, Steve French <sfrench@samba.org>
Cc: "Gustavo A. R. Silva" <gustavoars@kernel.org>,
 Paulo Alcantara <pc@manguebit.com>,
 Ronnie Sahlberg <ronniesahlberg@gmail.com>,
 Shyam Prasad N <sprasad@microsoft.com>, Tom Talpey <tom@talpey.com>,
 Bharath SM <bharathsm@microsoft.com>, linux-cifs@vger.kernel.org,
 samba-technical@lists.samba.org, linux-kernel@vger.kernel.org,
 linux-hardening@vger.kernel.org
References: <20241117113204.work.419-kees@kernel.org>
Content-Language: en-US
From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
In-Reply-To: <20241117113204.work.419-kees@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4166.hostgator.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - embeddedor.com
X-BWhitelist: no
X-Source-IP: 177.238.21.80
X-Source-L: No
X-Exim-ID: 1tCkjS-000o5T-22
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: ([192.168.0.21]) [177.238.21.80]:44616
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 1
X-Org: HG=hgshared;ORG=hostgator;
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfGb6HWmuahHuaxfXvSGkdeHujm4XiwlUFkv25UCoviln5hnA8a1cwOD86uq2U0jYlFe2rML5Ch0Roj+tiOEttkOkIAIkd6aYNbSNlkSqWkiyYUNgQ1ml
 rFCWgU3gVMNBFH4g+YXJAKil77CxDsL3l57szWqR+OWgJus6nNqNJkyFJGPdt6tvEb8ohm47wMJSYHBFc1R3VTSaHuTZo3+63LnyXajs0zSZkXHXSRUJ/yE+



On 17/11/24 05:32, Kees Cook wrote:
> Like commit f1f047bd7ce0 ("smb: client: Fix -Wstringop-overflow issues"),
> adjust the memcpy() destination address to be based off the surrounding
> object rather than based off the 4-byte "Protocol" member. This avoids a
> build-time warning when compiling under CONFIG_FORTIFY_SOURCE with GCC 15:
> 
> In function 'fortify_memcpy_chk',
>      inlined from 'CIFSSMBSetPathInfo' at ../fs/smb/client/cifssmb.c:5358:2:
> ../include/linux/fortify-string.h:571:25: error: call to '__write_overflow_field' declared with attribute warning: detected write beyond size of field (1st parameter); maybe use struct_group()? [-Werror=attribute-warning]
>    571 |                         __write_overflow_field(p_size_field, size);
>        |                         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> 
> Signed-off-by: Kees Cook <kees@kernel.org>

Reviewed-by: Gustavo A. R. Silva <gustavoars@kernel.org>

Thanks!
-Gustavo

> ---
> Cc: Steve French <sfrench@samba.org>
> Cc: "Gustavo A. R. Silva" <gustavoars@kernel.org>
> Cc: Paulo Alcantara <pc@manguebit.com>
> Cc: Ronnie Sahlberg <ronniesahlberg@gmail.com>
> Cc: Shyam Prasad N <sprasad@microsoft.com>
> Cc: Tom Talpey <tom@talpey.com>
> Cc: Bharath SM <bharathsm@microsoft.com>
> Cc: linux-cifs@vger.kernel.org
> Cc: samba-technical@lists.samba.org
> ---
>   fs/smb/client/cifssmb.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/fs/smb/client/cifssmb.c b/fs/smb/client/cifssmb.c
> index b96ca9be5352..026d6b5f23a9 100644
> --- a/fs/smb/client/cifssmb.c
> +++ b/fs/smb/client/cifssmb.c
> @@ -5337,7 +5337,7 @@ CIFSSMBSetPathInfo(const unsigned int xid, struct cifs_tcon *tcon,
>   	param_offset = offsetof(struct smb_com_transaction2_spi_req,
>   				InformationLevel) - 4;
>   	offset = param_offset + params;
> -	data_offset = (char *) (&pSMB->hdr.Protocol) + offset;
> +	data_offset = (char *)pSMB + offsetof(typeof(*pSMB), hdr.Protocol) + offset;
>   	pSMB->ParameterOffset = cpu_to_le16(param_offset);
>   	pSMB->DataOffset = cpu_to_le16(offset);
>   	pSMB->SetupCount = 1;

